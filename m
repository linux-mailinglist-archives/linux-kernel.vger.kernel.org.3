Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D3652A47F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348617AbiEQOO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348567AbiEQOOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:14:41 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE094F446
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:14:40 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 37A7F3F5EF
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652796879;
        bh=KRqMU95ectLf1biwXZ9JbXYqJSOfFsXEinRiaScCjPk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=F2+PNAsC7Wv0ddjsw9XdCptQs31u6bTdrbH/JZPb+oJgr6wmsgVCWk3pxq2fK3Oaq
         2pKhLUSbueLly1mvEYUQf9waT8tlZ/C6mUJCgAYbixkbrLOhnaUr49gu4rUf6g8iAR
         nNHz2M3ZY3lHnSCsTd+cqiPtHmZC7dV6PNtMSzvY/fBwm0BFMdTtWPIPik8Z/rPoIK
         3+758QQfRO7jFXYMGCEMUB6k2p4umU7M7Gh+MJ2/pTKvWkS+Tj54w2KMNUefpcYYKr
         eWgp/uYEnyvjlNeQY7thhHqAdw7Xgr+FwlvvSNk2QUgfJCBN47tCfLjvsE9l28l/+k
         yAdqoSe+6zj7Q==
Received: by mail-ej1-f70.google.com with SMTP id nb10-20020a1709071c8a00b006e8f89863ceso7455851ejc.18
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KRqMU95ectLf1biwXZ9JbXYqJSOfFsXEinRiaScCjPk=;
        b=19D0gStBrazDPn2HFv/FWqJ9e2sq1Ghhq0jvgg3gL8n4HSrugVl9Cm2dGbHJBCm555
         f+F3R8YHM2FQSMhDtOZMTrGkpHXbno+ezZCE607WZCCTWfvTncVtQJ3D4q6srLftRrpb
         zpoYQBQWuwxiRdZ1TJLl3dS6V9tOU38jsF9qZmRP/8Uk1o7N0qbAmR2wh6yLHfYEK2SA
         Z4ssIpewTw/C83LWNwxdpUoTTIy9BJ+BjOHVMCgRLG1CA8h4MBPE9godRf2xIJJ7W74T
         CsqtPg4wpj0k+a88bkOYEipT2/RuGSn8b71lFZty6oyJtlwOk//IYUU5lOqQo2Z2Zkx7
         vqpA==
X-Gm-Message-State: AOAM532hce8a+dM/dOM7klTKh3/OT9RfQ70gdxw/jeY7b3quD7CLTdi5
        HRjO0Fk/xqPLYCTVE+QjMWN/NzQcVICPygWf6zkNlq8iWD77Jb2+HTZBVZtq6Yg5jOIovqodmCm
        ++vaddV3gtVuwdhiMQOrI/DAsPooDcfWtWNlhMq/dKw==
X-Received: by 2002:a05:6402:331a:b0:42a:cbcc:dd53 with SMTP id e26-20020a056402331a00b0042acbccdd53mr2568831eda.8.1652796879031;
        Tue, 17 May 2022 07:14:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxKdjqKHc+dVjB63y1xSh3CuNvjTb9+wICuNc56GAq0XqWnVjVqv54Uo5uY7nBvnZzMGp7wg==
X-Received: by 2002:a05:6402:331a:b0:42a:cbcc:dd53 with SMTP id e26-20020a056402331a00b0042acbccdd53mr2568801eda.8.1652796878822;
        Tue, 17 May 2022 07:14:38 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id em9-20020a170907288900b006f3ef214e4fsm1079265ejc.181.2022.05.17.07.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:14:38 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 3/3] ARM: Kconfig.debug: Fix indentation
Date:   Tue, 17 May 2022 16:14:24 +0200
Message-Id: <20220517141424.331759-4-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220517141424.331759-1-juergh@canonical.com>
References: <20220517141424.331759-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/arm/Kconfig.debug | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 0c9497d549e3..4b00b1fd9ab3 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -22,28 +22,28 @@ config DEBUG_WX
 	depends on MMU
 	select ARM_PTDUMP_CORE
 	help
-		Generate a warning if any W+X mappings are found at boot.
+	  Generate a warning if any W+X mappings are found at boot.
 
-		This is useful for discovering cases where the kernel is leaving
-		W+X mappings after applying NX, as such mappings are a security risk.
+	  This is useful for discovering cases where the kernel is leaving
+	  W+X mappings after applying NX, as such mappings are a security risk.
 
-		Look for a message in dmesg output like this:
+	  Look for a message in dmesg output like this:
 
-			arm/mm: Checked W+X mappings: passed, no W+X pages found.
+		arm/mm: Checked W+X mappings: passed, no W+X pages found.
 
-		or like this, if the check failed:
+	  or like this, if the check failed:
 
-			arm/mm: Checked W+X mappings: FAILED, <N> W+X pages found.
+		arm/mm: Checked W+X mappings: FAILED, <N> W+X pages found.
 
-		Note that even if the check fails, your kernel is possibly
-		still fine, as W+X mappings are not a security hole in
-		themselves, what they do is that they make the exploitation
-		of other unfixed kernel bugs easier.
+	  Note that even if the check fails, your kernel is possibly
+	  still fine, as W+X mappings are not a security hole in
+	  themselves, what they do is that they make the exploitation
+	  of other unfixed kernel bugs easier.
 
-		There is no runtime or memory usage effect of this option
-		once the kernel has booted up - it's a one time check.
+	  There is no runtime or memory usage effect of this option
+	  once the kernel has booted up - it's a one time check.
 
-		If in doubt, say "Y".
+	  If in doubt, say "Y".
 
 choice
 	prompt "Choose kernel unwinder"
@@ -293,7 +293,7 @@ choice
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want the debug print routines to direct
-                  their output to the CNS3xxx UART0.
+		  their output to the CNS3xxx UART0.
 
 	config DEBUG_DAVINCI_DA8XX_UART1
 		bool "Kernel low-level debugging on DaVinci DA8XX using UART1"
@@ -847,7 +847,7 @@ choice
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
-                  on Rockchip RV1108 based platforms.
+		  on Rockchip RV1108 based platforms.
 
 	config DEBUG_RV1108_UART1
 		bool "Kernel low-level debugging messages via Rockchip RV1108 UART1"
@@ -1724,7 +1724,7 @@ config DEBUG_UART_PHYS
 	default 0xffffee00 if DEBUG_AT91_SAM9263_DBGU
 	default 0xfffff200 if DEBUG_AT91_RM9200_DBGU
 	depends on ARCH_EP93XX || \
-	        DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
+		DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
 		DEBUG_QCOM_UARTDM || DEBUG_R7S72100_SCIF2 || \
 		DEBUG_R7S9210_SCIF2 || DEBUG_R7S9210_SCIF4 || \
@@ -1895,7 +1895,6 @@ config DEBUG_UNCOMPRESS
 	  When this option is set, the selected DEBUG_LL output method
 	  will be re-used for normal decompressor output on multiplatform
 	  kernels.
-	  
 
 config UNCOMPRESS_INCLUDE
 	string
-- 
2.32.0

