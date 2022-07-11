Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2655357053F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiGKOSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKOSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:18:06 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631FD5FAD1;
        Mon, 11 Jul 2022 07:18:05 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c13so4551415pla.6;
        Mon, 11 Jul 2022 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=voWEGFF3KA1IgeGevlbZtwzM22a66pKEyYkCo2Z4mHg=;
        b=jmIdWsTUwnSmas9w6Wbygx3XWVWnePOHR86nRpTMSaF+GcfjhgM0h8WA7dP1mMwjDr
         9UIz7H1FOkhin165XWv/D/aQZk8Lpw8nv4PehzfuZo07QZnuql6pG4IkuNT7yNT5R3cv
         a6+C1oOE1zT6CQW1/teAC+h8oeDxiCraf1T28tYJFFtx17cB0/T7UQ9om1CZsUhSSp1a
         /NPjLuxHyn2CFFjqhrTwLVkjy1264onD6vsqzWHK93R0uLx5q6baVVqkt+ODde0YEH54
         toEzhzH2p5DPl1s1bjdMvR1ETXG1lG3snfV2bdoD+du9KjbuPAv0DlwmxDgRr9MNGK8F
         V32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=voWEGFF3KA1IgeGevlbZtwzM22a66pKEyYkCo2Z4mHg=;
        b=WB4NndAdfdb7r/u9BPFTEn/uYVxM3IAsN1aZ3FPNcT91BnCodeHj6ToA9yfrqfIoPD
         S3BlqcQ0Px4GfblNs6nsu2+CnAUy2JrbJho9uvOgVlC2KaYvxaaXaMO5rleByjekUuEy
         oL5pU2xK9p8sYUFFTfeI30eNFkb1uvVLPJQrxiHNrvOicwZU8mL7gr1Vu4NBG2cVFjJA
         Lt80vUrSWQRTrMWDfLCMDqW+BldXxuUkuSkEtDrHgEVfbduqgqt/fBSFOcaRaB1PtaOy
         pASCr23gw9RpNqL6FKPbEpQSkAPM6YwKGBkXqoEHy0ozeuCVHSQJkVvq4UKsgtUCNfXh
         DVnQ==
X-Gm-Message-State: AJIora/Iw90nEYiSqkhP+FfCcFuAjTlhPT+YKcKy13u3uIE/gcXzkUvv
        jhPIWkre9hLxBKr4xHfRvfX2JLlm6Y+L7Y6g
X-Google-Smtp-Source: AGRyM1unencx6BMiBSpETxK3OBiNwIN8O6n/z4ZYThj84ioc03yLqTZNYssmTTZ+RhQu3/1KDWiIYQ==
X-Received: by 2002:a17:902:c102:b0:16b:e03a:40ff with SMTP id 2-20020a170902c10200b0016be03a40ffmr18899416pli.29.1657549084843;
        Mon, 11 Jul 2022 07:18:04 -0700 (PDT)
Received: from ArtixLinux.localdomain ([116.193.141.74])
        by smtp.gmail.com with ESMTPSA id z19-20020a170903409300b001675d843332sm4769751plc.63.2022.07.11.07.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 07:18:04 -0700 (PDT)
From:   Aakash Sen Sharma <aakashsensharma@gmail.com>
To:     brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aakash Sen Sharma <aakashsensharma@gmail.com>
Subject: [PATCH] gpio: 104-idi-48: unsigned to unsigned int cleanup
Date:   Mon, 11 Jul 2022 19:47:53 +0530
Message-Id: <20220711141753.32523-1-aakashsensharma@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Removing checkpatch warnings.
* No functional changes.

Signed-off-by: Aakash Sen Sharma <aakashsensharma@gmail.com>
---
 drivers/gpio/gpio-104-idi-48.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index 9521ece3ebef..c1e4c3629e17 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -51,23 +51,23 @@ struct idi_48_gpio {
 	unsigned char cos_enb;
 };
 
-static int idi_48_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
+static int idi_48_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 {
 	return GPIO_LINE_DIRECTION_IN;
 }
 
-static int idi_48_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+static int idi_48_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
 	return 0;
 }
 
-static int idi_48_gpio_get(struct gpio_chip *chip, unsigned offset)
+static int idi_48_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	unsigned i;
+	unsigned int i;
 	static const unsigned int register_offset[6] = { 0, 1, 2, 4, 5, 6 };
 	void __iomem *port_addr;
-	unsigned mask;
+	unsigned int mask;
 
 	for (i = 0; i < 48; i += 8)
 		if (offset < i + 8) {
@@ -112,10 +112,10 @@ static void idi_48_irq_mask(struct irq_data *data)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	const unsigned offset = irqd_to_hwirq(data);
-	unsigned i;
-	unsigned mask;
-	unsigned boundary;
+	const unsigned int offset = irqd_to_hwirq(data);
+	unsigned int i;
+	unsigned int mask;
+	unsigned int boundary;
 	unsigned long flags;
 
 	for (i = 0; i < 48; i += 8)
@@ -143,11 +143,11 @@ static void idi_48_irq_unmask(struct irq_data *data)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	const unsigned offset = irqd_to_hwirq(data);
-	unsigned i;
-	unsigned mask;
-	unsigned boundary;
-	unsigned prev_irq_mask;
+	const unsigned int offset = irqd_to_hwirq(data);
+	unsigned int i;
+	unsigned int mask;
+	unsigned int boundary;
+	unsigned int prev_irq_mask;
 	unsigned long flags;
 
 	for (i = 0; i < 48; i += 8)
@@ -172,7 +172,7 @@ static void idi_48_irq_unmask(struct irq_data *data)
 		}
 }
 
-static int idi_48_irq_set_type(struct irq_data *data, unsigned flow_type)
+static int idi_48_irq_set_type(struct irq_data *data, unsigned int flow_type)
 {
 	/* The only valid irq types are none and both-edges */
 	if (flow_type != IRQ_TYPE_NONE &&
-- 
2.37.0

