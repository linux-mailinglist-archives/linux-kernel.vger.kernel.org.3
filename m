Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0848C51201D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239467AbiD0PMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239239AbiD0PLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:11:35 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A0B17ABC8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:08:22 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RBg6qJ022428;
        Wed, 27 Apr 2022 10:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=I12ksXqpIge63RJbRmQ1nY7zlBxi3wljr3CXegQnzWo=;
 b=mMObeF8R5VSmy6MGX/msNiKrUbbJAxBNtXAiFNL1K5rHLM6/aE6Mh4MngieGtbAXDkBK
 5IuZ+v5wjcpKKi4Xc0srLCbDtxejkBsPFP/B6xL+VWEAkvEGMuruAZ/uv70CetVtSobp
 JTQiHvGmHQB/eTOMooExYbfl1rG5pRYKojxhP3LNBPCZZv9QMwewwONYOQgvemQxYGss
 xDEWbwqty3tk5+qfEd2eYvETqWcPrdkIs4WR6Tyeq+J85vTYV7x95sFItop+WI+TGiZ8
 mgyVNZHoABlT5ia2vjxAlNpy1xbA+ahy2hHr3um6ohKBkYgeHOsmeAQFq3v2dF9tyeZX wg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fprt60xte-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Apr 2022 10:07:40 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 16:07:29 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 27 Apr 2022 16:07:29 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.170])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2582B478;
        Wed, 27 Apr 2022 15:07:29 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 16/26] ALSA: hda: cs35l41: Support multiple load paths for firmware
Date:   Wed, 27 Apr 2022 16:07:10 +0100
Message-ID: <20220427150720.9194-17-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: tA1qJSF_KUxbd2Tp1zo1NB93eIYocRe5
X-Proofpoint-ORIG-GUID: tA1qJSF_KUxbd2Tp1zo1NB93eIYocRe5
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
2.32.0

