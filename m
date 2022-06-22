Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5015543E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354118AbiFVHsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354191AbiFVHrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:47:52 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3953337A8A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:47:41 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M6wRdi014511;
        Wed, 22 Jun 2022 02:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=19zBbVWd5UQuD5z83ln7nLLvmxRQYQez1dYLGhgvRWg=;
 b=p2SdKHglLdneUzElJNVov9aSpqjNzrUKSSue0FLYOO8obAKJnR3oD8s1GosNGEixDM2I
 qz/9fIbN0KAiE6VgnxZnQ67q2k3oBI4zncz7vV+ggyWybZD7rrILillSYHghDSCcTFKd
 +6GOFkcQDtowAiMAJEFtf8YuduFyTV+4OrERJOO141xJtP6483A07oyUasUPC6rJIj3+
 6KHn4OseUNBOHRuwQ8kz/dxNRBmnUSd4wfU+ktwC9cRfOh/tk3LsAp9yOXcMq4aad9gd
 ll19DH9m65I9+nMSoRua5pBxKd51+kRXecm32QMedF9VFeDlZTU7iptCIis4uFllWIvT QQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gsb4p4mwn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Jun 2022 02:46:56 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 08:46:54 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 22 Jun 2022 08:46:54 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.175])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CCC597C;
        Wed, 22 Jun 2022 07:46:53 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v7 01/14] ALSA: hda: hda_cs_dsp_ctl: Add Library to support CS_DSP ALSA controls
Date:   Wed, 22 Jun 2022 08:46:40 +0100
Message-ID: <20220622074653.179078-2-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220622074653.179078-1-vitalyr@opensource.cirrus.com>
References: <20220622074653.179078-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: tEjL3Y1U8bwbA_LxSkw545vqJgyGPsar
X-Proofpoint-ORIG-GUID: tEjL3Y1U8bwbA_LxSkw545vqJgyGPsar
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

The cs35l41 part contains a DSP which is able to run firmware.
The cs_dsp library can be used to control the DSP.
These controls can be exposed to userspace using ALSA controls.
This library adds apis to be able to interface between
cs_dsp and hda drivers and expose the relevant controls as
ALSA controls.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 MAINTAINERS                    |   1 +
 sound/pci/hda/Kconfig          |   4 +
 sound/pci/hda/Makefile         |   2 +
 sound/pci/hda/hda_cs_dsp_ctl.c | 207 +++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_cs_dsp_ctl.h |  33 ++++++
 5 files changed, 247 insertions(+)
 create mode 100644 sound/pci/hda/hda_cs_dsp_ctl.c
 create mode 100644 sound/pci/hda/hda_cs_dsp_ctl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c49b3552f977..fabdd0981ba7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4799,6 +4799,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/cirrus,cs*
 F:	include/dt-bindings/sound/cs*
 F:	sound/pci/hda/cs*
+F:	sound/pci/hda/hda_cs_dsp_ctl.*
 F:	sound/soc/codecs/cs*
 
 CIRRUS LOGIC DSP FIRMWARE DRIVER
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 79ade4787d95..d1fd6cf82beb 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -94,6 +94,10 @@ config SND_HDA_PATCH_LOADER
 config SND_HDA_SCODEC_CS35L41
 	tristate
 
+config SND_HDA_CS_DSP_CONTROLS
+	tristate
+	depends on CS_DSP
+
 config SND_HDA_SCODEC_CS35L41_I2C
 	tristate "Build CS35L41 HD-audio side codec support for I2C Bus"
 	depends on I2C
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index 3e7bc608d45f..00d306104484 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -31,6 +31,7 @@ snd-hda-codec-hdmi-objs :=	patch_hdmi.o hda_eld.o
 snd-hda-scodec-cs35l41-objs :=		cs35l41_hda.o
 snd-hda-scodec-cs35l41-i2c-objs :=	cs35l41_hda_i2c.o
 snd-hda-scodec-cs35l41-spi-objs :=	cs35l41_hda_spi.o
+snd-hda-cs-dsp-ctls-objs :=		hda_cs_dsp_ctl.o
 
 # common driver
 obj-$(CONFIG_SND_HDA) := snd-hda-codec.o
@@ -54,6 +55,7 @@ obj-$(CONFIG_SND_HDA_CODEC_HDMI) += snd-hda-codec-hdmi.o
 obj-$(CONFIG_SND_HDA_SCODEC_CS35L41) += snd-hda-scodec-cs35l41.o
 obj-$(CONFIG_SND_HDA_SCODEC_CS35L41_I2C) += snd-hda-scodec-cs35l41-i2c.o
 obj-$(CONFIG_SND_HDA_SCODEC_CS35L41_SPI) += snd-hda-scodec-cs35l41-spi.o
+obj-$(CONFIG_SND_HDA_CS_DSP_CONTROLS) += snd-hda-cs-dsp-ctls.o
 
 # this must be the last entry after codec drivers;
 # otherwise the codec patches won't be hooked before the PCI probe
