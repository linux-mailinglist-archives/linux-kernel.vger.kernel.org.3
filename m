Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3F552A482
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348660AbiEQOPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348573AbiEQOOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:14:42 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9444F465
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:14:41 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2F1A33FFDF
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652796878;
        bh=KxRTaich0O2KIIuAv3r2jsA/7lZGy5FS+krvU/fZK3E=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Oe6MlVXPPKej0XXykOn+tFyktDc2xs4FfivyFsX/oyradvfEQVX8aWMP941QSaqwU
         UMGMFzQ3KiH5g2d+d4PYfe5T2iu0d5C8P9+sarZ4Qkp2jQAw40Om0a+lnHOHv1oUyl
         W8YOM7VRfvQUZcSoYVf4qlxDflyny/jUeeOVCkT7QLlx/WvBiz28Jdcc7OBy1TXk15
         hP+rHXIqSuZdH+Hpa2Tz3A5bu7xqd+5ciXYVUJCr1a7aiyH5GR0tjIQk4tgoYK03td
         Ri282/wu64MFkASDM8tgNZX57pMIStUak0JX/3l8UGvNVPh+rA89RaVEtWPk9FVH/F
         cNnmU9qK+qlPA==
Received: by mail-ej1-f70.google.com with SMTP id p7-20020a170906614700b006f87f866117so7421687ejl.21
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KxRTaich0O2KIIuAv3r2jsA/7lZGy5FS+krvU/fZK3E=;
        b=rzRX92JsqaHGeqfTACWrTQprf7mIK9HKczsXHce2FqiFSWkmbdOQiD6BCKYALZV8/3
         luaHVSYoYoPiIWAofKth1wsYfIVf0PxhqGY+2rETGqbimgvlHxgLZw7RjDs5GmSJwKpH
         Lh1QKo8e51y2NjsAeVxjnBEY4QgLRwYqzF4P2J7WPvINc54HnVR0QAvkO+FiirbhVRVw
         FhuM1KsG0DW6JLQaUc25YYARXE/+c9cbuoTy/EjdrMDJsiPjeoGSISZMdRtaoPQuoJov
         6PIi5ivfCidf3CtualViNxA1h/iXrh/cfea61JfvYHZmVCTKw+7ZcMds58Q+ttWIIvS1
         TSbw==
X-Gm-Message-State: AOAM533DZTN3Tow/StyLws5HnL9R5C8oYuooFGbG16Fu66l5JEo2GKDl
        qHvinth/vAPSL3p1u6IN8AvUBDB5o16Gcg2BOwgH/s6MhqN4JZ3y6C4bFrkLj480pP96nHAyUOw
        /XnP94ZGh/SNZ5mpKOoFdqAjtN1PaQfUAbnyKzj0vuw==
X-Received: by 2002:a05:6402:51d2:b0:428:48d0:5d05 with SMTP id r18-20020a05640251d200b0042848d05d05mr19326215edd.28.1652796877961;
        Tue, 17 May 2022 07:14:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzk8sMv2nKtt1yah+PpAN8hDgpc38foAdJDRPgHukEgDHoJhEw2QSDxpQjX2ftrDD66xEg2gw==
X-Received: by 2002:a05:6402:51d2:b0:428:48d0:5d05 with SMTP id r18-20020a05640251d200b0042848d05d05mr19326201edd.28.1652796877809;
        Tue, 17 May 2022 07:14:37 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id em9-20020a170907288900b006f3ef214e4fsm1079265ejc.181.2022.05.17.07.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:14:36 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 2/3] ARM: Kconfig-nommu: Fix indentation and quotes
Date:   Tue, 17 May 2022 16:14:23 +0200
Message-Id: <20220517141424.331759-3-juergh@canonical.com>
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

While add it, replace single quotes with double-quotes.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/arm/Kconfig-nommu | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/Kconfig-nommu b/arch/arm/Kconfig-nommu
index 36c80d3dd93f..5bc1b6d6526b 100644
--- a/arch/arm/Kconfig-nommu
+++ b/arch/arm/Kconfig-nommu
@@ -7,29 +7,29 @@
 config SET_MEM_PARAM
 	bool "Set flash/sdram size and base addr"
 	help
-	 Say Y to manually set the base addresses and sizes.
-	 otherwise, the default values are assigned.
+	  Say Y to manually set the base addresses and sizes.
+	  otherwise, the default values are assigned.
 
 config DRAM_BASE
-	hex '(S)DRAM Base Address' if SET_MEM_PARAM
+	hex "(S)DRAM Base Address" if SET_MEM_PARAM
 	default 0x00800000
 
 config DRAM_SIZE
-	hex '(S)DRAM SIZE' if SET_MEM_PARAM
+	hex "(S)DRAM SIZE" if SET_MEM_PARAM
 	default 0x00800000
 
 config FLASH_MEM_BASE
-	hex 'FLASH Base Address' if SET_MEM_PARAM
+	hex "FLASH Base Address" if SET_MEM_PARAM
 	depends on CPU_ARM740T || CPU_ARM946E || CPU_ARM940T
 	default 0x00400000
 
 config FLASH_SIZE
-	hex 'FLASH Size' if SET_MEM_PARAM
+	hex "FLASH Size" if SET_MEM_PARAM
 	depends on CPU_ARM740T || CPU_ARM946E || CPU_ARM940T
 	default 0x00400000
 
 config PROCESSOR_ID
-	hex 'Hard wire the processor ID'
+	hex "Hard wire the processor ID"
 	default 0x00007700
 	depends on !(CPU_CP15 || CPU_V7M)
 	help
@@ -37,7 +37,7 @@ config PROCESSOR_ID
 	  used instead of the auto-probing which utilizes the register.
 
 config REMAP_VECTORS_TO_RAM
-	bool 'Install vectors to the beginning of RAM'
+	bool "Install vectors to the beginning of RAM"
 	help
 	  The kernel needs to change the hardware exception vectors.
 	  In nommu mode, the hardware exception vectors are normally
@@ -54,13 +54,13 @@ config REMAP_VECTORS_TO_RAM
 	  the writable versions located at DRAM_BASE.
 
 config ARM_MPU
-       bool 'Use the ARM v7 PMSA Compliant MPU'
-       depends on CPU_V7 || CPU_V7M
-       default y if CPU_V7
-       help
-         Some ARM systems without an MMU have instead a Memory Protection
-         Unit (MPU) that defines the type and permissions for regions of
-         memory.
+	bool "Use the ARM v7 PMSA Compliant MPU"
+	depends on CPU_V7 || CPU_V7M
+	default y if CPU_V7
+	help
+	  Some ARM systems without an MMU have instead a Memory Protection
+	  Unit (MPU) that defines the type and permissions for regions of
+	  memory.
 
-         If your CPU has an MPU then you should choose 'y' here unless you
-         know that you do not want to use the MPU.
+	  If your CPU has an MPU then you should choose 'y' here unless you
+	  know that you do not want to use the MPU.
-- 
2.32.0

