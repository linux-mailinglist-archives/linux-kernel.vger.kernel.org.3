Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800454668A1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359704AbhLBQxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:53:38 -0500
Received: from srv6.fidu.org ([159.69.62.71]:54438 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347528AbhLBQxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:53:37 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id BC13BC80089;
        Thu,  2 Dec 2021 17:50:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id 6mT-j2k8NAvQ; Thu,  2 Dec 2021 17:50:10 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 60F1AC8006F;
        Thu,  2 Dec 2021 17:50:10 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: hda/realtek: Fix quirk for TongFang PHxTxX1
Date:   Thu,  2 Dec 2021 17:50:10 +0100
Message-Id: <20211202165010.876431-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the SND_PCI_QUIRK(...) of the TongFang PHxTxX1 barebone. This
fixes the issue of sound not working after s3 suspend.

When waking up from s3 suspend the Coef 0x10 is set to 0x0220 instead of
0x0020. Setting the value manually makes the sound work again. This patch
does this automatically.

While being on it, I also fixed the comment formatting of the quirk and
shortened variable and function names.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Fixes: dd6dd6e3c791 ("ALSA: hda/realtek: Add quirk for TongFang PHxTxX1")
Cc: <stable@vger.kernel.org>
---
 sound/pci/hda/patch_realtek.c | 40 +++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9ce7457533c96..d361a1260d5a1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6503,22 +6503,26 @@ static void alc287_fixup_legion_15imhg05_speakers(struct hda_codec *codec,
 /* for alc285_fixup_ideapad_s740_coef() */
 #include "ideapad_s740_helper.c"
 
-static void alc256_fixup_tongfang_reset_persistent_settings(struct hda_codec *codec,
-							    const struct hda_fixup *fix,
-							    int action)
+static const struct coef_fw alc256_fixup_set_coef_defaults_coefs[] = {
+	WRITE_COEF(0x10, 0x0020), WRITE_COEF(0x24, 0x0000),
+	WRITE_COEF(0x26, 0x0000), WRITE_COEF(0x29, 0x3000),
+	WRITE_COEF(0x37, 0xfe05), WRITE_COEF(0x45, 0x5089),
+	{}
+};
+
+static void alc256_fixup_set_coef_defaults(struct hda_codec *codec,
+					   const struct hda_fixup *fix,
+					   int action)
 {
 	/*
-	* A certain other OS sets these coeffs to different values. On at least one TongFang
-	* barebone these settings might survive even a cold reboot. So to restore a clean slate the
-	* values are explicitly reset to default here. Without this, the external microphone is
-	* always in a plugged-in state, while the internal microphone is always in an unplugged
-	* state, breaking the ability to use the internal microphone.
-	*/
-	alc_write_coef_idx(codec, 0x24, 0x0000);
-	alc_write_coef_idx(codec, 0x26, 0x0000);
-	alc_write_coef_idx(codec, 0x29, 0x3000);
-	alc_write_coef_idx(codec, 0x37, 0xfe05);
-	alc_write_coef_idx(codec, 0x45, 0x5089);
+	 * A certain other OS sets these coeffs to different values. On at least
+	 * one TongFang barebone these settings might survive even a cold
+	 * reboot. So to restore a clean slate the values are explicitly reset
+	 * to default here. Without this, the external microphone is always in a
+	 * plugged-in state, while the internal microphone is always in an
+	 * unplugged state, breaking the ability to use the internal microphone.
+	 */
+	alc_process_coef_fw(codec, alc256_fixup_set_coef_defaults_coefs);
 }
 
 static const struct coef_fw alc233_fixup_no_audio_jack_coefs[] = {
@@ -6759,7 +6763,7 @@ enum {
 	ALC287_FIXUP_LEGION_15IMHG05_AUTOMUTE,
 	ALC287_FIXUP_YOGA7_14ITL_SPEAKERS,
 	ALC287_FIXUP_13S_GEN2_SPEAKERS,
-	ALC256_FIXUP_TONGFANG_RESET_PERSISTENT_SETTINGS,
+	ALC256_FIXUP_SET_COEF_DEFAULTS,
 	ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 	ALC233_FIXUP_NO_AUDIO_JACK,
 };
@@ -8465,9 +8469,9 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE,
 	},
-	[ALC256_FIXUP_TONGFANG_RESET_PERSISTENT_SETTINGS] = {
+	[ALC256_FIXUP_SET_COEF_DEFAULTS] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = alc256_fixup_tongfang_reset_persistent_settings,
+		.v.func = alc256_fixup_set_coef_defaults,
 	},
 	[ALC245_FIXUP_HP_GPIO_LED] = {
 		.type = HDA_FIXUP_FUNC,
@@ -8929,7 +8933,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
 	SND_PCI_QUIRK(0x1c06, 0x2013, "Lemote A1802", ALC269_FIXUP_LEMOTE_A1802),
 	SND_PCI_QUIRK(0x1c06, 0x2015, "Lemote A190X", ALC269_FIXUP_LEMOTE_A190X),
-	SND_PCI_QUIRK(0x1d05, 0x1132, "TongFang PHxTxX1", ALC256_FIXUP_TONGFANG_RESET_PERSISTENT_SETTINGS),
+	SND_PCI_QUIRK(0x1d05, 0x1132, "TongFang PHxTxX1", ALC256_FIXUP_SET_COEF_DEFAULTS),
 	SND_PCI_QUIRK(0x1d72, 0x1602, "RedmiBook", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1701, "XiaomiNotebook Pro", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
-- 
2.25.1

