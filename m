Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4230455F028
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 23:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiF1VGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 17:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiF1VG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:06:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577223A195
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:06:24 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-317b370cec1so113353867b3.19
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NBjk3KmSTe6O3r+cvxYAfwMjmFb8XoFUly9qB4s0+Dc=;
        b=APNpMrpOxLHssUGRCp2dDrS3U6YDR8iMB9nY17tSekazF526G5tnofYcL+GneEuIZq
         hwfpA5ih5ST2vJUY9ymc30ltjAQjNu9EcZrTXbBErDPAYmqsjCf4FF92zmM57HL6jXsv
         LHZ2cQ9iGYKfcGfulX5G5FbKv/A86hgHPWTUt91XKAkWDwQtSelnXWA7E961ENKU0wEx
         HDJqKslHHoT+0dvcREMQQkYnXgN73t/2I+gGC5DCxjw+U19FzS8RsJIOzWKprgGyO0PG
         yt45zBIWo6DdlPfd6gdbfXGGSKc7Js8tqVdY6qDrumSz9qP5hG8AuDxVr1zlYoK3A6q+
         V60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NBjk3KmSTe6O3r+cvxYAfwMjmFb8XoFUly9qB4s0+Dc=;
        b=ncB4y+z3nQlCVroDrt7wF7urcXU2MwDz+rT7KvcFZhhSFl0aVoB4Avw2/B/7IQl+4H
         H0zRhfaWZTfBcxfxV3wK4/S4XSIzRrkdm/IDa7cS/vEFcDZ7OL1Qpf3/4cz84+j/4vPh
         N0qU+6ytkBkoAZzP1gGckMRTxbYpKA+ptqeTHET98VIamdjmB67gFLm7i3q/X3nvX++2
         TGLqdIkHGPthr2ufZWAyWd8lJeogAARioFDqqzOqw6TQLqdQEiV07djJ+lN2YNNM9HyJ
         aDUdgejBbMstds+EO0gS80PwetJESMKKxry4lPQKM9vxOOTVfrnAOz/d0H7XsDexRWbw
         bDAA==
X-Gm-Message-State: AJIora9OiXcJHnx0VqHWlASfkGi0Zr5CtqUxrZMbvKsqEnn7Zcb8WfTL
        BtSbm4pr1Sdzq/A2lggiPLPdt3Pi24JYY9slJMI=
X-Google-Smtp-Source: AGRyM1uqbxh15X0ffrMA2K/9ugnCtBuuiODCCvECKPIeqo/pFve31rlV2dvAY//fOQBVv4rrTPbVOCg7ZxjYvEYYrYU=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:fc06:3025:c99d:2af7])
 (user=ndesaulniers job=sendgmr) by 2002:a25:2185:0:b0:66c:97fb:f6ba with SMTP
 id h127-20020a252185000000b0066c97fbf6bamr18361471ybh.169.1656450383533; Tue,
 28 Jun 2022 14:06:23 -0700 (PDT)
Date:   Tue, 28 Jun 2022 14:04:07 -0700
In-Reply-To: <CA+55aFz2sNBbZyg-_i8_Ldr2e8o9dfvdSfHHuRzVtP2VMAUWPg@mail.gmail.com>
Message-Id: <20220628210407.3343118-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CA+55aFz2sNBbZyg-_i8_Ldr2e8o9dfvdSfHHuRzVtP2VMAUWPg@mail.gmail.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1656450247; l=9154;
 s=20211004; h=from:subject; bh=gvpD1o/b8JZSfOr8fCp8TXjM9bVhNEAdI7IvLmzBEEE=;
 b=nVhj4qFBlP9ZwYTN7PMDRYc5i+NSY2lfu1PyHgoG7UiKXpO4/BxXiJmVb9CLvzUlW9Ck7UIlIhpn
 CPuZETO6BScAKn5vPYakOUaU35pM/Wk9wOP/6OzF2BDoriqIdGNb
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] kbuild: drop support for CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     arnd@arndb.de, bigeasy@linutronix.de, chris@chrisdown.name,
        dmitry.torokhov@gmail.com, gustavoars@kernel.org,
        john.ogness@linutronix.de, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikoxyzzz@gmail.com,
        nathan@kernel.org, ndesaulniers@google.com, oleksandr@redhat.com,
        quic_eberman@quicinc.com, seanjc@google.com, tglx@linutronix.de,
        vbabka@suse.cz, x86@kernel.org, linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vgupta@kernel.org>
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

