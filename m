Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32B2552616
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345056AbiFTUzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344561AbiFTUzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:55:15 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAA91BEAD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:55:06 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25KIfiVe023078;
        Mon, 20 Jun 2022 15:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=VPZBc7LLWtqDFYox3jSoNijfQwcloC5vLsIWyXQT3Aw=;
 b=Myt9h/PXziRTTi3dxQXZQUrRdcv+DXqlQ/lDywugKHkSO6vVBI72gyM0FbT3TzhJc8kJ
 l9APA5KI3TJWJ5w+4mdf4Ih7W2+O9DQ/bWOIEcY3DcEz02CW9x8PJloNnieGvsWNa1pc
 EjUxE0PxBp2+N33wXXisC5Gt9OCdQbcmzUmTEKGftR44Li16xqjNz1Tc84YiF9o6oLvj
 esQAQ1EUsQanXftQoYZigbSw4vmkZbycI2VnRETNzi1g9BK8BQLtshbntM1G4fTORDXv
 hu102YRgnJ6LsRsJep7L6AUnBbgJWxRrN7HRAggAmEB+ze4TKoHhDi/Ife1jPaEkMPpm Fw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gsb4p2p54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Jun 2022 15:54:45 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 20 Jun
 2022 21:54:43 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 20 Jun 2022 21:54:43 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.175])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1D2F1468;
        Mon, 20 Jun 2022 20:54:39 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v5 02/14] ALSA: hda: hda_cs_dsp_ctl: Add apis to write the controls directly
Date:   Mon, 20 Jun 2022 21:54:20 +0100
Message-ID: <20220620205432.3809-3-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220620205432.3809-1-vitalyr@opensource.cirrus.com>
References: <20220620205432.3809-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: qDaRRzrNyvq0b0DoSIkDVSVOPwPmQ6Ry
X-Proofpoint-ORIG-GUID: qDaRRzrNyvq0b0DoSIkDVSVOPwPmQ6Ry
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

DSP controls are exposed as ALSA controls, however,
some of these controls are required to be accessed by
the driver. Add apis which allow read/write of these
controls. The write api will also notify the ALSA control
on value change.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/hda_cs_dsp_ctl.c | 39 ++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_cs_dsp_ctl.h |  4 ++++
 2 files changed, 43 insertions(+)

diff --git a/sound/pci/hda/hda_cs_dsp_ctl.c b/sound/pci/hda/hda_cs_dsp_ctl.c
index e61df1ce10df..c8c508e1f8aa 100644
--- a/sound/pci/hda/hda_cs_dsp_ctl.c
+++ b/sound/pci/hda/hda_cs_dsp_ctl.c
@@ -202,6 +202,45 @@ void hda_cs_dsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl)
 }
 EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_control_remove, SND_HDA_CS_DSP_CONTROLS);
 
+int hda_cs_dsp_write_ctl(struct cs_dsp *dsp, const char *name, int type,
+			 unsigned int alg, const void *buf, size_t len)
+{
+	struct cs_dsp_coeff_ctl *cs_ctl;
+	struct hda_cs_dsp_coeff_ctl *ctl;
+	int ret;
+
+	cs_ctl = cs_dsp_get_ctl(dsp, name, type, alg);
+	if (!cs_ctl)
+		return -EINVAL;
+
+	ctl = cs_ctl->priv;
+
+	ret = cs_dsp_coeff_write_ctrl(cs_ctl, 0, buf, len);
+	if (ret)
+		return ret;
+
+	if (cs_ctl->flags & WMFW_CTL_FLAG_SYS)
+		return 0;
+
+	snd_ctl_notify(ctl->card, SNDRV_CTL_EVENT_MASK_VALUE, &ctl->kctl->id);
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
+	return cs_dsp_coeff_read_ctrl(cs_ctl, 0, buf, len);
+}
+EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_read_ctl, SND_HDA_CS_DSP_CONTROLS);
+
 MODULE_DESCRIPTION("CS_DSP ALSA Control HDA Library");
 MODULE_AUTHOR("Stefan Binding, <sbinding@opensource.cirrus.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/pci/hda/hda_cs_dsp_ctl.h b/sound/pci/hda/hda_cs_dsp_ctl.h
index 1c6d0fc9a2cc..c65bfd6878fd 100644
--- a/sound/pci/hda/hda_cs_dsp_ctl.h
+++ b/sound/pci/hda/hda_cs_dsp_ctl.h
@@ -29,5 +29,9 @@ struct hda_cs_dsp_ctl_info {
 
 int hda_cs_dsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl, struct hda_cs_dsp_ctl_info *info);
 void hda_cs_dsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl);
+int hda_cs_dsp_write_ctl(struct cs_dsp *dsp, const char *name, int type,
+			 unsigned int alg, const void *buf, size_t len);
+int hda_cs_dsp_read_ctl(struct cs_dsp *dsp, const char *name, int type,
+			unsigned int alg, void *buf, size_t len);
 
 #endif /*__HDA_CS_DSP_CTL_H__*/
-- 
2.34.1

