Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BD358A77E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240330AbiHEHvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbiHEHvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:51:11 -0400
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B52010FFE
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 00:51:07 -0700 (PDT)
X-QQ-mid: bizesmtp77t1659685542t4v7n1qq
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 05 Aug 2022 15:45:35 +0800 (CST)
X-QQ-SSF: 01400000002000G0T000B00A0000000
X-QQ-FEAT: uGhnJwy6xZL//SSZC3HXd/LF7Y+7O4moIWupnV6N5uQNk3UE1T8Ttyb6tSIbA
        J+ewUm1c5SOaXZxL+/Ue2QUIIJSBS7/p7BIr0E1nquVgyQ4v/bgPPzcq0IkF3GMARxp1CBd
        4srJOxvnadce8LximV4oOk9vhukNgDTU/CItX08Yqfyu0GvayvQx9xWz/zJn9qWrcfg701h
        G0Yb0YkvwL2xtIT0BjNq9qllZbUtD0UwoO319A9XozhIRPZPhKmo10XDjWF127ZLCrokSxt
        Qfz/Flok4eAeSjt9rkgFhKO2pcC9nLi30JmYg4/m3S39qH30u9FrmWp4pvoHUJ6qa37pWvC
        /NH+qCTboKcZ0C8IhAyXHtHzJ09azuEQsTAF5jpnA4Z/7YDXzDGUjVvYnkclYpsMBy5U76X
        +knTQluTscY=
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     tcrawford@system76.com, wse@tuxedocomputers.com,
        kai.heng.feng@canonical.com, tanureal@opensource.cirrus.com,
        cam@neo-zeon.de, kailang@realtek.com,
        sbinding@opensource.cirrus.com, andy.chi@canonical.com,
        yong.wu@mediatek.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH v2] ALSA: hda/realtek: Add quirk for another Asus K42JZ model
Date:   Fri,  5 Aug 2022 15:45:34 +0800
Message-Id: <20220805074534.20003-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
+	},
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

