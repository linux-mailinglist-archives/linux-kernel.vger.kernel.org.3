Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FBB515AA3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 07:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241220AbiD3Fo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 01:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbiD3Foy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 01:44:54 -0400
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DDB51339
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 22:41:31 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 9308D80019E;
        Sat, 30 Apr 2022 13:41:29 +0800 (CST)
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
Subject: [PATCH v2] ASoC: hdmi-codec: Add option for ELD bypass
Date:   Sat, 30 Apr 2022 13:41:18 +0800
Message-Id: <20220430134006.v2.1.Ide2a04ad0c123cc6990a63632e6f9bb7d7f9be13@changeid>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUlKS0tKN1dZLVlBSVdZDwkaFQgSH1lBWUNIQ0JWQhhNGkIaTk
        JOSENCVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktITUpVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NiI6CBw5Dz08SRZNKSEfHlE#
        MRRPChVVSlVKTU5KSUJMSUJLSUpPVTMWGhIXVQgOHBoJVQETGhUcOwkUGBBWGBMSCwhVGBQWRVlX
        WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBT05NSjcG
X-HM-Tid: 0a8078fd0692b03akuuu9308d80019e
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

Changes in v2:
- Use MACRO SOC_SINGLE_BOOL_EXT to simplify code.
  Fix event_missing checked by mixer-test.
  Add suffix "Switch" for "ELD Bypass".

 sound/soc/codecs/hdmi-codec.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index b07607a..be46fbd 100644
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
@@ -427,6 +428,31 @@ static int hdmi_codec_iec958_mask_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
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
+	if (hcp->eld_bypass == ucontrol->value.integer.value[0])
+		return 0;
+
+	hcp->eld_bypass = ucontrol->value.integer.value[0];
+
+	return 1;
+}
+
 static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
@@ -447,7 +473,7 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 			goto err;
 	}
 
-	if (tx && hcp->hcd.ops->get_eld) {
+	if (tx && !hcp->eld_bypass && hcp->hcd.ops->get_eld) {
 		ret = hcp->hcd.ops->get_eld(dai->dev->parent, hcp->hcd.data,
 					    hcp->eld, sizeof(hcp->eld));
 		if (ret)
@@ -770,6 +796,8 @@ static struct snd_kcontrol_new hdmi_codec_controls[] = {
 		.info	= hdmi_eld_ctl_info,
 		.get	= hdmi_eld_ctl_get,
 	},
+	SOC_SINGLE_BOOL_EXT("ELD Bypass Switch", 0,
+			    hdmi_codec_eld_bypass_get, hdmi_codec_eld_bypass_put),
 };
 
 static int hdmi_codec_pcm_new(struct snd_soc_pcm_runtime *rtd,
@@ -854,7 +882,7 @@ static void plugged_cb(struct device *dev, bool plugged)
 	struct hdmi_codec_priv *hcp = dev_get_drvdata(dev);
 
 	if (plugged) {
-		if (hcp->hcd.ops->get_eld) {
+		if (!hcp->eld_bypass && hcp->hcd.ops->get_eld) {
 			hcp->hcd.ops->get_eld(dev->parent, hcp->hcd.data,
 					    hcp->eld, sizeof(hcp->eld));
 		}
-- 
2.7.4

