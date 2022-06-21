Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69541553DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356505AbiFUVjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355430AbiFUVi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:38:29 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7643211A36
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:38:28 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LBQrlM010673;
        Tue, 21 Jun 2022 16:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=sI8SX3PB/R2fNl6PH3oFh+Fy/DogbIVBHrE/v2Q5jyw=;
 b=jWwu3UhKQ2ioTp/03EHSqA++9kc7zsuVYLqEv5paYhMTxxkAI6cBE2ehiIbRQA+4uEsV
 XKLd5DSa73c4WN7vJVt+50/wwC1OXVXyi+ZNeMHZxVQ5NTxifYzi0up0rjYsvtiIYAWO
 hvEpzNKRc1BB0DmApAKxNIpJw0ubXCWA2TrbCyGEKBAvyInUkXdbb2QaVjsI7cvQO/Qr
 wTHY5Dgm6OW9aZgV7DSLHnO+DhlF2e6JLtnGDfmM1PZz6GJn0NxQm7NmfMXJmc0w4ntJ
 iA8aMcCyCvegsHysROVYByQL7poFEI/5zrkOrMDdFjNYMdz/mPlMYJTJkelLxgfo7AOt CA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gsc41c7yj-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Jun 2022 16:38:07 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 21 Jun
 2022 22:38:04 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 21 Jun 2022 22:38:04 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.175])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7B8E77C;
        Tue, 21 Jun 2022 21:38:04 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v6 08/14] ALSA: hda: cs35l41: Support Speaker ID for laptops
Date:   Tue, 21 Jun 2022 22:37:55 +0100
Message-ID: <20220621213801.2021097-9-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220621213801.2021097-1-vitalyr@opensource.cirrus.com>
References: <20220621213801.2021097-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: tQCtgm8Ya6wNMWumSSgEBlZ001kHZFB-
X-Proofpoint-ORIG-GUID: tQCtgm8Ya6wNMWumSSgEBlZ001kHZFB-
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

Some Laptops use a number of gpios to define which vendor is
used for a particular laptop.
Different coefficient files are used for different vendors.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 174 ++++++++++++++++++++++++++++++++++--
 sound/pci/hda/cs35l41_hda.h |   1 +
 2 files changed, 166 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 6d90bb8f74ea..6ac68b00cafe 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -86,13 +86,19 @@ static const struct cs_dsp_client_ops client_ops = {
 static int cs35l41_request_firmware_file(struct cs35l41_hda *cs35l41,
 					 const struct firmware **firmware, char **filename,
 					 const char *dir, const char *ssid, const char *amp_name,
-					 const char *filetype)
+					 int spkid, const char *filetype)
 {
 	const char * const dsp_name = cs35l41->cs_dsp.name;
 	char *s, c;
 	int ret = 0;
 
-	if (ssid && amp_name)
+	if (spkid > -1 && ssid && amp_name)
+		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s-spkid%d-%s.%s", dir, CS35L41_PART,
+				      dsp_name, "spk-prot", ssid, spkid, amp_name, filetype);
+	else if (spkid > -1 && ssid)
+		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s-spkid%d.%s", dir, CS35L41_PART,
+				      dsp_name, "spk-prot", ssid, spkid, filetype);
+	else if (ssid && amp_name)
 		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s-%s.%s", dir, CS35L41_PART,
 				      dsp_name, "spk-prot", ssid, amp_name,
 				      filetype);
@@ -130,6 +136,93 @@ static int cs35l41_request_firmware_file(struct cs35l41_hda *cs35l41,
 	return ret;
 }
 
