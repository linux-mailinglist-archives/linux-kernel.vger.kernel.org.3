Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068BF4D479B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 14:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242260AbiCJNEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 08:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiCJNE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:04:27 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279E0C791D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 05:03:23 -0800 (PST)
X-QQ-mid: bizesmtp78t1646917384tdsqalkf
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 10 Mar 2022 21:03:03 +0800 (CST)
X-QQ-SSF: 01400000002000B0C000B00A0000000
X-QQ-FEAT: hAQ2xUxVESwZEQadtxikZbscZLrGOFgmNn+CeTtX4AR5qtfkmOVoFOHtsHJad
        G3G4uvIAGBdITa72ZM2D/poSJOHwAy34zaXbnYquS5owIxyXuhOkenVy/NNKnVOQY9LEHdr
        A47rhkY13bprr5ZopJn/Qs0h/sW6tGH8FhY6jYIRavc+YVEWqCn3M23PDLTqE6YoI4HlR6D
        p3XoavG5oiFwI6BMHp0fcG9T2kEXatWgBOrisD/1sfUz5NSO2tU6561qBlixpsY087HuOEI
        q/uLWO1zBM0js8+I2mDODwA9C+H6Z6VRoxwRRoYjGF68Yq14+lMOJG+LbQIJPTA8Xa204AG
        sxaWAL0
X-QQ-GoodBg: 2
From:   huangwenhui <huangwenhuia@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     jeremy.szu@canonical.com, hui.wang@canonical.com,
        wse@tuxedocomputers.com, cam@neo-zeon.de, kailang@realtek.com,
        tanureal@opensource.cirrus.com, sami@loone.fi,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        huangwenhui <huangwenhuia@uniontech.com>
Subject: [PATCH] ALSA: hda/realtek - Fix headset mic problem for a HP machine with alc671
Date:   Thu, 10 Mar 2022 21:03:01 +0800
Message-Id: <20220310130301.22827-1-huangwenhuia@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a HP 288 Pro G8, the front Mic could not be detected.

Signed-off-by: huangwenhui <huangwenhuia@uniontech.com>
---
 sound/pci/hda/patch_realtek.c | 37 +++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3a42457984e9..bcd56cdc07af 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10519,6 +10519,37 @@ static void alc671_fixup_hp_headset_mic2(struct hda_codec *codec,
 	}
 }
 
+static void alc671_fixup_hp288_headset_mic2(struct hda_codec *codec,
+					     const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
+
+	static const struct hda_pintbl pincfgs[] = {
+		{ 0x19, 0x02a11040 }, /* use as headset mic, with its own jack detect */
+		{ 0x1b, 0x0181304f },
+		{ }
+	};
+
+	if (!hp_pin)
+		hp_pin = 0x21;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		spec->gen.mixer_nid = 0;
+		spec->parse_flags |= HDA_PINCFG_HEADSET_MIC;
+		snd_hda_apply_pincfgs(codec, pincfgs);
+		break;
+	case HDA_FIXUP_ACT_INIT:
+		alc_write_coef_idx(codec, 0x19, 0xa054);
+		msleep(80);
+		snd_hda_codec_write(codec, hp_pin, 0,
+			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+		msleep(100);
+		break;
+	}
+}
+
 static void alc897_hp_automute_hook(struct hda_codec *codec,
 					 struct hda_jack_callback *jack)
 {
@@ -10615,6 +10646,7 @@ enum {
 	ALC669_FIXUP_ACER_ASPIRE_ETHOS,
 	ALC669_FIXUP_ACER_ASPIRE_ETHOS_HEADSET,
 	ALC671_FIXUP_HP_HEADSET_MIC2,
+	ALC671_FIXUP_HP288_HEADSET_MIC2,
 	ALC662_FIXUP_ACER_X2660G_HEADSET_MODE,
 	ALC662_FIXUP_ACER_NITRO_HEADSET_MODE,
 	ALC668_FIXUP_ASUS_NO_HEADSET_MIC,
@@ -10986,6 +11018,10 @@ static const struct hda_fixup alc662_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc671_fixup_hp_headset_mic2,
 	},
+	[ALC671_FIXUP_HP288_HEADSET_MIC2] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc671_fixup_hp288_headset_mic2,
+	},
 	[ALC662_FIXUP_ACER_X2660G_HEADSET_MODE] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -11067,6 +11103,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x069f, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
 	SND_PCI_QUIRK(0x103c, 0x873e, "HP", ALC671_FIXUP_HP_HEADSET_MIC2),
+	SND_PCI_QUIRK(0x103c, 0x885f, "HP 288 Pro G8", ALC671_FIXUP_HP288_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x1043, 0x1080, "Asus UX501VW", ALC668_FIXUP_HEADSET_MODE),
 	SND_PCI_QUIRK(0x1043, 0x11cd, "Asus N550", ALC662_FIXUP_ASUS_Nx50),
 	SND_PCI_QUIRK(0x1043, 0x129d, "Asus N750", ALC662_FIXUP_ASUS_Nx50),
-- 
2.20.1



