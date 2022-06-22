Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC7E5543D5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351473AbiFVHrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353912AbiFVHrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:47:19 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6280E37A14
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:47:16 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M5nide032367;
        Wed, 22 Jun 2022 02:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=i2GlN7h4TCNJX78uJ9xbCqKDkFCcSex86cITEC2VbPI=;
 b=Nfq//OJT/Xn1BDiymW0nJmJ4zAlM+cx4A0NO1zBfGFELk8TWG1ZOEv/AzzYwc3h8IUny
 wZzAtX7X494aOCcjGOEOStAZG537FJFIycCz66vo/QNDBXU4DTUUb0zw2Jin7My6d8HF
 +6oDzb0ZUwkElxTl7eE7muoZYAwkFYVMQNiHiChMSj6K2snwN4CBXBu6jTbIO7jQQ7Ni
 sbLdSypmcBFGSvuiulW5AviMueykYlPpwlALVy9khERy8eZP9l7ATZLAAaAmK8kObx6Z
 Dw/PMkQVnxYwPSjshUf3b3nBvtaOmVQ/m9WRXYrxzPPmoIGF7V3wWsfnS3tPVT48PcQ0 ew== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gsc41cqh2-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Jun 2022 02:47:03 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 08:47:00 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 22 Jun 2022 08:47:00 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.175])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 870A87C;
        Wed, 22 Jun 2022 07:47:00 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v7 14/14] ALSA: hda: cs35l41: Add module parameter to control firmware load
Date:   Wed, 22 Jun 2022 08:46:53 +0100
Message-ID: <20220622074653.179078-15-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220622074653.179078-1-vitalyr@opensource.cirrus.com>
References: <20220622074653.179078-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nFV1EIyYUTpIEkyYW9vKdkiupNmAxgj1
X-Proofpoint-ORIG-GUID: nFV1EIyYUTpIEkyYW9vKdkiupNmAxgj1
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

By default, the driver will automatically load DSP firmware
for the amps, if available. Adding this option allows the
autoload to be optional, which allows for different configurations.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 3aa36c5ff972..4151ac5ab399 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -8,6 +8,7 @@
 
 #include <linux/acpi.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <sound/hda_codec.h>
 #include <sound/soc.h>
 #include <linux/pm_runtime.h>
@@ -32,6 +33,11 @@
 #define CAL_DSP_CTL_TYPE		5
 #define CAL_DSP_CTL_ALG			205
 
+static bool firmware_autostart = 1;
+module_param(firmware_autostart, bool, 0444);
+MODULE_PARM_DESC(firmware_autostart, "Allow automatic firmware download on boot"
+			     "(0=Disable, 1=Enable) (default=1); ");
+
 static const struct reg_sequence cs35l41_hda_config[] = {
 	{ CS35L41_PLL_CLK_CTRL,		0x00000430 }, // 3072000Hz, BCLK Input, PLL_REFCLK_EN = 1
 	{ CS35L41_DSP_CLK_CTRL,		0x00000003 }, // DSP CLK EN
@@ -862,11 +868,16 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 
 	cs35l41->firmware_type = HDA_CS_DSP_FW_SPK_PROT;
 
-	cs35l41->request_fw_load = true;
-	mutex_lock(&cs35l41->fw_mutex);
-	if (cs35l41_smart_amp(cs35l41) < 0)
-		dev_warn(cs35l41->dev, "Cannot Run Firmware, reverting to dsp bypass...\n");
-	mutex_unlock(&cs35l41->fw_mutex);
+	if (firmware_autostart) {
+		dev_dbg(cs35l41->dev, "Firmware Autostart.\n");
+		cs35l41->request_fw_load = true;
+		mutex_lock(&cs35l41->fw_mutex);
+		if (cs35l41_smart_amp(cs35l41) < 0)
+			dev_warn(cs35l41->dev, "Cannot Run Firmware, reverting to dsp bypass...\n");
+		mutex_unlock(&cs35l41->fw_mutex);
+	} else {
+		dev_dbg(cs35l41->dev, "Firmware Autostart is disabled.\n");
+	}
 
 	ret = cs35l41_create_controls(cs35l41);
 
-- 
2.34.1

