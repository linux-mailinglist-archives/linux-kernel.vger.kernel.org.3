Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72289496334
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349665AbiAUQz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379776AbiAUQyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:54:54 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4F1C061747
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 08:54:51 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id n22-20020a9d2016000000b0059bd79f7777so12085120ota.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 08:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HVA0ZWgzizXSbtVSNUIGHlKEL+CetSwxidS0XXuLPDw=;
        b=lhqbeFLn6LGWwaXmjOPj025/8uD2u6ghPM19YiK6cJI0mhCqlepHSe+COo5qrpuYrj
         Sl6tQM2aeFiwynHCEpE3AmawxvDoNYa46HXASqlYacYo/jQwc673zhFfithjVFOpFXq4
         wMa0NyFx/j25Ww4M4OL/nOUVvICnZ+Fk1posng1CxQ50V0w1A+I/ILNOAffBghZahGoA
         h8sg9o+LHpseXVWuqr9PKyzV/3hDbSpG2nLG2I2YSJk+g07XlsrvaurbNJYMGO3G37YW
         DjlvKNOAaIu0LDJVdA8MoxqUYd4NYzgYb/l9WBlYQWnYnu+5F+NGDNZRxUWtYq+HaI86
         GLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVA0ZWgzizXSbtVSNUIGHlKEL+CetSwxidS0XXuLPDw=;
        b=xSY68OJ1Pg8v9EuluwEB8NRsL6Q0aFaAI7Rk7J+yUYOSbA/NF/R0ig9XxntsEFpg+U
         sGMn52NjvX06IuFNIkA8mCFQwRBW3JfzTdg0lNs5KEhOSbE/BHcpc30g47qq87bixJdp
         FpPYMyh0X/euZQnwKDWm9xd67yoeTf3kl4Ewmxd3kKgYPARXY+V7YGEIoiwefzTXlUQJ
         NwuwA4d0aQsF2MlU1O+ertusKTHhVa6kiXJSPggNGs6uamtfOYUZgU0gdNtieM8WS1ee
         ngQPO51n6jbi/+2IeKl4anCfzELrdAAxQUAhtCw7bG3r67ReZ7aIFbI3EeupZNcp0Ll2
         s4Bw==
X-Gm-Message-State: AOAM533fsDIPVEmakRuA38kXVZ7S8JKNRxjNRPnBYjPNri84+GIhFrGa
        bd3bHjA0uXW+FNmFm1lg6vFqndRJl/M=
X-Google-Smtp-Source: ABdhPJzGe5RaMv9muOHI7TUblJz0zvxsC6HtZXqdKfF4KHj5o321mFmDbasyCgJoXNohCMLyfEp3ew==
X-Received: by 2002:a9d:60b:: with SMTP id 11mr3320985otn.384.1642784091086;
        Fri, 21 Jan 2022 08:54:51 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:cf72:4317:3105:f6e5])
        by smtp.gmail.com with ESMTPSA id y8sm1089271oou.23.2022.01.21.08.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:54:50 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 09/31] macintosh: changing LED_* from enum led_brightness to actual value
Date:   Fri, 21 Jan 2022 13:54:14 -0300
Message-Id: <20220121165436.30956-10-sampaio.ime@gmail.com>
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
 drivers/macintosh/via-pmu-led.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/via-pmu-led.c b/drivers/macintosh/via-pmu-led.c
index ae067ab2373d..b0a727ad0157 100644
--- a/drivers/macintosh/via-pmu-led.c
+++ b/drivers/macintosh/via-pmu-led.c
@@ -54,7 +54,7 @@ static void pmu_led_set(struct led_classdev *led_cdev,
 
 	spin_lock_irqsave(&pmu_blink_lock, flags);
 	switch (brightness) {
-	case LED_OFF:
+	case 0:
 		requested_change = 0;
 		break;
 	case LED_FULL:
-- 
2.34.1

