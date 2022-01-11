Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA16248A8B8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348667AbiAKHsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348638AbiAKHr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:47:58 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23025C06173F;
        Mon, 10 Jan 2022 23:47:58 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id b13so10273677edn.0;
        Mon, 10 Jan 2022 23:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZdPX8GIQceGUqvgcepNMikuMFPrZwyFE5c5d7j8AF5Y=;
        b=gvKTnYl7a/N9XVB0BiYT2wk3ZZHDbbFrIHKX8HV0j2PNt2Ugk4/vuu12iWJPaV7mI/
         MHHWlCFuiup7JXdSqQKarHqDcyaIBcdQ5P19QbtVHr8BYe6WnUBg7hl9SFwb7Cne+JRQ
         83z0koopBy6RkhcD/6IALDqebRHMJcRWJ+imLykdBNmROpIWXkazB9Td5Vut0dBAJlRV
         wNV9MU0dzS3s5YygksRYcntJ1R+DhT8JUUT1DhVyjiVllbB/QccbpbbUwwJh0QRJ06Wj
         jwUKZLXP+jqH11demWQQKe94kzkeXCbwfWRgQ13G+5AMDBQ12oE78SEOF0wK0XfjrxOR
         HKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdPX8GIQceGUqvgcepNMikuMFPrZwyFE5c5d7j8AF5Y=;
        b=NaaPyowkm73FcDaYjb9T60hGppEOzNJggPYZaOkb1k72McGJT1Q4qsUecEnY++GvRj
         cxsdTMPtHLUKuRXO0ETg5iIRyWHXuyYT36z4l/UmnlIAv3Ti9eX3AtGsw+ldSfuZUoby
         VUyhaIR6f9NfxCJTdXd+7LnLp18AHtjdjb4r+69jWgit7OItAeejCPTmCSOjplfNxhBj
         oj5HJt7xvGUbDP/fHV723Djrk9eIOZctOkJp+kcSN2KEfHR4LPfZjWM3PkXaLnV0U2oY
         fo7SIcfMrcMn9iyZj6tn/KHGCcQKMvT9+3DAm0xMxGMLQ81/aTmsyt7d8FucXJixZepf
         qI5Q==
X-Gm-Message-State: AOAM532p8sDIPgsf3NtdE8B8SV8cEAwE/TZzYIXwwFQEoWESGL4FBffG
        /yb1cnuF9im6d707yEIwRJU=
X-Google-Smtp-Source: ABdhPJyvTVJNxXsmi2pRMWNUGq62FF0tyDI+KiHJMeUkAxV+gQbBDafpo6q/kvMv7/tJCSg6ZDgGiA==
X-Received: by 2002:a05:6402:274e:: with SMTP id z14mr3155708edd.242.1641887276816;
        Mon, 10 Jan 2022 23:47:56 -0800 (PST)
Received: from demon-pc.localdomain ([79.119.107.253])
        by smtp.gmail.com with ESMTPSA id ga10sm3318827ejc.12.2022.01.10.23.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 23:47:56 -0800 (PST)
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
Subject: [PATCH v3 3/3] iio: addac: ad74413r: for_each_set_bit_from -> for_each_set_bit
Date:   Tue, 11 Jan 2022 09:47:03 +0200
Message-Id: <20220111074703.3677392-3-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111074703.3677392-1-cosmin.tanislav@analog.com>
References: <20220111074703.3677392-1-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The starting bit is always zero, it doesn't make much sense to
use for_each_set_bit_from. Replace it with for_each_set_bit
which doesn't start from a particular bit.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
V2 -> V3
 * move after patch 3
---
 drivers/iio/addac/ad74413r.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index b13cd5407df3..cf58ee19f912 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -284,10 +284,10 @@ static void ad74413r_gpio_set_multiple(struct gpio_chip *chip,
 	struct ad74413r_state *st = gpiochip_get_data(chip);
 	unsigned long real_mask = 0;
 	unsigned long real_bits = 0;
-	unsigned int offset = 0;
+	unsigned int offset;
 	int ret;
 
-	for_each_set_bit_from(offset, mask, chip->ngpio) {
+	for_each_set_bit(offset, mask, chip->ngpio) {
 		unsigned int real_offset = st->gpo_gpio_offsets[offset];
 
 		ret = ad74413r_set_gpo_config(st, real_offset,
@@ -325,7 +325,7 @@ static int ad74413r_gpio_get_multiple(struct gpio_chip *chip,
 				      unsigned long *bits)
 {
 	struct ad74413r_state *st = gpiochip_get_data(chip);
-	unsigned int offset = 0;
+	unsigned int offset;
 	unsigned int val;
 	int ret;
 
@@ -333,7 +333,7 @@ static int ad74413r_gpio_get_multiple(struct gpio_chip *chip,
 	if (ret)
 		return ret;
 
-	for_each_set_bit_from(offset, mask, chip->ngpio) {
+	for_each_set_bit(offset, mask, chip->ngpio) {
 		unsigned int real_offset = st->comp_gpio_offsets[offset];
 
 		__assign_bit(offset, bits, val & BIT(real_offset));
-- 
2.34.1

