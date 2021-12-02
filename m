Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86608466677
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348824AbhLBPcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:32:10 -0500
Received: from srv6.fidu.org ([159.69.62.71]:50240 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238168AbhLBPcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:32:08 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 77294C80089;
        Thu,  2 Dec 2021 16:28:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id T43BbA8HVVIw; Thu,  2 Dec 2021 16:28:44 +0100 (CET)
Received: from wsembach-tuxedo.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id 26010C80086;
        Thu,  2 Dec 2021 16:28:44 +0100 (CET)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Fix quirk for TongFang PHxTxX1
Date:   Thu,  2 Dec 2021 16:28:43 +0100
Message-Id: <20211202152843.818617-1-wse@tuxedocomputers.com>
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

While being on it, I also fixed the comment formatting of the quirk.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: <stable@vger.kernel.org>
---
 sound/pci/hda/patch_realtek.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9ce7457533c96..d3a16843c7afd 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6503,22 +6503,25 @@ static void alc287_fixup_legion_15imhg05_speakers(struct hda_codec *codec,
 /* for alc285_fixup_ideapad_s740_coef() */
 #include "ideapad_s740_helper.c"
 
+static const struct coef_fw alc256_fixup_tongfang_reset_persistent_settings_coefs[] = {
+	WRITE_COEF(0x10, 0x0020), WRITE_COEF(0x24, 0x0000), WRITE_COEF(0x26, 0x0000),
+	WRITE_COEF(0x29, 0x3000), WRITE_COEF(0x37, 0xfe05), WRITE_COEF(0x45, 0x5089),
+	{}
+};
+
 static void alc256_fixup_tongfang_reset_persistent_settings(struct hda_codec *codec,
 							    const struct hda_fixup *fix,
 							    int action)
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
+	alc_process_coef_fw(codec, alc256_fixup_tongfang_reset_persistent_settings_coefs);
 }
 
 static const struct coef_fw alc233_fixup_no_audio_jack_coefs[] = {
-- 
2.25.1

