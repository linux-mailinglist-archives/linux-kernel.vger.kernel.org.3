Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7947058C404
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbiHHHeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbiHHHef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:34:35 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC511391
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 00:34:28 -0700 (PDT)
X-QQ-mid: bizesmtp73t1659944055tdl8yyno
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 08 Aug 2022 15:34:09 +0800 (CST)
X-QQ-SSF: 01400000002000G0U000B00A0000000
X-QQ-FEAT: 3M0okmaRx3j9ek3mc9H7YxaHgeT7KxPegPx6HQ9LRbj12W87UcJm61TFOtxz5
        55PM7tObXUTp4SjlfvV04eZ9y9spypxUpndWt/0IefueZZ0mJ4C7nM/9/tuFTrwJopemMM0
        eTwHgigbwv2a+IKBLo2Bqd1tsH7zZXzHodpePR8jYotUyYNlBoEAg8BYlUN/ySg/GvyK3Mg
        ovg0t6fdwBwn92m7LHcGdo91CXs7gL+d08j4mUeIS+XIguX1k53lCToFurxh9lEHtfB1ubG
        RCjl2aEbMmZeVrkU8IvS+402ivj49EyCyCiVD5Kex3zECw2h5a253HnpKJIh05lPvxG3ZXt
        lriPUtl125bjRSt+PDhjsIkc9+BcgqjIht2lqzaFPgIgMzOHECKsfNlr6nj6UK/fpZDlWk7
        PQWlS1IEUV0=
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com, bo.liu@senarytech.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] ALSA: hda/conexant: Add quirk for LENOVO 20149 Notebook model
Date:   Mon,  8 Aug 2022 15:34:06 +0800
Message-Id: <20220808073406.19460-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is another LENOVO 20149 (Type1Sku0) Notebook model with
CX20590, the device PCI SSID is 17aa:3977, which headphones are
not responding, that requires the quirk CXT_PINCFG_LENOVO_NOTEBOOK.
Add the corresponding entry to the quirk table.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/pci/hda/patch_conexant.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 83ae21a01bbf..7b1a30a551f6 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -222,6 +222,7 @@ enum {
 	CXT_PINCFG_LEMOTE_A1205,
 	CXT_PINCFG_COMPAQ_CQ60,
 	CXT_FIXUP_STEREO_DMIC,
+	CXT_PINCFG_LENOVO_NOTEBOOK,
 	CXT_FIXUP_INC_MIC_BOOST,
 	CXT_FIXUP_HEADPHONE_MIC_PIN,
 	CXT_FIXUP_HEADPHONE_MIC,
@@ -772,6 +773,14 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_stereo_dmic,
 	},
+	[CXT_PINCFG_LENOVO_NOTEBOOK] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1a, 0x05d71030 },
+			{ }
+		},
+		.chain_id = CXT_FIXUP_STEREO_DMIC,
+	},
 	[CXT_FIXUP_INC_MIC_BOOST] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt5066_increase_mic_boost,
@@ -971,7 +980,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3905, "Lenovo G50-30", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x390b, "Lenovo G50-80", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3975, "Lenovo U300s", CXT_FIXUP_STEREO_DMIC),
-	SND_PCI_QUIRK(0x17aa, 0x3977, "Lenovo IdeaPad U310", CXT_FIXUP_STEREO_DMIC),
+	SND_PCI_QUIRK(0x17aa, 0x3977, "Lenovo IdeaPad U310", CXT_PINCFG_LENOVO_NOTEBOOK),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo G50-70", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x397b, "Lenovo S205", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", CXT_FIXUP_THINKPAD_ACPI),
-- 
2.20.1

