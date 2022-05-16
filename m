Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DB052929A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349302AbiEPVPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349133AbiEPVPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:15:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B888317E28
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:10:13 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2fedfd0f5b2so44473577b3.16
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BmTyv5Df5nSkvL+7PwI+QdbCtOf+cNe9vmiXu33ntQI=;
        b=gptOuy544f1/kWDiF/3OwcmGk6scE1yCINr+MYB1fM6wQOI6FyysBHER/hQTOSK0b+
         MaV+lyiNd6H08pwzyCgMNFopwYNwi/ySdFT99VpNmwgQEw0rEy19FI8sloRnORfz9EV4
         YuA8+Csdh3kYQlEkStrZ0CpdJcbK+x+1D+bsBF5GlIIousYpIEVQAE3MkbbjAsA60HDM
         jP9FqLob+qAOGNb6Ycu0ImKBZ1mi+hSyanggzGdQSkDubEMBbMo3sfYBAr0LDXQzZdaR
         JkwFLL7wq3O3irglenxPj5cF750M8ZXPb/t3wKR9aCD4OZO67kD9v4JgQWVu/llWeVVm
         8ZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BmTyv5Df5nSkvL+7PwI+QdbCtOf+cNe9vmiXu33ntQI=;
        b=A8OyU7FrjHk8I49C/AZqwoWIE96O65FM0VUmeJiMPmU4gVvmNOy0uXq1LNs9Lu7/CL
         mF8vM0yHQ53zlBClPb1hBaOHd3OG3D3e1KIxFbadCoP81tl9XSvpSly4DyzwcISrGXzt
         1DhtfEkfT8fmUVlfcqB1c3aPN//WFhf16F4DxJmXMcmLrugkB5/0VxIB7eoHocPvRx9U
         4QboJFsXqMUSkzhnLzKqBHDlMFvW1y0uESrTCCrZf0Opw8rgoqJFISU6KGPBVFJE4E9O
         6ygadqm1+rwW67Gbry/5HS8gmsvgRSk/SrxW5XUNgCwQwZN+Aqr6MaI4X/bdTrJ/Iw12
         uVdg==
X-Gm-Message-State: AOAM5335PdL2IffJ+x5juMMqQEXsTxJ+q3tx9D8ptToRljp7mhgE2/tt
        sUzF52PB/LYozNcH48kiQVKsHBCJeUZ+2lkMdcM=
X-Google-Smtp-Source: ABdhPJyMla5qPnmYHt216sR4ibgSN7vwxmKWbie1i9N4867KZ+Hc7TO27zSrR5W1Qkojj5JAsQSKdVVdoFJA+sTbuZw=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:2ef0:b8de:b9c8:da45])
 (user=ndesaulniers job=sendgmr) by 2002:a25:d116:0:b0:64d:6fe1:4dc5 with SMTP
 id i22-20020a25d116000000b0064d6fe14dc5mr11663959ybg.576.1652735412883; Mon,
 16 May 2022 14:10:12 -0700 (PDT)
Date:   Mon, 16 May 2022 14:09:54 -0700
In-Reply-To: <20220516210954.1660716-1-ndesaulniers@google.com>
Message-Id: <20220516210954.1660716-5-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20220516210954.1660716-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1652735394; l=3775;
 s=20211004; h=from:subject; bh=+s618NXBymdAo9VdYorCW3hWAXdQktAqz3laN51+p0c=;
 b=OVKnwODfYq9bHW9OJKqrl5qkJCDSXoxeW3Uqh+U1PMMqzJNX8xSLFGLaDqfYUfRMRaRK9PaeLrVs
 k97zmrYECFqtsXsQ5YEhv3E7FzsuxYTtWcX5oD9dXLdHurNhF4CA
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 4/4] ARM: pass -march= only to compiler
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Arnd Bergmann <arnd@arndb.de>, Ard@google.com,
        Biesheuvel@google.com
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When both -march= and -Wa,-march= are specified for assembler or
assembler-with-cpp sources, GCC and Clang will prefer the -Wa,-march=
value but Clang will warn that -march= is unused.

warning: argument unused during compilation: '-march=armv6k'
[-Wunused-command-line-argument]

This is the top group of warnings we observe when using clang to
assemble the kernel via `ARCH=arm make LLVM=1`.

