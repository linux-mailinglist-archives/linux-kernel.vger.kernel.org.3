Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B415A85FB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbiHaSoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbiHaSo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:44:28 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653175F9E
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:44:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3363b1dffa0so210978927b3.23
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=wE732wZm675iVXKD6yeBsDTR2gqwSJrBRBhO3wQb7iQ=;
        b=eShEMrNUlFCTE9aYVbAg0DgI0iTQu9WfmERbirOoR6oYYyP7ijLwfq/E0+J6ooYtcE
         hxeV/9DeC6BXMbXwjkhtDyt8TSgZSaPG4uWNHh1vS/Lm4jxju9dnHS4OACxqtaYPTOO1
         XV4aI25xVG9jdotAUGyN/q4M+4pIaTJ7EBgTNYEDPvwKJUKn+I04yZSNYaXo7PgWY8uU
         Neq26b8Ccc3YvSqH4Xn3np4CbJbmZ4dbr1gCWD29mDhWNarK2JjGE5RKGT+5YA2QY+MG
         aZKL8/MPstyqcl9bPEfhUfgACivj0gAhLIQlUXFH6yDEiSnetjzQWcAS4UebJrDqCNL5
         uhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=wE732wZm675iVXKD6yeBsDTR2gqwSJrBRBhO3wQb7iQ=;
        b=ZU/tQDwb6kgMBGjpkQn2Q15+FlsEpVlycsPaMu3IV7u9bk6iJEGs6/6LbRDeMBQmfE
         iDgx2En4irjr9A+ZbUj9QAxJqc4UQfBhPVi7uBYeOrl7sneTdEB0883nFHwafEKd66xO
         4dhcQVorL0GXdep4zLl8v6XCEDkWEgxYRuZSqby31K3dh5NzAkTgTR9iMEw/2PJzLP50
         6Cb3Jan7jjvrssoLsltpt5HhHh7yezp+DzRjgvY11/pCP/CXqKVxwD9+EL3WtCzX8s+9
         GnIwaZ03qfplEZHUJRJ3yKV9suoFhBeGsQdG5GNO2zchKu2MdqoPqpb8sOBwqFwoAHMo
         rdiQ==
X-Gm-Message-State: ACgBeo0Tt8PRFb9yL0nalrD2Wce1FAOZk2e5ozwTUfiZOoZRRd1bLBvG
        XuVy36V5ehVv3SVKptINQOS8byNSBsjFiojbI0w=
X-Google-Smtp-Source: AA6agR4+Ebu40vcHAmRMaudQ83J0/q9XXte3H1wM0GkT9zrEW8Y29d4ev5N+HjYyH+Ir/SWkm0uyd9uQ2tSYFkmGf4o=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:0:100e:712:5f5d:95d5:9a3:d41])
 (user=ndesaulniers job=sendgmr) by 2002:a0d:d5c2:0:b0:337:5d95:8bcb with SMTP
 id x185-20020a0dd5c2000000b003375d958bcbmr19167887ywd.359.1661971462704; Wed,
 31 Aug 2022 11:44:22 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:44:07 -0700
In-Reply-To: <20220831184408.2778264-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20220831184408.2778264-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1661971448; l=3120;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=NliQXprEuvO3t8z2w/GlA1aYI6D3EzX025tg2ksOCjQ=;
 b=u4wE/I7MNagG4I/nE2e5f0OfGZvDcBSQ12AuaA53Y2L7ge5X1x5R2F9kOpMQ2NHWcLdZ20mpNrM4
 +wycsrFcDvMkzcCjDBQ7pjAFIsqooWQNXvQdegA5VPqWXge0u9Kh
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220831184408.2778264-5-ndesaulniers@google.com>
Subject: [PATCH v2 4/5] Makefile.debug: re-enable debug info for .S files
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev, x86@kernel.org,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Bill Wendling <morbo@google.com>,
        Greg Thelen <gthelen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey reported that the fraction of unknown filename instances in
kallsyms grew from ~0.3% to ~10% recently; Bill and Greg tracked it down
to assembler defined symbols, which regressed as a result of:

commit b8a9092330da ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1")

In that commit, I allude to restoring debug info for assembler defined
symbols in a follow up patch, but it seems I forgot to do so in

commit a66049e2cf0e ("Kbuild: make DWARF version a choice")

This patch does a few things:
1. Add -g to KBUILD_AFLAGS. This will instruct the compiler to instruct
   the assembler to emit debug info. But this can cause an issue for
   folks using a newer compiler but older assembler, because the
   implicit default DWARF version changed from v4 to v5 in gcc-11 and
   clang-14.
2. If the user is using CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT, use a
   version check to explicitly set -Wa,-gdwarf-<version> for the
   assembler. There's another problem with this; GAS only gained support
   for explicit DWARF versions 3-5 in the 2.36 GNU binutils release.
3. Wrap -Wa,-gdwarf-<version> in as-option call to test whether the
   assembler supports that explicit DWARF version.

Link: https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=31bf18645d98b4d3d7357353be840e320649a67d
Fixes: b8a9092330da ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1")
Reported-by: Alexey Alexandrov <aalexand@google.com>
Reported-by: Bill Wendling <morbo@google.com>
Reported-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v1 -> v2:
* Use newly added compiler-specific macros, as per Bill.

 scripts/Makefile.debug | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
index 9f39b0130551..46e88f0ca998 100644
--- a/scripts/Makefile.debug
+++ b/scripts/Makefile.debug
@@ -4,18 +4,32 @@ ifdef CONFIG_DEBUG_INFO_SPLIT
 DEBUG_CFLAGS	+= -gsplit-dwarf
 else
 DEBUG_CFLAGS	+= -g
+KBUILD_AFLAGS	+= -g
 endif
 
-ifndef CONFIG_AS_IS_LLVM
-KBUILD_AFLAGS	+= -Wa,-gdwarf-2
+ifdef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
+# gcc-11+, clang-14+
+ifeq ($(call cc-min-version, 110000, 140000),y)
+dwarf-version-y := 5
+else
+dwarf-version-y := 4
 endif
-
-ifndef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
+else # !CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
 dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
 dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
 DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
 endif
 
+# Binutils 2.35+ (or clang) required for -gdwarf-{4|5}.
+# https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=31bf18645d98b4d3d7357353be840e320649a67d
+ifneq ($(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y)),)
+KBUILD_AFLAGS	+= -Wa,-gdwarf-$(dwarf-version-y)
+else
+ifndef CONFIG_AS_IS_LLVM
+KBUILD_AFLAGS	+= -Wa,-gdwarf-2
+endif
+endif
+
 ifdef CONFIG_DEBUG_INFO_REDUCED
 DEBUG_CFLAGS	+= -fno-var-tracking
 ifdef CONFIG_CC_IS_GCC
-- 
2.37.2.672.g94769d06f0-goog

