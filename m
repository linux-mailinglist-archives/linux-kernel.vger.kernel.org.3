Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD3452EB60
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348857AbiETMAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348856AbiETMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:00:31 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FDE3F881
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:00:29 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DC6DD3F1F7
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653048027;
        bh=QoaPiq4fPTA6G3V+mSGQc3xph8tZR7IAsq6+ZAgT0A4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=sKslWemWhZ6Q++u5L+DLiGypqCwVaL+u5jSvs8dRHshyRYt+4CvxPEJqrvo3+ahHa
         xdg7qKTOyQ6Iok9WaZ2uSNLyFNhn2lUg+7NxpbcA4BigXvbrZElwIJ3bwDWKcWLJD1
         o8ze3P/DFXX1bTp/Mv1bCXDIQSr9gZoqLK5fm0xMBEL4uk57Y5awBieAG9jTNFJD8/
         BkciK4JO6VhjWIks/GPaWu46MuRwjvwYHpWMUAdakXcTPbEKaORJ9ml4a5NiEE1zJg
         /MsqcxxBObL1D+HVysNQnFQ6TZ3tipeJtlQzVfmi7mFsaJkV71RmzOEHaee0WPqQKB
         Yvu5czcWpOEgg==
Received: by mail-ed1-f70.google.com with SMTP id o10-20020aa7c7ca000000b0042a4f08405fso5514556eds.22
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QoaPiq4fPTA6G3V+mSGQc3xph8tZR7IAsq6+ZAgT0A4=;
        b=d2zX856NK6ge1XNxhOTLpSJJJLvTcj/wh/FYrt66fF7SHBM3cqY7J2MKXpOjpkaLYZ
         9NTVt9wCdCmuJgCzwYH5lGf+1wHLkFv7fPGUJG0kf02GTVhv5Nyp4Jv/8dPurMoApVOa
         afdf5LCU54IK45+igUf6Q7u6D6zn1fUIUC2PVqQYeAeVexrjlpLRKWczJM34+dpRoMRk
         zG3wyp5On7qOIo9nXzNKnJQORecAmpwgQYNjqjiVqnIrMINyGCIewgiwter6iEGQTkkq
         Z1f8Oqb13xPB4lzPbZ5eS36XBsLqAuVzVY+CFMhXqAyhFt9TnJSZxK6TD9O3xkB0WMPQ
         9udg==
X-Gm-Message-State: AOAM5312G0CmA7SpgUJ2sNvODLuSaw0bVf+uupRaKlndJMgebp4DEgSR
        pCHdAHVMFwUC/ZyTbQ0uK9X2gF1uyiEiG1EQTSWUiau+bi34om6EXreERFh1HkSWMTeu6wONsvp
        lCFbb28r0ijHO9c5MO+zLz6QxHIYjFSrjSLe4qCGjaA==
X-Received: by 2002:a17:907:1c01:b0:6f4:2692:e23 with SMTP id nc1-20020a1709071c0100b006f426920e23mr8218173ejc.243.1653048025197;
        Fri, 20 May 2022 05:00:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjdIpS5lf1o/Ls6OBum8Ss6pStZxh6kQPYL97iuWOYjg+EuIR/jTzAtO0AaRPc7ixliuARsQ==
X-Received: by 2002:a17:907:1c01:b0:6f4:2692:e23 with SMTP id nc1-20020a1709071c0100b006f426920e23mr8218152ejc.243.1653048024940;
        Fri, 20 May 2022 05:00:24 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id i14-20020a1709067a4e00b006fea4d258cfsm892227ejo.147.2022.05.20.05.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 05:00:24 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux-ia64@vger.kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] ia64: Kconfig: Fix indentation and add comments
Date:   Fri, 20 May 2022 14:00:21 +0200
Message-Id: <20220520120021.148069-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

While add it, add trailing comments to endif and endmenu statements for
better readability.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/ia64/Kconfig | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index cb93769a9f2a..caf2ace768bc 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -259,19 +259,19 @@ config PERMIT_BSP_REMOVE
 	depends on HOTPLUG_CPU
 	default n
 	help
-	Say Y here if your platform SAL will support removal of BSP with HOTPLUG_CPU
-	support. 
+	  Say Y here if your platform SAL will support removal of BSP with HOTPLUG_CPU
+	  support.
 
 config FORCE_CPEI_RETARGET
 	bool "Force assumption that CPEI can be re-targeted"
 	depends on PERMIT_BSP_REMOVE
 	default n
 	help
-	Say Y if you need to force the assumption that CPEI can be re-targeted to
-	any cpu in the system. This hint is available via ACPI 3.0 specifications.
-	Tiger4 systems are capable of re-directing CPEI to any CPU other than BSP.
-	This option it useful to enable this feature on older BIOS's as well.
-	You can also enable this by using boot command line option force_cpei=1.
+	  Say Y if you need to force the assumption that CPEI can be re-targeted to
+	  any cpu in the system. This hint is available via ACPI 3.0 specifications.
+	  Tiger4 systems are capable of re-directing CPEI to any CPU other than BSP.
+	  This option it useful to enable this feature on older BIOS's as well.
+	  You can also enable this by using boot command line option force_cpei=1.
 
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
@@ -335,7 +335,7 @@ config IA64_PALINFO
 config IA64_MC_ERR_INJECT
 	tristate "MC error injection support"
 	help
-	  Adds support for MC error injection. If enabled, the kernel 
+	  Adds support for MC error injection. If enabled, the kernel
 	  will provide a sysfs interface for user applications to
 	  call MC error injection PAL procedures to inject various errors.
 	  This is a useful tool for MCA testing.
@@ -379,12 +379,12 @@ config KEXEC
 	  made.
 
 config CRASH_DUMP
-	  bool "kernel crash dumps"
-	  depends on IA64_MCA_RECOVERY && (!SMP || HOTPLUG_CPU)
-	  help
-	    Generate crash dump after being started by kexec.
+	bool "kernel crash dumps"
+	depends on IA64_MCA_RECOVERY && (!SMP || HOTPLUG_CPU)
+	help
+	  Generate crash dump after being started by kexec.
 
-endmenu
+endmenu # "Processor type and features"
 
 menu "Power management and ACPI options"
 
@@ -395,10 +395,10 @@ source "drivers/acpi/Kconfig"
 if PM
 menu "CPU Frequency scaling"
 source "drivers/cpufreq/Kconfig"
-endmenu
-endif
+endmenu # "CPU Frequency scaling"
+endif # PM
 
-endmenu
+endmenu # "Power management and ACPI options"
 
 config MSPEC
 	tristate "Memory special operations driver"
-- 
2.32.0

