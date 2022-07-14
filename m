Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4451D574137
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 04:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiGNCEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 22:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiGNCEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:04:13 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5779E0A8;
        Wed, 13 Jul 2022 19:04:12 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so6668938pjl.5;
        Wed, 13 Jul 2022 19:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wLG7qONxGWqm1koSH97LcjS1OgSZWdUrxomvK43Ws4o=;
        b=D93tsJCNyPzdHYHGAgUbmnzacKL3jzpSNKcfKBiBhWFPfWjTKS+qutPABJ62/w6YIJ
         GXzdO+5EiHBJYdBGt1neYfFH2IKIcTDIep4G2hJpBm8jhIb1+In7siIeLk6kAVurGx98
         aFhsCP68n/VQtQ5yR0TIxk61kusTKgsd8o+PESdHt1YqvIULieXlDcht56MwDpVevqA5
         Q2/oX3S63icHpZYRxk/fWcf03YTOVtG+YsH8czvC9HeVLoELorUSDzqem7IDUX/gEeoe
         LwMU0AyUAVJ+XN/4gFCvSnlXcdOUvfT3un+YJIkQF4uzA8nkfuaAZGPYW9yXTUZb6JFL
         6NzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wLG7qONxGWqm1koSH97LcjS1OgSZWdUrxomvK43Ws4o=;
        b=h1AZFYEIoHkJJBAwOfz97oov/Y2SnxRrMuj8iHWHdSCKhuAg9STZq/BRHVD6eQ2ctM
         a7mKG/zbwFepBnLV9toPXxUPDo6xlwp8/hxhDua2IuLTFA5MTNPnjDe7cZWxnP57LF28
         k5jZp/dQCIHCMYMRknMqKq/Wa4nLOsHlqeTHxavRryjHQhv32yt9I4VMN9E3fbB18ffk
         pIjOR++rCNWRWnLFUIeyFpRLyfjMcuIodgIL3QGrfk/xqCFzP7lEmysS5oBfix1E+M50
         WlYJ6FgjScDRdxjYoqYw70bkzUfMIxORJLk8pj1XS4ZOwbtaFkqN7GprFWSaYVn7uLjO
         0EqA==
X-Gm-Message-State: AJIora92E59mnDLu+eS8meGiivovJ3fo5GU5/Q+4yA45BqPKPsWAN+hW
        Ord4kCym+LFxBkoStj2jveQQV8EU3tE=
X-Google-Smtp-Source: AGRyM1vFXa9IEgX/I7Uedhpap1MQhnBw9hy7S2Xzs+Q/t9SUffnwydT2DFM8A1WwQTDDFwnW48Wrsw==
X-Received: by 2002:a17:902:7807:b0:16b:e3d5:b2ce with SMTP id p7-20020a170902780700b0016be3d5b2cemr5923801pll.18.1657764251841;
        Wed, 13 Jul 2022 19:04:11 -0700 (PDT)
Received: from sol.home.arpa (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id i137-20020a62878f000000b0052542cbff9dsm230886pfe.99.2022.07.13.19.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 19:04:11 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org, dipenp@nvidia.com,
        andy.shevchenko@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 3/6] gpiolib: cdev: replace if-else chains with switches
Date:   Thu, 14 Jul 2022 10:03:16 +0800
Message-Id: <20220714020319.72952-4-warthog618@gmail.com>
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

Improve readability by replacing if-else chains with switch
statements.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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
2.37.1

