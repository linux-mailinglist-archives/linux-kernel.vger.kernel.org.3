Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE25F547A8F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 16:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiFLOtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 10:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbiFLOtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 10:49:19 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B12830554
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 07:49:17 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d14so4212548eda.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 07:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZYegJLBLKIFYA6731P7rWnnXUer1l3FN0VMP5JguwY=;
        b=FPXLILWZPGq7+yE5oU94gYNFh96HzpsKl+xzWHN+uwWHd4VyxnXpwpo/mj4VuZBrtD
         Tvg7JahnzUPnuHNGsBIpXKvCXDzm/3Vp7SaM9xq49uRA4P1vbNCzJkK9chsIpN2uL1qM
         01+U5br4Xj3mvf1+QtPT++Musa0/OhMj07HLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZYegJLBLKIFYA6731P7rWnnXUer1l3FN0VMP5JguwY=;
        b=5n2fsrYbZr23JPH+lNCD9j2bn3LI+UpWGpYH8565XI7lDdMF8bHqIkcUockZOTPkRa
         ewhYMZ94w5w6ftPAfxC7wxci2qU3XYilMgB8pbwqIGGTRmG3+WbetzZJYFTAe8JmkBK7
         Dx71V0GyoEgvLyXNoQwdnvMcr0wnJqPrsyu76up7tVpXXN5Q4IhGGii0IDjhQJhn+XOB
         ggSTEeBppFLxmPyY9WgdOJRqH0QZptGkg/r7Kr+SzhM6kSd2K+Fp3aNYyWic7c62xcFv
         eAXU0Uop0lnDTm+CvRkIK6BNFhWUuV58tJIeEMcQjkY0pv0PX1+cx7fTQWBEpnhpHyOK
         6cjQ==
X-Gm-Message-State: AOAM532vpbdNYHcN3xuPCNQT8wl5H8X9uMsklpic8tlqpVjCIq7As7Om
        74MIuQV6qtns0cIIy74uUwe00A==
X-Google-Smtp-Source: ABdhPJwrwWudy5n1gSRNpA4pV8YgeBNu8lNs+Ynkn3H26f6GqvaWiOLkI+WUyJSGNv4YS8RPuMGgdg==
X-Received: by 2002:a50:fb99:0:b0:42d:e4fd:c368 with SMTP id e25-20020a50fb99000000b0042de4fdc368mr60703009edq.138.1655045355718;
        Sun, 12 Jun 2022 07:49:15 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id cm20-20020a0564020c9400b004316f94ec4esm3257076edb.66.2022.06.12.07.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 07:49:15 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Archit Taneja <architt@codeaurora.org>
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/2] drm: bridge: adv7511: fix CEC power down control register offset
Date:   Sun, 12 Jun 2022 16:48:53 +0200
Message-Id: <20220612144854.2223873-2-alvin@pqrs.dk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220612144854.2223873-1-alvin@pqrs.dk>
References: <20220612144854.2223873-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

The ADV7511_REG_CEC_CTRL = 0xE2 register is part of the main register
map - not the CEC register map. As such, we shouldn't apply an offset to
the register address. Doing so will cause us to address a bogus register
for chips with a CEC register map offset (e.g. ADV7533).

Fixes: 3b1b975003e4 ("drm: adv7511/33: add HDMI CEC support")
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 drivers/gpu/drm/bridge/adv7511/adv7511.h     | 5 +----
 drivers/gpu/drm/bridge/adv7511/adv7511_cec.c | 4 ++--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511.h b/drivers/gpu/drm/bridge/adv7511/adv7511.h
index 9e3bb8a8ee40..46ae6c0d9aa5 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511.h
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511.h
@@ -406,10 +406,7 @@ void adv7511_cec_irq_process(struct adv7511 *adv7511, unsigned int irq1);
 #else
 static inline int adv7511_cec_init(struct device *dev, struct adv7511 *adv7511)
 {
-	unsigned int offset = adv7511->type == ADV7533 ?
-						ADV7533_REG_CEC_OFFSET : 0;
-
-	regmap_write(adv7511->regmap, ADV7511_REG_CEC_CTRL + offset,
+	regmap_write(adv7511->regmap, ADV7511_REG_CEC_CTRL,
 		     ADV7511_CEC_CTRL_POWER_DOWN);
 	return 0;
 }
diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c b/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
index 399f625a50c8..6d067fa54bea 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_cec.c
@@ -347,7 +347,7 @@ int adv7511_cec_init(struct device *dev, struct adv7511 *adv7511)
 		goto err_cec_alloc;
 	}
 
-	regmap_write(adv7511->regmap, ADV7511_REG_CEC_CTRL + offset, 0);
+	regmap_write(adv7511->regmap, ADV7511_REG_CEC_CTRL, 0);
 	/* cec soft reset */
 	regmap_write(adv7511->regmap_cec,
 		     ADV7511_REG_CEC_SOFT_RESET + offset, 0x01);
@@ -374,7 +374,7 @@ int adv7511_cec_init(struct device *dev, struct adv7511 *adv7511)
 	dev_info(dev, "Initializing CEC failed with error %d, disabling CEC\n",
 		 ret);
 err_cec_parse_dt:
-	regmap_write(adv7511->regmap, ADV7511_REG_CEC_CTRL + offset,
+	regmap_write(adv7511->regmap, ADV7511_REG_CEC_CTRL,
 		     ADV7511_CEC_CTRL_POWER_DOWN);
 	return ret == -EPROBE_DEFER ? ret : 0;
 }
-- 
2.36.1

