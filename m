Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F7048DF5C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiAMVDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiAMVDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:03:52 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216EDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 13:03:52 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o12so7228429lfu.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 13:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-disposition;
        bh=tGX52jpKcvhFH/6brEyGmgi4fo82MK8VJ055FYumYks=;
        b=BiCDKASXPZBtC1iofv0BUMoC2DJJnKaHN1XpKxglNscDIjTE/BT/THocVVnQ7kbqBi
         Mzkwhz+rPXygx7lku8MPXYm11m25daNyn6Je6Ag0/gr2X6+z5PUXksxCyjVNsQsQ6tKO
         ciSLwSJr34dh9jWc1vUo0DI1DpgMI5uLwkJPVNlrcxhRWWxLqMaghjnlBW1Kz/TQWcC0
         aIAtwO47Wj/Tk3zXgbYkA2nuP4T8epqw8sCIaqksM1wRO9DyA8L4v3HdDVsYjzpS2qd3
         HFHhkiGjr+OHHqqkVJzqE4cTg0oo3STwuAOLfMc26tUXw/Pea1qUFQ5JCfVAykKc+oxB
         cR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version:content-disposition;
        bh=tGX52jpKcvhFH/6brEyGmgi4fo82MK8VJ055FYumYks=;
        b=WG82V1/Xb8bTllATPNq6pLD7s5MSuLxzNQ+8F9PTgIw39KFfvCGtE3b9saqx/uArrk
         9C5QAekc7EoC9paWOwHJi7CY3Ym6TYNHkMlFcWsKMUh9zhVwBH1BhQfsHdRvmAY/r4k3
         XL2UJvSABRAthe4yGlwSMV1gdIzncZG8/nKp1VRcOxAiCymvCY672RG92zjgbg/NPRiH
         1dURfidzKoXt/Av36AsyCiV8utyAs6DK0BTcqPtFP4lKinGNSh6QPu66jsF6wmXWG+8H
         pBtNruampAyGRn29zuIt48NUfZZ/gznkPLgNXUAGiHoLUrigNbxQwJ6zHASrt/tT7Amd
         ka3w==
X-Gm-Message-State: AOAM533LmdZSuBImOfjr43ixAdPXBHjhvN8tGQ9/XDaMRsZ71ld0Sc7P
        z9PFGcWkofit2MDX19OIjvo=
X-Google-Smtp-Source: ABdhPJwkWM114QNfLjFQzUCqwBMbRjR32QYRDP2Wdz4P+zKOumDAKoKrj6k1plTk8R9kbaBHpkSWBQ==
X-Received: by 2002:a2e:9209:: with SMTP id k9mr3796207ljg.165.1642107830507;
        Thu, 13 Jan 2022 13:03:50 -0800 (PST)
Received: from localhost.localdomain (ntd06459.static.corbina.ru. [95.31.14.149])
        by smtp.gmail.com with ESMTPSA id u10sm377489ljh.119.2022.01.13.13.03.49
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 13 Jan 2022 13:03:49 -0800 (PST)
Date:   Fri, 14 Jan 2022 00:09:30 +0300
From:   Alexander Sergeyev <sergeev917@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Hui Wang <hui.wang@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>, Sami Loone <sami@loone.fi>,
        Elia Devito <eliadevito@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: fix speakers and micmute on HP 855 G8
Message-ID: <20220113210930.dtryx4ifjsmb33lz@localhost.localdomain>
User-Agent: mtt
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Changes are tested on v5.16. Speakers and headphones are consistenly
working, as well as mute/micmute LEDs and the internal microphone.

Signed-off-by: Alexander Sergeyev <sergeev917@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 28255e752c4a..b809de2b9759 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6784,6 +6784,7 @@ enum {
 	ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 	ALC233_FIXUP_NO_AUDIO_JACK,
 	ALC256_FIXUP_MIC_NO_PRESENCE_AND_RESUME,
+	ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -8514,6 +8515,16 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
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
@@ -8727,6 +8738,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8870, "HP ZBook Fury 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8873, "HP ZBook Studio 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x888d, "HP ZBook Power 15.6 inch G8 Mobile Workstation PC", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8895, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8896, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8898, "HP EliteBook 845 G8 Notebook PC", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x103c, 0x88d0, "HP Pavilion 15-eh1xxx (mainboard 88D0)", ALC287_FIXUP_HP_GPIO_LED),
-- 
2.34.1

