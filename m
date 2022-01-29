Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065F84A2E3C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 12:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbiA2LdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 06:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237690AbiA2LdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 06:33:13 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047E9C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 03:33:13 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c24so15832554edy.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 03:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ERA8aqBvYsjnUMCz9U3prbef6jppsXR/APdHoQnIWjI=;
        b=P1NiM06ryBLQy3PdF+YpGkhXnOuNMR3s8H1hQSsvru5rizLJ7ry7FqvJ3vWk9DV9nS
         PlUjGs9ofhwEoHiosLGbGNy3yqtrTNemNzSrlcuq9mt7vj0cFJuT+bXrsw70rs3peRTz
         RUXFPvgVugBgBKomRdW0C24/qgG3t/DCG2JA4uNZ1xWGPVPPKombPk4PuthWsbQe8FcT
         94xi0DwL5gX2/1SRrZxIH0H3tQlwg4aDnOxImjglbQnb+bTgdbpbKiBs9svG8hQ+mjbh
         Y0EyFlOXzXc09r9aXVE0k4Euwp9B3BlAvENQLzEmnOmAgM/ARgyYHmhRTZq2PUOz+7XQ
         pDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ERA8aqBvYsjnUMCz9U3prbef6jppsXR/APdHoQnIWjI=;
        b=E26/QE/tjmiPIICLvaiw2Bh51vWIDKmyT63aTW7FG/r9G8qosCypKO8WowIzmCUiJU
         IUkio9x+1RSDs2BOSr2K/I6rd/5jRSLze2Ii0pKZlV3AhHcsrNvCGSz8FXmyvE24VZkb
         Uj3Dw5Y/wsoN/xyGv7QwTAK9J4He5n+6XfOggToVVXBDxRTTCdHfVBvQF7YIDXNXxWjX
         We5SwmX+MMhrFwpm2YwsdL0xHW0KUpll8RYokk64mdd27hbVelrsS1JWgRulnfpiV33W
         JgNbWqXfhnoXBKqTJlPhzje6q6InsjsFKhGwSVyMqeARRmqJfibQkdHiXGu8dZnuSc9l
         KCyQ==
X-Gm-Message-State: AOAM531guE/7MIkgAHB9vywTRTu7GDHYtO++QpRKdcdeYQ8PLm5dqnjg
        +UBsgzSmtMvewbeBeyMQeTY=
X-Google-Smtp-Source: ABdhPJzLP+bbtbCvN3Io1A8R1+++zl+5dkNH9PZbnUUObW7WZv04fmuU2WXnQGXu/SJSsU31RnO0JQ==
X-Received: by 2002:a05:6402:5147:: with SMTP id n7mr12261744edd.2.1643455991590;
        Sat, 29 Jan 2022 03:33:11 -0800 (PST)
Received: from cosmos.lan (178.113.77.92.wireless.dyn.drei.com. [178.113.77.92])
        by smtp.gmail.com with ESMTPSA id g6sm8885062ejz.170.2022.01.29.03.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 03:33:11 -0800 (PST)
From:   Christian Lachner <gladiac@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, kailang@realtek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Christian Lachner <gladiac@gmail.com>
Subject: [PATCH 1/3] hda/realtek: Add missing fixup-model entry for Gigabyte X570 ALC1220 quirks
Date:   Sat, 29 Jan 2022 12:32:41 +0100
Message-Id: <20220129113243.93068-2-gladiac@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129113243.93068-1-gladiac@gmail.com>
References: <20220129113243.93068-1-gladiac@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial commit of the new Gigabyte X570 ALC1220 quirks lacked the
fixup-model entry in alc882_fixup_models[]. It seemed not to cause any ill
effects but for completeness sake this commit makes up for that.

Signed-off-by: Christian Lachner <gladiac@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 668274e52674..48af182f87e4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2626,6 +2626,7 @@ static const struct hda_model_fixup alc882_fixup_models[] = {
 	{.id = ALC882_FIXUP_NO_PRIMARY_HP, .name = "no-primary-hp"},
 	{.id = ALC887_FIXUP_ASUS_BASS, .name = "asus-bass"},
 	{.id = ALC1220_FIXUP_GB_DUAL_CODECS, .name = "dual-codecs"},
+	{.id = ALC1220_FIXUP_GB_X570, .name = "gb-x570"},
 	{.id = ALC1220_FIXUP_CLEVO_P950, .name = "clevo-p950"},
 	{}
 };
-- 
2.34.1