The difference in most compilers between `-O3` and `-O2` is mostly down
to whether loops with statically determinable trip counts are fully
unrolled vs unrolled to a multiple of SIMD width.

This patch is effectively a revert of
commit 15f5db60a137 ("kbuild,arc: add
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3 for ARC") without re-adding
ARCH_CFLAGS

Ever since
commit cfdbc2e16e65 ("ARC: Build system: Makefiles, Kconfig, Linker
script")
ARC has been built with -O3, though the reason for doing so was not
specified in inline comments or the commit message. This commit does not
re-add -O3 to arch/arc/Makefile.

Folks looking to experiment with `-O3` (or any compiler flag for that
matter) may pass them along to the command line invocation of make:

$ make KCFLAGS=-O3

Code that looks to re-add an explicit Kconfig option for `-O3` should
provide:
1. A rigorous and reproducible performance profile of a reasonable
   userspace workload that demonstrates a hot loop in the kernel that
   would benefit from `-O3` over `-O2`.
2. Disassembly of said loop body before and after.
3. Provides stats on terms of increase in file size.

Link: https://lore.kernel.org/linux-kbuild/CA+55aFz2sNBbZyg-_i8_Ldr2e8o9dfvdSfHHuRzVtP2VMAUWPg@mail.gmail.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile                                   | 2 --
 arch/arc/configs/axs101_defconfig          | 1 -
 arch/arc/configs/axs103_defconfig          | 1 -
 arch/arc/configs/axs103_smp_defconfig      | 1 -
 arch/arc/configs/haps_hs_defconfig         | 1 -
 arch/arc/configs/haps_hs_smp_defconfig     | 1 -
 arch/arc/configs/hsdk_defconfig            | 1 -
 arch/arc/configs/nsim_700_defconfig        | 1 -
 arch/arc/configs/nsimosci_defconfig        | 1 -
 arch/arc/configs/nsimosci_hs_defconfig     | 1 -
 arch/arc/configs/nsimosci_hs_smp_defconfig | 1 -
 arch/arc/configs/tb10x_defconfig           | 1 -
 arch/arc/configs/vdk_hs38_defconfig        | 1 -
 arch/arc/configs/vdk_hs38_smp_defconfig    | 1 -
 init/Kconfig                               | 7 -------
 15 files changed, 22 deletions(-)

diff --git a/Makefile b/Makefile
index 8973b285ce6c..b69f6cd7f2e2 100644
--- a/Makefile
+++ b/Makefile
@@ -755,8 +755,6 @@ KBUILD_CFLAGS	+= $(call cc-disable-warning, address-of-packed-member)
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
 KBUILD_CFLAGS += -O2
-else ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
-KBUILD_CFLAGS += -O3
 else ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS += -Os
 endif
diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_defconfig
index 0016149f9583..e31a8ebc3ecc 100644
--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -9,7 +9,6 @@ CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
diff --git a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_defconfig
index 5b031582a1cf..e0e8567f0d75 100644
--- a/arch/arc/configs/axs103_defconfig
+++ b/arch/arc/configs/axs103_defconfig
@@ -9,7 +9,6 @@ CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
diff --git a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs103_smp_defconfig
index d4eec39e0112..fcbc952bc75b 100644
--- a/arch/arc/configs/axs103_smp_defconfig
+++ b/arch/arc/configs/axs103_smp_defconfig
@@ -9,7 +9,6 @@ CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
diff --git a/arch/arc/configs/haps_hs_defconfig b/arch/arc/configs/haps_hs_defconfig
index 7337cdf4ffdd..d87ad7e88d62 100644
--- a/arch/arc/configs/haps_hs_defconfig
+++ b/arch/arc/configs/haps_hs_defconfig
@@ -11,7 +11,6 @@ CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
diff --git a/arch/arc/configs/haps_hs_smp_defconfig b/arch/arc/configs/haps_hs_smp_defconfig
index bc927221afc0..8d82cdb7f86a 100644
--- a/arch/arc/configs/haps_hs_smp_defconfig
+++ b/arch/arc/configs/haps_hs_smp_defconfig
@@ -11,7 +11,6 @@ CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index aa000075a575..f856b03e0fb5 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -9,7 +9,6 @@ CONFIG_NAMESPACES=y
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
diff --git a/arch/arc/configs/nsim_700_defconfig b/arch/arc/configs/nsim_700_defconfig
index 326f6cde7826..a1ce12bf5b16 100644
--- a/arch/arc/configs/nsim_700_defconfig
+++ b/arch/arc/configs/nsim_700_defconfig
@@ -11,7 +11,6 @@ CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
diff --git a/arch/arc/configs/nsimosci_defconfig b/arch/arc/configs/nsimosci_defconfig
index bf39a0091679..ca10f4a2c823 100644
--- a/arch/arc/configs/nsimosci_defconfig
+++ b/arch/arc/configs/nsimosci_defconfig
@@ -10,7 +10,6 @@ CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
diff --git a/arch/arc/configs/nsimosci_hs_defconfig b/arch/arc/configs/nsimosci_hs_defconfig
index 7121bd71c543..31b6ec3683c6 100644
--- a/arch/arc/configs/nsimosci_hs_defconfig
+++ b/arch/arc/configs/nsimosci_hs_defconfig
@@ -10,7 +10,6 @@ CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
diff --git a/arch/arc/configs/nsimosci_hs_smp_defconfig b/arch/arc/configs/nsimosci_hs_smp_defconfig
index f9863b294a70..41a0037f48a5 100644
--- a/arch/arc/configs/nsimosci_hs_smp_defconfig
+++ b/arch/arc/configs/nsimosci_hs_smp_defconfig
@@ -8,7 +8,6 @@ CONFIG_IKCONFIG_PROC=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_KPROBES=y
diff --git a/arch/arc/configs/tb10x_defconfig b/arch/arc/configs/tb10x_defconfig
index a12656ec0072..d93b65008d4a 100644
--- a/arch/arc/configs/tb10x_defconfig
+++ b/arch/arc/configs/tb10x_defconfig
@@ -14,7 +14,6 @@ CONFIG_INITRAMFS_SOURCE="../tb10x-rootfs.cpio"
 CONFIG_INITRAMFS_ROOT_UID=2100
 CONFIG_INITRAMFS_ROOT_GID=501
 # CONFIG_RD_GZIP is not set
-CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_AIO is not set
 CONFIG_EMBEDDED=y
diff --git a/arch/arc/configs/vdk_hs38_defconfig b/arch/arc/configs/vdk_hs38_defconfig
index d7c858df520c..0c3b21416819 100644
--- a/arch/arc/configs/vdk_hs38_defconfig
+++ b/arch/arc/configs/vdk_hs38_defconfig
@@ -4,7 +4,6 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
diff --git a/arch/arc/configs/vdk_hs38_smp_defconfig b/arch/arc/configs/vdk_hs38_smp_defconfig
index 015c1d43889e..f9ad9d3ee702 100644
--- a/arch/arc/configs/vdk_hs38_smp_defconfig
+++ b/arch/arc/configs/vdk_hs38_smp_defconfig
@@ -4,7 +4,6 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
diff --git a/init/Kconfig b/init/Kconfig
index c7900e8975f1..1b4d8acc3def 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1401,13 +1401,6 @@ config CC_OPTIMIZE_FOR_PERFORMANCE
 	  with the "-O2" compiler flag for best performance and most
 	  helpful compile-time warnings.
 
-config CC_OPTIMIZE_FOR_PERFORMANCE_O3
-	bool "Optimize more for performance (-O3)"
-	depends on ARC
-	help
-	  Choosing this option will pass "-O3" to your compiler to optimize
-	  the kernel yet more for performance.
-
 config CC_OPTIMIZE_FOR_SIZE
 	bool "Optimize for size (-Os)"
 	help
-- 
2.37.0.rc0.161.g10f37bed90-goog

