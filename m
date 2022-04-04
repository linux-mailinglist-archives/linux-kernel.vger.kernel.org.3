Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8CE4F1E50
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382234AbiDDVuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380713AbiDDVKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 17:10:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790EE1136;
        Mon,  4 Apr 2022 14:08:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 733BC60ED7;
        Mon,  4 Apr 2022 21:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EE7C340F3;
        Mon,  4 Apr 2022 21:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649106511;
        bh=lMFZzJK3d7b7zCNL7PVAqXkEUtWjmCH9N34EDxdccbc=;
        h=From:To:Cc:Subject:Date:From;
        b=bVbvEY29tdsfqT/5ETEFVDzbQ12LdDJo1+j+PrvKJA2Vvlera/X/BqrspOXXgONOL
         r0u/ZV0rcxAmNgs8dxItcaluZwy+eMg4VcT1ix24MXSIyBT3s2qVgIrd3K5LiXHuBR
         gRRA+DXvABmxagsDWSXMsGS3B21HI0xY7Ao8OZgTS5QD/86Ubu7/d9S2EI5bmsxCUL
         jU2Ov8h1iH2g4ihtAHV8eMUPdDYs5jqs8sMNQ23pHMDar+RKy7FRslRQfuUz4fqfJz
         dAWLtN9q1K0hxmJ5f+rx091lsztNv+7tTi5CBf6MnLJKSnMLDE5NaUgGpYOJuyVKgm
         9+x3xsOvqRH6w==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] lib/raid6: Add -Wno-declaration-after-statement to NEON_FLAGS for clang < 14.0.1
Date:   Mon,  4 Apr 2022 14:08:05 -0700
Message-Id: <20220404210804.3537324-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit e8c07082a810 ("Kbuild: move to -std=gnu11"), there is a
spew of warnings in lib/raid6/ when building arm64 defconfig plus
CONFIG_CPU_BIG_ENDIAN=y with clang 14.0.0, which come from its
arm_neon.h header:

lib/raid6/recov_neon_inner.c:55:8: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                vy = vshrq_n_u8(vx, 4);
                     ^
.../lib/clang/14.0.0/include/arm_neon.h:25231:14: note: expanded from macro 'vshrq_n_u8'
  uint8x16_t __ret; \
             ^

Looking at the header, the big endian version does mix declarations and
code, due to the reversal of the first argument:

  #ifdef __LITTLE_ENDIAN__
  #define vshrq_n_u8(__p0, __p1) __extension__ ({ \
    uint8x16_t __s0 = __p0; \
    uint8x16_t __ret; \
    __ret = (uint8x16_t) __builtin_neon_vshrq_n_v((int8x16_t)__s0, __p1, 48); \
    __ret; \
  })
  #else
  #define vshrq_n_u8(__p0, __p1) __extension__ ({ \
    uint8x16_t __s0 = __p0; \
    uint8x16_t __rev0;  __rev0 = __builtin_shufflevector(__s0, __s0, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0); \
    uint8x16_t __ret; \
    __ret = (uint8x16_t) __builtin_neon_vshrq_n_v((int8x16_t)__rev0, __p1, 48); \
    __ret = __builtin_shufflevector(__ret, __ret, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0); \
    __ret; \
  })
  #endif

It was initially surprising that clang warned about a macro that
originates from a system header, as this deviates from GCC. The
machinery in clang to ignore warnings in macros from system headers is
relatively new in clang (January 2022). When that change was landed, the
code owner of clang was not confident that clang's diagnostic system
provided enough information to avoid falsely disabling warnings that
originated from user controlled code that was mixed with system macros,
so the default behavior of warning within system macros remained
unchanged. This deficiency is unlikely to further impact the kernel, as
it does not use any system headers aside from SIMD intrinsic headers
after commit 04e85bbf71c9 ("isystem: delete global -isystem compile
option").

Another interesting aspect of this warning's appearance is how it only
appeared when moving from gnu89 to gnu11, as the above problem has
always been relevant for clang, regardless of the C standard version
used to build the kernel. In clang 14.0.0, -Wdeclaration-after-statement
was made available under newer C standard versions; prior to that
change, it was only available for C standard versions older than C99.

https://github.com/llvm/llvm-project/commit/118f966b46cfb60897b56a9878e1c68fd0e2afa4

When compiling for a C standard older than C99,
-Wdeclaration-after-statement is an extension warning, which means it
can be silenced with '__extension__', as the macro above does. However,
starting with C99, using '__extension__' to silence the warning does not
work, as mixing declarations and code is no longer an extension, which
is why the warning appears for gnu11 and gnu89.

Ultimately, this issue is resolved in clang 14.0.1 and 15.0.0 by making
arm_neon.h fully compliant with -Wdeclaration-after-statement for all C
standard versions. For older versions of clang, hide this warning for
32-bit and 64-bit ARM big endian in files that use arm_neon.h.

Link: https://github.com/ClangBuiltLinux/linux/issues/1603
Link: https://github.com/llvm/llvm-project/issues/54062
Link: https://github.com/llvm/llvm-project/commit/5a2e56b70e2fa7ad0d82e54bc4c741b16f05e475
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 lib/raid6/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 45e17619422b..f0a17bc7bd1d 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -41,6 +41,12 @@ NEON_FLAGS += -isystem $(shell $(CC) -print-file-name=include)
 ifeq ($(ARCH),arm)
 NEON_FLAGS += -march=armv7-a -mfloat-abi=softfp -mfpu=neon
 endif
+# https://github.com/ClangBuiltLinux/linux/issues/1603
+ifdef CONFIG_CPU_BIG_ENDIAN
+ifeq ($(shell test $(CONFIG_CLANG_VERSION) -lt 140001; echo $$?),0)
+NEON_FLAGS += -Wno-declaration-after-statement
+endif
+endif
 CFLAGS_recov_neon_inner.o += $(NEON_FLAGS)
 ifeq ($(ARCH),arm64)
 CFLAGS_REMOVE_recov_neon_inner.o += -mgeneral-regs-only

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.35.1

