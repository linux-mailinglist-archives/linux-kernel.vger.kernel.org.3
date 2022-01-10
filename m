Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C2748A266
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345264AbiAJWFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345224AbiAJWF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:05:28 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57469C06173F;
        Mon, 10 Jan 2022 14:05:28 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u21so36810822edd.5;
        Mon, 10 Jan 2022 14:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rKVOUbvydfCeHi5tJwijuuUgLBGIuDEY3IU/RY2wubM=;
        b=SeeQIQpkWM/ess+X62WkIw0TES/RhtM1mfTCs2z3Ddsu0xLqdO4RA65vAjNGW1h2xE
         oYC+10H3bP9blkHgTd7f/FgcOmmqT1WuagUaSzE8Clm+IWIazILugNDdN0pryMjNepqy
         kruWd1uueFZKdlbHcTC1s2ppwq4idTPttGUFqfTVkJjUjUSVd2YQjM7dpCtFT5+QFatL
         Cb/Xsu9Vn2cYsodJWZELQycIwx4zgq6qdl3/wpKdjsG87C46u6YacwUPPkS9J7Sc2i1C
         kJbrSZLg7DCXpEpizL6zVmZNZCHrbjcBGzW2/JhKFqGpX4HHtZwHCyRTNfkMSwx6NebO
         JDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rKVOUbvydfCeHi5tJwijuuUgLBGIuDEY3IU/RY2wubM=;
        b=LejPjQDkkNF1dP92a6tMEXpY29blLxGtV6EsgW0/ew7/19jKDrXOzFrTbMoRpDLIgG
         thmauzarcAhvLTm6iUX1DXV9AHPc4YeeYvjb8m72Ua/OOgh5DQO/bj7eKxGlHAiqlTnf
         kOuti4DRATmFcT2wGP0sIc2ixw/vnyXkSTsGI8QhntxysE+T0U5B3Gy62WUyJDFXUa4i
         9tjhUKVgW/ApDOJ4WbBQ9VbUN94oouFPshvDmKQQGh5l32aFY6RwTIskssA3C3vZhN5N
         qdpDKwoUhFKVDesUdjqHhY5+jpw6WyPLy15FAwYQbkqwLdTOoVbAI3wKLot9ThUxYwn9
         GUZQ==
X-Gm-Message-State: AOAM532YW4jOAUuNWFgjB0n6vHp9dXD5PFlU7rCSeVJgnqUVgVsDIxZJ
        jhWMG+GV1rMqYrdU2ESmdQFezHrA0WBQjg==
X-Google-Smtp-Source: ABdhPJy1wVf+72rwfYqpxWlszjQV5IoEh/vncFDqxg/OHqFm+ToWBJBvYjIe1mKw3ueOlIRiuH1LLg==
X-Received: by 2002:a50:eacb:: with SMTP id u11mr1641622edp.290.1641852327043;
        Mon, 10 Jan 2022 14:05:27 -0800 (PST)
Received: from demon-pc.localdomain ([79.119.107.253])
        by smtp.gmail.com with ESMTPSA id q21sm2842672ejn.107.2022.01.10.14.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 14:05:26 -0800 (PST)
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
Subject: [PATCH v2 2/3] iio: addac: ad74413r: for_each_set_bit_from -> for_each_set_bit
Date:   Tue, 11 Jan 2022 00:05:08 +0200
Message-Id: <20220110220509.3527402-2-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110220509.3527402-1-cosmin.tanislav@analog.com>
References: <20220110220509.3527402-1-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The starting bit is always zero, it doesn't make much sense to
use for_each_set_bit_from. Replace it with for_each_set_bit
which doesn't start from a particular bit.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/iio/addac/ad74413r.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 6ea3cd933d05..3d089c0b6f7a 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -285,10 +285,10 @@ static void ad74413r_gpio_set_multiple(struct gpio_chip *chip,
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
@@ -326,7 +326,7 @@ static int ad74413r_gpio_get_multiple(struct gpio_chip *chip,
 				      unsigned long *bits)
 {
 	struct ad74413r_state *st = gpiochip_get_data(chip);
-	unsigned int offset = 0;
+	unsigned int offset;
 	unsigned int val;
 	int ret;
 
@@ -334,7 +334,7 @@ static int ad74413r_gpio_get_multiple(struct gpio_chip *chip,
 	if (ret)
 		return ret;
 
-	for_each_set_bit_from(offset, mask, chip->ngpio) {
+	for_each_set_bit(offset, mask, chip->ngpio) {
 		unsigned int real_offset = st->comp_gpio_offsets[offset];
 
 		if (val & BIT(real_offset))
-- 
2.34.1

