Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7D9553DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356689AbiFUVjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355660AbiFUVia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:38:30 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDAC120A5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:38:29 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LBDkxW018841;
        Tue, 21 Jun 2022 16:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=EbmHX6Pf2odyNfINmfGSummXzA3kLvVccKNYAHBOj+4=;
 b=QhdpqTtCxBp4MZQ+UE6sWT16OFPntJfj8RRlISOOMRCKJtFXQQzNomhpxrO0YAlgVD01
 KQCU67L/ZMf5CemMOQ0GPkUjt+7WUTyHG6GInXFKatpvlrWW/WjwfDpladyCqpjeAZBA
 rkxQMQOkYl2YWqaCugtbtJDy5KpvNdNqgxwrH5Q5JDPtLy+1sidrU2xi8dpm6KnQBAf6
 hLqXqNmLVEIoDToD4I4PWmnQMRHsWEuNn+62xnLIANhCaVuq6gZAMc2eImKgJmqswurK
 8EdNuTDBTBm1O99vK9B+5ZuD+8fF3qsuP5bI/NYI8bFkGhkgIusAuZjzXau1E87dKiyr Ew== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gsb4p45ae-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Jun 2022 16:38:06 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 21 Jun
 2022 22:38:05 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 21 Jun 2022 22:38:05 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.175])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3CC1E7C;
        Tue, 21 Jun 2022 21:38:05 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v6 10/14] ALSA: hda: cs35l41: Read Speaker Calibration data from UEFI variables
Date:   Tue, 21 Jun 2022 22:37:57 +0100
Message-ID: <20220621213801.2021097-11-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220621213801.2021097-1-vitalyr@opensource.cirrus.com>
References: <20220621213801.2021097-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: A9lyDvFEx3tpza1XWidBsX821PL4qjkT
X-Proofpoint-ORIG-GUID: A9lyDvFEx3tpza1XWidBsX821PL4qjkT
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

Speaker Calibration data, specific to an individual speaker is
stored inside UEFI variables during calibration, and can be
used by the DSP.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 101 ++++++++++++++++++++++++++++++++++++
 sound/pci/hda/cs35l41_hda.h |  15 ++++++
 2 files changed, 116 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index b502806fbfa1..ef3dfda7b03e 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -26,6 +26,12 @@
 #define HALO_STATE_DSP_CTL_NAME		"HALO_STATE"
 #define HALO_STATE_DSP_CTL_TYPE		5
 #define HALO_STATE_DSP_CTL_ALG		262308
