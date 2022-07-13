Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F27572AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 03:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbiGMBid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 21:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbiGMBiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 21:38:25 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0848DD1ED9;
        Tue, 12 Jul 2022 18:38:22 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so1166744pjr.4;
        Tue, 12 Jul 2022 18:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tUjIr1POS5JV8O95mGxEYzBba9cDKwoWvQleO64OPNk=;
        b=TZIRS3vmXHWyQ4P9q8TBK6DgqR1/f8uKVVqAOc3HrJ1UKgiFrW1T4HaxqtQ/DUrncN
         oRz048E9EvupkpnluH6ZeDXNG77D3nsfkXswDgKKmj+xIl48cHkaSWfGOk2DgcqbdVJS
         ta8KbyXWH4iJrzCzm4+rUO8BGQjncBH/+R1IGbQlid9KYDgzMDktOvsTVhtKgJi4dPvB
         kfpn4ysSnD/pqyiJEDnfAQe//aaSEPpawjyoeWsdtTpijb0wQVYDASMBQtcgD6OSyifV
         nGdd8ipnpQi73nJ0nKoRlj/4fbxw7MBI438Mfn0TUKOW45wyowe1yfn41Uq4CfdUiyi6
         MRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tUjIr1POS5JV8O95mGxEYzBba9cDKwoWvQleO64OPNk=;
        b=1cHUS6OVNhYg9j5oAK83I/xlp4gghuroYurTlS2//lPhLI/YWDU5LEahejgkIvQDOn
         WvRm9/4y8gXOLIBImbzHJtu9TMtL2Y5pSM7GvKkOg8eAvRlfTfVij1RrvY2fesm71A6+
         3WRPbeZGg9HfKxg3vo5nRuav6gGGUYqh1U2IKnoOOGCW+ft/ET51Gut6r6vvF2TmmidA
         4NeOn9FHOdAYjeH2za1Qy3fgbxaPdGx0O4M7/wYQOj83jwmJJMlTGW9Gob3KOChcUhIb
         HL6vIUzm6WKJ1HHGpuTN2bnw1UfzONFtEZaPIte/PB4LBTRMD/0XUVnRsVPliLvKSFuH
         sJjQ==
X-Gm-Message-State: AJIora8UD37dF1TvqPsGNX867CRh8hL30zSONFVKB7ps/G/YJAZHjoo2
        S5nwfEt8KQUwurbiNMmYnbTbAA9R2qE=
X-Google-Smtp-Source: AGRyM1u67L9Jv69MGQ8CL9ADlKWuEf7pXgwhiibSsOVKnUSa/N1Z1OSOOU/IK9/4y7wkxN3zL8L93w==
X-Received: by 2002:a17:903:1105:b0:16c:32e4:6453 with SMTP id n5-20020a170903110500b0016c32e46453mr847893plh.131.1657676301238;
        Tue, 12 Jul 2022 18:38:21 -0700 (PDT)
Received: from sol.home.arpa (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id ob2-20020a17090b390200b001ef76dbae28sm225879pjb.36.2022.07.12.18.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 18:38:20 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org, dipenp@nvidia.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 4/6] gpiolib: cdev: simplify line event identification
Date:   Wed, 13 Jul 2022 09:37:19 +0800
Message-Id: <20220713013721.68879-5-warthog618@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713013721.68879-1-warthog618@gmail.com>
References: <20220713013721.68879-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorganise line event identification code to reduce code duplication,
and replace if-else initializers with the ternary equivalent to
improve readability.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 42 ++++++++++++-------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index bc7c8822ede0..34d0bdfe5498 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -590,26 +590,20 @@ static enum hte_return process_hw_ts_thread(void *p)
 
 	switch (eflags) {
 	case GPIO_V2_LINE_FLAG_EDGE_BOTH:
-		if (line->raw_level >= 0) {
-			if (test_bit(FLAG_ACTIVE_LOW, &line->desc->flags))
-				level = !line->raw_level;
-			else
-				level = line->raw_level;
-		} else {
-			level = gpiod_get_value_cansleep(line->desc);
-		}
+		level = (line->raw_level >= 0) ?
+				line->raw_level :
+				gpiod_get_raw_value_cansleep(line->desc);
 
-		if (level)
-			le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
-		else
-			le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
+		if (test_bit(FLAG_ACTIVE_LOW, &line->desc->flags))
+			level = !level;
+
+		le.id = level ? GPIO_V2_LINE_EVENT_RISING_EDGE :
+				GPIO_V2_LINE_EVENT_FALLING_EDGE;
 		break;
 	case GPIO_V2_LINE_FLAG_EDGE_RISING:
-		/* Emit low-to-high event */
 		le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
 		break;
 	case GPIO_V2_LINE_FLAG_EDGE_FALLING:
-		/* Emit high-to-low event */
 		le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
 		break;
 	default:
@@ -684,20 +678,14 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
 
 	switch (READ_ONCE(line->eflags)) {
 	case GPIO_V2_LINE_FLAG_EDGE_BOTH:
-		if (gpiod_get_value_cansleep(line->desc))
-			/* Emit low-to-high event */
-			le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
-		else
-			/* Emit high-to-low event */
-			le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
-
+		le.id = gpiod_get_value_cansleep(line->desc) ?
+				GPIO_V2_LINE_EVENT_RISING_EDGE :
+				GPIO_V2_LINE_EVENT_FALLING_EDGE;
 		break;
 	case GPIO_V2_LINE_FLAG_EDGE_RISING:
-		/* Emit low-to-high event */
 		le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
 		break;
 	case GPIO_V2_LINE_FLAG_EDGE_FALLING:
-		/* Emit high-to-low event */
 		le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
 		break;
 	default:
@@ -821,12 +809,8 @@ static void debounce_work_func(struct work_struct *work)
 			le.line_seqno : atomic_inc_return(&lr->seqno);
 	}
 
-	if (level)
-		/* Emit low-to-high event */
-		le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
-	else
-		/* Emit high-to-low event */
-		le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
+	le.id = level ? GPIO_V2_LINE_EVENT_RISING_EDGE :
+			GPIO_V2_LINE_EVENT_FALLING_EDGE;
 
 	linereq_put_event(lr, &le);
 }
-- 
2.37.0

