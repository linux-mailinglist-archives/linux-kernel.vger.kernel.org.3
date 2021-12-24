Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B4E47EAF6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 04:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351159AbhLXDue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 22:50:34 -0500
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:54638
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245534AbhLXDud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 22:50:33 -0500
Received: from HP-EliteBook-840-G7.. (1-171-103-242.dynamic-ip.hinet.net [1.171.103.242])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B31F23F11C;
        Fri, 24 Dec 2021 03:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640317825;
        bh=uGReKCT7KlBUxGPqrreDeVFqMMWzWBCJayMZ1lWFkkc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=TnA1lI9V1UT/2e+A1w55ZT12CB/FA2B1uhsmB3vFts0OjAtfnTXSRnywjRFlw12wb
         55+hpIpUucdYapnJuQpXuTHjXaKkU6ihZyFzlVLw9UNZV7Jcu8jog3TyDqCI++HvCK
         4EtFEpr4MhUk4w3UpP7lZCbrb/M6WexTPpLrvdzoA2SgbS4BcHe49uP4ph3erAofVG
         4m3jZtuG/C6d9SZEO/VKbNC4tDuNHN2gprdGkB6PZ0hR3aFaAXSFVV6mbtCeWMbCB9
         Rc//ap7J5lnss4ziAmc7dKEy6zaZsni3z4Wtv4jjuQ6JlWOKUUNVvaw5ebQ4kGdCKM
         aHA2VuW8q8Ffw==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Hui Wang <hui.wang@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>, Sami Loone <sami@loone.fi>,
        Elia Devito <eliadevito@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Use ALC285_FIXUP_HP_GPIO_LED on another HP laptop
Date:   Fri, 24 Dec 2021 11:50:13 +0800
Message-Id: <20211224035015.310068-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio mute and mic mute LEDs don't work, so use the quirk to make
them work.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 28255e752c4a1..344741869281f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8730,6 +8730,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8896, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8898, "HP EliteBook 845 G8 Notebook PC", ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x103c, 0x88d0, "HP Pavilion 15-eh1xxx (mainboard 88D0)", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x89c3, "HP", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x89ca, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
-- 
2.33.1