+static int cs35l41_request_firmware_files_spkid(struct cs35l41_hda *cs35l41,
+						const struct firmware **wmfw_firmware,
+						char **wmfw_filename,
+						const struct firmware **coeff_firmware,
+						char **coeff_filename)
+{
+	int ret;
+
+	/* try cirrus/part-dspN-fwtype-sub<-spkidN><-ampname>.wmfw */
+	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
+					    CS35L41_FIRMWARE_ROOT,
+					    cs35l41->acpi_subsystem_id, cs35l41->amp_name,
+					    cs35l41->speaker_id, "wmfw");
+	if (!ret) {
+		/* try cirrus/part-dspN-fwtype-sub<-spkidN><-ampname>.bin */
+		cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+					      CS35L41_FIRMWARE_ROOT,
+					      cs35l41->acpi_subsystem_id, cs35l41->amp_name,
+					      cs35l41->speaker_id, "bin");
+		return 0;
+	}
+
+	/* try cirrus/part-dspN-fwtype-sub<-ampname>.wmfw */
+	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
+					    CS35L41_FIRMWARE_ROOT, cs35l41->acpi_subsystem_id,
+					    cs35l41->amp_name, -1, "wmfw");
+	if (!ret) {
+		/* try cirrus/part-dspN-fwtype-sub<-spkidN><-ampname>.bin */
+		cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+					      CS35L41_FIRMWARE_ROOT, cs35l41->acpi_subsystem_id,
+					      cs35l41->amp_name, cs35l41->speaker_id, "bin");
+		return 0;
+	}
+
+	/* try cirrus/part-dspN-fwtype-sub<-spkidN>.wmfw */
+	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
+					    CS35L41_FIRMWARE_ROOT, cs35l41->acpi_subsystem_id,
+					    NULL, cs35l41->speaker_id, "wmfw");
+	if (!ret) {
+		/* try cirrus/part-dspN-fwtype-sub<-spkidN><-ampname>.bin */
+		ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+						    CS35L41_FIRMWARE_ROOT,
+						    cs35l41->acpi_subsystem_id,
+						    cs35l41->amp_name, cs35l41->speaker_id, "bin");
+		if (ret)
+			/* try cirrus/part-dspN-fwtype-sub<-spkidN>.bin */
+			cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+						CS35L41_FIRMWARE_ROOT,
+						cs35l41->acpi_subsystem_id,
+						NULL, cs35l41->speaker_id, "bin");
+		return 0;
+	}
+
+	/* try cirrus/part-dspN-fwtype-sub.wmfw */
+	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
+					    CS35L41_FIRMWARE_ROOT, cs35l41->acpi_subsystem_id,
+					    NULL, -1, "wmfw");
+	if (!ret) {
+		/* try cirrus/part-dspN-fwtype-sub<-spkidN><-ampname>.bin */
+		ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+						    CS35L41_FIRMWARE_ROOT,
+						    cs35l41->acpi_subsystem_id,
+						    cs35l41->amp_name, cs35l41->speaker_id, "bin");
+		if (ret)
+			/* try cirrus/part-dspN-fwtype-sub<-spkidN>.bin */
+			cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+						      CS35L41_FIRMWARE_ROOT,
+						      cs35l41->acpi_subsystem_id,
+						      NULL, cs35l41->speaker_id, "bin");
+		return 0;
+	}
+
+	/* fallback try cirrus/part-dspN-fwtype.wmfw */
+	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
+					    CS35L41_FIRMWARE_ROOT, NULL, NULL, -1, "wmfw");
+	if (!ret) {
+		/* fallback try cirrus/part-dspN-fwtype.bin */
+		cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+					      CS35L41_FIRMWARE_ROOT, NULL, NULL, -1, "bin");
+		return 0;
+	}
+
+	dev_warn(cs35l41->dev, "Failed to request firmware\n");
+
+	return ret;
+}
+
 static int cs35l41_request_firmware_files(struct cs35l41_hda *cs35l41,
 					  const struct firmware **wmfw_firmware,
 					  char **wmfw_filename,
@@ -138,43 +231,48 @@ static int cs35l41_request_firmware_files(struct cs35l41_hda *cs35l41,
 {
 	int ret;
 
+	if (cs35l41->speaker_id > -1)
+		return cs35l41_request_firmware_files_spkid(cs35l41, wmfw_firmware, wmfw_filename,
+							    coeff_firmware, coeff_filename);
+
 	/* try cirrus/part-dspN-fwtype-sub<-ampname>.wmfw */
 	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
 					    CS35L41_FIRMWARE_ROOT, cs35l41->acpi_subsystem_id,
-					    cs35l41->amp_name, "wmfw");
+					    cs35l41->amp_name, -1, "wmfw");
 	if (!ret) {
 		/* try cirrus/part-dspN-fwtype-sub<-ampname>.bin */
 		cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
 					      CS35L41_FIRMWARE_ROOT, cs35l41->acpi_subsystem_id,
-					      cs35l41->amp_name, "bin");
+					      cs35l41->amp_name, -1, "bin");
 		return 0;
 	}
 
 	/* try cirrus/part-dspN-fwtype-sub.wmfw */
 	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
 					    CS35L41_FIRMWARE_ROOT, cs35l41->acpi_subsystem_id,
-					    NULL, "wmfw");
+					    NULL, -1, "wmfw");
 	if (!ret) {
 		/* try cirrus/part-dspN-fwtype-sub<-ampname>.bin */
 		ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
 						    CS35L41_FIRMWARE_ROOT,
 						    cs35l41->acpi_subsystem_id,
-						    cs35l41->amp_name, "bin");
+						    cs35l41->amp_name, -1, "bin");
 		if (ret)
 			/* try cirrus/part-dspN-fwtype-sub.bin */
 			cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
 						      CS35L41_FIRMWARE_ROOT,
