Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A21511EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbiD0PLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239006AbiD0PK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:10:58 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAC954BC7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:07:45 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R6M8vj014103;
        Wed, 27 Apr 2022 10:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ZFbBmmpTjl/Vq2+nzJvMH6GVEdM6lotyERekmMtL4Oo=;
 b=nxZo+LTwOJM7Jjd54+vI9MtJLb+/lwNit96yDdm9tIq3Wls6JjVh2hNGYxEJ+CHNApSa
 PP2zT2pFSeBJwSFc7zXcAEsCW9lthza52KRxd0FSRgpLujshmJSYGuCZRHqyHIfJGh5K
 wWhHihOzLZF6BGRhx1XDT5dxZX2ZgJHCAUi6My9KV0RqJc5SlUJXZ68Uz5cusJX1XBIx
 j8PMRcegBp+bH+amjJq9j8H7XOYzRm/6qXuD4bOcoRRbTN/J+QIUGumUB6xA8ew/T7IL
 ns3Lk/27LGGAOyqk2E/qXPiXPvDqEOvfSyPi2ivc/E6OhA1tmDjp93KK46lMvCwGzSaz Sw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fprt60xth-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Apr 2022 10:07:30 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 16:07:26 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 27 Apr 2022 16:07:26 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.170])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4593BB1A;
        Wed, 27 Apr 2022 15:07:26 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 10/26] ALSA: hda: hda_cs_dsp_ctl: Add Library to support CS_DSP ALSA controls