diff --git a/sound/pci/hda/hda_cs_dsp_ctl.c b/sound/pci/hda/hda_cs_dsp_ctl.c
new file mode 100644
index 000000000000..0f4f02e0a538
--- /dev/null
+++ b/sound/pci/hda/hda_cs_dsp_ctl.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// HDA DSP ALSA Control Driver
+//
+// Copyright 2022 Cirrus Logic, Inc.
+//
+// Author: Stefan Binding <sbinding@opensource.cirrus.com>
+
+#include <linux/module.h>
+#include <sound/soc.h>
+#include <linux/firmware/cirrus/cs_dsp.h>
+#include <linux/firmware/cirrus/wmfw.h>
+#include "hda_cs_dsp_ctl.h"
+
+#define ADSP_MAX_STD_CTRL_SIZE               512
+
+struct hda_cs_dsp_coeff_ctl {
+	const char *name;
+	struct cs_dsp_coeff_ctl *cs_ctl;
+	struct snd_card *card;
+	struct snd_kcontrol *kctl;
+};
+
+static const char * const hda_cs_dsp_fw_text[HDA_CS_DSP_NUM_FW] = {
+	[HDA_CS_DSP_FW_SPK_PROT] = "Prot",
+	[HDA_CS_DSP_FW_SPK_CALI] = "Cali",
+	[HDA_CS_DSP_FW_SPK_DIAG] = "Diag",
+	[HDA_CS_DSP_FW_MISC] =     "Misc",
+};
+
+static int hda_cs_dsp_coeff_info(struct snd_kcontrol *kctl, struct snd_ctl_elem_info *uinfo)
+{
+	struct hda_cs_dsp_coeff_ctl *ctl = (struct hda_cs_dsp_coeff_ctl *)kctl->private_value;
+	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	uinfo->count = cs_ctl->len;
+
+	return 0;
+}
+
+static int hda_cs_dsp_coeff_put(struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_cs_dsp_coeff_ctl *ctl = (struct hda_cs_dsp_coeff_ctl *)kctl->private_value;
+	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
+	char *p = ucontrol->value.bytes.data;
+	int ret = 0;
+
+	mutex_lock(&cs_ctl->dsp->pwr_lock);
+	ret = cs_dsp_coeff_write_ctrl(cs_ctl, 0, p, cs_ctl->len);
+	mutex_unlock(&cs_ctl->dsp->pwr_lock);
+
+	return ret;
+}
+
+static int hda_cs_dsp_coeff_get(struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_cs_dsp_coeff_ctl *ctl = (struct hda_cs_dsp_coeff_ctl *)kctl->private_value;
+	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
+	char *p = ucontrol->value.bytes.data;
+	int ret;
+
+	mutex_lock(&cs_ctl->dsp->pwr_lock);
+	ret = cs_dsp_coeff_read_ctrl(cs_ctl, 0, p, cs_ctl->len);
+	mutex_unlock(&cs_ctl->dsp->pwr_lock);
+
+	return ret;
+}
+
+static unsigned int wmfw_convert_flags(unsigned int in)
+{
+	unsigned int out, rd, wr, vol;
+
+	rd = SNDRV_CTL_ELEM_ACCESS_READ;
+	wr = SNDRV_CTL_ELEM_ACCESS_WRITE;
+	vol = SNDRV_CTL_ELEM_ACCESS_VOLATILE;
+
+	out = 0;
+
+	if (in) {
+		out |= rd;
+		if (in & WMFW_CTL_FLAG_WRITEABLE)
+			out |= wr;
+		if (in & WMFW_CTL_FLAG_VOLATILE)
+			out |= vol;
+	} else {
+		out |= rd | wr | vol;
+	}
+
+	return out;
+}
+
+static int hda_cs_dsp_add_kcontrol(struct hda_cs_dsp_coeff_ctl *ctl)
+{
+	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
+	struct snd_kcontrol_new *kcontrol;
+	struct snd_kcontrol *kctl;
+	int ret = 0;
+
+	if (cs_ctl->len > ADSP_MAX_STD_CTRL_SIZE) {
+		dev_err(cs_ctl->dsp->dev, "Control %s: length %zu exceeds maximum %d\n", ctl->name,
+			cs_ctl->len, ADSP_MAX_STD_CTRL_SIZE);
+		return -EINVAL;
+	}
+
+	kcontrol = kzalloc(sizeof(*kcontrol), GFP_KERNEL);
+	if (!kcontrol)
+		return -ENOMEM;
+
+	kcontrol->name = ctl->name;
+	kcontrol->info = hda_cs_dsp_coeff_info;
+	kcontrol->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	kcontrol->private_value = (unsigned long)ctl;
+	kcontrol->access = wmfw_convert_flags(cs_ctl->flags);
+
+	kcontrol->get = hda_cs_dsp_coeff_get;
+	kcontrol->put = hda_cs_dsp_coeff_put;
+
+	kctl = snd_ctl_new1(kcontrol, NULL);
+	if (!kctl) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	ctl->kctl = kctl;
+
+	ret = snd_ctl_add(ctl->card, kctl);
+	if (ret)
+		dev_err(cs_ctl->dsp->dev, "Failed to add KControl: %s - Ret: %d\n", kcontrol->name,
+			ret);
+	else
+		dev_dbg(cs_ctl->dsp->dev, "Added KControl: %s\n", kcontrol->name);
+
+err:
+	kfree(kcontrol);
+
+	return ret;
+}
+
+int hda_cs_dsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl, struct hda_cs_dsp_ctl_info *info)
+{
+	struct cs_dsp *cs_dsp = cs_ctl->dsp;
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	struct hda_cs_dsp_coeff_ctl *ctl;
+	const char *region_name;
+	int ret;
+
+	if (cs_ctl->flags & WMFW_CTL_FLAG_SYS)
+		return 0;
+
+	region_name = cs_dsp_mem_region_name(cs_ctl->alg_region.type);
+	if (!region_name) {
+		dev_err(cs_dsp->dev, "Unknown region type: %d\n", cs_ctl->alg_region.type);
+		return -EINVAL;
+	}
+
+	ret = scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "%s %s %.12s %x", info->device_name,
+			cs_dsp->name, hda_cs_dsp_fw_text[info->fw_type], cs_ctl->alg_region.alg);
+
+	if (cs_ctl->subname) {
+		int avail = SNDRV_CTL_ELEM_ID_NAME_MAXLEN - ret - 2;
+		int skip = 0;
+
+		/* Truncate the subname from the start if it is too long */
+		if (cs_ctl->subname_len > avail)
+			skip = cs_ctl->subname_len - avail;
+
+		snprintf(name + ret, SNDRV_CTL_ELEM_ID_NAME_MAXLEN - ret,
+			 " %.*s", cs_ctl->subname_len - skip, cs_ctl->subname + skip);
+	}
+
+	ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
+	if (!ctl)
+		return -ENOMEM;
+	ctl->cs_ctl = cs_ctl;
+	ctl->card = info->card;
+
+	ctl->name = kmemdup(name, strlen(name) + 1, GFP_KERNEL);
+	if (!ctl->name) {
+		ret = -ENOMEM;
+		dev_err(cs_dsp->dev, "Cannot save ctl name\n");
+		goto err_ctl;
+	}
+
+	cs_ctl->priv = ctl;
+
+	return hda_cs_dsp_add_kcontrol(ctl);
+
+err_ctl:
+	dev_err(cs_dsp->dev, "Error adding control: %s\n", name);
+	kfree(ctl);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_control_add, SND_HDA_CS_DSP_CONTROLS);
+
+void hda_cs_dsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl)
+{
+	struct hda_cs_dsp_coeff_ctl *ctl = cs_ctl->priv;
+
+	snd_ctl_remove_id(ctl->card, &ctl->kctl->id);
+	kfree(ctl->name);
+	kfree(ctl);
+}
+EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_control_remove, SND_HDA_CS_DSP_CONTROLS);
+
+MODULE_DESCRIPTION("CS_DSP ALSA Control HDA Library");
+MODULE_AUTHOR("Stefan Binding, <sbinding@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/pci/hda/hda_cs_dsp_ctl.h b/sound/pci/hda/hda_cs_dsp_ctl.h
new file mode 100644
index 000000000000..1c6d0fc9a2cc
--- /dev/null
+++ b/sound/pci/hda/hda_cs_dsp_ctl.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * HDA DSP ALSA Control Driver
+ *
+ * Copyright 2022 Cirrus Logic, Inc.
+ *
+ * Author: Stefan Binding <sbinding@opensource.cirrus.com>
+ */
+
+#ifndef __HDA_CS_DSP_CTL_H__
+#define __HDA_CS_DSP_CTL_H__
+
+#include <sound/soc.h>
+#include <linux/firmware/cirrus/cs_dsp.h>
+
+enum hda_cs_dsp_fw_id {
+	HDA_CS_DSP_FW_SPK_PROT,
+	HDA_CS_DSP_FW_SPK_CALI,
+	HDA_CS_DSP_FW_SPK_DIAG,
+	HDA_CS_DSP_FW_MISC,
+	HDA_CS_DSP_NUM_FW
+};
+
+struct hda_cs_dsp_ctl_info {
+	struct snd_card *card;
+	enum hda_cs_dsp_fw_id fw_type;
+	const char *device_name;
+};
+
+int hda_cs_dsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl, struct hda_cs_dsp_ctl_info *info);
+void hda_cs_dsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl);
+
+#endif /*__HDA_CS_DSP_CTL_H__*/
-- 
2.34.1

