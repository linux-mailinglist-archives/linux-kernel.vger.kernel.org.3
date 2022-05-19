Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B43C52DBCD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243249AbiESRuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243339AbiESRsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:48:55 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D729B225B
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:48:48 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J66mcZ012194;
        Thu, 19 May 2022 12:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=cpKA7D3u60Un0Q7jaRk6044JdqC+LVcgSD1wYGWQh3U=;
 b=SqrJe/6t3mCfdPAhoyNtZaf7TguwmlWXArwWaOUmQL62Uf/qDTwUkPOPOWb00r8rKahn
 AS/fI+ZRyF/jYCb89xoXP2aFWkutaH99fzB6nJf4XL5/56yYU8eAn9y7T7xT6SuuZF3p
 sKG/l927Z2MN/f5OCYtz9cRElq+kV9ST1O/UjGfgWC/JdkbtUONftEY7TmZIAw5vBivn
 fS2kYbsMjOM6Congsc2ks9FT/2NMO81rLvjJ5gxusYJz05vEM2IkkJbuwtRSbaQm8nzQ
 pCtIeFqFtqQBrRrbiHztOgPLaqPB5GrPv20689ZsuCbuuKuRUEWvhaO9hiYNt40v8/Lu qQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3g28upfavr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 19 May 2022 12:47:59 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 18:47:57 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 19 May 2022 18:47:57 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.59])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2F299476;
        Thu, 19 May 2022 17:47:57 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 17/17] ALSA: hda: cs35l41: Add module parameter to control firmware load
Date:   Thu, 19 May 2022 18:47:49 +0100
Message-ID: <20220519174749.15459-18-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220519174749.15459-1-vitalyr@opensource.cirrus.com>
References: <20220519174749.15459-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 3hbDY2jHkOjnuYNYeRimszsI8YEz0aBO
X-Proofpoint-ORIG-GUID: 3hbDY2jHkOjnuYNYeRimszsI8YEz0aBO
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
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

Changes since v2:
 - Added module paramter to control firmware loading
 
 sound/pci/hda/cs35l41_hda.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 06abd03e2996..8aea09870bc2 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -30,6 +30,11 @@
 #define CAL_R_DSP_CTL_TYPE		5
 #define CAL_R_DSP_CTL_ALG		205
 
+static bool firmware_autostart = 1;
+module_param(firmware_autostart, bool, 0444);
+MODULE_PARM_DESC(firmware_autostart, "Allow automatic firmware download on boot"
+			     "(0=Disable, 1=Enable) (default=1); ");
+
 static const struct reg_sequence cs35l41_hda_config[] = {
 	{ CS35L41_PLL_CLK_CTRL,		0x00000430 }, // 3072000Hz, BCLK Input, PLL_REFCLK_EN = 1
 	{ CS35L41_DSP_CLK_CTRL,		0x00000003 }, // DSP CLK EN
@@ -779,11 +784,16 @@ static int cs35l41_hda_bind(struct device *dev, struct device *master, void *mas
 
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
 
 	cs35l41_create_controls(cs35l41);
 
-- 
2.34.1