Date:   Wed, 27 Apr 2022 16:07:04 +0100
Message-ID: <20220427150720.9194-11-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ihxfNNyHIMWNu54D0YxHyRaasAlr4-s7
X-Proofpoint-ORIG-GUID: ihxfNNyHIMWNu54D0YxHyRaasAlr4-s7
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
 sound/pci/hda/hda_cs_dsp_ctl.c | 364 +++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_cs_dsp_ctl.h |  34 +++
 5 files changed, 405 insertions(+)
 create mode 100644 sound/pci/hda/hda_cs_dsp_ctl.c
 create mode 100644 sound/pci/hda/hda_cs_dsp_ctl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 61d9f114c37f..10bcb9fba3eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4693,6 +4693,7 @@ L:	patches@opensource.cirrus.com
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/cirrus,cs*
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
index 000000000000..e94740c5557a
--- /dev/null
+++ b/sound/pci/hda/hda_cs_dsp_ctl.c
@@ -0,0 +1,364 @@
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
+struct hda_cs_dsp_coeff_ctl {
+	const char *name;
+	struct cs_dsp_coeff_ctl *cs_ctl;
+	struct snd_card *card;
+	struct soc_bytes_ext bytes_ext;
+	struct work_struct add_work;
+	struct work_struct remove_work;
+};
+
+static const char * const hda_cs_dsp_fw_text[HDA_CS_DSP_NUM_FW] = {
+	[HDA_CS_DSP_FW_SPK_PROT] = "Prot",
+	[HDA_CS_DSP_FW_SPK_CALI] = "Cali",
+	[HDA_CS_DSP_FW_SPK_DIAG] = "Diag",
+	[HDA_CS_DSP_FW_MISC] =     "Misc",
+};
+
+static inline struct hda_cs_dsp_coeff_ctl *bytes_ext_to_ctl(struct soc_bytes_ext *ext)
+{
+	return container_of(ext, struct hda_cs_dsp_coeff_ctl, bytes_ext);
+}
+
+static int hda_cs_dsp_coeff_info(struct snd_kcontrol *kctl, struct snd_ctl_elem_info *uinfo)
+{
+	struct soc_bytes_ext *bytes_ext =
+		(struct soc_bytes_ext *)kctl->private_value;
+	struct hda_cs_dsp_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
+	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
+
+	switch (cs_ctl->type) {
+	case WMFW_CTL_TYPE_ACKED:
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+		uinfo->value.integer.min = CS_DSP_ACKED_CTL_MIN_VALUE;
+		uinfo->value.integer.max = CS_DSP_ACKED_CTL_MAX_VALUE;
+		uinfo->value.integer.step = 1;
+		uinfo->count = 1;
+		break;
+	default:
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+		uinfo->count = cs_ctl->len;
+		break;
+	}
+
+	return 0;
+}
+
+static int hda_cs_dsp_coeff_put(struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_bytes_ext *bytes_ext =
+		(struct soc_bytes_ext *)kctl->private_value;
+	struct hda_cs_dsp_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
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
+static int hda_cs_dsp_coeff_tlv_put(struct snd_kcontrol *kctl,
+				    const unsigned int __user *bytes, unsigned int size)
+{
+	struct soc_bytes_ext *bytes_ext =
+		(struct soc_bytes_ext *)kctl->private_value;
+	struct hda_cs_dsp_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
+	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
+	int ret = 0;
+
+	mutex_lock(&cs_ctl->dsp->pwr_lock);
+
+	if (copy_from_user(cs_ctl->cache, bytes, size))
+		ret = -EFAULT;
+	else
+		ret = cs_dsp_coeff_write_ctrl(cs_ctl, 0, cs_ctl->cache, size);
+
+	mutex_unlock(&cs_ctl->dsp->pwr_lock);
+
+	return ret;
+}
+
+static int hda_cs_dsp_coeff_put_acked(struct snd_kcontrol *kctl,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_bytes_ext *bytes_ext =
+		(struct soc_bytes_ext *)kctl->private_value;
+	struct hda_cs_dsp_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
+	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
+	unsigned int val = ucontrol->value.integer.value[0];
+	int ret;
+
+	if (val == 0)
+		return 0;	/* 0 means no event */
+
+	mutex_lock(&cs_ctl->dsp->pwr_lock);
+
+	if (cs_ctl->enabled)
+		ret = cs_dsp_coeff_write_acked_control(cs_ctl, val);
+	else
+		ret = -EPERM;
+
+	mutex_unlock(&cs_ctl->dsp->pwr_lock);
+
+	return ret;
+}
+
+static int hda_cs_dsp_coeff_get(struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_bytes_ext *bytes_ext =
+		(struct soc_bytes_ext *)kctl->private_value;
+	struct hda_cs_dsp_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
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
+static int hda_cs_dsp_coeff_tlv_get(struct snd_kcontrol *kctl,
+				    unsigned int __user *bytes, unsigned int size)
+{
+	struct soc_bytes_ext *bytes_ext =
+		(struct soc_bytes_ext *)kctl->private_value;
+	struct hda_cs_dsp_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
+	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
+	int ret = 0;
+
+	mutex_lock(&cs_ctl->dsp->pwr_lock);
+
+	ret = cs_dsp_coeff_read_ctrl(cs_ctl, 0, cs_ctl->cache, size);
+
+	if (!ret && copy_to_user(bytes, cs_ctl->cache, size))
+		ret = -EFAULT;
+
+	mutex_unlock(&cs_ctl->dsp->pwr_lock);
+
+	return ret;
+}
+
+static int hda_cs_dsp_coeff_get_acked(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	/*
+	 * Although it's not useful to read an acked control, we must satisfy
+	 * user-side assumptions that all controls are readable and that a
+	 * write of the same value should be filtered out (it's valid to send
+	 * the same event number again to the firmware). We therefore return 0,
+	 * meaning "no event" so valid event numbers will always be a change
+	 */
+	ucontrol->value.integer.value[0] = 0;
+
+	return 0;
+}
+#define ADSP_MAX_STD_CTRL_SIZE               512
+
+static unsigned int wmfw_convert_flags(unsigned int in, unsigned int len)
+{
+	unsigned int out, rd, wr, vol;
+
+	if (len > ADSP_MAX_STD_CTRL_SIZE) {
+		rd = SNDRV_CTL_ELEM_ACCESS_TLV_READ;
+		wr = SNDRV_CTL_ELEM_ACCESS_TLV_WRITE;
+		vol = SNDRV_CTL_ELEM_ACCESS_VOLATILE;
+
+		out = SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
+	} else {
+		rd = SNDRV_CTL_ELEM_ACCESS_READ;
+		wr = SNDRV_CTL_ELEM_ACCESS_WRITE;
+		vol = SNDRV_CTL_ELEM_ACCESS_VOLATILE;
+
+		out = 0;
+	}
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
+static void hda_cs_dsp_ctl_add_work(struct work_struct *work)
+{
+	struct hda_cs_dsp_coeff_ctl *ctl = container_of(work,
+							struct hda_cs_dsp_coeff_ctl,
+							add_work);
+	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
+	struct snd_kcontrol_new *kcontrol;
+
+	kcontrol = kzalloc(sizeof(*kcontrol), GFP_KERNEL);
+	if (!kcontrol)
+		return;
+
+	kcontrol->name = ctl->name;
+	kcontrol->info = hda_cs_dsp_coeff_info;
+	kcontrol->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	kcontrol->tlv.c = snd_soc_bytes_tlv_callback;
+	kcontrol->private_value = (unsigned long)&ctl->bytes_ext;
+	kcontrol->access = wmfw_convert_flags(cs_ctl->flags, cs_ctl->len);
+
+	switch (cs_ctl->type) {
+	case WMFW_CTL_TYPE_ACKED:
+		kcontrol->get = hda_cs_dsp_coeff_get_acked;
+		kcontrol->put = hda_cs_dsp_coeff_put_acked;
+		break;
+	default:
+		if (kcontrol->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
+			ctl->bytes_ext.max = cs_ctl->len;
+			ctl->bytes_ext.get = hda_cs_dsp_coeff_tlv_get;
+			ctl->bytes_ext.put = hda_cs_dsp_coeff_tlv_put;
+		} else {
+			kcontrol->get = hda_cs_dsp_coeff_get;
+			kcontrol->put = hda_cs_dsp_coeff_put;
+		}
+		break;
+	}
+
+	if (snd_ctl_add(ctl->card, snd_ctl_new1(kcontrol, NULL)))
+		dev_err(cs_ctl->dsp->dev, "Failed to add KControl: %s\n", kcontrol->name);
+	else
+		dev_dbg(cs_ctl->dsp->dev, "Added KControl: %s\n", kcontrol->name);
+
+	kfree(kcontrol);
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
+	if (cs_ctl->flags & WMFW_CTL_FLAG_SYS) {
+		dev_dbg(cs_dsp->dev, "cs_ctl->flags = WMFW_CTL_FLAG_SYS\n");
+		return 0;
+	}
+
+	region_name = cs_dsp_mem_region_name(cs_ctl->alg_region.type);
+	if (!region_name) {
+		dev_err(cs_dsp->dev, "Unknown region type: %d\n", cs_ctl->alg_region.type);
+		return -EINVAL;
+	}
+
+	switch (cs_dsp->fw_ver) {
+	case 0:
+	case 1:
+		ret = scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
+				"%s %s %s %x", info->amp_name, cs_dsp->name, region_name,
+				cs_ctl->alg_region.alg);
+		break;
+	case 2:
+		ret = scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
+				"%s %s%c %.12s %x", info->amp_name, cs_dsp->name, *region_name,
+				hda_cs_dsp_fw_text[info->fw_type], cs_ctl->alg_region.alg);
+		break;
+	default:
+		ret = scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
+				"%s %s %.12s %x", info->amp_name, cs_dsp->name,
+				hda_cs_dsp_fw_text[info->fw_type], cs_ctl->alg_region.alg);
+		break;
+	}
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
+	INIT_WORK(&ctl->add_work, hda_cs_dsp_ctl_add_work);
+	schedule_work(&ctl->add_work);
+
+	return 0;
+
+err_ctl:
+	dev_err(cs_dsp->dev, "Error adding control: %s\n", name);
+	kfree(ctl);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_control_add, SND_HDA_CS_DSP_CONTROLS);
+
+int hda_cs_dsp_remove_kcontrol(struct snd_card *card, const char *name)
+{
+	struct snd_kcontrol *kctl;
+
+	list_for_each_entry(kctl, &card->controls, list)
+		if (!strncmp(kctl->id.name, name, sizeof(kctl->id.name)))
+			return snd_ctl_remove_id(card, &kctl->id);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_remove_kcontrol, SND_HDA_CS_DSP_CONTROLS);
+
+static void hda_cs_dsp_ctl_del_work(struct work_struct *work)
+{
+	struct hda_cs_dsp_coeff_ctl *ctl = container_of(work,
+							struct hda_cs_dsp_coeff_ctl,
+							remove_work);
+
+	cancel_work_sync(&ctl->add_work);
+
+	hda_cs_dsp_remove_kcontrol(ctl->card, ctl->name);
+
+	kfree(ctl->name);
+	kfree(ctl);
+}
+
+void hda_cs_dsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl)
+{
+	struct hda_cs_dsp_coeff_ctl *ctl = cs_ctl->priv;
+
+	INIT_WORK(&ctl->remove_work, hda_cs_dsp_ctl_del_work);
+	schedule_work(&ctl->remove_work);
+}
+EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_control_remove, SND_HDA_CS_DSP_CONTROLS);
+
+MODULE_DESCRIPTION("CS_DSP ALSA Control HDA Library");
+MODULE_AUTHOR("Stefan Binding, <sbinding@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/pci/hda/hda_cs_dsp_ctl.h b/sound/pci/hda/hda_cs_dsp_ctl.h
new file mode 100644
index 000000000000..3c90312b45d6
--- /dev/null
+++ b/sound/pci/hda/hda_cs_dsp_ctl.h
@@ -0,0 +1,34 @@
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
+	const char *amp_name;
+};
+
+int hda_cs_dsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl, struct hda_cs_dsp_ctl_info *info);
+void hda_cs_dsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl);
+int hda_cs_dsp_remove_kcontrol(struct snd_card *card, const char *name);
+
+#endif /*__HDA_CS_DSP_CTL_H__*/
-- 
2.32.0

