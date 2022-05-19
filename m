Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCC852DBB6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243256AbiESRsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243145AbiESRsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:48:08 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A06663FC
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:48:07 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J6k19A002261;
        Thu, 19 May 2022 12:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=J0fR9KNlFufNc0MdSXybhI4lFVPpHlH9P+kE1CluQgE=;
 b=QYTDOaz6aW6hAuegxp5NakPZ/5EiCejl9QnqpMI+utTd/QTgJO/46d6rVuMf1kOSAg7v
 TORwxcFYdWAAy+LDJTcKhSbDG35lwZPkUeKxeLN/ORrT3Ug1dMC/dTl/FfCDddtGbfqS
 hpDHYPDIkJE0DApjBRu3Z9ik3bFgV5LYkT9Ae3clNtvHCoihOmAOmFn0T2D8l0WUdRww
 0AUYIyWSPDHRzuX68IEu5nR9jm5M6kJPIJDUv3/8zkdiwWezgUBtpSB0pybrW3nTuUbn
 xfN39LJymNqu4ZZ0vh1+aaRd2D4Ll7/Hhnims+5duXqiowpnKOJF1rRzSXrmOFfDFu+K yQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3g29u37ted-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 19 May 2022 12:47:52 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 18:47:50 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 19 May 2022 18:47:50 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.59])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2812F458;
        Thu, 19 May 2022 17:47:50 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 02/17] ALSA: hda: hda_cs_dsp_ctl: Add apis to write the controls directly
Date:   Thu, 19 May 2022 18:47:34 +0100
Message-ID: <20220519174749.15459-3-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220519174749.15459-1-vitalyr@opensource.cirrus.com>
References: <20220519174749.15459-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: bO3RACdmFGlnrsAaJeqjEDT6Jrg2Uxlp
X-Proofpoint-ORIG-GUID: bO3RACdmFGlnrsAaJeqjEDT6Jrg2Uxlp
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

DSP controls are exposed as ALSA controls, however,
some of these controls are required to be accessed by
the driver. Add apis which allow read/write of these
controls. The write api will also notify the ALSA control
on value change.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---

Changes since v2:
 - No change

 sound/pci/hda/hda_cs_dsp_ctl.c | 52 ++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_cs_dsp_ctl.h |  4 +++
 2 files changed, 56 insertions(+)

diff --git a/sound/pci/hda/hda_cs_dsp_ctl.c b/sound/pci/hda/hda_cs_dsp_ctl.c
index 46df48ff2ae1..3b837d000a00 100644
--- a/sound/pci/hda/hda_cs_dsp_ctl.c
+++ b/sound/pci/hda/hda_cs_dsp_ctl.c
@@ -237,6 +237,58 @@ void hda_cs_dsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl)
 }
 EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_control_remove, SND_HDA_CS_DSP_CONTROLS);
 
+int hda_cs_dsp_write_ctl(struct cs_dsp *dsp, const char *name, int type,
+			 unsigned int alg, void *buf, size_t len)
+{
+	struct cs_dsp_coeff_ctl *cs_ctl;
+	struct hda_cs_dsp_coeff_ctl *ctl;
+	struct snd_kcontrol *kctl;
+	int ret;
+
+	cs_ctl = cs_dsp_get_ctl(dsp, name, type, alg);
+	if (!cs_ctl)
+		return -EINVAL;
+
+	ctl = cs_ctl->priv;
+
+	if (len > cs_ctl->len)
+		return -EINVAL;
+
+	ret = cs_dsp_coeff_write_ctrl(cs_ctl, 0, buf, len);
+	if (ret)
+		return ret;
+
+	if (cs_ctl->flags & WMFW_CTL_FLAG_SYS)
+		return 0;
+
+	list_for_each_entry(kctl, &ctl->card->controls, list)
+		if (!strncmp(kctl->id.name, ctl->name, sizeof(kctl->id.name))) {
+			snd_ctl_notify(ctl->card, SNDRV_CTL_EVENT_MASK_VALUE, &kctl->id);
+			return 0;
+		}
+
+	dev_warn(dsp->dev, "Cannot find Control for %s\n", name);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_write_ctl, SND_HDA_CS_DSP_CONTROLS);
+
+int hda_cs_dsp_read_ctl(struct cs_dsp *dsp, const char *name, int type,
+			unsigned int alg, void *buf, size_t len)
+{
+	struct cs_dsp_coeff_ctl *cs_ctl;
+
+	cs_ctl = cs_dsp_get_ctl(dsp, name, type, alg);
+	if (!cs_ctl)
+		return -EINVAL;
+
+	if (len > cs_ctl->len)
+		return -EINVAL;
+
+	return cs_dsp_coeff_read_ctrl(cs_ctl, 0, buf, len);
+}
+EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_read_ctl, SND_HDA_CS_DSP_CONTROLS);
+
 MODULE_DESCRIPTION("CS_DSP ALSA Control HDA Library");
 MODULE_AUTHOR("Stefan Binding, <sbinding@opensource.cirrus.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/pci/hda/hda_cs_dsp_ctl.h b/sound/pci/hda/hda_cs_dsp_ctl.h
index 3c90312b45d6..65b9c5c68957 100644
--- a/sound/pci/hda/hda_cs_dsp_ctl.h
+++ b/sound/pci/hda/hda_cs_dsp_ctl.h
@@ -30,5 +30,9 @@ struct hda_cs_dsp_ctl_info {
 int hda_cs_dsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl, struct hda_cs_dsp_ctl_info *info);
 void hda_cs_dsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl);
 int hda_cs_dsp_remove_kcontrol(struct snd_card *card, const char *name);
+int hda_cs_dsp_write_ctl(struct cs_dsp *dsp, const char *name, int type,
+			 unsigned int alg, void *buf, size_t len);
+int hda_cs_dsp_read_ctl(struct cs_dsp *dsp, const char *name, int type,
+			unsigned int alg, void *buf, size_t len);
 
 #endif /*__HDA_CS_DSP_CTL_H__*/
-- 
2.34.1

