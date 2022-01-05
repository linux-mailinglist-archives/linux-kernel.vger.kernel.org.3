Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB39484CF8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 04:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbiAED5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 22:57:43 -0500
Received: from m12-14.163.com ([220.181.12.14]:37949 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230284AbiAED5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 22:57:43 -0500
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2022 22:57:42 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6aSfX
        k2y0bbGcy2PXv7xbUnmwxl/WAcJwLMFrxzKbxM=; b=O2sacQg7/Dlxut+KCyh5s
        v42QNzgaLBK0tuz+brTw2H8pDQDt0Esc8utWOxtr2yTx7MMq4CCL6Nze9XcNSjIP
        eBGlssekq7s6K5F2mvBg3W3QSZC32ca2kJIjD2wDvXlM2FL79/+wlLwY+tcfjzvD
        WCZEhQ/o1ZYXmW06RSy8UU=
Received: from localhost.localdomain (unknown [183.194.153.98])
        by smtp10 (Coremail) with SMTP id DsCowAAHQfRWE9VhLd_RGA--.64628S2;
        Wed, 05 Jan 2022 11:41:14 +0800 (CST)
From:   Baole Fang <fbl718@163.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Hui Wang <hui.wang@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>, Sami Loone <sami@loone.fi>,
        Elia Devito <eliadevito@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Baole Fang <fbl718@163.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Legion Y9000X 2020
Date:   Wed,  5 Jan 2022 11:41:01 +0800
Message-Id: <20220105034103.12484-1-fbl718@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAAHQfRWE9VhLd_RGA--.64628S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4xGw4DKw17Kry3ZFy8Grg_yoW5JrW3pF
        4rAwn5WF4kXFnayr43Ar4jgry8Gan3Cr48CFy5Aw17Zan3uFsrGrWFg3yavryDGrWkGrZ8
        Xr1kZas8Wr45Xw7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UzE__UUUUU=
X-Originating-IP: [183.194.153.98]
X-CM-SenderInfo: 5ieoliqy6rljoofrz/1tbiHhp-6VSIy9z6mAAAs7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 25960cafa06e6fcd830e6c792e6a7de68c1e25ed upstream.

Legion Y9000X 2020 has a speaker, but the speaker doesn't work.
This can be fixed by applying alc285_fixup_ideapad_s740_coef
 to fix the speaker's coefficients.
Besides, to support the transition between the speaker and the headphone,
alc287_fixup_legion_15imhg05_speakers needs to be run.

Signed-off-by: Baole Fang <fbl718@163.com>
---
 sound/pci/hda/patch_realtek.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 28255e752c4a..c7232f9be690 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6784,6 +6784,8 @@ enum {
 	ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 	ALC233_FIXUP_NO_AUDIO_JACK,
 	ALC256_FIXUP_MIC_NO_PRESENCE_AND_RESUME,
+	ALC285_FIXUP_LEGION_Y9000X_SPEAKERS,
+	ALC285_FIXUP_LEGION_Y9000X_AUTOMUTE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -8380,6 +8382,18 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF,
 	},
+	[ALC285_FIXUP_LEGION_Y9000X_SPEAKERS] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_ideapad_s740_coef,
+		.chained = true,
+		.chain_id = ALC285_FIXUP_LEGION_Y9000X_AUTOMUTE,
+	},
+	[ALC285_FIXUP_LEGION_Y9000X_AUTOMUTE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_legion_15imhg05_speakers,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
+	},
 	[ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS] = {
 		.type = HDA_FIXUP_VERBS,
 		//.v.verbs = legion_15imhg05_coefs,
@@ -8923,6 +8937,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x31af, "ThinkCentre Station", ALC623_FIXUP_LENOVO_THINKSTATION_P340),
 	SND_PCI_QUIRK(0x17aa, 0x3818, "Lenovo C940", ALC298_FIXUP_LENOVO_SPK_VOLUME),
 	SND_PCI_QUIRK(0x17aa, 0x3827, "Ideapad S740", ALC285_FIXUP_IDEAPAD_S740_COEF),
+	SND_PCI_QUIRK(0x17aa, 0x3824, "Legion Y9000X 2020", ALC285_FIXUP_LEGION_Y9000X_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3843, "Yoga 9i", ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3852, "Lenovo Yoga 7 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
-- 
2.25.1

