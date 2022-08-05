Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A4758A691
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbiHEHIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbiHEHHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:07:31 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073F974DED
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 00:07:12 -0700 (PDT)
X-QQ-mid: bizesmtp89t1659683019t5llqh8r
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 05 Aug 2022 15:03:33 +0800 (CST)
X-QQ-SSF: 01400000002000G0T000B00A0000000
X-QQ-FEAT: CR3LFp2JE4nvt+CFfh6xyx180K17RHFc6YiAjlUGcQVRQd6OEQSQ+oqEsYYlF
        BzHsAs2Y2sGZMguYibGNtUqXHkEOGrnwcXB0iTL0cRlzFd2BLtt1ciXkFS8yZrj9ETx3v6g
        8SQMTT/n1h+UgtiDnu0+Tj11Fh+pVmie8sLgWtWIqD79AE5nDdzFHzCtSALrIWJX1XaSQ6j
        0rd7kE4uPjhLnSxacTklwDrkpoIw6g5JMSMTHAfdKVk/OLuTzz/KTAsrw3nHXE2QA0b0tiA
        dZi5SpqCwaqU20iWKfLyolYGBqZftUIr+sHaJbIyME+u0LbkBrRmdOl8+ToK6H8sU2y3Muy
        x+29St9cUFt82bMVEQPloywbXe/UoI8HpSo4LN4QCvopB9UF+75LDSwU6MGOhMjELASJ1fT
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     tcrawford@system76.com, wse@tuxedocomputers.com,
        kai.heng.feng@canonical.com, tanureal@opensource.cirrus.com,
        cam@neo-zeon.de, kailang@realtek.com,
        sbinding@opensource.cirrus.com, andy.chi@canonical.com,
        yong.wu@mediatek.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for another Asus K42JZ model
Date:   Fri,  5 Aug 2022 15:03:31 +0800
Message-Id: <20220805070331.13743-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is another Asus K42JZ model with the PCI SSID 1043:1313
that requires the quirk ALC269VB_FIXUP_ASUS_MIC_NO_PRESENCE.
Add the corresponding entry to the quirk table.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/pci/hda/patch_realtek.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 383a814b8539..4461237a3474 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6842,6 +6842,7 @@ enum {
 	ALC269_FIXUP_LIMIT_INT_MIC_BOOST,
 	ALC269VB_FIXUP_ASUS_ZENBOOK,
 	ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A,
+	ALC269VB_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC269_FIXUP_LIMIT_INT_MIC_BOOST_MUTE_LED,
 	ALC269VB_FIXUP_ORDISSIMO_EVE2,
 	ALC283_FIXUP_CHROME_BOOK,
@@ -7427,6 +7428,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269VB_FIXUP_ASUS_ZENBOOK,
 	},
+	[ALC269VB_FIXUP_ASUS_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x18, 0x01a110f0 },  /* use as headset mic */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MIC
+	}
 	[ALC269_FIXUP_LIMIT_INT_MIC_BOOST_MUTE_LED] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_limit_int_mic_boost,
@@ -9124,6 +9134,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x12a0, "ASUS X441UV", ALC233_FIXUP_EAPD_COEF_AND_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x12e0, "ASUS X541SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x12f0, "ASUS X541UV", ALC256_FIXUP_ASUS_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1313, "Asus K42JZ", ALC269VB_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
-- 
2.20.1