-						      cs35l41->acpi_subsystem_id, NULL, "bin");
+						      cs35l41->acpi_subsystem_id,
+						      NULL, -1, "bin");
 		return 0;
 	}
 
 	/* fallback try cirrus/part-dspN-fwtype.wmfw */
 	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
-					    CS35L41_FIRMWARE_ROOT, NULL, NULL, "wmfw");
+					    CS35L41_FIRMWARE_ROOT, NULL, NULL, -1, "wmfw");
 	if (!ret) {
 		/* fallback try cirrus/part-dspN-fwtype.bin */
 		cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-					      CS35L41_FIRMWARE_ROOT, NULL, NULL, "bin");
+					      CS35L41_FIRMWARE_ROOT, NULL, NULL, -1, "bin");
 		return 0;
 	}
 
@@ -614,6 +712,61 @@ static int cs35l41_get_acpi_sub_string(struct device *dev, struct acpi_device *a
 	return ret;
 }
 
+static int cs35l41_get_speaker_id(struct device *dev, int amp_index,
+				  int num_amps, int fixed_gpio_id)
+{
+	struct gpio_desc *speaker_id_desc;
+	int speaker_id = -ENODEV;
+
+	if (fixed_gpio_id >= 0) {
+		dev_dbg(dev, "Found Fixed Speaker ID GPIO (index = %d)\n", fixed_gpio_id);
+		speaker_id_desc = gpiod_get_index(dev, NULL, fixed_gpio_id, GPIOD_IN);
+		if (IS_ERR(speaker_id_desc)) {
+			speaker_id = PTR_ERR(speaker_id_desc);
+			return speaker_id;
+		}
+		speaker_id = gpiod_get_value_cansleep(speaker_id_desc);
+		gpiod_put(speaker_id_desc);
+		dev_dbg(dev, "Speaker ID = %d\n", speaker_id);
+	} else {
+		int base_index;
+		int gpios_per_amp;
+		int count;
+		int tmp;
+		int i;
+
+		count = gpiod_count(dev, "spk-id");
+		if (count > 0) {
+			speaker_id = 0;
+			gpios_per_amp = count / num_amps;
+			base_index = gpios_per_amp * amp_index;
+
+			if (count % num_amps)
+				return -EINVAL;
+
+			dev_dbg(dev, "Found %d Speaker ID GPIOs per Amp\n", gpios_per_amp);
+
+			for (i = 0; i < gpios_per_amp; i++) {
+				speaker_id_desc = gpiod_get_index(dev, "spk-id", i + base_index,
+								  GPIOD_IN);
+				if (IS_ERR(speaker_id_desc)) {
+					speaker_id = PTR_ERR(speaker_id_desc);
+					break;
+				}
+				tmp = gpiod_get_value_cansleep(speaker_id_desc);
+				gpiod_put(speaker_id_desc);
+				if (tmp < 0) {
+					speaker_id = tmp;
+					break;
+				}
+				speaker_id |= tmp << i;
+			}
+			dev_dbg(dev, "Speaker ID = %d\n", speaker_id);
+		}
+	}
+	return speaker_id;
+}
+
 static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, int id)
 {
 	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
@@ -719,6 +872,8 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	else
 		hw_cfg->bst_cap = -1;
 
+	cs35l41->speaker_id = cs35l41_get_speaker_id(physdev, cs35l41->index, nval, -1);
+
 	if (hw_cfg->bst_ind > 0 || hw_cfg->bst_cap > 0 || hw_cfg->bst_ipk > 0)
 		hw_cfg->bst_type = CS35L41_INT_BOOST;
 	else
@@ -752,6 +907,7 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	cs35l41->channel_index = 0;
 	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 0, GPIOD_OUT_HIGH);
 	cs35l41->hw_cfg.bst_type = CS35L41_EXT_BOOST_NO_VSPK_SWITCH;
+	cs35l41->speaker_id = cs35l41_get_speaker_id(physdev, 0, 0, 2);
 	hw_cfg->gpio2.func = CS35L41_GPIO2_INT_OPEN_DRAIN;
 	hw_cfg->gpio2.valid = true;
 	cs35l41->hw_cfg.valid = true;
diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
index b57f59a1ba49..a9dbc1c19248 100644
--- a/sound/pci/hda/cs35l41_hda.h
+++ b/sound/pci/hda/cs35l41_hda.h
@@ -43,6 +43,7 @@ struct cs35l41_hda {
 	unsigned volatile long irq_errors;
 	const char *amp_name;
 	const char *acpi_subsystem_id;
+	int speaker_id;
 	struct mutex fw_mutex;
 	struct regmap_irq_chip_data *irq_data;
 	bool firmware_running;
-- 
2.34.1

