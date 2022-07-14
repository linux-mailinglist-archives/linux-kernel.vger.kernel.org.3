Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F04574138
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 04:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbiGNCE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 22:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiGNCEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:04:24 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB501167FA;
        Wed, 13 Jul 2022 19:04:22 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id bf13so229667pgb.11;
        Wed, 13 Jul 2022 19:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3uLc8JPFebejYIwGj9kxcsIGui9VsJLkcFMCjjNKKKg=;
        b=LysBEPVyo1qsX3ec9IiZ0UIGJAYuaK2DB1tQah1eBgsDlWUw43Lzsm6IcjNt2R/SRC
         uyF9eyd056E9IPNrGjVyrW7UrWdAMtgnTTaLr7nArFYv0GVj7C/0v+4m2n7I3ReByuML
         s81SYg+uoKMknF03V5rW6jRAJrmcXsBE37ESqmTOWCPvVvE3Br39JN0FESryeA6q7cWj
         e44msZncyH+R+uoSOM5/3ZZCqxfk/L16Wn5HHXE3Bi2dBFczujfllHpBUiyFDVnO1bIg
         mmztzX9lIipzjVlWxmvqHwijKjSlRfdhkSTR+rSc7B7+arzPYl9gULyvG3y85tXAW5is
         Z1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3uLc8JPFebejYIwGj9kxcsIGui9VsJLkcFMCjjNKKKg=;
        b=wmmiuA9S1ylN10YNgAiob465LytqtdtsCBWma5YIl07AMldran+cNodsaSGCS7BUy9
         mf4zfv2Z/esnbM44dkzbJyKrb5X6ix9hJK/qNKtN696QuRJkCC3n8+IO7h/K7Hoh+ltb
         ml4VydUPb+3T6SO/56Pc+L/x8QgrHdnmLL2HXgzWVvJr2WyvFHdq+1pT1L0srEV2aaU/
         8KWFajzlRontwEjg96/CrlfCllF5E6HvPrbjvmJ0qLwIbKU2I80ZPinecZUY1L7VTuM/
         tlh+7SvhE2yMYVKyby+BMc9V/PGncdDwylJrTClwsTbhc08Zg3t42tVatT6N/xNUIsoj
         beUg==
X-Gm-Message-State: AJIora/wWssiyAS+ujJfOPKmbTmVuvzoV1oNHBcgjl/6jstmxm0mL5e/
        KGhEvwbHo+vFIHtq7sCEM4dCKXoh/3I=
X-Google-Smtp-Source: AGRyM1sG57IyKhQJSwBPudq5Dcd46zFoTbLADJmiSVJ2XSUSwqgBRGfAUAppRbjE4EMc0zui31ElQg==
X-Received: by 2002:a05:6a00:1a01:b0:52a:d4dc:5653 with SMTP id g1-20020a056a001a0100b0052ad4dc5653mr6132334pfv.69.1657764261545;
        Wed, 13 Jul 2022 19:04:21 -0700 (PDT)
Received: from sol.home.arpa (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id i137-20020a62878f000000b0052542cbff9dsm230886pfe.99.2022.07.13.19.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 19:04:21 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org, dipenp@nvidia.com,
        andy.shevchenko@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 4/6] gpiolib: cdev: simplify line event identification
Date:   Thu, 14 Jul 2022 10:03:17 +0800
Message-Id: <20220714020319.72952-5-warthog618@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220714020319.72952-1-warthog618@gmail.com>
References: <20220714020319.72952-1-warthog618@gmail.com>
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
and replace if-else initializers with a helper function to improve
readability.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 44 +++++++++++++------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index bc7c8822ede0..5765379f4b54 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -569,6 +569,12 @@ static u64 line_event_timestamp(struct line *line)
 	return ktime_get_ns();
 }
 
+static u32 line_event_id(int level)
+{
+	return level ? GPIO_V2_LINE_EVENT_RISING_EDGE :
+		       GPIO_V2_LINE_EVENT_FALLING_EDGE;
+}
+
 static enum hte_return process_hw_ts_thread(void *p)
 {
 	struct line *line;
@@ -590,26 +596,19 @@ static enum hte_return process_hw_ts_thread(void *p)
 
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
+		le.id = line_event_id(level);
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
@@ -684,20 +683,12 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
 
 	switch (READ_ONCE(line->eflags)) {
 	case GPIO_V2_LINE_FLAG_EDGE_BOTH:
-		if (gpiod_get_value_cansleep(line->desc))
-			/* Emit low-to-high event */
-			le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
-		else
-			/* Emit high-to-low event */
-			le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
-
+		le.id = line_event_id(gpiod_get_value_cansleep(line->desc));
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
@@ -821,12 +812,7 @@ static void debounce_work_func(struct work_struct *work)
 			le.line_seqno : atomic_inc_return(&lr->seqno);
 	}
 
-	if (level)
-		/* Emit low-to-high event */
-		le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
-	else
-		/* Emit high-to-low event */
-		le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
+	le.id = line_event_id(level);
 
 	linereq_put_event(lr, &le);
 }
-- 
2.37.1

