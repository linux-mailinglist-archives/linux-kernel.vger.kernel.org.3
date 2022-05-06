Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC96B51D2AC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389763AbiEFIAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386640AbiEFIAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:00:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1860D674F2
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651823784; x=1683359784;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NfqfBy/2mV+d23R6nU9hPwmIhD35HU5Ufwf2vf+gjMc=;
  b=ehrEMiRR7r3aQ5YmJ1pkNLhelaz3FPPKKRoxWJC8UZz6p1RL9a8fE04W
   9PFolbDQbmtV6JCp5MfmW/3zL7prn4pnPe+a2jhpunIwOHTD744WF5FQ/
   ykqN9o9K4BcxEhG0AtCYqmBPu9WdeVy+Mfa2qwkrk44Sy3liITQ4F6ZDi
   Ry++89B9bfISa7WeQOG5q/9w1EnmubEguVC91wesRVYTrJnJSgmm2bBfp
   j2kaBF8uHIBb2M8dyLdncn2X78wDIjVOKXvo8kQxAmneD7t0hWMFnyl/x
   YGRg7IK7rBR+qg+zfd95SDCxHHonQmr+Z6CeLmSyt0ovHOFbMgBwaY0Q4
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="155029122"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 May 2022 00:56:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 6 May 2022 00:56:22 -0700
Received: from ROU-LT-M43238L.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 6 May 2022 00:56:20 -0700
From:   <nicolas.ferre@microchip.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <broonie@kernel.org>, <patches@lists.linux.dev>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH] ARM: configs: at91: Enable AUTOFS_FS required by systemd
Date:   Fri, 6 May 2022 09:56:11 +0200
Message-ID: <20220506075611.17840-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Align all at91 defconfigs to required options for systemd.
The missing of autofs would cause warnings on boot
when not available.

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/configs/sama5_defconfig | 1 +
 arch/arm/configs/sama7_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 1c4c5a035518..18852803522e 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -222,6 +222,7 @@ CONFIG_PWM_ATMEL_HLCDC_PWM=y
 CONFIG_PWM_ATMEL_TCB=y
 CONFIG_EXT4_FS=y
 CONFIG_FANOTIFY=y
+CONFIG_AUTOFS_FS=m
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_UBIFS_FS=y
diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 4a8466306b54..63302858b9c4 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -200,6 +200,7 @@ CONFIG_RESET_CONTROLLER=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_FANOTIFY=y
+CONFIG_AUTOFS_FS=m
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_UBIFS_FS=y
-- 
2.32.0

