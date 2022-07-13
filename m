Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11812572AF5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 03:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbiGMBjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 21:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiGMBiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 21:38:54 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DE020BE5;
        Tue, 12 Jul 2022 18:38:44 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id j3so8973663pfb.6;
        Tue, 12 Jul 2022 18:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BT2seOJ8NGJEHRkn0iYy8m64vZXk01Yw+5iEObos+QA=;
        b=X/JRPACoyMRVIk+ssTUqdDIlu3ucKw8jJK8v2EEcsIEx37G5V/rkt/pU9FqsZw8ZNO
         L15Ogz1S+8X9tdKy2D7EAYSn+88Mlic9oheWxuEk7tRPr4y27m6HSKoWEpnx2wz9b4gB
         kAeb7ZwsPBl54+pXIBd/ALnm7jXrYF/COzIreWOYpEwsY6GgdDApGqqaONCIwe6p3C2E
         6G1kDycGeM8ME11DfIsZUKgpfbgoQZACQvIF8Ek408FyN7LTxwm22i52sAgk9eEV+mz0
         hlFx2+TzznjbwP0bznH+dtMzyBep+7E0Ty4Umq1ft6aWKU97oumOPW0ZEM0hxOYuSS2u
         NGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BT2seOJ8NGJEHRkn0iYy8m64vZXk01Yw+5iEObos+QA=;
        b=0uLf9/QyNoBD4rSry7X1EA4B3PqCIa3f4H6MPc9kkuG1aU0Yj/Nuqd25TgaGGTjSTi
         VRhQZbgImMCruzbgUCUinl84BHnZYLlBz8RbMXQh5G5yozBE9+vqGNyoR3IQc49qJZ0C
         6PZoKW4Xt9lzh90KqfenotTDLxnVE+EwK+kvHBG5Wre29e1q7v00JkPscqWkMmzQLMm6
         XiAn7MD3T5eX2ZtybDh0QmM43WNSYnQNOFMTwFFnIQJ86Lmayk5PcZCB8GSsfdB3PrgZ
         +2OrIjUvYWnywjs2sxb6C3GjINnqcfrjJSLzHwdOY/HC2+scaqGME4Y7MLBp+aD0FFTu
         ZSdw==
X-Gm-Message-State: AJIora9dO1hDla4YsRc/BH3gDZ79nFUMUglgavatsFRJ1q7CWviuaZhY
        IX9yMC3OauWZ1+ly/YND6U+Qvr4xVEY=
X-Google-Smtp-Source: AGRyM1sO9SMPSQyveDGD00Dbpc2C47IzF7ltzmHvyaNqRTTz5jOf9GKlpVWF3njfvnL0OzpOK2X48w==
X-Received: by 2002:a63:904b:0:b0:412:aea7:9e7a with SMTP id a72-20020a63904b000000b00412aea79e7amr897026pge.421.1657676323666;
        Tue, 12 Jul 2022 18:38:43 -0700 (PDT)
Received: from sol.home.arpa (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id ob2-20020a17090b390200b001ef76dbae28sm225879pjb.36.2022.07.12.18.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 18:38:43 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org, dipenp@nvidia.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 6/6] gpiolib: cdev: compile out HTE unless CONFIG_HTE selected
Date:   Wed, 13 Jul 2022 09:37:21 +0800
Message-Id: <20220713013721.68879-7-warthog618@gmail.com>
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

