Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75052553DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356026AbiFUViz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353965AbiFUViZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:38:25 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2689A11A0A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:38:24 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LBDkxX018841;
        Tue, 21 Jun 2022 16:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=0fK09WSPqLJ843WJS+jSWz9TO+bRzFkM+vnHmi+bF70=;
 b=CpGerZCAyNCWBC+D8NHpuo4ja1haWu+siKwzUDjYsJKvMCt9Of3IwnEV9fBFaB2MryPZ
 O3Esf+ULsnnlXUEuzOhxiIkbn8Vd9OTRclOwfIIvz5dTplGg3feCwaMtWl7wJb88TCV/
 CeAr3LyLiQCOCYQIL2RUAawL8O4hr1GAeIGVDuzr/E/I2wWQ+MfHpOCA6A0+omQ6YJq0
 Zdl/DIfIrcm0a5bflRkzhzRezS9ESK1ihsTSyaHYfApqnF9iKDbQRCKAtcqbJmUeCe+H
 yGBvfe0GZBC/lxG40T/T3OT7/6f6XOUgZLbEikApiraBKeQFwxMGVGxMqhataN3CTkr8 Cg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gsb4p45ae-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Jun 2022 16:38:07 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 21 Jun
 2022 22:38:05 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 21 Jun 2022 22:38:05 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.175])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 94A32475;
        Tue, 21 Jun 2022 21:38:05 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v6 11/14] ALSA: hda: hda_cs_dsp_ctl: Add fw id strings
Date:   Tue, 21 Jun 2022 22:37:58 +0100
Message-ID: <20220621213801.2021097-12-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220621213801.2021097-1-vitalyr@opensource.cirrus.com>
References: <20220621213801.2021097-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Yg3XOzqz_ykYaHLDTi1wxawzfGr5yqfE
X-Proofpoint-ORIG-GUID: Yg3XOzqz_ykYaHLDTi1wxawzfGr5yqfE
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

This will be used to define the firmware names.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/hda_cs_dsp_ctl.c | 8 ++++++++
 sound/pci/hda/hda_cs_dsp_ctl.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/sound/pci/hda/hda_cs_dsp_ctl.c b/sound/pci/hda/hda_cs_dsp_ctl.c
index 6131fcfe21e5..f4f3b0a249f4 100644
--- a/sound/pci/hda/hda_cs_dsp_ctl.c
+++ b/sound/pci/hda/hda_cs_dsp_ctl.c
@@ -28,6 +28,14 @@ static const char * const hda_cs_dsp_fw_text[HDA_CS_DSP_NUM_FW] = {
 	[HDA_CS_DSP_FW_MISC] =     "Misc",
 };
 
+const char * const hda_cs_dsp_fw_ids[HDA_CS_DSP_NUM_FW] = {
+	[HDA_CS_DSP_FW_SPK_PROT] = "spk-prot",
+	[HDA_CS_DSP_FW_SPK_CALI] = "spk-cali",
+	[HDA_CS_DSP_FW_SPK_DIAG] = "spk-diag",
+	[HDA_CS_DSP_FW_MISC] =     "misc",
+};
+EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_fw_ids, SND_HDA_CS_DSP_CONTROLS);
+
 static int hda_cs_dsp_coeff_info(struct snd_kcontrol *kctl, struct snd_ctl_elem_info *uinfo)
 {
 	struct hda_cs_dsp_coeff_ctl *ctl = (struct hda_cs_dsp_coeff_ctl *)kctl->private_value;
diff --git a/sound/pci/hda/hda_cs_dsp_ctl.h b/sound/pci/hda/hda_cs_dsp_ctl.h
index c65bfd6878fd..4babc69cf2f0 100644
--- a/sound/pci/hda/hda_cs_dsp_ctl.h
+++ b/sound/pci/hda/hda_cs_dsp_ctl.h
@@ -27,6 +27,8 @@ struct hda_cs_dsp_ctl_info {
 	const char *device_name;
 };
 
+extern const char * const hda_cs_dsp_fw_ids[HDA_CS_DSP_NUM_FW];
+
 int hda_cs_dsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl, struct hda_cs_dsp_ctl_info *info);
 void hda_cs_dsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl);
 int hda_cs_dsp_write_ctl(struct cs_dsp *dsp, const char *name, int type,
-- 
2.34.1