+#define CAL_R_DSP_CTL_NAME		"CAL_R"
+#define CAL_STATUS_DSP_CTL_NAME		"CAL_STATUS"
+#define CAL_CHECKSUM_DSP_CTL_NAME	"CAL_CHECKSUM"
+#define CAL_AMBIENT_DSP_CTL_NAME	"CAL_AMBIENT"
+#define CAL_DSP_CTL_TYPE		5
+#define CAL_DSP_CTL_ALG			205
 
 static const struct reg_sequence cs35l41_hda_config[] = {
 	{ CS35L41_PLL_CLK_CTRL,		0x00000430 }, // 3072000Hz, BCLK Input, PLL_REFCLK_EN = 1
@@ -282,6 +288,96 @@ static int cs35l41_request_firmware_files(struct cs35l41_hda *cs35l41,
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_EFI)
+static int cs35l41_apply_calibration(struct cs35l41_hda *cs35l41, unsigned int ambient,
+				     unsigned int r0, unsigned int status, unsigned int checksum)
+{
+	int ret;
+
+	ret = hda_cs_dsp_write_ctl(&cs35l41->cs_dsp, CAL_AMBIENT_DSP_CTL_NAME, CAL_DSP_CTL_TYPE,
+				   CAL_DSP_CTL_ALG, &ambient, 4);
+	if (ret) {
+		dev_err(cs35l41->dev, "Cannot Write Control: %s - %d\n", CAL_AMBIENT_DSP_CTL_NAME,
+			ret);
+		return ret;
+	}
+	ret = hda_cs_dsp_write_ctl(&cs35l41->cs_dsp, CAL_R_DSP_CTL_NAME, CAL_DSP_CTL_TYPE,
+				   CAL_DSP_CTL_ALG, &r0, 4);
+	if (ret) {
+		dev_err(cs35l41->dev, "Cannot Write Control: %s - %d\n", CAL_R_DSP_CTL_NAME, ret);
+		return ret;
+	}
+	ret = hda_cs_dsp_write_ctl(&cs35l41->cs_dsp, CAL_STATUS_DSP_CTL_NAME, CAL_DSP_CTL_TYPE,
+				   CAL_DSP_CTL_ALG, &status, 4);
+	if (ret) {
+		dev_err(cs35l41->dev, "Cannot Write Control: %s - %d\n", CAL_STATUS_DSP_CTL_NAME,
+			ret);
+		return ret;
+	}
+	ret = hda_cs_dsp_write_ctl(&cs35l41->cs_dsp, CAL_CHECKSUM_DSP_CTL_NAME, CAL_DSP_CTL_TYPE,
+				   CAL_DSP_CTL_ALG, &checksum, 4);
+	if (ret) {
+		dev_err(cs35l41->dev, "Cannot Write Control: %s - %d\n", CAL_CHECKSUM_DSP_CTL_NAME,
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cs35l41_save_calibration(struct cs35l41_hda *cs35l41)
+{
+	static efi_guid_t efi_guid = EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4, 0x3d, 0x93, 0xfe,
+					      0x5a, 0xa3, 0x5d, 0xb3);
+	static efi_char16_t efi_name[] = L"CirrusSmartAmpCalibrationData";
+	const struct cs35l41_amp_efi_data *efi_data;
+	const struct cs35l41_amp_cal_data *cl;
+	unsigned long data_size = 0;
+	efi_status_t status;
+	int ret = 0;
+	u8 *data = NULL;
+	u32 attr;
+
+	/* Get real size of UEFI variable */
+	status = efi.get_variable(efi_name, &efi_guid, &attr, &data_size, data);
+	if (status == EFI_BUFFER_TOO_SMALL) {
+		ret = -ENODEV;
+		/* Allocate data buffer of data_size bytes */
+		data = vmalloc(data_size);
+		if (!data)
+			return -ENOMEM;
+		/* Get variable contents into buffer */
+		status = efi.get_variable(efi_name, &efi_guid, &attr, &data_size, data);
+		if (status == EFI_SUCCESS) {
+			efi_data = (struct cs35l41_amp_efi_data *)data;
+			dev_dbg(cs35l41->dev, "Calibration: Size=%d, Amp Count=%d\n",
+				efi_data->size, efi_data->count);
+			if (efi_data->count > cs35l41->index) {
+				cl = &efi_data->data[cs35l41->index];
+				dev_dbg(cs35l41->dev,
+					"Calibration: Ambient=%02x, Status=%02x, R0=%d\n",
+					cl->calAmbient, cl->calStatus, cl->calR);
+
+				/* Calibration can only be applied whilst the DSP is not running */
+				ret = cs35l41_apply_calibration(cs35l41,
+								cpu_to_be32(cl->calAmbient),
+								cpu_to_be32(cl->calR),
+								cpu_to_be32(cl->calStatus),
+								cpu_to_be32(cl->calR + 1));
+			}
+		}
+		vfree(data);
+	}
+	return ret;
+}
+#else
+static int cs35l41_save_calibration(struct cs35l41_hda *cs35l41)
+{
+	dev_warn(cs35l41->dev, "Calibration not supported without EFI support.\n");
+	return 0;
+}
+#endif
+
 static int cs35l41_init_dsp(struct cs35l41_hda *cs35l41)
 {
 	const struct firmware *coeff_firmware = NULL;
@@ -314,7 +410,12 @@ static int cs35l41_init_dsp(struct cs35l41_hda *cs35l41)
 
 	ret = cs_dsp_power_up(dsp, wmfw_firmware, wmfw_filename, coeff_firmware, coeff_filename,
 			      FW_NAME);
+	if (ret)
+		goto err_release;
+
+	ret = cs35l41_save_calibration(cs35l41);
 
+err_release:
 	release_firmware(wmfw_firmware);
 	release_firmware(coeff_firmware);
 	kfree(wmfw_filename);
diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
index 439c4b705328..59a9461d0444 100644
--- a/sound/pci/hda/cs35l41_hda.h
+++ b/sound/pci/hda/cs35l41_hda.h
@@ -10,6 +10,7 @@
 #ifndef __CS35L41_HDA_H__
 #define __CS35L41_HDA_H__
 
+#include <linux/efi.h>
 #include <linux/regulator/consumer.h>
 #include <linux/gpio/consumer.h>
 #include <linux/device.h>
@@ -18,6 +19,20 @@
 #include <linux/firmware/cirrus/cs_dsp.h>
 #include <linux/firmware/cirrus/wmfw.h>
 
+struct cs35l41_amp_cal_data {
+	u32 calTarget[2];
+	u32 calTime[2];
+	s8 calAmbient;
+	u8 calStatus;
+	u16 calR;
+} __packed;
+
+struct cs35l41_amp_efi_data {
+	u32 size;
+	u32 count;
+	struct cs35l41_amp_cal_data data[];
+} __packed;
+
 enum cs35l41_hda_spk_pos {
 	CS35l41_LEFT,
 	CS35l41_RIGHT,
-- 
2.34.1

