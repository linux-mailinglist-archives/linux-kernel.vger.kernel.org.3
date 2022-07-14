Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB8657413C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 04:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiGNCE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 22:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiGNCEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:04:53 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592A9237C2;
        Wed, 13 Jul 2022 19:04:49 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s21so1019538pjq.4;
        Wed, 13 Jul 2022 19:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EME9vXPWQYeTzNMZe7eXduyu6mIuulBInrr92ndX+U8=;
        b=YE2UfkSXieEWKCyzEgRq5WWG/yywD3zSyNbjvGzDj0CR+8o9LdEQa+56M1Ro+BkOAI
         Dt1ZnsGXLXSKZ2+l+6OIRAkxxbmQyvnS3KG3aNXilyTUcVnIB/QC5kkT3mzJeQKaJegv
         dgXDZFUFB+p6EYvS8vLPNn+oSlGqSqU97pMNmzMvNajgcj1WN3n5CI0XU0l0+FbJZMM4
         eNBcQLmvgLMZTid979PhY8m3D0rFRApbMm3yJn0brHChcbzuIx+UIeTHTliXNYektRhl
         YBsW76xxatAVmymz+xgS0bW6Rc7g6LO6arsx+SAhokjkkOIT06aV/HqJhg6errVdLZ6c
         fxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EME9vXPWQYeTzNMZe7eXduyu6mIuulBInrr92ndX+U8=;
        b=4WOrq6Dvsaixouh/SuZKghMLEIr8glxr8TyWjqBgChtQm6HpNNc3ClX3MuYMFYHSdZ
         SGFxyubiB8PxsCcYSOIgciJk02Y/MLZv1p/8U78ZzbDz8vC7zVyW3smP2nJ+iJEuNAhm
         1vQ0xwjGvBtMROWXfvjfvOrQYoOT1mKth2CGvLRYT/uH0tk+8qvGustXm/YGN6g9BAW9
         WsAPHtUtgrpO9YrBFkTjg0bhM2sUuf385wV/otgg2LX6r/UVIjn3YiIBHlBqu/1LrH/o
         BjmqfHmweHfaHPoctrf7fx4yZAGlyeGFDkWM93/ANqVQ3lSzTRKPkUOkIE5TdHTYW9Gp
         067g==
X-Gm-Message-State: AJIora+Y2sUg9yePaMPwIsIre5UmuUFVq1mQhBzoqx7YrirUOvInpTEN
        pN2h+i+syW6GexHjau+k+86QtEIMiAQ=
X-Google-Smtp-Source: AGRyM1sm/bEaB3QFIxwPPsKczsNbzHMD1VnF3VJCH9SSqmo8CrK+ZdgXfWx51d5Y9P6UiLenPl4n6g==
X-Received: by 2002:a17:90a:ba04:b0:1ee:e6b0:edff with SMTP id s4-20020a17090aba0400b001eee6b0edffmr6984226pjr.153.1657764288554;
        Wed, 13 Jul 2022 19:04:48 -0700 (PDT)
Received: from sol.home.arpa (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id i137-20020a62878f000000b0052542cbff9dsm230886pfe.99.2022.07.13.19.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 19:04:48 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org, dipenp@nvidia.com,
        andy.shevchenko@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 6/6] gpiolib: cdev: compile out HTE unless CONFIG_HTE selected
Date:   Thu, 14 Jul 2022 10:03:19 +0800
Message-Id: <20220714020319.72952-7-warthog618@gmail.com>
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

