Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CE052DBAC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243099AbiESRsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242755AbiESRsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:48:07 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF01AFB32
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:48:06 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J6k19C002261;
        Thu, 19 May 2022 12:47:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=fYmjIggmqaxp0xE4Jpga+Pd2F4S8iC+s9X3j+VD0f1I=;
 b=inFOC1ayUyESdJz7q/ivoFht5Q06nwkggz0k1QPmo5GgxBXvv0WokPSjgj+OXswZT8yZ
 jEOGj5NQhFhqdfWcvDPgtVoYDxhun9K6A0d6GFBvX1vagXXqz8NRdcFvJCnu14MZMHCm
 sAZRRdZaJXwSVtSu5zVBkU1O9Va/NaD1SUirpzzT2zGU/teHaKn05d484cn9MWYDR/8M
 NKNYT3pbPPuQnraH+maY7YOchAHLCfvSkXVAje003p+xASUUxwAYOeRNK39R2k9TPaP9
 wu5lrq8p4nykkg+iTg9hgy+uPecdLQkjgScsgYKBg5I0oSukEYlKqSqCYWgyLrh3taR/ Mw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3g29u37ted-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 19 May 2022 12:47:53 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 18:47:52 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 19 May 2022 18:47:52 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.59])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D882D458;
        Thu, 19 May 2022 17:47:51 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 06/17] ALSA: hda: cs35l41: Support reading subsystem id from ACPI
Date:   Thu, 19 May 2022 18:47:38 +0100
Message-ID: <20220519174749.15459-7-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220519174749.15459-1-vitalyr@opensource.cirrus.com>
References: <20220519174749.15459-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: SVZ0uO2nOIGNr9x7jIFYiJsKymuV-Zys
X-Proofpoint-ORIG-GUID: SVZ0uO2nOIGNr9x7jIFYiJsKymuV-Zys
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

On some laptop models, the ACPI contains the unique
Subsystem ID, and this value should be preferred
over the value from the HDA driver.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---

Changes since v2:
 - No change
 
 sound/pci/hda/cs35l41_hda.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index c235b899aa04..81d6f4cf0166 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -533,6 +533,36 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
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
@@ -552,6 +582,12 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
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

