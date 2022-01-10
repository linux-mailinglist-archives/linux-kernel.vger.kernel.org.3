Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6400A48A264
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345191AbiAJWFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345138AbiAJWFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:05:25 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9EDC06173F;
        Mon, 10 Jan 2022 14:05:25 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a18so58335795edj.7;
        Mon, 10 Jan 2022 14:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2KNDSTMgmpn78jXPNcdZdc248EGwYEv2Gjal4+4tRhw=;
        b=RiFStyDM5Pp8ZqOKMAsRLRlEn/FLc4LxH7nUjUHXMSug5CXO0SseBSimR7JTeQ0oP3
         GDm+dKtb4/F3GXYBMmW+yix9J6zPp+ICpKg3cskyUYWepIkbn9oQuYE8R+/B+dKyOZw8
         QRXY4w0rB/6ZBwUh8u0H8iJv8AXw79QBVBMn45Zd17bfWpzlonPizIdbIIyFXO4x37cM
         BQKAKT1xC5dxxzP1EUMW7prgFJ3TUJupyJJMYmQzjwGdLYPZfXHLxr2Z5kRxHDw2za5M
         ZwIiAE0Xc4BtoQGQGkD55K9195F+V99LDjjZeiAEG33Ultcx6aEXvLgc8QKL9l/Wc+B3
         92rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2KNDSTMgmpn78jXPNcdZdc248EGwYEv2Gjal4+4tRhw=;
        b=CEzftobPDNUQj6TSkAbRhlNrStnt5e1+lRi8QoRiJp/MgYU1hthwTQzLCaUZG0wAVc
         gK+kqJ8sCsAsIIqn8LLBISJdUEmLSuTWwtGPO2pfYuCJiE8QRB5NCqwsjiyclnfheUdx
         qR7JMt42o9zc/ywV6fVKauBIhbd+Wpmj4nMY9HL2XFUw32DSc32k1FD1f/jlZjYaAMoL
         TDbT1vh5jT7sq2+EmoZrX6I/icCr5+m/qbSE/J305sbAjWkSlo5Sh0K3O2RRJ6clbNJF
         u2MTzDsnP5hVKEFaCV2VCGhtPB9tRHXVBjnxlo04TrznTxpGrORHJDZSt+tva+OmVIBp
         Sknw==
X-Gm-Message-State: AOAM5314rBeRZMQH47Dt4NcjPb2AiKztuEWy+WzWaYLLwNBkagjQoYN4
        hlpkMJKCZ7CUQwVspErhFyo=
X-Google-Smtp-Source: ABdhPJwFaNr3YbubWwEFcP1bli+hmQ0u9SBToTufY4zEEmBjEMZPwN1nzD7musj0eO+J568M/l0j5A==
X-Received: by 2002:a17:906:69d2:: with SMTP id g18mr1363345ejs.197.1641852323764;
        Mon, 10 Jan 2022 14:05:23 -0800 (PST)
Received: from demon-pc.localdomain ([79.119.107.253])
        by smtp.gmail.com with ESMTPSA id q21sm2842672ejn.107.2022.01.10.14.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 14:05:23 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
To:     andy.shevchenko@gmail.com
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH v2 1/3] iio: addac: ad74413r: use ngpio size when iterating over mask
Date:   Tue, 11 Jan 2022 00:05:07 +0200
Message-Id: <20220110220509.3527402-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ngpio is the actual number of GPIOs handled by the GPIO chip,
as opposed to the max number of GPIOs.

Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
V1 -> V2
 * add Fixes tag
---
 drivers/iio/addac/ad74413r.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 5271073bb74e..6ea3cd933d05 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -288,7 +288,7 @@ static void ad74413r_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned int offset = 0;
 	int ret;
 
-	for_each_set_bit_from(offset, mask, AD74413R_CHANNEL_MAX) {
+	for_each_set_bit_from(offset, mask, chip->ngpio) {
 		unsigned int real_offset = st->gpo_gpio_offsets[offset];
 
 		ret = ad74413r_set_gpo_config(st, real_offset,
@@ -334,7 +334,7 @@ static int ad74413r_gpio_get_multiple(struct gpio_chip *chip,
 	if (ret)
 		return ret;
 
-	for_each_set_bit_from(offset, mask, AD74413R_CHANNEL_MAX) {
+	for_each_set_bit_from(offset, mask, chip->ngpio) {
 		unsigned int real_offset = st->comp_gpio_offsets[offset];
 
 		if (val & BIT(real_offset))
-- 
2.34.1

