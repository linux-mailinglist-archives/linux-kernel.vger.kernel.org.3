Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB92247E9C8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 01:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245356AbhLXACB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 19:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240979AbhLXAB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 19:01:59 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23F6C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 16:01:59 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id v13so6456899pfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 16:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7ggQBNMAqAjGTUlvKaJU07V7AfVhAISD5RgiaV8JRGs=;
        b=IFJj9qPXeCuePq4rjbQUsEG50IuDfmVMYkqL4rtyvSh6FVkjwIgKeyszIKstG7SjZ6
         h8tlmaNzqdbK6PmnK/5xy05W5SmfBd8sM1uJKxyVGieuDQ3+Mq6+7xUjm8QoNwP43SNL
         MhW967Grf5VO/Ynyez0BLbcN+ckm7ew/RKve4EvQxHcRpJBJ5jq7BeUWmRfy8AJwBSNK
         MpcTOz/CtPXkD80BGtlg4eSzpsFexwUlc3pn0Q0gDZeBmh+BsZ6W/Sbk92NrabgTkevL
         gBYen/C9I84SBVx8sI2QgCdxmNHnjSRk0Ukr2WceEkQbvdZgsm289f2Q1lK1hZIraxTG
         CORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7ggQBNMAqAjGTUlvKaJU07V7AfVhAISD5RgiaV8JRGs=;
        b=uSyeR1tbE+67rnVv2pL/I1LPFPo6164YottVI72F805tAWYFR6saHcbKHfiMS0CNEo
         8He9hl8gOh1QddcAUEEgso6/FbWwIAP2kgbcyyI0yugS+TZCIyD9MPpNdZcMlBEhBVql
         lJOOCsknGte8aZ7hunPXcwxa2PVDGh8DjWELc2XF3+4OwDGg1nW2kfdTt2NZGIt2Ee2b
         1Rwv3C4Hi1e9pEO2CmTjotA61da9VRmORUPhlWcTH4xlhgsqOH/A15zzitpcJvmBaCJ7
         lEti+HCjtpwuQwLdzkX5hZrNeyDguJ5pTFiL0FAVHyTXdJB5nRIhMqxJw/hsvDzVi7Fy
         7ysw==
X-Gm-Message-State: AOAM531ekzgGqLq15EWDFjKlshQGeGqu9jctUTIluAi2k3i6FsPesFcL
        fXVBOh97UBEdmBao4QBwZYk=
X-Google-Smtp-Source: ABdhPJzSg/6HwrjM49XpxA8CErlhLiVOv7c4h/NWi+MwT5eKtODNLmmLjomN/7UBRgHeh1Cqz0fOaw==
X-Received: by 2002:a05:6a00:2391:b0:4a2:cb64:2e01 with SMTP id f17-20020a056a00239100b004a2cb642e01mr4460477pfc.45.1640304119102;
        Thu, 23 Dec 2021 16:01:59 -0800 (PST)
Received: from localhost.localdomain (cpe-104-173-210-7.socal.res.rr.com. [104.173.210.7])
        by smtp.gmail.com with ESMTPSA id w19sm6220207pjh.10.2021.12.23.16.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 16:01:58 -0800 (PST)
From:   arsgeiger@gmail.com
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org (open list),
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Hui Wang <hui.wang@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>, Sami Loone <sami@loone.fi>,
        Elia Devito <eliadevito@gmail.com>,
        Arie Geiger <arsgeiger@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add speaker fixup for some Yoga 15ITL5 devices
Date:   Thu, 23 Dec 2021 15:28:57 -0800
Message-Id: <20211223232857.30741-1-arsgeiger@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arie Geiger <arsgeiger@gmail.com>

This patch adds another possible subsystem ID for the ALC287 used by
the Lenovo Yoga 15ITL5.
It uses the same initalization as the others.
This patch has been tested and works for my device.

Signed-off-by: Arie Geiger <arsgeiger@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3599f4c85ebf..188cbcde6e49 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8901,6 +8901,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3852, "Lenovo Yoga 7 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
+	SND_PCI_QUIRK(0x17aa, 0x384a, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL", ALC287_FIXUP_13S_GEN2_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
-- 
2.34.1

