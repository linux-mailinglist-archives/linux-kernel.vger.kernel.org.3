Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB5057413A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 04:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbiGNCEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 22:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbiGNCEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:04:39 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7154512097;
        Wed, 13 Jul 2022 19:04:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o15so1062566pjh.1;
        Wed, 13 Jul 2022 19:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s/A2rUGjZ27kRcqb1SuBn4bRrQieNLSXo1YSQitYVzo=;
        b=LzdDDcwiyR1LiDQVFPge+pJYdYiI5o4njO3Cil8sSuVCl9QsOqJnwvx1yfF4ZKXeuk
         BOh3AS0vFAIbGd8TJ/gVHshlMFfJbN6T+PYSEABcbbeF1RMVyHMF0Shx23/LXi7CtcQT
         skkFDjgN308UdgoHOARlG8w7FI7PFFw6TvLoMq1BuqERs70ZuuygziPTctWOHHlXfiEI
         +KCI6gS4W2QRQ+u55xC2geazRUCiCMtMS98TYXPB23D/wYtZwrVOdf9JYafqyhK10AWp
         l+iNHfGMad/ArqU4ffP2JCOxDLi9wKIgtqWzFkR2Uv6Mot0tLfrU1YqWSDN4qALGKoCu
         7r3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s/A2rUGjZ27kRcqb1SuBn4bRrQieNLSXo1YSQitYVzo=;
        b=CouuKSC9/kpfIeEE3r/FUYyAjOKnjpemobs6hHH5o0rb/QODJ0wOocjXOf6zgiBxwN
         Hwhm1pnWei88Z3pOjFxBB5qR2I2CcgePwm2Gv7YsXhhm//uKhv+H+Xf3pkokGAPT3EUW
         BWJp7mRpOW3Nvvm6awCaCQcLkY7XB8lnG9leel/A4eYH7Oc+1CU+ckEm5K8EH6z99h3D
         5hcmUrHsss1aWZBDcVraHXnBuTZinTY/0tG0OjjmSEC/GW382hEbAxBvk9yrIygegFeu
         E/UaurgroZzPfpMtUKkNSf8wyT1m3P4yvxQIXNUTAGh22vnxRlaU7+Na00tqqI+L1ivA
         x1jw==
X-Gm-Message-State: AJIora9maKORnuC2DYLYlC88IbxZcBGvEZR6S1Sku4KuX1q44c2HhBZn
        n8N0sx4qpViagNi6FK5KzjcJOwkjXPE=
X-Google-Smtp-Source: AGRyM1tBbXEt2BLdMiExa+3lTDM8lryH9g9Bq8e/UzIKRqk8l8K7bQDLjdwJWG0sT7IP7/9fPi5glg==
X-Received: by 2002:a17:902:a9c6:b0:16c:9d5a:fde1 with SMTP id b6-20020a170902a9c600b0016c9d5afde1mr3012853plr.3.1657764276535;
        Wed, 13 Jul 2022 19:04:36 -0700 (PDT)
Received: from sol.home.arpa (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id i137-20020a62878f000000b0052542cbff9dsm230886pfe.99.2022.07.13.19.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 19:04:36 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org, dipenp@nvidia.com,
        andy.shevchenko@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 5/6] gpiolib: cdev: consolidate edge detector configuration flags
Date:   Thu, 14 Jul 2022 10:03:18 +0800
Message-Id: <20220714020319.72952-6-warthog618@gmail.com>
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

Combine the polarity_change flag, struct line eflags, and hte enable
flag into a single flag variable.

The combination of these flags describes the configuration state
of the edge detector, so formalize and clarify that by combining
them into a single variable, edflags, in struct line.

The edflags is a subset of the GPIO_V2_LINE_FLAGsb relevant to
the edge detector, and is also a superset of the eflags it replaces.
The eflags name is still used to describe the subset of edflags
corresponding to the rising/falling edge flags where edflags is
masked down to that subset.