The majority of builds do not include HTE, so compile out hte
functionality unless CONFIG_HTE is selected.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 98 ++++++++++++++++++++++++-------------
 1 file changed, 63 insertions(+), 35 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 01c76aa00701..7e4670a286b2 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -468,9 +468,7 @@ struct line {
 	 * stale value.
 	 */
 	unsigned int level;
-	/*
-	 * -- hte specific fields --
-	 */
+#ifdef CONFIG_HTE
 	struct hte_ts_desc hdesc;
 	/*
 	 * HTE provider sets line level at the time of event. The valid
@@ -487,6 +485,7 @@ struct line {
 	 * last sequence number before debounce period expires.
 	 */
 	u32 last_seqno;
+#endif /* CONFIG_HTE */
 };
 
 /**
@@ -572,7 +571,8 @@ static u64 line_event_timestamp(struct line *line)
 {
 	if (test_bit(FLAG_EVENT_CLOCK_REALTIME, &line->desc->flags))
 		return ktime_get_real_ns();
-	else if (test_bit(FLAG_EVENT_CLOCK_HTE, &line->desc->flags))
+	else if (IS_ENABLED(CONFIG_HTE) &&
+		 test_bit(FLAG_EVENT_CLOCK_HTE, &line->desc->flags))
 		return line->timestamp_ns;
 
 	return ktime_get_ns();
@@ -584,6 +584,8 @@ static u32 line_event_id(int level)
 		       GPIO_V2_LINE_EVENT_FALLING_EDGE;
 }
 
+#ifdef CONFIG_HTE
+
 static enum hte_return process_hw_ts_thread(void *p)
 {
 	struct line *line;
@@ -667,6 +669,42 @@ static enum hte_return process_hw_ts(struct hte_ts_data *ts, void *p)
 	return HTE_CB_HANDLED;
 }
 
+static int hte_edge_setup(struct line *line, u64 eflags)
+{
+	int ret;
+	unsigned long flags = 0;
+	struct hte_ts_desc *hdesc = &line->hdesc;
+
+	if (eflags & GPIO_V2_LINE_FLAG_EDGE_RISING)
+		flags |= test_bit(FLAG_ACTIVE_LOW, &line->desc->flags) ?
+				 HTE_FALLING_EDGE_TS :
+				 HTE_RISING_EDGE_TS;
+	if (eflags & GPIO_V2_LINE_FLAG_EDGE_FALLING)
+		flags |= test_bit(FLAG_ACTIVE_LOW, &line->desc->flags) ?
+				 HTE_RISING_EDGE_TS :
+				 HTE_FALLING_EDGE_TS;
+
+	line->total_discard_seq = 0;
+
+	hte_init_line_attr(hdesc, desc_to_gpio(line->desc), flags, NULL,
+			   line->desc);
+
+	ret = hte_ts_get(NULL, hdesc, 0);
+	if (ret)
+		return ret;
+
+	return hte_request_ts_ns(hdesc, process_hw_ts, process_hw_ts_thread,
+				 line);
+}
+
+#else
+
+static int hte_edge_setup(struct line *line, u64 eflags)
+{
+	return 0;
+}
+#endif /* CONFIG_HTE */
+
 static irqreturn_t edge_irq_thread(int irq, void *p)
 {
 	struct line *line = p;
@@ -766,10 +804,13 @@ static void debounce_work_func(struct work_struct *work)
 	struct line *line = container_of(work, struct line, work.work);
 	struct linereq *lr;
 	u64 eflags, edflags = READ_ONCE(line->edflags);
-	int level = -1, diff_seqno;
+	int level = -1;
+#ifdef CONFIG_HTE
+	int diff_seqno;
 
 	if (edflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE)
 		level = line->raw_level;
+#endif
 	if (level < 0)
 		level = gpiod_get_raw_value_cansleep(line->desc);
 	if (level < 0) {
@@ -802,6 +843,7 @@ static void debounce_work_func(struct work_struct *work)
 	lr = line->req;
 	le.timestamp_ns = line_event_timestamp(line);
 	le.offset = gpio_chip_hwgpio(line->desc);
+#ifdef CONFIG_HTE
 	if (edflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE) {
 		/* discard events except the last one */
 		line->total_discard_seq -= 1;
@@ -811,7 +853,9 @@ static void debounce_work_func(struct work_struct *work)
 		le.line_seqno = line->line_seqno;
 		le.seqno = (lr->num_lines == 1) ?
 			le.line_seqno : atomic_add_return(diff_seqno, &lr->seqno);
-	} else {
+	} else
+#endif /* CONFIG_HTE */
+	{
 		line->line_seqno++;
 		le.line_seqno = line->line_seqno;
 		le.seqno = (lr->num_lines == 1) ?
@@ -823,32 +867,6 @@ static void debounce_work_func(struct work_struct *work)
 	linereq_put_event(lr, &le);
 }
 
-static int hte_edge_setup(struct line *line, u64 eflags)
-{
-	int ret;
-	unsigned long flags = 0;
-	struct hte_ts_desc *hdesc = &line->hdesc;
-
-	if (eflags & GPIO_V2_LINE_FLAG_EDGE_RISING)
-		flags |= test_bit(FLAG_ACTIVE_LOW, &line->desc->flags) ?
-				  HTE_FALLING_EDGE_TS : HTE_RISING_EDGE_TS;
-	if (eflags & GPIO_V2_LINE_FLAG_EDGE_FALLING)
-		flags |= test_bit(FLAG_ACTIVE_LOW, &line->desc->flags) ?
-				  HTE_RISING_EDGE_TS : HTE_FALLING_EDGE_TS;
-
-	line->total_discard_seq = 0;
-
-	hte_init_line_attr(hdesc, desc_to_gpio(line->desc), flags,
-			   NULL, line->desc);
-
-	ret = hte_ts_get(NULL, hdesc, 0);
-	if (ret)
-		return ret;
-
-	return hte_request_ts_ns(hdesc, process_hw_ts,
-				 process_hw_ts_thread, line);
-}
-
 static int debounce_setup(struct line *line, unsigned int debounce_period_us)
 {
 	unsigned long irqflags;
@@ -869,7 +887,8 @@ static int debounce_setup(struct line *line, unsigned int debounce_period_us)
 		if (level < 0)
 			return level;
 
-		if (!test_bit(FLAG_EVENT_CLOCK_HTE, &line->desc->flags)) {
+		if (!(IS_ENABLED(CONFIG_HTE) &&
+		      test_bit(FLAG_EVENT_CLOCK_HTE, &line->desc->flags))) {
 			irq = gpiod_to_irq(line->desc);
 			if (irq < 0)
 				return -ENXIO;
@@ -927,8 +946,10 @@ static void edge_detector_stop(struct line *line)
 		line->irq = 0;
 	}
 
+#ifdef CONFIG_HTE
 	if (READ_ONCE(line->edflags) & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE)
 		hte_ts_put(&line->hdesc);
+#endif
 
 	cancel_delayed_work_sync(&line->work);
 	WRITE_ONCE(line->sw_debounced, 0);
@@ -966,7 +987,8 @@ static int edge_detector_setup(struct line *line,
 	if (!eflags || READ_ONCE(line->sw_debounced))
 		return 0;
 
-	if (edflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE)
+	if (IS_ENABLED(CONFIG_HTE) &&
+	    (edflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE))
 		return hte_edge_setup(line, edflags);
 
 	irq = gpiod_to_irq(line->desc);
@@ -1051,6 +1073,11 @@ static int gpio_v2_line_flags_validate(u64 flags)
 	/* Return an error if an unknown flag is set */
 	if (flags & ~GPIO_V2_LINE_VALID_FLAGS)
 		return -EINVAL;
+
+	if (!IS_ENABLED(CONFIG_HTE) &&
+	    (flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE))
+		return -EOPNOTSUPP;
+
 	/*
 	 * Do not allow both INPUT and OUTPUT flags to be set as they are
 	 * contradictory.
@@ -1060,7 +1087,8 @@ static int gpio_v2_line_flags_validate(u64 flags)
 		return -EINVAL;
 
 	/* Only allow one event clock source */
-	if ((flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME) &&
+	if (IS_ENABLED(CONFIG_HTE) &&
+	    (flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME) &&
 	    (flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE))
 		return -EINVAL;
 
-- 
2.37.1

