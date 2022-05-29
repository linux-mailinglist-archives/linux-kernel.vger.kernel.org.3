Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF2F5372CA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 00:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiE2WgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 18:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiE2Wf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 18:35:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770C650B2E
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 15:35:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b8so3432078edf.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 15:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=28grDNGVVwgvkgCPe3HFvEYkJipC2Cb3fnAVX4fq0Lg=;
        b=J5pOk7YAN5RiRnaTEd5KNJyjKchIaoV/9ff0ljMqAgtajGMDjG8KcERrFloK1EIMkR
         SyIl5qdg/OzIYTqNk/DmY3FDbsJh+pAUJu2h7kHYD2qMC17GDJkAMIzq+MuB7ACiRJdy
         KYUwNGYiXTLtVsT5NBGsJdqE4fUMIR19VQOn3XrZ8N0hT9V5gzA4ekE4rzsvJVWsRORy
         KqVhhqLLCLxlKBPf8xHkt5J/ya+Vr24XCrNHnJuaDLMF9QsPeMGrihSe990IOanm5c1Y
         KPdFo/Wer5nAb1eDbCwilyzjUljbMNwdiVIj0L5+FcVv3OECj4LPkBUYZPFoqsXtGycA
         IfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=28grDNGVVwgvkgCPe3HFvEYkJipC2Cb3fnAVX4fq0Lg=;
        b=shRHgrv8XgToEEQcLcDeD585GtTT3IoaqUHCxF2VcjX/RND6h9T9yKDc58cnQMKmEl
         k2c6RS9RcWkcSsxE8j5TJe89Ow5buCk3adsdQmoND71l8lkooP5rNlYoN862sI0fbY2r
         9PHUJ+BWpM1gwaFMz4LxlvmIbv0iQiDwlSORgbBphAFig708YXw5KwI3+nYixLMrzIYP
         Wab8WRHtpu+DXkR7MuTxcQGmFQuTi//D90eSlrivKdjO8K4iudS8XQCHe6sfZoVS094L
         sYkwJnpCcdSaNfMFDZkihvfTDMIfR5jv5plZcYeqSxFBlmcQWqYHMOd+Ph8/lscCRFvD
         JrbA==
X-Gm-Message-State: AOAM531+r4w7LuwxYE1CSMwR9egPTPYZDG/yNfGmEpqCegMYO4Ss1El9
        5n10dytwUTWTRa1KD3p/IWw=
X-Google-Smtp-Source: ABdhPJy36gFtvxZXqd/ef4i7J/Vur7da2Ugd78lWMuv8NEHUzvMn6fT0GPLCrZE9jkhNYCiNYTZePA==
X-Received: by 2002:a05:6402:a42:b0:42b:c5e9:1495 with SMTP id bt2-20020a0564020a4200b0042bc5e91495mr25576734edb.323.1653863756112;
        Sun, 29 May 2022 15:35:56 -0700 (PDT)
Received: from marios-pc.home.mlevogiannis.gr (194.219.107.43.dsl.dyn.forthnet.gr. [194.219.107.43])
        by smtp.gmail.com with ESMTPSA id u28-20020a50c05c000000b0042dc882c823sm697456edd.70.2022.05.29.15.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 15:35:55 -0700 (PDT)
From:   Marios Levogiannis <marios.levogiannis@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Marios Levogiannis <marios.levogiannis@gmail.com>
Subject: [PATCH] ALSA: hda/realtek - Fix microphone noise on ASUS TUF B550M-PLUS
Date:   Mon, 30 May 2022 01:35:24 +0300
Message-Id: <20220529223524.9057-1-marios.levogiannis@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set microphone pins 0x18 (rear) and 0x19 (front) to VREF_50 to fix the
microphone noise on ASUS TUF B550M-PLUS which uses the ALCS1200A codec.
The initial value was VREF_80.

The same issue is also present on Windows using both the default Windows
driver and all tested Realtek drivers before version 6.0.9049.1. Comparing
Realtek driver 6.0.9049.1 (the first one without the microphone noise) to
Realtek driver 6.0.9047.1 (the last one with the microphone noise)
revealed that the fix is the result of setting pins 0x18 and 0x19 to
VREF_50.

This fix may also work for other boards that have been reported to have
the same microphone issue and use the ALC1150 and ALCS1200A codecs, since
these codecs are similar and the fix in the Realtek driver on Windows is
common for both. However, it is currently enabled only for ASUS TUF
B550M-PLUS as this is the only board that could be tested.
---
 sound/pci/hda/patch_realtek.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 89d610afa..f3ad454b3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1981,6 +1981,7 @@ enum {
 	ALC1220_FIXUP_CLEVO_PB51ED_PINS,
 	ALC887_FIXUP_ASUS_AUDIO,
 	ALC887_FIXUP_ASUS_HMIC,
+	ALCS1200A_FIXUP_MIC_VREF,
 };
 
 static void alc889_fixup_coef(struct hda_codec *codec,
@@ -2526,6 +2527,14 @@ static const struct hda_fixup alc882_fixups[] = {
 		.chained = true,
 		.chain_id = ALC887_FIXUP_ASUS_AUDIO,
 	},
+	[ALCS1200A_FIXUP_MIC_VREF] = {
+		.type = HDA_FIXUP_PINCTLS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x18, PIN_VREF50 }, /* rear mic */
+			{ 0x19, PIN_VREF50 }, /* front mic */
+			{}
+		}
+	},
 };
 
 static const struct snd_pci_quirk alc882_fixup_tbl[] = {
@@ -2563,6 +2572,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x835f, "Asus Eee 1601", ALC888_FIXUP_EEE1601),
 	SND_PCI_QUIRK(0x1043, 0x84bc, "ASUS ET2700", ALC887_FIXUP_ASUS_BASS),
 	SND_PCI_QUIRK(0x1043, 0x8691, "ASUS ROG Ranger VIII", ALC882_FIXUP_GPIO3),
+	SND_PCI_QUIRK(0x1043, 0x8797, "ASUS TUF B550M-PLUS", ALCS1200A_FIXUP_MIC_VREF),
 	SND_PCI_QUIRK(0x104d, 0x9043, "Sony Vaio VGC-LN51JGB", ALC882_FIXUP_NO_PRIMARY_HP),
 	SND_PCI_QUIRK(0x104d, 0x9044, "Sony VAIO AiO", ALC882_FIXUP_NO_PRIMARY_HP),
 	SND_PCI_QUIRK(0x104d, 0x9047, "Sony Vaio TT", ALC889_FIXUP_VAIO_TT),
-- 
2.36.1

