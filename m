Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D74572E30
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbiGMGd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiGMGdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:33:54 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E53B31DC8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:33:48 -0700 (PDT)
X-QQ-mid: bizesmtp78t1657694019td8n9a41
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 13 Jul 2022 14:33:33 +0800 (CST)
X-QQ-SSF: 01400000002000G0T000B00A0000000
X-QQ-FEAT: UJd4nZbM1CcbWDiDvZVuAeNKZ7bGg0B+n4f0wn07NL2C/jEB4OOopWmu3Seqb
        ftMldvW00rffAuBGrbia6pDbhkPrwqkcbr1DSdl259b8Cd5id0VV6IiVkznXoWtHGgfBhqz
        R1+rvvs3cYyMwtVcxy9o59q35h1p5/8pojDzJkb+AjTm0YnPjuAiKGIGHcd1ZVcP1CqrULg
        DPY46ZbBhlRs7aHa3Td6lLbIevSiTSbDI32TQurgg+QeZbgyhpLIH3+kmhgIGqhcStC4rep
        /sWhZrK6afXr+/pee+cuYwui8JPD66S5aPgozP0wsMDx14mLcYXGcughcC05/IIDlPdvoww
        ht04ERtSCelSwpWPccu4luz53YYN8vk0AUqsikeCD3pl2VuQz9zieS2M19Ke2WWB3pRfBQL
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com, tcrawford@system76.com,
        wse@tuxedocomputers.com, kai.heng.feng@canonical.com,
        tanureal@opensource.cirrus.com, cam@neo-zeon.de,
        kailang@realtek.com, sbinding@opensource.cirrus.com,
        andy.chi@canonical.com, yong.wu@mediatek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] ALSA: hda/realtek - Fix headset mic problem for a HP machine with alc221
Date:   Wed, 13 Jul 2022 14:33:32 +0800
Message-Id: <20220713063332.30095-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign8
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a HP 288 Pro G2 MT (X9W02AV), the front mic could not be detected.
In order to get it working, the pin configuration needs to be set
correctly, and the ALC221_FIXUP_HP_288PRO_MIC_NO_PRESENCE fixup needs
to be applied.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/pci/hda/patch_realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 34139c26795f..91cd58849ee8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6901,6 +6901,7 @@ enum {
 	ALC298_FIXUP_LENOVO_SPK_VOLUME,
 	ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER,
 	ALC269_FIXUP_ATIV_BOOK_8,
+	ALC221_FIXUP_HP_288PRO_MIC_NO_PRESENCE,
 	ALC221_FIXUP_HP_MIC_NO_PRESENCE,
 	ALC256_FIXUP_ASUS_HEADSET_MODE,
 	ALC256_FIXUP_ASUS_MIC,
@@ -7837,6 +7838,16 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_NO_SHUTUP
 	},
+	[ALC221_FIXUP_HP_288PRO_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{ 0x1a, 0x01813030 }, /* use as headphone mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MODE
+	},
 	[ALC221_FIXUP_HP_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -9012,6 +9023,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x2335, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2336, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2337, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
+	SND_PCI_QUIRK(0x103c, 0x2b5e, "HP 288 Pro G2 MT", ALC221_FIXUP_HP_288PRO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x802e, "HP Z240 SFF", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x802f, "HP Z240", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x8077, "HP", ALC256_FIXUP_HP_HEADSET_MIC),
-- 
2.20.1