This consolidation reduces the number of variables being passed,
simplifies state comparisons, and provides a more extensible
foundation should additional edge sources be integrated in the
future.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 126 +++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 66 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 5765379f4b54..01c76aa00701 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -430,12 +430,15 @@ struct line {
 	struct linereq *req;
 	unsigned int irq;
 	/*
-	 * eflags is set by edge_detector_setup(), edge_detector_stop() and
-	 * edge_detector_update(), which are themselves mutually exclusive,
-	 * and is accessed by edge_irq_thread() and debounce_work_func(),
-	 * which can both live with a slightly stale value.
+	 * The flags for the active edge detector configuration.
+	 *
+	 * edflags is set by linereq_create(), linereq_free(), and
+	 * linereq_set_config_unlocked(), which are themselves mutually
+	 * exclusive, and is accessed by edge_irq_thread(),
+	 * process_hw_ts_thread() and debounce_work_func(),
+	 * which can all live with a slightly stale value.
 	 */
-	u64 eflags;
+	u64 edflags;
 	/*
 	 * timestamp_ns and req_seqno are accessed only by
 	 * edge_irq_handler() and edge_irq_thread(), which are themselves
@@ -541,6 +544,12 @@ struct linereq {
 	 GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE | \
 	 GPIO_V2_LINE_BIAS_FLAGS)
 
+/* subset of flags relevant for edge detector configuration */
+#define GPIO_V2_LINE_EDGE_DETECTOR_FLAGS \
+	(GPIO_V2_LINE_FLAG_ACTIVE_LOW | \
+	 GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE | \
+	 GPIO_V2_LINE_EDGE_FLAGS)
+
 static void linereq_put_event(struct linereq *lr,
 			      struct gpio_v2_line_event *le)
 {
@@ -580,8 +589,8 @@ static enum hte_return process_hw_ts_thread(void *p)
 	struct line *line;
 	struct linereq *lr;
 	struct gpio_v2_line_event le;
+	u64 edflags;
 	int level;
-	u64 eflags;
 
 	if (!p)
 		return HTE_CB_HANDLED;
@@ -592,15 +601,15 @@ static enum hte_return process_hw_ts_thread(void *p)
 	memset(&le, 0, sizeof(le));
 
 	le.timestamp_ns = line->timestamp_ns;
-	eflags = READ_ONCE(line->eflags);
+	edflags = READ_ONCE(line->edflags);
 
-	switch (eflags) {
+	switch (edflags & GPIO_V2_LINE_EDGE_FLAGS) {
 	case GPIO_V2_LINE_FLAG_EDGE_BOTH:
 		level = (line->raw_level >= 0) ?
 				line->raw_level :
 				gpiod_get_raw_value_cansleep(line->desc);
 
-		if (test_bit(FLAG_ACTIVE_LOW, &line->desc->flags))
+		if (edflags & GPIO_V2_LINE_FLAG_ACTIVE_LOW)
 			level = !level;
 
 		le.id = line_event_id(level);
@@ -681,7 +690,7 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
 	}
 	line->timestamp_ns = 0;
 
-	switch (READ_ONCE(line->eflags)) {
+	switch (READ_ONCE(line->edflags) & GPIO_V2_LINE_EDGE_FLAGS) {
 	case GPIO_V2_LINE_FLAG_EDGE_BOTH:
 		le.id = line_event_id(gpiod_get_value_cansleep(line->desc));
 		break;
@@ -756,16 +765,13 @@ static void debounce_work_func(struct work_struct *work)
 	struct gpio_v2_line_event le;
 	struct line *line = container_of(work, struct line, work.work);
 	struct linereq *lr;
-	int level, diff_seqno;
-	u64 eflags;
+	u64 eflags, edflags = READ_ONCE(line->edflags);
+	int level = -1, diff_seqno;
 
-	if (test_bit(FLAG_EVENT_CLOCK_HTE, &line->desc->flags)) {
+	if (edflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE)
 		level = line->raw_level;
-		if (level < 0)
-			level = gpiod_get_raw_value_cansleep(line->desc);
-	} else {
+	if (level < 0)
 		level = gpiod_get_raw_value_cansleep(line->desc);
-	}
 	if (level < 0) {
 		pr_debug_ratelimited("debouncer failed to read line value\n");
 		return;
@@ -777,12 +783,12 @@ static void debounce_work_func(struct work_struct *work)
 	WRITE_ONCE(line->level, level);
 
 	/* -- edge detection -- */
-	eflags = READ_ONCE(line->eflags);
+	eflags = edflags & GPIO_V2_LINE_EDGE_FLAGS;
 	if (!eflags)
 		return;
 
 	/* switch from physical level to logical - if they differ */
-	if (test_bit(FLAG_ACTIVE_LOW, &line->desc->flags))
+	if (edflags & GPIO_V2_LINE_FLAG_ACTIVE_LOW)
 		level = !level;
 
 	/* ignore edges that are not being monitored */
@@ -796,7 +802,7 @@ static void debounce_work_func(struct work_struct *work)
 	lr = line->req;
 	le.timestamp_ns = line_event_timestamp(line);
 	le.offset = gpio_chip_hwgpio(line->desc);
-	if (test_bit(FLAG_EVENT_CLOCK_HTE, &line->desc->flags)) {
+	if (edflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE) {
 		/* discard events except the last one */
 		line->total_discard_seq -= 1;
 		diff_seqno = line->last_seqno - line->total_discard_seq -
@@ -843,8 +849,7 @@ static int hte_edge_setup(struct line *line, u64 eflags)
 				 process_hw_ts_thread, line);
 }
 
-static int debounce_setup(struct line *line,
-			  unsigned int debounce_period_us, bool hte_req)
+static int debounce_setup(struct line *line, unsigned int debounce_period_us)
 {
 	unsigned long irqflags;
 	int ret, level, irq;
@@ -864,7 +869,7 @@ static int debounce_setup(struct line *line,
 		if (level < 0)
 			return level;
 
-		if (!hte_req) {
+		if (!test_bit(FLAG_EVENT_CLOCK_HTE, &line->desc->flags)) {
 			irq = gpiod_to_irq(line->desc);
 			if (irq < 0)
 				return -ENXIO;
@@ -915,19 +920,19 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
 	return 0;
 }
 
-static void edge_detector_stop(struct line *line, bool hte_en)
+static void edge_detector_stop(struct line *line)
 {
-	if (line->irq && !hte_en) {
+	if (line->irq) {
 		free_irq(line->irq, line);
 		line->irq = 0;
 	}
 
-	if (hte_en)
+	if (READ_ONCE(line->edflags) & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE)
 		hte_ts_put(&line->hdesc);
 
 	cancel_delayed_work_sync(&line->work);
 	WRITE_ONCE(line->sw_debounced, 0);
-	WRITE_ONCE(line->eflags, 0);
+	WRITE_ONCE(line->edflags, 0);
 	if (line->desc)
 		WRITE_ONCE(line->desc->debounce_period_us, 0);
 	/* do not change line->level - see comment in debounced_value() */
@@ -935,23 +940,23 @@ static void edge_detector_stop(struct line *line, bool hte_en)
 
 static int edge_detector_setup(struct line *line,
 			       struct gpio_v2_line_config *lc,
-			       unsigned int line_idx,
-			       u64 eflags, bool hte_req)
+			       unsigned int line_idx, u64 edflags)
 {
 	u32 debounce_period_us;
 	unsigned long irqflags = 0;
+	u64 eflags;
 	int irq, ret;
 
+	eflags = edflags & GPIO_V2_LINE_EDGE_FLAGS;
 	if (eflags && !kfifo_initialized(&line->req->events)) {
 		ret = kfifo_alloc(&line->req->events,
 				  line->req->event_buffer_size, GFP_KERNEL);
 		if (ret)
 			return ret;
 	}
-	WRITE_ONCE(line->eflags, eflags);
 	if (gpio_v2_line_config_debounced(lc, line_idx)) {
 		debounce_period_us = gpio_v2_line_config_debounce_period(lc, line_idx);
-		ret = debounce_setup(line, debounce_period_us, hte_req);
+		ret = debounce_setup(line, debounce_period_us);
 		if (ret)
 			return ret;
 		WRITE_ONCE(line->desc->debounce_period_us, debounce_period_us);
@@ -961,8 +966,8 @@ static int edge_detector_setup(struct line *line,
 	if (!eflags || READ_ONCE(line->sw_debounced))
 		return 0;
 
-	if (hte_req)
-		return hte_edge_setup(line, eflags);
+	if (edflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE)
+		return hte_edge_setup(line, edflags);
 
 	irq = gpiod_to_irq(line->desc);
 	if (irq < 0)
@@ -988,35 +993,29 @@ static int edge_detector_setup(struct line *line,
 
 static int edge_detector_update(struct line *line,
 				struct gpio_v2_line_config *lc,
-				unsigned int line_idx,
-				u64 flags, bool polarity_change,
-				bool prev_hte_flag)
+				unsigned int line_idx, u64 edflags)
 {
-	u64 eflags = flags & GPIO_V2_LINE_EDGE_FLAGS;
+	u64 active_edflags = READ_ONCE(line->edflags);
 	unsigned int debounce_period_us =
 			gpio_v2_line_config_debounce_period(lc, line_idx);
-	bool hte_change = (prev_hte_flag !=
-		      ((flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE) != 0));
 
-	if ((READ_ONCE(line->eflags) == eflags) && !polarity_change &&
-	    (READ_ONCE(line->desc->debounce_period_us) == debounce_period_us)
-	    && !hte_change)
+	if ((active_edflags == edflags) &&
+	    (READ_ONCE(line->desc->debounce_period_us) == debounce_period_us))
 		return 0;
 
 	/* sw debounced and still will be...*/
 	if (debounce_period_us && READ_ONCE(line->sw_debounced)) {
-		WRITE_ONCE(line->eflags, eflags);
 		WRITE_ONCE(line->desc->debounce_period_us, debounce_period_us);
 		return 0;
 	}
 
 	/* reconfiguring edge detection or sw debounce being disabled */
-	if ((line->irq && !READ_ONCE(line->sw_debounced)) || prev_hte_flag ||
+	if ((line->irq && !READ_ONCE(line->sw_debounced)) ||
+	    (active_edflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE) ||
 	    (!debounce_period_us && READ_ONCE(line->sw_debounced)))
-		edge_detector_stop(line, prev_hte_flag);
+		edge_detector_stop(line);
 
-	return edge_detector_setup(line, lc, line_idx, eflags,
-				   flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE);
+	return edge_detector_setup(line, lc, line_idx, edflags);
 }
 
 static u64 gpio_v2_line_config_flags(struct gpio_v2_line_config *lc,
@@ -1285,22 +1284,17 @@ static long linereq_set_config_unlocked(struct linereq *lr,
 					struct gpio_v2_line_config *lc)
 {
 	struct gpio_desc *desc;
+	struct line *line;
 	unsigned int i;
-	u64 flags;
-	bool polarity_change;
-	bool prev_hte_flag;
+	u64 flags, edflags;
 	int ret;
 
 	for (i = 0; i < lr->num_lines; i++) {
+		line = &lr->lines[i];
 		desc = lr->lines[i].desc;
 		flags = gpio_v2_line_config_flags(lc, i);
-		polarity_change =
-			(!!test_bit(FLAG_ACTIVE_LOW, &desc->flags) !=
-			 ((flags & GPIO_V2_LINE_FLAG_ACTIVE_LOW) != 0));
-
-		prev_hte_flag = !!test_bit(FLAG_EVENT_CLOCK_HTE, &desc->flags);
-
 		gpio_v2_line_config_flags_to_desc_flags(flags, &desc->flags);
+		edflags = flags & GPIO_V2_LINE_EDGE_DETECTOR_FLAGS;
 		/*
 		 * Lines have to be requested explicitly for input
 		 * or output, else the line will be treated "as is".
@@ -1308,7 +1302,7 @@ static long linereq_set_config_unlocked(struct linereq *lr,
 		if (flags & GPIO_V2_LINE_FLAG_OUTPUT) {
 			int val = gpio_v2_line_config_output_value(lc, i);
 
-			edge_detector_stop(&lr->lines[i], prev_hte_flag);
+			edge_detector_stop(line);
 			ret = gpiod_direction_output(desc, val);
 			if (ret)
 				return ret;
@@ -1317,12 +1311,13 @@ static long linereq_set_config_unlocked(struct linereq *lr,
 			if (ret)
 				return ret;
 
-			ret = edge_detector_update(&lr->lines[i], lc, i,
-					flags, polarity_change, prev_hte_flag);
+			ret = edge_detector_update(line, lc, i, edflags);
 			if (ret)
 				return ret;
 		}
 
+		WRITE_ONCE(line->edflags, edflags);
+
 		blocking_notifier_call_chain(&desc->gdev->notifier,
 					     GPIO_V2_LINE_CHANGED_CONFIG,
 					     desc);
@@ -1449,13 +1444,10 @@ static ssize_t linereq_read(struct file *file,
 static void linereq_free(struct linereq *lr)
 {
 	unsigned int i;
-	bool hte;
 
 	for (i = 0; i < lr->num_lines; i++) {
 		if (lr->lines[i].desc) {
-			hte = !!test_bit(FLAG_EVENT_CLOCK_HTE,
-					 &lr->lines[i].desc->flags);
-			edge_detector_stop(&lr->lines[i], hte);
+			edge_detector_stop(&lr->lines[i]);
 			gpiod_free(lr->lines[i].desc);
 		}
 	}
@@ -1491,7 +1483,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 	struct gpio_v2_line_config *lc;
 	struct linereq *lr;
 	struct file *file;
-	u64 flags;
+	u64 flags, edflags;
 	unsigned int i;
 	int fd, ret;
 
@@ -1565,6 +1557,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 		if (ret < 0)
 			goto out_free_linereq;
 
+		edflags = flags & GPIO_V2_LINE_EDGE_DETECTOR_FLAGS;
 		/*
 		 * Lines have to be requested explicitly for input
 		 * or output, else the line will be treated "as is".
@@ -1581,12 +1574,13 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 				goto out_free_linereq;
 
 			ret = edge_detector_setup(&lr->lines[i], lc, i,
-				flags & GPIO_V2_LINE_EDGE_FLAGS,
-				flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE);
+						  edflags);
 			if (ret)
 				goto out_free_linereq;
 		}
 
+		lr->lines[i].edflags = edflags;
+
 		blocking_notifier_call_chain(&desc->gdev->notifier,
 					     GPIO_V2_LINE_CHANGED_REQUESTED, desc);
 
-- 
2.37.1

