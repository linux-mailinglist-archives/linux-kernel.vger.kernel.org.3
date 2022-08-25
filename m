Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC985A12EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbiHYODh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241611AbiHYODI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:03:08 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A003CB0B34
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:03:00 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1661436172; bh=l8JOb0hAWhVJH3nSwe474gz70FVSVhQNrSMoKlGL5NE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DGrIQhoRsIrW6NeEmOuD5vnKGvGau5m3L5zCZyZQoUzJ4++Obr6tjp31EDTIDVBEH
         TlSSOvrhZl0DB/Axv0/GvdZDBh9Z+vK0WGxvVs4nksjHbQPrAjpbMQS+HQiCbKubhC
         CC/7BN32D69v6dlKIeo2vKWi0fDQ1ZfQzTxJrWmQ=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     navada@ti.com, shenghao-ding@ti.com, asyrus@ti.com,
        raphael-xu@ti.com,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Stephen Kitt <steve@sk2.org>, Dan Murphy <dmurphy@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: [PATCH 5/5] ASoC: tas2764: Export highpass filter setting
Date:   Thu, 25 Aug 2022 16:02:41 +0200
Message-Id: <20220825140241.53963-6-povik+lin@cutebit.org>
In-Reply-To: <20220825140241.53963-1-povik+lin@cutebit.org>
References: <20220825140241.53963-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose a control for the setting of 'DC blocker' highpass filter in the
playback path of TAS2764.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/tas2764.c | 10 ++++++++++
 sound/soc/codecs/tas2764.h |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index e99a46fb503f..51b87a936179 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -593,11 +593,21 @@ static int tas2764_codec_probe(struct snd_soc_component *component)
 static DECLARE_TLV_DB_SCALE(tas2764_digital_tlv, 1100, 50, 0);
 static DECLARE_TLV_DB_SCALE(tas2764_playback_volume, -10050, 50, 1);
 
+static const char * const tas2764_hpf_texts[] = {
+	"Disabled", "2 Hz", "50 Hz", "100 Hz", "200 Hz",
+	"400 Hz", "800 Hz"
+};
+
+static SOC_ENUM_SINGLE_DECL(
+	tas2764_hpf_enum, TAS2764_DC_BLK0,
+	TAS2764_DC_BLK0_HPF_FREQ_PB_SHIFT, tas2764_hpf_texts);
+
 static const struct snd_kcontrol_new tas2764_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Volume", TAS2764_DVC, 0,
 		       TAS2764_DVC_MAX, 1, tas2764_playback_volume),
 	SOC_SINGLE_TLV("Amp Gain Volume", TAS2764_CHNL_0, 1, 0x14, 0,
 		       tas2764_digital_tlv),
+	SOC_ENUM("HPF Corner Frequency", tas2764_hpf_enum),
 };
 
 static const struct snd_soc_component_driver soc_component_driver_tas2764 = {
diff --git a/sound/soc/codecs/tas2764.h b/sound/soc/codecs/tas2764.h
index 960b337ed0fc..168af772a898 100644
--- a/sound/soc/codecs/tas2764.h
+++ b/sound/soc/codecs/tas2764.h
@@ -33,6 +33,10 @@
 #define TAS2764_VSENSE_POWER_EN		3
 #define TAS2764_ISENSE_POWER_EN		4
 
+/* DC Blocker Control */
+#define TAS2764_DC_BLK0			TAS2764_REG(0x0, 0x04)
+#define TAS2764_DC_BLK0_HPF_FREQ_PB_SHIFT  0
+
 /* Digital Volume Control */
 #define TAS2764_DVC	TAS2764_REG(0X0, 0x1a)
 #define TAS2764_DVC_MAX	0xc9
-- 
2.33.0

