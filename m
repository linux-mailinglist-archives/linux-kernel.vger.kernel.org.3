Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D02F4D3D07
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbiCIWfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238702AbiCIWfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:35:38 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04617121689
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:34:39 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id h5so1853692plf.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iqofDGyvLh9ucnd9K2IvJDYKRmWqauAqViHarwufpQo=;
        b=OADP5Tdq8IEmMkpS6qsuttrrRqtzkyntAjIyx9m7gOS2j73vT942qZA4DhUwWkRXhw
         NiVem8FWxIyiRa7hnClnEVdWuw6NzdkRx19K4RmelBn7IKON5TyNUic5QEh4Y0SXKAM8
         1D5VYGceoTDZDgTAfPE1r1/K2I6Iv2z4pWbyNbYiJNaEQnKWf1lWuRhJNmJ2V2ABJvJK
         Bj1NZCdE4MUDbs/FvYrBGvuwtHlZe+lh7QWatODVqHobR7N2eeBa6dEp2DYmntp91EpL
         tqgDpTzraqoUlc+VKxfdr08ueP506O/m52NUAQGHy2CLYAN4fMKL2k2QCrbrrMt1/AKr
         Cprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iqofDGyvLh9ucnd9K2IvJDYKRmWqauAqViHarwufpQo=;
        b=XMsEVjvtJM1Q2Cug6BZK0X2tT7mJUyW0ujhd3f+yikIBO+TXmYFpPP/YJsqm6WATps
         gcwlWh6pPkg2Bd4EzwxeENu4QyXEkym+Na0//yl+k1nFJq28YSAoERmJNPruU/vxB1K6
         ejodi7AVgtFIhme7TFsdHXjdwwrBi9+nzp6UB8l5zR3hnwem7ogmyq6+6Ye6rX1fYgal
         0ozM4gC/B82498mGA8jQ+g3ghn3ivsbTdrdA9IeZm0rkYIICm+SMVCmXEP2SXopM8rli
         gbjkX3L3BgIEASKS2zGLCXqchl2vVP5jyRZqWHrhL3+Wojhbs0ocRDVOLKu3BKPJq6CT
         SQ6A==
X-Gm-Message-State: AOAM530VTgGHQcMsMywj4C3R0k9svjl+vlwpSGVuk/RGq0h8gOQjWi3f
        nhVOksQFdYFOrcPNjBPw87M=
X-Google-Smtp-Source: ABdhPJw3GGik8ofqP7XbwJF1EfgkYIqYSlkZZCNl+r7SAtuLMEY/vW7U1uW85L91ejc+GIbmZyXIxg==
X-Received: by 2002:a17:90b:4c43:b0:1bf:8585:9baa with SMTP id np3-20020a17090b4c4300b001bf85859baamr1808359pjb.60.1646865278466;
        Wed, 09 Mar 2022 14:34:38 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:6f34:be93:349a:f478])
        by smtp.gmail.com with ESMTPSA id e14-20020a056a001a8e00b004f75cf1ab6csm3476477pfv.206.2022.03.09.14.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 14:34:37 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/2] xtensa: don't link with libgcc
Date:   Wed,  9 Mar 2022 14:34:18 -0800
Message-Id: <20220309223418.1253242-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220309223418.1253242-1-jcmvbkbc@gmail.com>
References: <20220309223418.1253242-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

libgcc may be absent or may have different ABI than the kernel. Don't
link with it. Drop declarations and export for helpers that are not
implemented. Use generic versions of DI mode multiplication and
comparisons. Drop register window spilling helper as it should never be
used by the compiler-generated code.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig               |  3 +++
 arch/xtensa/Makefile              |  6 +-----
 arch/xtensa/kernel/xtensa_ksyms.c | 14 --------------
 3 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 8ac599aa6d99..b324f6743073 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -20,6 +20,9 @@ config XTENSA
 	select DMA_REMAP if MMU
 	select GENERIC_ATOMIC64
 	select GENERIC_IRQ_SHOW
+	select GENERIC_LIB_CMPDI2
+	select GENERIC_LIB_MULDI3
+	select GENERIC_LIB_UCMPDI2
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index ee2769519eaf..725cd4cd8b30 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -51,13 +51,9 @@ KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(vardirs) $(plfdirs))
 
 KBUILD_DEFCONFIG := iss_defconfig
 
-# Find libgcc.a
-
-LIBGCC := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
-
 head-y		:= arch/xtensa/kernel/head.o
 
-libs-y		+= arch/xtensa/lib/ $(LIBGCC)
+libs-y		+= arch/xtensa/lib/
 
 boot		:= arch/xtensa/boot
 
diff --git a/arch/xtensa/kernel/xtensa_ksyms.c b/arch/xtensa/kernel/xtensa_ksyms.c
index d79edbb98d2a..b0bc8897c924 100644
--- a/arch/xtensa/kernel/xtensa_ksyms.c
+++ b/arch/xtensa/kernel/xtensa_ksyms.c
@@ -59,32 +59,18 @@ extern long long __ashldi3(long long, int);
 extern long long __lshrdi3(long long, int);
 extern int __divsi3(int, int);
 extern int __modsi3(int, int);
-extern long long __muldi3(long long, long long);
 extern int __mulsi3(int, int);
 extern unsigned int __udivsi3(unsigned int, unsigned int);
 extern unsigned int __umodsi3(unsigned int, unsigned int);
-extern unsigned long long __umoddi3(unsigned long long, unsigned long long);
-extern unsigned long long __udivdi3(unsigned long long, unsigned long long);
-extern int __ucmpdi2(int, int);
 
 EXPORT_SYMBOL(__ashldi3);
 EXPORT_SYMBOL(__ashrdi3);
 EXPORT_SYMBOL(__lshrdi3);
 EXPORT_SYMBOL(__divsi3);
 EXPORT_SYMBOL(__modsi3);
-EXPORT_SYMBOL(__muldi3);
 EXPORT_SYMBOL(__mulsi3);
 EXPORT_SYMBOL(__udivsi3);
 EXPORT_SYMBOL(__umodsi3);
-EXPORT_SYMBOL(__udivdi3);
-EXPORT_SYMBOL(__umoddi3);
-EXPORT_SYMBOL(__ucmpdi2);
-
-void __xtensa_libgcc_window_spill(void)
-{
-	BUG();
-}
-EXPORT_SYMBOL(__xtensa_libgcc_window_spill);
 
 unsigned int __sync_fetch_and_and_4(volatile void *p, unsigned int v)
 {
-- 
2.30.2

