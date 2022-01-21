Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07320496332
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379690AbiAUQzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379312AbiAUQye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:54:34 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862E3C06173B;
        Fri, 21 Jan 2022 08:54:34 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id s127so14381111oig.2;
        Fri, 21 Jan 2022 08:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gMvwDdKHz8SxD4XNsSXi0ifYKZbrqBGSjCLlHvwqADI=;
        b=bFxWZzsGiGVdBe5x6szZZuz5pjdNt6E15NqjGO8IZpJRKXyU1CUVtQfiS7nQ85w9Hr
         a2F1y2md9h0rVZQajdIrclWiJ+nPA3vP/ZbKGqY1iQ5LhRK5axOYZFH1PI5vO/zWWhHl
         Eor7nYxkOYgUmAvJXNbqMrfjOckjduoYsdX4Y6JNRzNb3G1lgccNCs7Y980we11ot3UN
         XHQSZwNj5VD7/nnNJ8r4qN9vTm6Bj+G85IZM4HPdO+1G2RHVJXmzMRqb+7g60TcsjCK4
         wuMh1c/1/kQbcrDd8GS8Jj8JzJYBPQdU0Ypn6G0fz+xx25Wr4xWQNsmqWf1XxJQQbtiZ
         KVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gMvwDdKHz8SxD4XNsSXi0ifYKZbrqBGSjCLlHvwqADI=;
        b=v6NZrRcc03i/LAx1MtmQH/zsI3ox74a08ew4B2sK0zop3ll94wwmMr8qkDKWbac48/
         Gjl1DtXTn5shBeK3f4HEWrHBfeU4xiX89XpGk3ZQAU/btCgvLptYNLFv7J7iEkRBrcdh
         wN2hNE/F4r9FOOl4OWCgurdXtiS9VTk9LAVsSJGBbsGSNSdhSZ/iM0HQhLheho9cyzFd
         gY/AxgMuzSCfLxL+Lsc+91TNrNZz4rWjeGJy5QGDfZRiCQTuJlxfCH1yP/WqyByOrNnu
         VSCxhljM7hHWIQnSCCg/be+/5q1Raq2MiD5w5BmnOg47bs3bvPZX0Q+u6vSq3GKnPENr
         hizg==
X-Gm-Message-State: AOAM533X99YDAl/Qj01E6p/xeeJiHtdw471z2LKx/RV/11aWKu72DYdS
        O+glebWAECoSg1ZFgzJN1e0=
X-Google-Smtp-Source: ABdhPJynqGcrSez4vywi3ZAwZ9c1EdrO57Z15fp5aZAFGlBkrVlL1jMCkHBNN5fSrWBvd5Uebtem0g==
X-Received: by 2002:a05:6808:171c:: with SMTP id bc28mr1273461oib.102.1642784073967;
        Fri, 21 Jan 2022 08:54:33 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:cf72:4317:3105:f6e5])
        by smtp.gmail.com with ESMTPSA id y8sm1089271oou.23.2022.01.21.08.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:54:33 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>,
        linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/31] input: touchscreen: changing LED_* from enum led_brightness to actual value
Date:   Fri, 21 Jan 2022 13:54:12 -0300
Message-Id: <20220121165436.30956-8-sampaio.ime@gmail.com>
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
 drivers/input/touchscreen/stmfts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
index bc11203c9cf7..7e7cb5f4d6d3 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -608,8 +608,8 @@ static int stmfts_enable_led(struct stmfts_data *sdata)
 		return PTR_ERR(sdata->ledvdd);
 
 	sdata->led_cdev.name = STMFTS_DEV_NAME;
-	sdata->led_cdev.max_brightness = LED_ON;
-	sdata->led_cdev.brightness = LED_OFF;
+	sdata->led_cdev.max_brightness = 1;
+	sdata->led_cdev.brightness = 0;
 	sdata->led_cdev.brightness_set_blocking = stmfts_brightness_set;
 	sdata->led_cdev.brightness_get = stmfts_brightness_get;
 
-- 
2.34.1

