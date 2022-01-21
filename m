Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827DB496366
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381640AbiAUQ56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379849AbiAUQ4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:56:49 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755DBC061763;
        Fri, 21 Jan 2022 08:55:34 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id w188so14290830oiw.13;
        Fri, 21 Jan 2022 08:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4weifrQ7PTCoGujS0yQMKZpi8lSBUanoNpSA0DdSt+Y=;
        b=OF1LGc0evnBIhNNz84FPs7c8hsoF1r+/WS4fAuOmilgSYZYbT6CrqaPs1OIO/6LIxh
         aCfomttS8vaYkKjlBhGRnCkK5sNSvB90MhaAykJPVz096eYCnJ7kncwalddJLbZmYVe5
         MjebfomEvGhfTf2h1MgGTNSTVznz9gV0EWT14LVTZ24nZGykPBIKktLkT/rP1v3y60e1
         Z6yTLr7ejol0GHlZUCZY41ckrUnhyqaRW1JwMN5GZK5O2k8qBmD5DCBxAozgWYBBu1uF
         5RSJhj6dkBWt0EeCIIdyLjgqmWG4OcP7EQD/B7dkBMCqcGG2P0YCfdnVn2Gyds3JND8A
         yv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4weifrQ7PTCoGujS0yQMKZpi8lSBUanoNpSA0DdSt+Y=;
        b=x+li9HbDXQxNSfkR5zgpJikqvGrAYCErkUYGH9I5UfkQQCf1U17sx/roNCXoDm411l
         BZclYBsCnwRC1gLj6Y8kDxmWfULut50+ZKnVP1JpyMb36dfHJWM8l/sdQON2F9jw6coW
         sYgEzsKs8JzU71ELMlRk/CFcjK4Z/DDKNZ8BQ79MqAEL+VyjNxRNedhBWMHbcdKYzQbf
         pgphObiWid10/FsYZViA3CWwGNuMYXD4OMAzeWSfLZPee1S2LBAkvQDYpe+uCbMGrmCa
         tvAxKp4vZeDflKS0MmJV67b8cSlk40cM5ha1LV/sp0g2Vc7tKNTtJiVpml4kn4cekY3w
         zWSg==
X-Gm-Message-State: AOAM5328Le80sLSk3NGsLg4blFjC2dRtgEx06Ps5cugKvls4BHdkbhL9
        jKm8j0ZRnfnfhvjjHkUGUflbyJnnq9I=
X-Google-Smtp-Source: ABdhPJwjGzQmdpB6fvzrVNmA0mJLwxz20tqVgliSftrr9PonyQNufPf2QsVgpesq4DcccdBJkKfIgw==
X-Received: by 2002:a54:4e9a:: with SMTP id c26mr1250134oiy.159.1642784133886;
        Fri, 21 Jan 2022 08:55:33 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:cf72:4317:3105:f6e5])
        by smtp.gmail.com with ESMTPSA id y8sm1089271oou.23.2022.01.21.08.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:55:33 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH 21/31] power: supply: changing LED_* from enum led_brightness to actual value
Date:   Fri, 21 Jan 2022 13:54:26 -0300
Message-Id: <20220121165436.30956-22-sampaio.ime@gmail.com>
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
 drivers/power/supply/power_supply_leds.c | 26 ++++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/power/supply/power_supply_leds.c b/drivers/power/supply/power_supply_leds.c
index d69880cc3593..16f25179f710 100644
--- a/drivers/power/supply/power_supply_leds.c
+++ b/drivers/power/supply/power_supply_leds.c
@@ -31,25 +31,25 @@ static void power_supply_update_bat_leds(struct power_supply *psy)
 
 	switch (status.intval) {
 	case POWER_SUPPLY_STATUS_FULL:
-		led_trigger_event(psy->charging_full_trig, LED_FULL);
-		led_trigger_event(psy->charging_trig, LED_OFF);
-		led_trigger_event(psy->full_trig, LED_FULL);
+		led_trigger_event(psy->charging_full_trig, 255);
+		led_trigger_event(psy->charging_trig, 0);
+		led_trigger_event(psy->full_trig, 255);
 		led_trigger_event(psy->charging_blink_full_solid_trig,
-			LED_FULL);
+			255);
 		break;
 	case POWER_SUPPLY_STATUS_CHARGING:
-		led_trigger_event(psy->charging_full_trig, LED_FULL);
-		led_trigger_event(psy->charging_trig, LED_FULL);
-		led_trigger_event(psy->full_trig, LED_OFF);
+		led_trigger_event(psy->charging_full_trig, 255);
+		led_trigger_event(psy->charging_trig, 255);
+		led_trigger_event(psy->full_trig, 0);
 		led_trigger_blink(psy->charging_blink_full_solid_trig,
 			&delay_on, &delay_off);
 		break;
 	default:
-		led_trigger_event(psy->charging_full_trig, LED_OFF);
-		led_trigger_event(psy->charging_trig, LED_OFF);
-		led_trigger_event(psy->full_trig, LED_OFF);
+		led_trigger_event(psy->charging_full_trig, 0);
+		led_trigger_event(psy->charging_trig, 0);
+		led_trigger_event(psy->full_trig, 0);
 		led_trigger_event(psy->charging_blink_full_solid_trig,
-			LED_OFF);
+			0);
 		break;
 	}
 }
@@ -120,9 +120,9 @@ static void power_supply_update_gen_leds(struct power_supply *psy)
 	dev_dbg(&psy->dev, "%s %d\n", __func__, online.intval);
 
 	if (online.intval)
-		led_trigger_event(psy->online_trig, LED_FULL);
+		led_trigger_event(psy->online_trig, 255);
 	else
-		led_trigger_event(psy->online_trig, LED_OFF);
+		led_trigger_event(psy->online_trig, 0);
 }
 
 static int power_supply_create_gen_triggers(struct power_supply *psy)
-- 
2.34.1