Split the arch-y make variable into two, so that -march= flags only get
passed to the compiler, not the assembler. -D flags are added to
KBUILD_CPPFLAGS which is used for both C and assembler-with-cpp sources.

Link: https://github.com/ClangBuiltLinux/linux/issues/1315
Link: https://github.com/ClangBuiltLinux/linux/issues/1587
Link: https://lore.kernel.org/llvm/628249e8.1c69fb81.d20fd.02ea@mx.google.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/Makefile | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 1029c2503aef..47a300f6f99c 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -57,21 +57,34 @@ endif
 KBUILD_CFLAGS	+= $(call cc-option,-fno-ipa-sra)
 
 # This selects which instruction set is used.
+arch-$(CONFIG_CPU_32v7M)	:=-march=armv7-m
+arch-$(CONFIG_CPU_32v7)		:=-march=armv7-a
+arch-$(CONFIG_CPU_32v6)		:=-march=armv6
+# Only override the compiler option if ARMv6. The ARMv6K extensions are
+# always available in ARMv7
+ifeq ($(CONFIG_CPU_32v6),y)
+arch-$(CONFIG_CPU_32v6K)	:=-march=armv6k
+endif
+arch-$(CONFIG_CPU_32v5)		:=-march=armv5te
+arch-$(CONFIG_CPU_32v4T)	:=-march=armv4t
+arch-$(CONFIG_CPU_32v4)		:=-march=armv4
+arch-$(CONFIG_CPU_32v3)		:=-march=armv3m
+
 # Note that GCC does not numerically define an architecture version
 # macro, but instead defines a whole series of macros which makes
 # testing for a specific architecture or later rather impossible.
-arch-$(CONFIG_CPU_32v7M)	:=-D__LINUX_ARM_ARCH__=7 -march=armv7-m
-arch-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7 -march=armv7-a
-arch-$(CONFIG_CPU_32v6)		:=-D__LINUX_ARM_ARCH__=6 -march=armv6
-# Only override the compiler opt:ion if ARMv6. The ARMv6K extensions are
+cpp-$(CONFIG_CPU_32v7M)		:=-D__LINUX_ARM_ARCH__=7
+cpp-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7
+cpp-$(CONFIG_CPU_32v6)		:=-D__LINUX_ARM_ARCH__=6
+# Only override the compiler option if ARMv6. The ARMv6K extensions are
 # always available in ARMv7
 ifeq ($(CONFIG_CPU_32v6),y)
-arch-$(CONFIG_CPU_32v6K)	:=-D__LINUX_ARM_ARCH__=6 -march=armv6k
+cpp-$(CONFIG_CPU_32v6K)		:=-D__LINUX_ARM_ARCH__=6
 endif
-arch-$(CONFIG_CPU_32v5)		:=-D__LINUX_ARM_ARCH__=5 -march=armv5te
-arch-$(CONFIG_CPU_32v4T)	:=-D__LINUX_ARM_ARCH__=4 -march=armv4t
-arch-$(CONFIG_CPU_32v4)		:=-D__LINUX_ARM_ARCH__=4 -march=armv4
-arch-$(CONFIG_CPU_32v3)		:=-D__LINUX_ARM_ARCH__=3 -march=armv3m
+cpp-$(CONFIG_CPU_32v5)		:=-D__LINUX_ARM_ARCH__=5
+cpp-$(CONFIG_CPU_32v4T)		:=-D__LINUX_ARM_ARCH__=4
+cpp-$(CONFIG_CPU_32v4)		:=-D__LINUX_ARM_ARCH__=4
+cpp-$(CONFIG_CPU_32v3)		:=-D__LINUX_ARM_ARCH__=3
 
 # This selects how we optimise for the processor.
 tune-$(CONFIG_CPU_ARM7TDMI)	:=-mtune=arm7tdmi
@@ -123,8 +136,9 @@ AFLAGS_ISA	:=$(CFLAGS_ISA)
 endif
 
 # Need -Uarm for gcc < 3.x
+KBUILD_CPPFLAGS	+=$(cpp-y)
 KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
-KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
+KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) -Wa,$(arch-y) $(tune-y) -include asm/unified.h -msoft-float
 
 CHECKFLAGS	+= -D__arm__
 
-- 
2.36.0.550.gb090851708-goog

