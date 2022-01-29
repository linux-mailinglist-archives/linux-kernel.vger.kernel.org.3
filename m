Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834C84A2E3D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 12:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbiA2Ld0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 06:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237825AbiA2LdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 06:33:14 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C28C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 03:33:13 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id j23so15690349edp.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 03:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sru1jdaN0i8x7BMpLToXDQYkXxi+rqmOmOeEeeUCi8w=;
        b=oAnGyMaNax0I3RmgHekqsLU9GExFU8MdPWRMoUgsM0/KyoGqF3j17wvCP2d7r2MErD
         dQY0cvVfW8p5BbHBbHPQr9Fv8Gm5t2Og27W8JoT5EwJ9877viAtCJMVBdKt1wJr8wc6d
         4pEa5UCK3aQGakgHPwW3g6OhckKFpVEUACxPycUjEd3a8Kn1elF0VFNgUHxmxcEd1Cm/
         1qAMC6YFeLAAEovPrYs1ScwvsWvT1G6xy673H1XAQsy4q+uQUBK+iM5ysLcr2sSpsaNf
         3OF865pyXiPZkW4ChbMhhBNrpExCRccTS9OzP5lxU7o6+/UkOg3QQcc81Mo9Kr1wK7Uw
         MXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sru1jdaN0i8x7BMpLToXDQYkXxi+rqmOmOeEeeUCi8w=;
        b=cDbBUODtP4iyY+36/msPTm0NKXHaM9O32C60Gpkd53tGastHea0Iue7tquAy29qeit
         eY+JeCZEs+0ln+rcuz+51bjrAXqwqGjPvwsf7HJMfye2KozL6mENyvTKFUlR0RFg569n
         a8sccbdJaEStmyA++wSWynAh1oa/8/jEZ5Ieb0MgIwmvlhg+S23IVPOZvPb9mUvWEHmQ
         +YWxeZJsdTYVrL2UblNKjUzzFo8aXuaBcfJbJkK41nBE00l8MHhhMTIZultBVSnq9oWP
         6JvCrO78FPd2990TRCexE09keSCxbO0pZTTD9oxDY2WTZOF8vhj3iUgPrLcUhKPLwRMd
         y06g==
X-Gm-Message-State: AOAM533oJpRAXm9Mr8X0jmtx50/hrCWey9MByM1wP/QcIetH4iLqWPcK
        Ov4IuZFTfry5C6RAHVWR9WE=
X-Google-Smtp-Source: ABdhPJzBi8S9tPmb0gPjL+mqr1DSXbVLEoeBxZimbwlpMKMIEusoJzn6cn4RgGbtDGRcQtCP/pCsmw==
X-Received: by 2002:a50:fc14:: with SMTP id i20mr12197926edr.261.1643455992567;
        Sat, 29 Jan 2022 03:33:12 -0800 (PST)
Received: from cosmos.lan (178.113.77.92.wireless.dyn.drei.com. [178.113.77.92])
        by smtp.gmail.com with ESMTPSA id g6sm8885062ejz.170.2022.01.29.03.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 03:33:12 -0800 (PST)
From:   Christian Lachner <gladiac@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, kailang@realtek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Christian Lachner <gladiac@gmail.com>
Subject: [PATCH 2/3] hda/realtek: Fix silent output on Gigabyte X570S Aorus Master (newer chipset)
Date:   Sat, 29 Jan 2022 12:32:42 +0100
Message-Id: <20220129113243.93068-3-gladiac@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129113243.93068-1-gladiac@gmail.com>
References: <20220129113243.93068-1-gladiac@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer versions of the X570 Master come with a newer revision of the
mainboard chipset - the X570S. These boards have the same ALC1220 codec
but seem to initialize the codec with a different parameter in Coef 0x7
which causes the output audio to be very low. We therefore write a
known-good value to Coef 0x7 to fix that. As the value is the exact same
as on the other X570(non-S) boards the same quirk-function can be shared
between both generations.

This commit adds the Gigabyte X570S Aorus Master to the list of boards
using the ALC1220_FIXUP_GB_X570 quirk. This fixes both, the silent output
and the no-audio after reboot from windows problems.

This work has been tested by the folks over at the level1techs forum here:
https://forum.level1techs.com/t/has-anybody-gotten-audio-working-in-linux-on-aorus-x570-master/154072

Signed-off-by: Christian Lachner <gladiac@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 48af182f87e4..ca8475c24187 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2125,6 +2125,7 @@ static void alc1220_fixup_gb_x570(struct hda_codec *codec,
 {
 	static const hda_nid_t conn1[] = { 0x0c };
 	static const struct coef_fw gb_x570_coefs[] = {
+		WRITE_COEF(0x07, 0x03c0),
 		WRITE_COEF(0x1a, 0x01c1),
 		WRITE_COEF(0x1b, 0x0202),
 		WRITE_COEF(0x43, 0x3005),
@@ -2552,6 +2553,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1458, 0xa0cd, "Gigabyte X570 Aorus Master", ALC1220_FIXUP_GB_X570),
 	SND_PCI_QUIRK(0x1458, 0xa0ce, "Gigabyte X570 Aorus Xtreme", ALC1220_FIXUP_CLEVO_P950),
+	SND_PCI_QUIRK(0x1458, 0xa0d5, "Gigabyte X570S Aorus Master", ALC1220_FIXUP_GB_X570),
 	SND_PCI_QUIRK(0x1462, 0x11f7, "MSI-GE63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1228, "MSI-GP63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1229, "MSI-GP73", ALC1220_FIXUP_CLEVO_P950),
-- 
2.34.1

