Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CDE572AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 03:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiGMBia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 21:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbiGMBiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 21:38:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEA5D2168;
        Tue, 12 Jul 2022 18:38:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s21so9900376pjq.4;
        Tue, 12 Jul 2022 18:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NfBBUzeyZ9gfiKjWRByf+PfpanO2f7BWflurV2e1pq4=;
        b=AAHSnmWw2z/yn/NhvFbfTMKjOMi5Z5yQzpYx6lK5dBLdgU0L1OJyElbXD1f4VgRwNc
         DguDVMw0TOxnQMJYJLMJc0+iimbPstJ9JPho3nAZMh5uOyRjNcQaVI9+qv0jqm8BPpJG
         ZYbzs3zMvGHOlmz1GVrDin/4j7GZjZr1BkH0CPyhqWX+PlPKbvijnaL6PYy4IuiOXBfy
         W2x4HsUist/qEovNTuTjdwgYG3O84sE8XGksRtCKjOKxOemtuLGotS2HCVV0nhhbw+sZ
         Uuc5G7tzj4abzZ+jj3GPzVuRjrwagpfY+PZ0KPZujzHAyiQUZNoYGMTW1XvuJog9cnx4
         m4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NfBBUzeyZ9gfiKjWRByf+PfpanO2f7BWflurV2e1pq4=;
        b=k0XinYq31i4MTGH5Qvz1cCgW7jASRtvRnrF3W5QiF1aoIHYXhb3sGqHpOT54T/fy+H
         Zjaboe2mD9vFeLdFm9PqW8iRTOPpQ7z/2njeaZjQv/PG5eyyhmg2aPV/ilqC73uAA4yA
         rXMgf8iQw2iBJ39IHH16QP1KSGIz6wYXZv5mvbzX9iV978ruB8hSFTI0oNG4p3G0phzc
         YqKnFFKX+phF3/Q3LimXa011T8pSe68ndDhqGG+axSM67IMwwakhCHuGRRxgdy9UD4Ej
         NLls3vRegA10Pk9TdeSaX2FHBVHb92rjvjBD3XtiF8r9xF0uPibImvbjgBh5Dxe0MjSE
         fMNg==
X-Gm-Message-State: AJIora8CLCl5Q7k3V8iT4wmznBTRO3AY5pwbyLXqksNR2M1PrAlw9tsj
        biOBbRPTMwpclftzfsUpiCqRWYE0q3g=
X-Google-Smtp-Source: AGRyM1tcIS5kujmiNv8Ng+x02QX46ZMvrBofTU8PxuAxKQQBJ19NNzXAF+iHP21hWaLAMOP5EKj83g==
X-Received: by 2002:a17:902:bf01:b0:16b:e24e:1d2f with SMTP id bi1-20020a170902bf0100b0016be24e1d2fmr890413plb.46.1657676289851;
        Tue, 12 Jul 2022 18:38:09 -0700 (PDT)
Received: from sol.home.arpa (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id ob2-20020a17090b390200b001ef76dbae28sm225879pjb.36.2022.07.12.18.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 18:38:09 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org, dipenp@nvidia.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 3/6] gpiolib: cdev: replace if-else chains with switches
Date:   Wed, 13 Jul 2022 09:37:18 +0800
Message-Id: <20220713013721.68879-4-warthog618@gmail.com>
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

Improve readability by replacing if-else chains with switch
statements.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index f635bbbb6a6d..bc7c8822ede0 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -588,7 +588,8 @@ static enum hte_return process_hw_ts_thread(void *p)
 	le.timestamp_ns = line->timestamp_ns;
 	eflags = READ_ONCE(line->eflags);
 
-	if (eflags == GPIO_V2_LINE_FLAG_EDGE_BOTH) {
+	switch (eflags) {
+	case GPIO_V2_LINE_FLAG_EDGE_BOTH:
 		if (line->raw_level >= 0) {
 			if (test_bit(FLAG_ACTIVE_LOW, &line->desc->flags))
 				level = !line->raw_level;
@@ -602,13 +603,16 @@ static enum hte_return process_hw_ts_thread(void *p)
 			le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
 		else
 			le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
-	} else if (eflags == GPIO_V2_LINE_FLAG_EDGE_RISING) {
+		break;
+	case GPIO_V2_LINE_FLAG_EDGE_RISING:
 		/* Emit low-to-high event */
 		le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
-	} else if (eflags == GPIO_V2_LINE_FLAG_EDGE_FALLING) {
+		break;
+	case GPIO_V2_LINE_FLAG_EDGE_FALLING:
 		/* Emit high-to-low event */
 		le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
-	} else {
+		break;
+	default:
 		return HTE_CB_HANDLED;
 	}
 	le.line_seqno = line->line_seqno;
@@ -660,7 +664,6 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
 	struct line *line = p;
 	struct linereq *lr = line->req;
 	struct gpio_v2_line_event le;
-	u64 eflags;
 
 	/* Do not leak kernel stack to userspace */
 	memset(&le, 0, sizeof(le));
@@ -679,23 +682,25 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
 	}
 	line->timestamp_ns = 0;
 
-	eflags = READ_ONCE(line->eflags);
-	if (eflags == GPIO_V2_LINE_FLAG_EDGE_BOTH) {
-		int level = gpiod_get_value_cansleep(line->desc);
-
-		if (level)
+	switch (READ_ONCE(line->eflags)) {
+	case GPIO_V2_LINE_FLAG_EDGE_BOTH:
+		if (gpiod_get_value_cansleep(line->desc))
 			/* Emit low-to-high event */
 			le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
 		else
 			/* Emit high-to-low event */
 			le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
-	} else if (eflags == GPIO_V2_LINE_FLAG_EDGE_RISING) {
+
+		break;
+	case GPIO_V2_LINE_FLAG_EDGE_RISING:
 		/* Emit low-to-high event */
 		le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
-	} else if (eflags == GPIO_V2_LINE_FLAG_EDGE_FALLING) {
+		break;
+	case GPIO_V2_LINE_FLAG_EDGE_FALLING:
 		/* Emit high-to-low event */
 		le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
-	} else {
+		break;
+	default:
 		return IRQ_NONE;
 	}
 	line->line_seqno++;
-- 
2.37.0

