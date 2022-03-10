Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADAD4D3E82
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbiCJBAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiCJBAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:00:45 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C72411B5DC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:59:46 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so6826058pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 16:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5qZevkSAmxuoLVg5aDLT92ifTO2nnGfgZ5a7Axj/RUM=;
        b=jcPUUqS9Je3Vp9gbZSR6TalzMQMhaFmtIM0I77HY3cswToVnq5c3rqMDQWl8i+z5wU
         1irgIs9dxQ7v2jXtsp6YzmZwNyfmFPAj/+3mLXHrGQfF5dU66GxmobUXbn8RST+VwZ6/
         kmufg9hOI3FV01EnjhLvaI5+rbj0F2QEQF6XamWXDR5bcbvERT8QEppVoF1ybGm3tAzY
         xXuc3jie/JfFaq9lU6PrgrWaZ1AYtT7vUJaqc3vNaUqUl342uMH8Clnr+r7EWERCqY9A
         HhRYVY3utl1hecje7dhiBWFpcU4ZrINqNEwtgnZ1CykVbQa1LWuYTzxrmgx5v5Cvsl98
         x4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5qZevkSAmxuoLVg5aDLT92ifTO2nnGfgZ5a7Axj/RUM=;
        b=gnEtDFwzeflzKASZa4hPd93ZDQ4KmLi4MaX4B+ccb0TblMw5xaJl85RbvtrMQpE74a
         Ok+kRIaBhbOk+knQynzfWNCKjBjySJ2q3e6b9Je30HkvAnTVhC9ftwRt7ZRP1bwEkaE/
         LB9hCh+NN6FSdlu1HTotEcLngDoXnW2uBcDYOoD2VkJb0u62DQtrmxxpEfen6eRQlhyV
         9fIp7VnZBbZDM+Uh56mUevxmxvI0ueYSSNnisj4abFyQC7z5O1sUw6UMa5lRfn9U8n0Z
         jqPmiKxzaeCMDERu1S4SrMq2n4UdGcbjgVGerFYDT/xoLy8Wd9G3hXR1DUBgOAEjSVy+
         TEZA==
X-Gm-Message-State: AOAM531HmQT8gxT24jesfvHNHvAfeTkiTIz2sANiXVPRsf98UXGK91bs
        /vn58YuE7R1i3NtsoIiW1nU=
X-Google-Smtp-Source: ABdhPJw7oqhdzxafv34V0ur32R3vtwbCyqOkVYsBriNGgv2bI5X8MM7lhwv3wL5GRkENCxzaWHJjUA==
X-Received: by 2002:a17:90a:4890:b0:1bf:654e:e1a0 with SMTP id b16-20020a17090a489000b001bf654ee1a0mr13351280pjh.113.1646873985542;
        Wed, 09 Mar 2022 16:59:45 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:6f34:be93:349a:f478])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090a390c00b001bf7b033e21sm3782606pjb.8.2022.03.09.16.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 16:59:44 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: make secondary reset vector support conditional
Date:   Wed,  9 Mar 2022 16:59:35 -0800
Message-Id: <20220310005935.1260003-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Whether xtensa cores start from primary or secondary reset vector is
configurable and may be chosen by board designer or controlled at
runtime. When secondary reset vector is unused its location in memory
may not be writable.
Make secondary reset vector support conditional and don't build and load
secondary reset vector code when it is disabled.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig              | 9 +++++++++
 arch/xtensa/kernel/Makefile      | 3 ++-
 arch/xtensa/kernel/setup.c       | 2 +-
 arch/xtensa/kernel/vmlinux.lds.S | 4 ++--
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index cf03ed54c8f0..a02c3388f521 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -227,6 +227,15 @@ config HOTPLUG_CPU
 
 	  Say N if you want to disable CPU hotplug.
 
+config SECONDARY_RESET_VECTOR
+	bool "Secondary cores use alternative reset vector"
+	default y
+	depends on HAVE_SMP
+	help
+	  Secondary cores may be configured to use alternative reset vector,
+	  or all cores may use primary reset vector.
+	  Say Y here to supply handler for the alternative reset location.
+
 config FAST_SYSCALL_XTENSA
 	bool "Enable fast atomic syscalls"
 	default n
diff --git a/arch/xtensa/kernel/Makefile b/arch/xtensa/kernel/Makefile
index d4082c6a121b..5fd6cd15e0fb 100644
--- a/arch/xtensa/kernel/Makefile
+++ b/arch/xtensa/kernel/Makefile
@@ -13,7 +13,8 @@ obj-$(CONFIG_MMU) += pci-dma.o
 obj-$(CONFIG_PCI) += pci.o
 obj-$(CONFIG_MODULES) += xtensa_ksyms.o module.o
 obj-$(CONFIG_FUNCTION_TRACER) += mcount.o
-obj-$(CONFIG_SMP) += smp.o mxhead.o
+obj-$(CONFIG_SMP) += smp.o
+obj-$(CONFIG_SECONDARY_RESET_VECTOR) += mxhead.o
 obj-$(CONFIG_XTENSA_VARIANT_HAVE_PERF_EVENTS) += perf_event.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT) += hw_breakpoint.o
 obj-$(CONFIG_S32C1I_SELFTEST) += s32c1i_selftest.o
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 3f1842891482..9191738f9941 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -349,7 +349,7 @@ void __init setup_arch(char **cmdline_p)
 
 #endif /* CONFIG_VECTORS_ADDR */
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_SECONDARY_RESET_VECTOR
 	mem_reserve(__pa(_SecondaryResetVector_text_start),
 		    __pa(_SecondaryResetVector_text_end));
 #endif
diff --git a/arch/xtensa/kernel/vmlinux.lds.S b/arch/xtensa/kernel/vmlinux.lds.S
index eee270a039a4..965a3952c47b 100644
--- a/arch/xtensa/kernel/vmlinux.lds.S
+++ b/arch/xtensa/kernel/vmlinux.lds.S
@@ -207,7 +207,7 @@ SECTIONS
     RELOCATE_ENTRY(_xip_data, .data);
     RELOCATE_ENTRY(_xip_init_data, .init.data);
 #endif
-#if defined(CONFIG_SMP)
+#if defined(CONFIG_SECONDARY_RESET_VECTOR)
     RELOCATE_ENTRY(_SecondaryResetVector_text,
 		   .SecondaryResetVector.text);
 #endif
@@ -303,7 +303,7 @@ SECTIONS
 #define LAST .DoubleExceptionVector.text
 
 #endif
-#if defined(CONFIG_SMP)
+#if defined(CONFIG_SECONDARY_RESET_VECTOR)
 
   SECTION_VECTOR4 (_SecondaryResetVector_text,
 		  .SecondaryResetVector.text,
-- 
2.30.2

