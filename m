Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAC9560E02
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 02:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiF3AYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 20:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiF3AYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 20:24:10 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5E31C12F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 17:24:09 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25U004kK009594;
        Wed, 29 Jun 2022 19:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=+QbXq9bn9RLwQ+qcOkiNiqeAFwoktMZKC+3daW2KG4Y=;
 b=ozY4OE4i/BEVzZjXPWUblefrY2+3Q7dyxvhbxagg4sKZG2fLMqE2DRpQT1AyVD2/7Blk
 5CDjtQuxtaodYpZ+LiteRdrGQpmtq/219J7ZlhE2OZ1SwGIEeq4mjwmVx/4NljwBZ/OV
 5xVZXR5VUhXrlbCPQtiLtL77kyYC+L9Su9t4LgJ6mc/rnfrnUdrlQOR0NECjiN4Uo7z7
 KRDqvjOlY8o0VONYKyOSuG11LqfXloUzoqOCx0/x2XsoY59cj5c+/PaKAwgamBI81h7t
 mIcskA9FvTmBvlPBnpZPHsROOUcCgLANEYJypkfuagJATRtBFyFCV++/gZvR/wowkGUH Hw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gwys2p9gn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 Jun 2022 19:23:47 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 01:23:46 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 30 Jun 2022 01:23:46 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.125])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C39662A9;
        Thu, 30 Jun 2022 00:23:45 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v8 06/14] ALSA: hda: cs35l41: Support reading subsystem id from ACPI
Date:   Thu, 30 Jun 2022 01:23:27 +0100
Message-ID: <20220630002335.366545-7-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220630002335.366545-1-vitalyr@opensource.cirrus.com>
References: <20220630002335.366545-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: GCufCKNPjsOjueThU4-fNEWhcyTOxczx
X-Proofpoint-GUID: GCufCKNPjsOjueThU4-fNEWhcyTOxczx
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

On some laptop models, the ACPI contains the unique
Subsystem ID, and this value should be preferred
over the value from the HDA driver.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index b6e94e7b482a..2af3bb5ea1fb 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -544,6 +544,36 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 	return cs35l41_hda_channel_map(cs35l41->dev, 0, NULL, 1, &hw_cfg->spk_pos);
 }
 
+static int cs35l41_get_acpi_sub_string(struct device *dev, struct acpi_device *adev,
+				       const char **subsysid)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	acpi_status status;
+	int ret = 0;
+
+	status = acpi_evaluate_object(adev->handle, "_SUB", NULL, &buffer);
+	if (ACPI_SUCCESS(status)) {
+		obj = buffer.pointer;
+		if (obj->type == ACPI_TYPE_STRING) {
+			*subsysid = devm_kstrdup(dev, obj->string.pointer, GFP_KERNEL);
+			if (*subsysid == NULL) {
+				dev_err(dev, "Cannot allocate Subsystem ID");
+				ret = -ENOMEM;
+			}
+		} else {
+			dev_warn(dev, "Warning ACPI _SUB did not return a string\n");
+			ret = -ENODEV;
+		}
+		acpi_os_free(buffer.pointer);
+	} else {
+		dev_dbg(dev, "Warning ACPI _SUB failed: %#x\n", status);
+		ret = -ENODEV;
+	}
+
+	return ret;
+}
+
 static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, int id)
 {
 	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
@@ -563,6 +593,12 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	physdev = get_device(acpi_get_first_physical_node(adev));
 	acpi_dev_put(adev);
 
+	ret = cs35l41_get_acpi_sub_string(cs35l41->dev, adev, &cs35l41->acpi_subsystem_id);
+	if (ret)
+		dev_info(cs35l41->dev, "No Subsystem ID found in ACPI: %d", ret);
+	else
+		dev_dbg(cs35l41->dev, "Subsystem ID %s found", cs35l41->acpi_subsystem_id);
+
 	property = "cirrus,dev-index";
 	ret = device_property_count_u32(physdev, property);
 	if (ret <= 0)
-- 
2.34.1

