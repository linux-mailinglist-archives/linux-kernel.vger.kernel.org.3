Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4D95375A1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbiE3HmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbiE3HmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:42:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C15186D7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:42:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id n28so3556580edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hfKG4YWK0/wF8JKckFHhogrN1Uspikw4VVSzOBOiZQs=;
        b=nPGSDOs/5FdLND1ypnker0BsT+k7E7bv6TdT4ZdNBPkH7MsnjruPykKv0SZXIF/jNv
         kx6YmAJDmpO4Nh8wbwsc1jKjSqisZYjKdSX3bL1TBqct6ziFgzEP1NfGPNcRtNKl5Lts
         xcLeui3Jl2Iq+mLKp+WbGt2Y6Iriz/NbdrJrANZzv4fX41uAnP0hvZadOrgZSJBNt2WN
         qqC3dmAy4vuC24MQDq5hZ+SyS9d9enWpyVX1iQkd31v4QaBTXGrz9y8x0hbrT8O9RwQG
         yxC3uj+ytcd1VVQBVVlAmL81HnYbjEI/qg4Gng4MchGjaxHOhkXi6312xBJGWoRGGbHN
         GYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hfKG4YWK0/wF8JKckFHhogrN1Uspikw4VVSzOBOiZQs=;
        b=nhS2tKDb9PGOb5KncFYfSHEgtW83We2kzxO+MRCzyaod9H0V824kiqAWdAnEB6FmdL
         k9ALun97FsZ6mw00xH6fntjuqZsVY2HjCY2FrBFPp+pFczTbsPwt7PmBOmG8G35Tgkbg
         OvzwIx9Q54eXR8P3tcf41E0Kt7nc6zG0sLmZ1322JCPWdkynnXSj9O9C5KE2pln4QZpQ
         f1z3bJK8DHHJYVtkxb/rOkpPLubPDYio6rhGn6ZD1niCQgvToZ9gr7qtDssSVC5DKjTy
         5ZnAvoXc32MF85BuboLpBsvnaWgZhUcUyb1NRcV8Ut8WK82a62ri3+sPHOAn/m7AVevR
         KqVw==
X-Gm-Message-State: AOAM531BfKGfkf94yvaSFKCVlUuyg5+F+fd0L/WJOrqEM4cJYS/GLtNZ
        MEZsZSUusW5wumM7sIScl4c=
X-Google-Smtp-Source: ABdhPJwqovQExkbkxPWrSxPyXA9KL9bw91tu3ooAFG/n8Qxt/g9ubvu7yewtRPUTtwTrPfTjoLX2mQ==
X-Received: by 2002:aa7:dc09:0:b0:42a:aadd:8e71 with SMTP id b9-20020aa7dc09000000b0042aaadd8e71mr57204773edu.41.1653896537958;
        Mon, 30 May 2022 00:42:17 -0700 (PDT)
Received: from marios-pc.home.mlevogiannis.gr (194.219.107.43.dsl.dyn.forthnet.gr. [194.219.107.43])
        by smtp.gmail.com with ESMTPSA id z1-20020a1709060ac100b006f3ef214de1sm3709693ejf.71.2022.05.30.00.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 00:42:17 -0700 (PDT)
From:   Marios Levogiannis <marios.levogiannis@gmail.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Marios Levogiannis <marios.levogiannis@gmail.com>
Subject: [PATCH] ALSA: hda/realtek - Fix microphone noise on ASUS TUF B550M-PLUS
Date:   Mon, 30 May 2022 10:41:31 +0300
Message-Id: <20220530074131.12258-1-marios.levogiannis@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <87r14by1xi.wl-tiwai@suse.de>
References: <87r14by1xi.wl-tiwai@suse.de>
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

Signed-off-by: Marios Levogiannis <marios.levogiannis@gmail.com>
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

