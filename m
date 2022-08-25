Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C505A1BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244225AbiHYWBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244152AbiHYWBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:01:44 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F55CB4E8F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:01:43 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E221E5C0112;
        Thu, 25 Aug 2022 18:01:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 25 Aug 2022 18:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1661464902; x=1661551302; bh=5f8892CWhzB/Oa681ruXsO/BK
        kD7Nk+PX7cFrRgrLVc=; b=hk4VJ+YexUBwOHzG4aA16vzBzPvU+wREaGuKhODwa
        7+BG/ynaoOpykU5tSOtwllnZ9wE/BgveCAdU3QXs3TtXMpfiEbAPtVtZ0CSB+pgA
        zTvMto2fVFnrZ5Fb8WUUrP/EITsH1zmV9oYx2jwNq1bvZ9BKLTtInyFsz2X/dWzi
        JuCO33Ml7aJJgPdrOTkriR3FMsh4lo4zBTN6y1syw+XKSZf/YNO7SYOj4tO2n88p
        KGWU3J2DksqHWo4/wUWICRs1TK5FRrvTORkoCUIM9ZkkWSjhb9dZxMYVPClKJAZ0
        Umk19Iobl3khkShXFtXoJ16L8kfPhbcZOsDatxsFb0vlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1661464902; x=1661551302; bh=5f8892CWhzB/Oa681ruXsO/BKkD7Nk+PX7c
        FrRgrLVc=; b=lnk6COYF3alDsMqezini1tHb933FgoAt8nf1R5cG38IIfuAEDPD
        n2frG1KYwwXNgndUiVk8Clpzc262Mqzr7mRI7qtthrXO+rqBatTVOK77oVDxLZVX
        ybeTpqnBTMXou+2v/SVBOZsu2o12H3J0HKc6o4yaNmwYng0KpR8mM1h09vojIEbM
        tzhQ4qMvYVwCPl+LdX9u81GBN0tY1EQbiSU3ejlmzUYLOJmH2bOpsOO+2CVSIHVG
        UGTsVxMz/oCdKCCcTJn1tyjqs4b5jEBCNmF3496HAhsNPi/gn4/DKlWXm9nBvVXG
        klMgNv8TgcgC32S4QMTqI3FdG7aOD1VjSSw==
X-ME-Sender: <xms:RvEHY6pqqDeCHJCSjsUj6B3IWSqUtE-qwyyn4V16jGH7mSkaax7T5A>
    <xme:RvEHY4pCOAu331NblctThs866oTe3LgkJT1yY7xAMWkv29rl1y7QgZszhyWPHg_R9
    bHQh7-_k3neQw3jUb4>
X-ME-Received: <xmr:RvEHY_OoVE2VldNZxdoRHMx2DO0vfhebBnfCSS6pWX8-5kj-c_nma9noyils>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejgedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:RvEHY56tvbtIiyLNUbL1NIu4z9xHzdZ0r4MLN-T55LuiLbvugdj4Yg>
    <xmx:RvEHY56kqqcf_S-1dYMIvLXZsGdHbVw08yMlIdZXx0WnbYkRr-hpqQ>
    <xmx:RvEHY5inHPqtu8k9yG_oKCs8E-EmOx_ZNtuqAXavK1Vc7U0PscalHQ>
    <xmx:RvEHYzloaZDGKlS2dWHqa4GmqfJC60BC1qAGsY0jbIG3JSnwZ08arQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Aug 2022 18:01:38 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     tiwai@suse.com
Cc:     kai.heng.feng@canonical.com, andy.chi@canonical.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 1/2] sound: realtek: Add pincfg for ASUS G533Z
Date:   Fri, 26 Aug 2022 10:01:29 +1200
Message-Id: <20220825220130.331371-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes up the pincfg for ASUS ROG Strix G15 (G533Z) laptop.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 sound/pci/hda/patch_realtek.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fd630d62b5a0..e9cad49ee2a5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5828,7 +5828,7 @@ static void alc_fixup_headset_mode_alc255_no_hp_mic(struct hda_codec *codec,
 		struct alc_spec *spec = codec->spec;
 		spec->parse_flags |= HDA_PINCFG_HEADSET_MIC;
 		alc255_set_default_jack_type(codec);
-	} 
+	}
 	else
 		alc_fixup_headset_mode(codec, fix, action);
 }
@@ -7022,6 +7022,7 @@ enum {
 	ALC294_FIXUP_ASUS_GX502_HP,
 	ALC294_FIXUP_ASUS_GX502_PINS,
 	ALC294_FIXUP_ASUS_GX502_VERBS,
+	ALC285_FIXUP_ASUS_G533Z_PINS,
 	ALC294_FIXUP_ASUS_GU502_HP,
 	ALC294_FIXUP_ASUS_GU502_PINS,
 	ALC294_FIXUP_ASUS_GU502_VERBS,
@@ -8363,6 +8364,17 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc294_fixup_gu502_hp,
 	},
+	[ALC285_FIXUP_ASUS_G533Z_PINS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x14, 0x90170120 },
+			{ 0x19, 0x03A11050 }, /* front HP mic */
+			{ 0x1B, 0x03A11C30 }, /* rear external mic */
+			{ 0x21, 0x03211420 }, /* front HP out */
+			{ }
+		},
+		.chained = false,
+	},
 	[ALC294_FIXUP_ASUS_COEF_1B] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
@@ -9294,6 +9306,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_DUAL_SPK),
 	SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", ALC294_FIXUP_ASUS_DUAL_SPK),
 	SND_PCI_QUIRK(0x1043, 0x1881, "ASUS Zephyrus S/M", ALC294_FIXUP_ASUS_GX502_PINS),
+	SND_PCI_QUIRK(0x1043, 0x1c92, "ASUS ROG Strix G15", ALC285_FIXUP_ASUS_G533Z_PINS),
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x18f1, "Asus FX505DT", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x194e, "ASUS UX563FD", ALC294_FIXUP_ASUS_HPE),
-- 
2.37.2

