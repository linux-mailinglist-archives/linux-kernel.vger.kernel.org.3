Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F614800B2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 16:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbhL0Ps1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 10:48:27 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42282 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbhL0PnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 10:43:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AD616111D;
        Mon, 27 Dec 2021 15:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470CEC36AE7;
        Mon, 27 Dec 2021 15:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640619790;
        bh=kl6UkQJUTQXxFpnhH68KO0HrFTF2hhF/ZabYQ7dXLnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e/F/XxhFJkx+FrmRl0MTWh+QI9vylBgwMoHaXp7lNn5trNDZm9tCmjD9nUeCBBN6D
         meVXoschTC7UwhFA38lC2ql1Wgcuq0HxvUlVwcrnNI7Q/GU3F58TUIOdqNSP/5qpaD
         pkdn0BX+PBBOtEfkiRrwVhIkFVlHWNLt2B2OmeEg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bradley Scott <bscott@teksavvy.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 070/128] ALSA: hda/realtek: Add new alc285-hp-amp-init model
Date:   Mon, 27 Dec 2021 16:30:45 +0100
Message-Id: <20211227151333.824022963@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211227151331.502501367@linuxfoundation.org>
References: <20211227151331.502501367@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bradley Scott <bscott@teksavvy.com>

commit aa72394667e5cea3547e4c41ddff7ca8c632d764 upstream.

Adds a new "alc285-hp-amp-init" model that can be used to apply the ALC285
HP speaker amplifier initialization fixup to devices that are not already
known by passing "hda_model=alc285-hp-amp-init" to the
snd-sof-intel-hda-common module or "model=alc285-hp-amp-init" to the
snd-hda-intel module, depending on which is being used.

Signed-off-by: Bradley Scott <bscott@teksavvy.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20211213162246.506838-1-bscott@teksavvy.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/sound/hd-audio/models.rst |    2 ++
 sound/pci/hda/patch_realtek.c           |    1 +
 2 files changed, 3 insertions(+)

--- a/Documentation/sound/hd-audio/models.rst
+++ b/Documentation/sound/hd-audio/models.rst
@@ -326,6 +326,8 @@ usi-headset
     Headset support on USI machines
 dual-codecs
     Lenovo laptops with dual codecs
+alc285-hp-amp-init
+    HP laptops which require speaker amplifier initialization (ALC285)
 
 ALC680
 ======
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9124,6 +9124,7 @@ static const struct hda_model_fixup alc2
 	{.id = ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP, .name = "alc287-ideapad-bass-spk-amp"},
 	{.id = ALC623_FIXUP_LENOVO_THINKSTATION_P340, .name = "alc623-lenovo-thinkstation-p340"},
 	{.id = ALC255_FIXUP_ACER_HEADPHONE_AND_MIC, .name = "alc255-acer-headphone-and-mic"},
+	{.id = ALC285_FIXUP_HP_GPIO_AMP_INIT, .name = "alc285-hp-amp-init"},
 	{}
 };
 #define ALC225_STANDARD_PINS \