The majority of builds do not include HTE, so compile out hte
functionality unless CONFIG_HTE is selected.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 95 ++++++++++++++++++++++++-------------
 1 file changed, 63 insertions(+), 32 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 406b9e063374..7e7058141cd2 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -468,6 +468,7 @@ struct line {
 	 * stale value.
 	 */
 	unsigned int level;
+#ifdef CONFIG_HTE
 	/*
 	 * -- hte specific fields --
 	 */
@@ -487,6 +488,7 @@ struct line {
 	 * last sequence number before debounce period expires.
 	 */
 	u32 last_seqno;
+#endif /* CONFIG_HTE */
 };
 
 /**
@@ -572,12 +574,15 @@ static u64 line_event_timestamp(struct line *line)
 {
 	if (test_bit(FLAG_EVENT_CLOCK_REALTIME, &line->desc->flags))
 		return ktime_get_real_ns();
-	else if (test_bit(FLAG_EVENT_CLOCK_HTE, &line->desc->flags))
+	else if (IS_ENABLED(CONFIG_HTE) &&
+		 (test_bit(FLAG_EVENT_CLOCK_HTE, &line->desc->flags)))
 		return line->timestamp_ns;
 
 	return ktime_get_ns();
 }
 
+#ifdef CONFIG_HTE
+
 static enum hte_return process_hw_ts_thread(void *p)
 {
 	struct line *line;
@@ -662,6 +667,42 @@ static enum hte_return process_hw_ts(struct hte_ts_data *ts, void *p)
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
@@ -762,11 +803,14 @@ static void debounce_work_func(struct work_struct *work)
 	struct gpio_v2_line_event le;
 	struct line *line = container_of(work, struct line, work.work);
 	struct linereq *lr;
-	int level = -1, diff_seqno;
+	int level = -1;
 	u64 eflags, edflags = READ_ONCE(line->edflags);
+#ifdef CONFIG_HTE
+	int diff_seqno;
 
 	if (edflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE)
 		level = line->raw_level;
+#endif
 	if (level < 0)
 		level = gpiod_get_raw_value_cansleep(line->desc);
 	if (level < 0) {
@@ -799,6 +843,7 @@ static void debounce_work_func(struct work_struct *work)
 	lr = line->req;
 	le.timestamp_ns = line_event_timestamp(line);
 	le.offset = gpio_chip_hwgpio(line->desc);
+#ifdef CONFIG_HTE
 	if (edflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE) {
 		/* discard events except the last one */
 		line->total_discard_seq -= 1;
@@ -808,7 +853,9 @@ static void debounce_work_func(struct work_struct *work)
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
@@ -821,32 +868,6 @@ static void debounce_work_func(struct work_struct *work)
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
@@ -867,7 +888,8 @@ static int debounce_setup(struct line *line, unsigned int debounce_period_us)
 		if (level < 0)
 			return level;
 
-		if (!test_bit(FLAG_EVENT_CLOCK_HTE, &line->desc->flags)) {
+		if (!IS_ENABLED(CONFIG_HTE) ||
+		    !test_bit(FLAG_EVENT_CLOCK_HTE, &line->desc->flags)) {
 			irq = gpiod_to_irq(line->desc);
 			if (irq < 0)
 				return -ENXIO;
@@ -925,8 +947,10 @@ static void edge_detector_stop(struct line *line)
 		line->irq = 0;
 	}
 
+#ifdef CONFIG_HTE
 	if (READ_ONCE(line->edflags) & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE)
 		hte_ts_put(&line->hdesc);
+#endif
 
 	cancel_delayed_work_sync(&line->work);
 	WRITE_ONCE(line->sw_debounced, 0);
@@ -964,7 +988,8 @@ static int edge_detector_setup(struct line *line,
 	if (!eflags || READ_ONCE(line->sw_debounced))
 		return 0;
 
-	if (edflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE)
+	if (IS_ENABLED(CONFIG_HTE) &&
+	    (edflags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE))
 		return hte_edge_setup(line, edflags);
 
 	irq = gpiod_to_irq(line->desc);
@@ -1049,6 +1074,11 @@ static int gpio_v2_line_flags_validate(u64 flags)
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
@@ -1058,7 +1088,8 @@ static int gpio_v2_line_flags_validate(u64 flags)
 		return -EINVAL;
 
 	/* Only allow one event clock source */
-	if ((flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME) &&
+	if (IS_ENABLED(CONFIG_HTE) &&
+	    (flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME) &&
 	    (flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE))
 		return -EINVAL;
 
-- 
2.37.0

