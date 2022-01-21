Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405F8496325
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378906AbiAUQyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbiAUQyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:54:16 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CC6C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 08:54:16 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id x31-20020a056830245f00b00599111c8b20so12500769otr.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 08:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJAypc7GOb09YdvN33B2vpee2uXuBcVdkBylIc96AeA=;
        b=K5JwDApwVvttoj1FuEQWHcNMeEk9ffV26USk+IVo7z4R+E0TB6ZLbA+uyyhQbQIeIW
         7/HguzO/fxNh33d2a1NipgqeVvG2HGQkV2/EUEuAcyenIBmOSItP0HQtiTRTMSQCTB19
         Q8JRE466S0mqUGFHRMq6HnMj6W7VTJm84rdOAn/bB0D6pKxs4VHgQ12wQqE8s4vSm8ad
         pfC/q04FuRUVchCnEmBr9uvyn9AHV11GeeDBs4nU09hWmqoVn7DMtgVKdhjraXSGsd9L
         S0FyshtxeBr3TgNQJXcg1xT2BR2QOjvt6FqBAdNWocPYRpii+5V1Wc/NGPoJFEjoJ972
         JFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJAypc7GOb09YdvN33B2vpee2uXuBcVdkBylIc96AeA=;
        b=NMIvzb9X6rqtPiV74Fa4DGvUgBE47WPBXef/XGRKL7HIAFHl6W05AOeO8xOcXZvFTa
         Ub9ZJFqx5VSzMAQ7QvS09zV62PNpKt2AbjwTAvxobAbwAhBoP8hOym34kPe3wIj+GsPH
         67kAG5miVITYqghhwyBUXHkMddQ92kBkBUJEwMm87abcvoKmUOvj4spdvyzEXqWp/YLb
         8p/u4pasliMQb0YesrvnDRSnHmvBRi35jY3fHF/ZXp/F8zS6s1AMUKpwfQWsuNly5UZ3
         bRTQDEuZB6kNPTlcIOFP84wyChTD0rl84Csav9DY/z0e+z0+jOM9hj678cZwKTYo9c1U
         elig==
X-Gm-Message-State: AOAM531YIFmG4CvWlKZNTf2rnNbIneWuMippFO6Ne++W7c+nZUwChSH1
        XD84thRV29vfIIxn6TK/ZMDPUTUb6zI=
X-Google-Smtp-Source: ABdhPJxVTLluA8KZ26wu9YLuaAzbXLzAR+oweGtMG8xK7CPe3rWm/4vkcVKatam8xzsp4HJXvlwuhg==
X-Received: by 2002:a9d:650e:: with SMTP id i14mr3360247otl.350.1642784055795;
        Fri, 21 Jan 2022 08:54:15 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:cf72:4317:3105:f6e5])
        by smtp.gmail.com with ESMTPSA id y8sm1089271oou.23.2022.01.21.08.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:54:15 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 01/31] gpu: nouveau: nouveau_led: changing LED_FULL to actual value
Date:   Fri, 21 Jan 2022 13:54:06 -0300
Message-Id: <20220121165436.30956-2-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121165436.30956-1-sampaio.ime@gmail.com>
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum led_brightness, which contains the declaration of LED_OFF,
LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
max_brightness.
---
 drivers/gpu/drm/nouveau/nouveau_led.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_led.c b/drivers/gpu/drm/nouveau/nouveau_led.c
index 2c5e0628da12..df4a734510e1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_led.c
+++ b/drivers/gpu/drm/nouveau/nouveau_led.c
@@ -45,7 +45,7 @@ nouveau_led_get_brightness(struct led_classdev *led)
 	duty = nvif_rd32(device, 0x61c884) & 0x00ffffff;
 
 	if (div > 0)
-		return duty * LED_FULL / div;
+		return duty * 255 / div;
 	else
 		return 0;
 }
@@ -62,7 +62,7 @@ nouveau_led_set_brightness(struct led_classdev *led, enum led_brightness value)
 	u32 div, duty;
 
 	div = input_clk / freq;
-	duty = value * div / LED_FULL;
+	duty = value * div / 255;
 
 	/* for now, this is safe to directly poke those registers because:
 	 *  - A: nvidia never puts the logo led to any other PWM controler
-- 
2.34.1

