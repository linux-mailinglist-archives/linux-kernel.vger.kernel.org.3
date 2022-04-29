Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69929514EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358497AbiD2PR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378319AbiD2PRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:17:20 -0400
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46F3D4C4B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:13:58 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id C22A08002E3;
        Fri, 29 Apr 2022 23:13:56 +0800 (CST)
From:   Sugar Zhang <sugar.zhang@rock-chips.com>
To:     broonie@kernel.org
Cc:     Sugar Zhang <sugar.zhang@rock-chips.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: hdmi-codec: Add option for ELD bypass
Date:   Fri, 29 Apr 2022 23:13:38 +0800
Message-Id: <1651245218-47201-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUlKS0tKN1dZLVlBSVdZDwkaFQgSH1lBWRoaHklWTBpNHUtMQk
        pPQ01JVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktITUpVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6My46Tyo*GT06LhcCIjg8DjUN
        N0wKFEhVSlVKTU5KSU9OSUhMSE5DVTMWGhIXVQgOHBoJVQETGhUcOwkUGBBWGBMSCwhVGBQWRVlX
        WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBT0xPTTcG
X-HM-Tid: 0a8075e2c346b03akuuuc22a08002e3
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allow users to enable "ELD Bypass" who don't
care anything from EDID Link Data.

Currently, this driver gets ELD(from EDID) to constraint
channels and rates.

Unfortunately, EDID is not always valid, maybe caused by
the fragile HDMI port or cable, in this situation, the max
features are limited to 48kHz stereo.

So, add this option to allow user to select the manual way
to output audio as expected. such as multi-channels LPCM(7.1),
or HBR bitstream for these sink devices.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/codecs/hdmi-codec.c | 44 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index b07607a..3b78aa8 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -275,6 +275,7 @@ struct hdmi_codec_priv {
 	unsigned int chmap_idx;
 	struct mutex lock;
 	bool busy;
+	bool eld_bypass;
 	struct snd_soc_jack *jack;
 	unsigned int jack_status;
 	u8 iec_status[AES_IEC958_STATUS_SIZE];
@@ -427,6 +428,44 @@ static int hdmi_codec_iec958_mask_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int hdmi_codec_eld_bypass_info(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+
+	return 0;
+}
+
+static int hdmi_codec_eld_bypass_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.integer.value[0] = hcp->eld_bypass;
+
+	return 0;
+}
+
+static int hdmi_codec_eld_bypass_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
+
+	hcp->eld_bypass = ucontrol->value.integer.value[0];
+
+	return 0;
+}
+
+#define HDMI_CODEC_ELD_BYPASS_DECL(xname) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = hdmi_codec_eld_bypass_info, .get = hdmi_codec_eld_bypass_get, \
+	.put = hdmi_codec_eld_bypass_put, }
+
 static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
@@ -447,7 +486,7 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 			goto err;
 	}
 
-	if (tx && hcp->hcd.ops->get_eld) {
+	if (tx && !hcp->eld_bypass && hcp->hcd.ops->get_eld) {
 		ret = hcp->hcd.ops->get_eld(dai->dev->parent, hcp->hcd.data,
 					    hcp->eld, sizeof(hcp->eld));
 		if (ret)
@@ -770,6 +809,7 @@ static struct snd_kcontrol_new hdmi_codec_controls[] = {
 		.info	= hdmi_eld_ctl_info,
 		.get	= hdmi_eld_ctl_get,
 	},
+	HDMI_CODEC_ELD_BYPASS_DECL("ELD Bypass"),
 };
 
 static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
@@ -854,7 +894,7 @@ static void plugged_cb(struct device *dev, bool plugged)
 	struct hdmi_codec_priv *hcp = dev_get_drvdata(dev);
 
 	if (plugged) {
-		if (hcp->hcd.ops->get_eld) {
+		if (!hcp->eld_bypass && hcp->hcd.ops->get_eld) {
 			hcp->hcd.ops->get_eld(dev->parent, hcp->hcd.data,
 					    hcp->eld, sizeof(hcp->eld));
 		}
-- 
2.7.4

