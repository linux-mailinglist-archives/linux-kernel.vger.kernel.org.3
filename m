Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7E74831AE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbiACOGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiACOGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:06:02 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3C3C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 06:06:02 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j21so136190145edt.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 06:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HlVveiNnri8hgSppcLIAT5o2RVBcySrm7q5wmh+e/yQ=;
        b=F0RcrVUN5nmc/FMM1n6g6VzQabKa2OUQympmMwY4JfM0vO3XlI6aAwdpUHprAhaWTu
         SwRJH9r5NkRF9DAYyDyE6HwDMYxHEkaakU6pxQjXp9lijfPmP7erfhxM36nzeU7C81xz
         1KUpQVTgRvfApA2yQGf43nrKkK2lx+BOKtqKnzjaWbHHG3XofJl+R1nB/bgtQxvJq3qI
         6rTLfGSxzDAb1WKPvjgkiHfn1fhAa5nmnvvTD9KMVloD3fwDeZryiXX6pkS/qUsjvLz5
         g41cUntCl9yEzswYcfY9IabZfHvQZmGaR9JJ8ufe2hRbEfrs8nB9w3ZU7QS9Hmt0wbaW
         U7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HlVveiNnri8hgSppcLIAT5o2RVBcySrm7q5wmh+e/yQ=;
        b=WB02vt7KWT1v1WKEEtv85ErHsCkzRfLfEleGlL2sxO1d54mH7ofW69/wh3ZzRD7WCd
         7giVHsgKBuKVvXcndbNxEwRABLxEdcQKU4Kr4L1AjTF8Q223hdFfQ2s+XqoXmB69SMXN
         PlMBEqY59oXN7FnzmZXA2hrmAlsiOOjkT8V6gsNNIec7ZI0YrsefiPdf4wcWKvDIBetE
         Zgo9byZswFTxucNy7eZjQQjl5VCByUhI/LIFMKWZuHy/B7MGC6eAZ1GOXTTBQA/taOem
         elE9M3euD9vhJ118mHIpm/RiPjD/UD6raVSwiddnrW7NR9X/3a1tqOCBEjGS2Eh72ejp
         PtNQ==
X-Gm-Message-State: AOAM533Ce4Fm5OcSsnWo7hu3IzrdMawZqH3zGeDfo372uWI8aHoMZblF
        dIIkcefJXrcBBpE+WXX4aKI=
X-Google-Smtp-Source: ABdhPJx/Hy1VgfiwOsAjdZOYW53FayTOozWjTN5SwR9kAExSne73geqxrHf/bXym8DNelAbUhqT7nw==
X-Received: by 2002:a05:6402:3584:: with SMTP id y4mr44743854edc.119.1641218760939;
        Mon, 03 Jan 2022 06:06:00 -0800 (PST)
Received: from cosmos.lan (77.116.2.39.wireless.dyn.drei.com. [77.116.2.39])
        by smtp.gmail.com with ESMTPSA id k16sm10694297ejk.172.2022.01.03.06.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 06:06:00 -0800 (PST)
From:   Christian Lachner <gladiac@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, kailang@realtek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Christian Lachner <gladiac@gmail.com>
Subject: [PATCH v2 1/1] ALSA: hda/realtek - Fix silent output on Gigabyte X570  Aorus Master after reboot from Windows
Date:   Mon,  3 Jan 2022 15:05:17 +0100
Message-Id: <20220103140517.30273-2-gladiac@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220103140517.30273-1-gladiac@gmail.com>
References: <20220103140517.30273-1-gladiac@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses an issue where after rebooting from Windows into Linux
there would be no audio output.

It turns out that the Realtek Audio driver on Windows changes some coeffs
which are not being reset/reinitialized when rebooting the machine. As a
result, there is no audio output until these coeffs are being reset to
their initial state. This patch takes care of that by setting known-good
(initial) values to the coeffs.

We initially relied upon alc1220_fixup_clevo_p950() to fix some pins in the
connection list. However, it also sets coef 0x7 which does not need to be
touched. Furthermore, to prevent mixing device-specific quirks I introduced
a new alc1220_fixup_gb_x570() which is heavily based on
alc1220_fixup_clevo_p950() but does not set coeff 0x7 and fixes the coeffs
that are actually needed instead.

This new alc1220_fixup_gb_x570() is believed to also work for other boards,
like the Gigabyte X570 Aorus Extreme and the newer Gigabyte Aorus X570S
Master. However, as there is no way for me to test these I initially only
enable this new behaviour for the mainboard I have which is the Gigabyte
X570(non-S) Aorus Master.

I tested this patch on the 5.15 branch as well as on master and it is
working well for me.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205275
Signed-off-by: Christian Lachner <gladiac@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 28255e752c4a..b56d7e8f236b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1924,6 +1924,7 @@ enum {
 	ALC887_FIXUP_ASUS_BASS,
 	ALC887_FIXUP_BASS_CHMAP,
 	ALC1220_FIXUP_GB_DUAL_CODECS,
+	ALC1220_FIXUP_GB_X570,
 	ALC1220_FIXUP_CLEVO_P950,
 	ALC1220_FIXUP_CLEVO_PB51ED,
 	ALC1220_FIXUP_CLEVO_PB51ED_PINS,
@@ -2113,6 +2114,29 @@ static void alc1220_fixup_gb_dual_codecs(struct hda_codec *codec,
 	}
 }
 
+static void alc1220_fixup_gb_x570(struct hda_codec *codec,
+				     const struct hda_fixup *fix,
+				     int action)
+{
+	static const hda_nid_t conn1[] = { 0x0c };
+	static const struct coef_fw gb_x570_coefs[] = {
+		WRITE_COEF(0x1a, 0x01c1),
+		WRITE_COEF(0x1b, 0x0202),
+		WRITE_COEF(0x43, 0x3005),
+		{}
+	};
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		snd_hda_override_conn_list(codec, 0x14, ARRAY_SIZE(conn1), conn1);
+		snd_hda_override_conn_list(codec, 0x1b, ARRAY_SIZE(conn1), conn1);
+		break;
+	case HDA_FIXUP_ACT_INIT:
+		alc_process_coef_fw(codec, gb_x570_coefs);
+		break;
+	}
+}
+
 static void alc1220_fixup_clevo_p950(struct hda_codec *codec,
 				     const struct hda_fixup *fix,
 				     int action)
@@ -2415,6 +2439,10 @@ static const struct hda_fixup alc882_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc1220_fixup_gb_dual_codecs,
 	},
+	[ALC1220_FIXUP_GB_X570] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc1220_fixup_gb_x570,
+	},
 	[ALC1220_FIXUP_CLEVO_P950] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc1220_fixup_clevo_p950,
@@ -2517,7 +2545,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x13fe, 0x1009, "Advantech MIT-W101", ALC886_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte EP45-DS3/Z87X-UD3H", ALC889_FIXUP_FRONT_HP_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
-	SND_PCI_QUIRK(0x1458, 0xa0cd, "Gigabyte X570 Aorus Master", ALC1220_FIXUP_CLEVO_P950),
+	SND_PCI_QUIRK(0x1458, 0xa0cd, "Gigabyte X570 Aorus Master", ALC1220_FIXUP_GB_X570),
 	SND_PCI_QUIRK(0x1458, 0xa0ce, "Gigabyte X570 Aorus Xtreme", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x11f7, "MSI-GE63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1228, "MSI-GP63", ALC1220_FIXUP_CLEVO_P950),
-- 
2.34.1

