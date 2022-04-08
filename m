Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28704F9A7E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 18:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiDHQZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 12:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiDHQZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:25:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C916F10C515
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 09:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649434984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ofocLwjgfrlRUiguKE9lsikbmfnw6N1ZVOog+yoEC3o=;
        b=hKx3YFDPrboIbZ9mstbsG6o/SIO+YXrMTtgo0ZUZ/k3LNcpYTLMkqJKau9f5SME5q2utI9
        G4jwC9nTirQD9UgCS9s8KiR7gFPVoa4gn+a3OKNDIpme8xV93729pxuLxIzXAfGEk305qm
        k7MsOQCO/BqKB7wquKnAVtMEaxWK5Xc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-JH2oBAntP3iehww6ZgiXhQ-1; Fri, 08 Apr 2022 12:23:01 -0400
X-MC-Unique: JH2oBAntP3iehww6ZgiXhQ-1
Received: by mail-qt1-f200.google.com with SMTP id g22-20020ac870d6000000b002e20a1508ecso8060352qtp.19
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 09:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ofocLwjgfrlRUiguKE9lsikbmfnw6N1ZVOog+yoEC3o=;
        b=1KqTmKtXJniyAH3o7reCUsMSVXVV6IrOVhTvPvVMiYdkqzxrEmXNw5pWlRLV7PAP8l
         Df3zYS64biEK7MiYK0oCxVWdLrBjteC76hXlfEzc4/qS3G1McRreemr8DY+4J9prYQ2x
         sF6yCdGteSpxI7Xrw5I4ej54Y/Y5w7a8LNt2607yUEdkWMTpXkrgdvERChmUmEKqaBcp
         E/a/49484heepWbDMe7fVM+792EQkKyQ7mC3ZrjCoZnWshPGxmTWCx7CE+u+N/nzxEw0
         CYFmObH1n+FZXSkUjg5iRRHOzX41bd8l6iKngeGOCbL1AZzm7rJaBHPuxLKN38Ydh091
         /e8A==
X-Gm-Message-State: AOAM532R1HWo+5VS7NzHZL4+zhL/52TxY0V9XQKmtOFwbsLxTE95aGxq
        qq3YWaSTED/IJX0UkiAQU/SK1DHwXWFHtqV5HZnmFOGA5XbXIK8B4Rpbx/Ao/e/t/MWCCSDi0eH
        QWtZL5MstaQJqFXZJfL66o7cF
X-Received: by 2002:a05:6214:2622:b0:444:1b35:b6a5 with SMTP id gv2-20020a056214262200b004441b35b6a5mr4717034qvb.102.1649434981140;
        Fri, 08 Apr 2022 09:23:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIM9ayM7bF8aYO2zn3Ghsa6P4/1Q2tP2xWbGcFH5vNeM8F875g1oDKNWu3MONplVRltPS00g==
X-Received: by 2002:a05:6214:2622:b0:444:1b35:b6a5 with SMTP id gv2-20020a056214262200b004441b35b6a5mr4717017qvb.102.1649434980810;
        Fri, 08 Apr 2022 09:23:00 -0700 (PDT)
Received: from treble.attlocal.net ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id v7-20020ac85787000000b002e1c8376517sm17629692qta.22.2022.04.08.09.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 09:23:00 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>, x86@kernel.org
Subject: [PATCH] kbuild: Remove CONFIG_DEBUG_SECTION_MISMATCH
Date:   Fri,  8 Apr 2022 09:21:56 -0700
Message-Id: <7fad83ecde03540e65677959034315f8fbb3755e.1649434832.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modpost's section mismatch detection warns when a non-init function
references an __init function or __initdata.  Those warnings are very
useful, because __init memory is freed during boot, so the non-init
function might end up referencing or calling into some random memory.

CONFIG_DEBUG_SECTION_MISMATCH is intended to root out even more of these
issues by adding the -fno-inline-functions-called-once compiler flag,
which forces once-called static functions to not be inlined.  As
described in the option's help description:

  - Add the option -fno-inline-functions-called-once to gcc commands.
    When inlining a function annotated with __init in a non-init
    function, we would lose the section information and thus
    the analysis would not catch the illegal reference.
    This option tells gcc to inline less (but it does result in
    a larger kernel).

So it's basically a debug (non-production) option, which has the goal of
rooting out potential issues which might exist on *other* configs which
might somehow trigger different inlining decisions, without having to
build all those other configs to see the warnings directly.

But with -O2, once-called static functions are almost always inlined, so
its usefulness for rooting out mismatch warnings on other configs is
somewhere between extremely limited and non-existent.  And nowadays we
have build bots everywhere doing randconfigs continuously, which are
great for rooting out such edge cases.

Somewhat ironically, the existence of those build bots means we get a
lot of unrealistic objtool warnings being reported, due to unrealistic
inlines caused by CONFIG_DEBUG_SECTION_MISMATCH, where the only way to
silence the warnings is to force a single-called function to be inlined
with '__always_inline'.

So the limited, hypothetical benefit of "rooting out configs with
section mismatches" is outweighed by the very real downside of "adding
lots of unnecessary '__always_inline' annotations".

In fact I suspect this option has been responsible for dozens of
"convert inline to __always_inline" patches over the years.  Such
patches usually complain about the compiler's inlining decisions being
unpredictable.  It turns out this config option is the main culprit.

