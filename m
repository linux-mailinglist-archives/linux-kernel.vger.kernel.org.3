Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C04B48EE9D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243563AbiANQpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbiANQpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:45:11 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F5AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:45:11 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id br17so32062134lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Ewl4Z1YzYAlBkYJHiGEEyV0oXVxsjSkcQKpSsXudmY=;
        b=K8NvBUy53fi8ana5vroczUiRdXFyT9R9/wAmRZbCSLWgnGiBWEUE3075TJh3ghWG5+
         fjSl0jcQiC0R/5QGoXS6RFG3daJ+Kx7EP7RFy69O+5tAoQMUc6GTcZ1XEvBEidwxzVFD
         s2SDusPeQjW4xPLzvB0Br+OO95QyMO0JESSCqVwodvlIokcT07ZGw7GXe/trOQcNCp6I
         hzRAbVPtpRDY6qmtGCys2wgFKO/BaDqXhG1Bs5HWHyu/SzB6mU7M7z6tV99RWipo76og
         TCkWyudx5nKk9zmncKJ+YL30yF9kAZlMGS98JfjixvvgRWcIJ8H179AUVw3YEk+biUMq
         LkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=+Ewl4Z1YzYAlBkYJHiGEEyV0oXVxsjSkcQKpSsXudmY=;
        b=hl/75EKJctmbVfWk0IJ/y9x2/KKleYiByfP1Zr1j8WET/jnGTtUoNucRiRG8NGNJ57
         NSRR/KeBp3XNXH/9jGFwKaw9lDj/FlAxNT2r4KaSqSrPUNfwPPiqmX3diXAKeN6WTtxH
         VM7SQoxMXuf4NYkD2ZqaTl70lmHEUcA4jFTBAj43lK7pSHTZAzxjvktdfBzwCtDUc2f7
         RI/zpu/aTBpF47FO1xJMLH7XfOSBKPCpdyp/Czo2jLRuZ9KI6po0T35viij8928CfToN
         CppPBtQ311RYsRh0UkSO5fETG4NgkgAnbN23zecXymmaBFbc2EI1Rhb3m0Nseex3Wi5t
         pvMQ==
X-Gm-Message-State: AOAM531vF8n9tS4vAUdFIhvJxTw9OLzgFzZpSwvik/8PtFxU8tyF+8ru
        +80DufFjeiHRV6tSRoyoQ0w=
X-Google-Smtp-Source: ABdhPJy52fzrZR4GVtyxgjM2bL1dY3ywuTuj1Hr/avoeO6sl7A+zqJ/FvElf9ZvHWvkt6QdLDbuDsQ==
X-Received: by 2002:ac2:4d4c:: with SMTP id 12mr7774929lfp.554.1642178709529;
        Fri, 14 Jan 2022 08:45:09 -0800 (PST)
Received: from localhost.localdomain (ntd06459.static.corbina.ru. [95.31.14.149])
        by smtp.gmail.com with ESMTPSA id d6sm631744lfn.149.2022.01.14.08.45.08
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 14 Jan 2022 08:45:09 -0800 (PST)
Date:   Fri, 14 Jan 2022 19:50:50 +0300
From:   Alexander Sergeyev <sergeev917@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Hui Wang <hui.wang@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>, Sami Loone <sami@loone.fi>,
        Elia Devito <eliadevito@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] ALSA: hda/realtek: fix speakers and micmute on HP 855
 G8
Message-ID: <20220114165050.ouw2nknuspclynro@localhost.localdomain>
User-Agent: mtt
References: <20220114164904.lgj7yimbei6fmloe@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114164904.lgj7yimbei6fmloe@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several PCI ids associated with HP EliteBook 855 G8 Notebook
PC. Commit 0e68c4b11f1e6 ("ALSA: hda/realtek: fix mute/micmute LEDs for
HP 855 G8") covers 0x103c:0x8896, while this commit covers 0x103c:0x8895
which needs some additional work on top of the quirk from 0e68c4b11f1e6.

Note that the device can boot up with working speakers and micmute LED
without this patch, but the success rate would be quite low (order of
16 working boots across 709 boots) at least for the built-in drivers
scenario. This also means that there are some timing issues during early
boot and this patch is a workaround.

With this patch applied speakers and headphones are consistenly working,
as well as mute/micmute LEDs and the internal microphone.

Signed-off-by: Alexander Sergeyev <sergeev917@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index eef973661b0a..668274e52674 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6948,6 +6948,7 @@ enum {
 	ALC285_FIXUP_LEGION_Y9000X_AUTOMUTE,
 	ALC287_FIXUP_LEGION_16ACHG6,
 	ALC287_FIXUP_CS35L41_I2C_2,
+	ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -8698,6 +8699,16 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cs35l41_fixup_i2c_two,
 	},
+	[ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			 { 0x20, AC_VERB_SET_COEF_INDEX, 0x19 },
+			 { 0x20, AC_VERB_SET_PROC_COEF, 0x8e11 },
+			 { }
+		},
+		.chained = true,
+		.chain_id = ALC285_FIXUP_HP_MUTE_LED,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -8911,6 +8922,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8870, "HP ZBook Fury 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8873, "HP ZBook Studio 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x888d, "HP ZBook Power 15.6 inch G8 Mobile Workstation PC", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8895, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8896, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8898, "HP EliteBook 845 G8 Notebook PC", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x103c, 0x88d0, "HP Pavilion 15-eh1xxx (mainboard 88D0)", ALC287_FIXUP_HP_GPIO_LED),
-- 
2.34.1

