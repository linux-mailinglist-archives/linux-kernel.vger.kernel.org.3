Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB39B52DBC3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243374AbiESRtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243165AbiESRsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:48:12 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23E5B2255
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:48:08 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J5MiMs023727;
        Thu, 19 May 2022 12:47:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=CzXHR0GocBNOj0BfbZGkVZXbGMIVdRauzKeaNK4Hhqo=;
 b=QdBWnNQXLxL0jAxomxlpR+02xqf5W/nAbcVbojwo4PveqiiN5Ac9WOC+HmvM2ESB32PO
 EQ8uaVYpAfPAq85J0kLvdIJhi4WN/T1JJgkmvFyNQRvXhD2QyeEfmw8aYtmnsXUW3kZE
 /Fo7R2//4AmQMpU7ikgDLoAFCwT6nyuR8RBwHKLE6WB4qva5F9EIbwrfWr11pH50N2ja
 igRqCm8YTQw4D5qlgccXiLSWJGE+nyrC9EogxyAjqfuBiN0fwTn/a9PCCCTL27UAZPE1
 M5c2IEnWww9otlzr4mfA5VRVfqRTdbuQBqpvRl0xGBftvF80E5F8hDM/dxnIPImKvCOs tg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3g29u37tee-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 19 May 2022 12:47:54 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 18:47:52 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 19 May 2022 18:47:52 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.59])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3B8FE476;
        Thu, 19 May 2022 17:47:52 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 07/17] ALSA: hda: cs35l41: Support multiple load paths for firmware
Date:   Thu, 19 May 2022 18:47:39 +0100
Message-ID: <20220519174749.15459-8-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220519174749.15459-1-vitalyr@opensource.cirrus.com>
References: <20220519174749.15459-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nySu78NR_TdziI2a4ZcOB14uqSu0JTzB
X-Proofpoint-ORIG-GUID: nySu78NR_TdziI2a4ZcOB14uqSu0JTzB
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

To be able to support different firmwares and tuning
for different models, the driver needs to be able to
load a different firmware and coefficient file based
on its Subsystem ID.

The driver attempts to load the firmware in the
following order:

/lib/firmware/cirrus/cs35l41-dsp1-<fw-type>-<ssid>-dev<#>.wmfw
/lib/firmware/cirrus/cs35l41-dsp1-<fw-type>-<ssid>.wmfw
/lib/firmware/cirrus/cs35l41-dsp1-<fw-type>.wmfw

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---

Changes since v2:
 - No change
 
 sound/pci/hda/cs35l41_hda.c | 53 ++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 81d6f4cf0166..0957b4984143 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -85,14 +85,23 @@ static const struct cs_dsp_client_ops client_ops = {
 
 static int cs35l41_request_firmware_file(struct cs35l41_hda *cs35l41,
 					 const struct firmware **firmware, char **filename,
-					 const char *dir, const char *filetype)
+					 const char *dir, const char *ssid, const char *amp_name,
+					 const char *filetype)
 {
 	const char * const dsp_name = cs35l41->cs_dsp.name;
 	char *s, c;
 	int ret = 0;
 
-	*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s.%s", dir, CS35L41_PART, dsp_name, "spk-prot",
-			      filetype);
+	if (ssid && amp_name)
+		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s-%s.%s", dir, CS35L41_PART,
+				      dsp_name, "spk-prot", ssid, amp_name,
+				      filetype);
+	else if (ssid)
+		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s.%s", dir, CS35L41_PART,
+				      dsp_name, "spk-prot", ssid, filetype);
+	else
+		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s.%s", dir, CS35L41_PART,
+				      dsp_name, "spk-prot", filetype);
 
 	if (*filename == NULL)
 		return -ENOMEM;
@@ -129,12 +138,43 @@ static int cs35l41_request_firmware_files(struct cs35l41_hda *cs35l41,
 {
 	int ret;
 
-	/* cirrus/part-dspN-fwtype.wmfw */
+	/* try cirrus/part-dspN-fwtype-sub<-ampname>.wmfw */
+	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
+					    CS35L41_FIRMWARE_ROOT, cs35l41->acpi_subsystem_id,
+					    cs35l41->amp_name, "wmfw");
+	if (!ret) {
+		/* try cirrus/part-dspN-fwtype-sub<-ampname>.bin */
+		cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+					      CS35L41_FIRMWARE_ROOT, cs35l41->acpi_subsystem_id,
+					      cs35l41->amp_name, "bin");
+		return 0;
+	}
+
+	/* try cirrus/part-dspN-fwtype-sub.wmfw */
 	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
-					    CS35L41_FIRMWARE_ROOT, "wmfw");
+					    CS35L41_FIRMWARE_ROOT, cs35l41->acpi_subsystem_id,
+					    NULL, "wmfw");
 	if (!ret) {
+		/* try cirrus/part-dspN-fwtype-sub<-ampname>.bin */
+		ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+						    CS35L41_FIRMWARE_ROOT,
+						    cs35l41->acpi_subsystem_id,
+						    cs35l41->amp_name, "bin");
+		if (ret)
+			/* try cirrus/part-dspN-fwtype-sub.bin */
+			cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+						      CS35L41_FIRMWARE_ROOT,
+						      cs35l41->acpi_subsystem_id, NULL, "bin");
+		return 0;
+	}
+
+	/* fallback try cirrus/part-dspN-fwtype.wmfw */
+	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
+					    CS35L41_FIRMWARE_ROOT, NULL, NULL, "wmfw");
+	if (!ret) {
+		/* fallback try cirrus/part-dspN-fwtype.bin */
 		cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-					      CS35L41_FIRMWARE_ROOT, "bin");
+					      CS35L41_FIRMWARE_ROOT, NULL, NULL, "bin");
 		return 0;
 	}
 
@@ -143,7 +183,6 @@ static int cs35l41_request_firmware_files(struct cs35l41_hda *cs35l41,
 	return ret;
 }
 
-
 static int cs35l41_init_dsp(struct cs35l41_hda *cs35l41)
 {
 	const struct firmware *coeff_firmware = NULL;
-- 
2.34.1

