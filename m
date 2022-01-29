Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EE44A2E3E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 12:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbiA2Ld3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 06:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbiA2LdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 06:33:15 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EFEC06173B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 03:33:14 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w25so14856837edt.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 03:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FNNDRp1DwqScqAKKfKlwRaoAS6b293HuHJmyYnE9wS8=;
        b=Zi8eoe7gWXACuUnDq5t0aWFzMJGG4durC3+Muthlr1md1mipaKJpB5q05nI5KKSpap
         P8iZm0jVx2+xK5IJXfmR5J6isPNA/Yv8nSKeWpCN0nlatcSJFk7QAekzdMYqFPXYY69d
         2xMPRRJ58KunDFjAnjn8xprIKwaBQf+5qHq6thXwLOqcDkn11HSmOrUiaHaYVcjPVtvm
         AH4bCx/hfq/8auaG40sjTIc1bgd4CIP8ZN31sgiBb/R86mi4YpktODHw1ir1tDUnEOBd
         xugN3WOAVzI6wJle7otsVeBeqy1d6pJz0B0OHAfWpKPiMukwxuU397W+Rb2W5s+yEMMr
         Wb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FNNDRp1DwqScqAKKfKlwRaoAS6b293HuHJmyYnE9wS8=;
        b=2LEuAiGgwLWI3viQAjwNT+Z4KMDQ5mwA9d5ltq+SK2TI8ziYNOpMGsnFC1QbHZx+uF
         L/9zce/8FWrxoZ+inybvftaUUZ93qoNMgdNygYQlNVqD2JVfk2NcXzvpYr9bZvNSuf8I
         erhky/U0yj0TECuJ7B7EAke5wJmXgnSDdfLzg5lzqTJRr5MYawLkoOOnewZ4XWqXvQfz
         yZyqyT9irvk3fsBwad2vZb8l2XyPQc6qQyftSq7HMJbWiy6B1rtDN2a9253rbTxr6IX4
         ODcWbLwVy4UFESj7/d3qmoON3Dce0KBk3S+f9VsaAQlTXuE+sc5+f/SPCwEdaDsD13qL
         YBzQ==
X-Gm-Message-State: AOAM533lYUhdjwnzBCuqj6dFaPZPLqSldnpRkxjOJ8tUV+VR54Vakqx7
        CbS4oqPCtiW2GP0dLONMF+k=
X-Google-Smtp-Source: ABdhPJzcGNGWAcIyzhGn3nbQK2CtmvxSCcdePO+OD9d6F0cJ+39tKSEi8scnnzCon2J/8kOxyRkixA==
X-Received: by 2002:a05:6402:1705:: with SMTP id y5mr12271070edu.200.1643455993377;
        Sat, 29 Jan 2022 03:33:13 -0800 (PST)
Received: from cosmos.lan (178.113.77.92.wireless.dyn.drei.com. [178.113.77.92])
        by smtp.gmail.com with ESMTPSA id g6sm8885062ejz.170.2022.01.29.03.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 03:33:13 -0800 (PST)
From:   Christian Lachner <gladiac@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, kailang@realtek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Christian Lachner <gladiac@gmail.com>
Subject: [PATCH 3/3] hda/realtek: Fix silent output on Gigabyte X570 Aorus Xtreme after reboot from Windows
Date:   Sat, 29 Jan 2022 12:32:43 +0100
Message-Id: <20220129113243.93068-4-gladiac@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129113243.93068-1-gladiac@gmail.com>
References: <20220129113243.93068-1-gladiac@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit switches the Gigabyte X570 Aorus Xtreme from using the
ALC1220_FIXUP_CLEVO_P950 to the ALC1220_FIXUP_GB_X570 quirk. This fixes
the no-audio after reboot from windows problem.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205275
Signed-off-by: Christian Lachner <gladiac@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ca8475c24187..a2e36bf0f25e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2552,7 +2552,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte EP45-DS3/Z87X-UD3H", ALC889_FIXUP_FRONT_HP_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1458, 0xa0cd, "Gigabyte X570 Aorus Master", ALC1220_FIXUP_GB_X570),
-	SND_PCI_QUIRK(0x1458, 0xa0ce, "Gigabyte X570 Aorus Xtreme", ALC1220_FIXUP_CLEVO_P950),
+	SND_PCI_QUIRK(0x1458, 0xa0ce, "Gigabyte X570 Aorus Xtreme", ALC1220_FIXUP_GB_X570),
 	SND_PCI_QUIRK(0x1458, 0xa0d5, "Gigabyte X570S Aorus Master", ALC1220_FIXUP_GB_X570),
 	SND_PCI_QUIRK(0x1462, 0x11f7, "MSI-GE63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1228, "MSI-GP63", ALC1220_FIXUP_CLEVO_P950),
-- 
2.34.1