So considering the drawbacks of this option significantly outweigh the
benefits, especially now in the age of randconfig build bots, remove it.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 .../media/maintainer-entry-profile.rst        |  2 +-
 Makefile                                      |  5 -----
 arch/arc/configs/tb10x_defconfig              |  1 -
 arch/s390/configs/debug_defconfig             |  1 -
 arch/s390/configs/defconfig                   |  1 -
 kernel/configs/debug.config                   |  1 -
 lib/Kconfig.debug                             | 22 -------------------
 .../selftests/wireguard/qemu/debug.config     |  1 -
 8 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/Documentation/driver-api/media/maintainer-entry-profile.rst b/Documentation/driver-api/media/maintainer-entry-profile.rst
index ffc712a5f632..06106d7e7fae 100644
--- a/Documentation/driver-api/media/maintainer-entry-profile.rst
+++ b/Documentation/driver-api/media/maintainer-entry-profile.rst
@@ -123,7 +123,7 @@ Those tests need to pass before the patches go upstream.
 
 Also, please notice that we build the Kernel with::
 
-	make CF=-D__CHECK_ENDIAN__ CONFIG_DEBUG_SECTION_MISMATCH=y C=1 W=1 CHECK=check_script
+	make CF=-D__CHECK_ENDIAN__ C=1 W=1 CHECK=check_script
 
 Where the check script is::
 
diff --git a/Makefile b/Makefile
index 8c7de9a72ea2..3d7ea1a23558 100644
--- a/Makefile
+++ b/Makefile
@@ -871,11 +871,6 @@ KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_FLAGS_USING)
 KBUILD_AFLAGS	+= $(CC_FLAGS_USING)
 endif
 
-# We trigger additional mismatches with less inlining
-ifdef CONFIG_DEBUG_SECTION_MISMATCH
-KBUILD_CFLAGS += -fno-inline-functions-called-once
-endif
-
 ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
 KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
 LDFLAGS_vmlinux += --gc-sections
diff --git a/arch/arc/configs/tb10x_defconfig b/arch/arc/configs/tb10x_defconfig
index a12656ec0072..5acf8cc3e7b0 100644
--- a/arch/arc/configs/tb10x_defconfig
+++ b/arch/arc/configs/tb10x_defconfig
@@ -96,7 +96,6 @@ CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
 CONFIG_HEADERS_INSTALL=y
 CONFIG_HEADERS_CHECK=y
-CONFIG_DEBUG_SECTION_MISMATCH=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DEBUG_STACKOVERFLOW=y
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 498bed9b261b..66a4c65a4bd8 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -791,7 +791,6 @@ CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_GDB_SCRIPTS=y
 CONFIG_HEADERS_INSTALL=y
-CONFIG_DEBUG_SECTION_MISMATCH=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_PAGEALLOC=y
 CONFIG_PAGE_OWNER=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 61e36b999f67..0e6ae36cf401 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -776,7 +776,6 @@ CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_GDB_SCRIPTS=y
-CONFIG_DEBUG_SECTION_MISMATCH=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_WX=y
 CONFIG_PTDUMP_DEBUGFS=y
diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
index e8db8d938661..0c1a5d64febb 100644
--- a/kernel/configs/debug.config
+++ b/kernel/configs/debug.config
@@ -18,7 +18,6 @@ CONFIG_SYMBOLIC_ERRNAME=y
 #
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
-CONFIG_DEBUG_SECTION_MISMATCH=y
 CONFIG_FRAME_WARN=2048
 CONFIG_SECTION_MISMATCH_WARN_ONLY=y
 #
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 075cd25363ac..e52f851e9e3b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -425,28 +425,6 @@ config HEADERS_INSTALL
 	  user-space program samples. It is also needed by some features such
 	  as uapi header sanity checks.
 
-config DEBUG_SECTION_MISMATCH
-	bool "Enable full Section mismatch analysis"
-	depends on CC_IS_GCC
-	help
-	  The section mismatch analysis checks if there are illegal
-	  references from one section to another section.
-	  During linktime or runtime, some sections are dropped;
-	  any use of code/data previously in these sections would
-	  most likely result in an oops.
-	  In the code, functions and variables are annotated with
-	  __init,, etc. (see the full list in include/linux/init.h),
-	  which results in the code/data being placed in specific sections.
-	  The section mismatch analysis is always performed after a full
-	  kernel build, and enabling this option causes the following
-	  additional step to occur:
-	  - Add the option -fno-inline-functions-called-once to gcc commands.
-	    When inlining a function annotated with __init in a non-init
-	    function, we would lose the section information and thus
-	    the analysis would not catch the illegal reference.
-	    This option tells gcc to inline less (but it does result in
-	    a larger kernel).
-
 config SECTION_MISMATCH_WARN_ONLY
 	bool "Make section mismatch errors non-fatal"
 	default y
diff --git a/tools/testing/selftests/wireguard/qemu/debug.config b/tools/testing/selftests/wireguard/qemu/debug.config
index 2b321b8a96cf..e737ce3b324e 100644
--- a/tools/testing/selftests/wireguard/qemu/debug.config
+++ b/tools/testing/selftests/wireguard/qemu/debug.config
@@ -57,7 +57,6 @@ CONFIG_USER_STACKTRACE_SUPPORT=y
 CONFIG_DEBUG_SG=y
 CONFIG_DEBUG_NOTIFIERS=y
 CONFIG_X86_DEBUG_FPU=y
-CONFIG_DEBUG_SECTION_MISMATCH=y
 CONFIG_DEBUG_PAGEALLOC=y
 CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
 CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
-- 
2.34.1

