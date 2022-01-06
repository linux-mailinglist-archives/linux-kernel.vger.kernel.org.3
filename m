Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA61F48609C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 07:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbiAFGXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 01:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbiAFGX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 01:23:28 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD427C061245;
        Wed,  5 Jan 2022 22:23:27 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 30so3989570edv.3;
        Wed, 05 Jan 2022 22:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rKVOUbvydfCeHi5tJwijuuUgLBGIuDEY3IU/RY2wubM=;
        b=RrfZs/uM4TkREL/5OUI56ce4isc0HTw1n2RoKM/HlrQZfP971fN9YzmoJxa2TdHOwR
         T7dS9xalsyNoIi+w0PSgo7OuY15FHeYZzfXy2G+R0NWyp9dcUYcaVRwaFkegfe7EleJ+
         CCev63fDvSz1UcHTYJFcjagFnF5XJ7ky5f7iG0Wc9ZUk6c/PnaNMqfXvOiO4b6A2zWik
         wEWHIcROx0RdEWRa9/yk2EXNyvo4aYn88HUWFkZ8YxXymls800vSkqPm28Oj1x5aAVC0
         3YDQc3k27SNhwp9oPB2NRTZndcb5xVZ6xBQiXs4U0V4ojClUIKFcfDoQDxyQWyrBYsEo
         Z4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rKVOUbvydfCeHi5tJwijuuUgLBGIuDEY3IU/RY2wubM=;
        b=yqYUSBWfYVWtrZ/CJttbUu9GUgje+fr+wdGIiSSc29/8HsRj07Hz3JZOGG76tSl6qx
         reCdac5N61vKmJ/vEEzWo/Zv50eUJlqKHV8kdiXPq1aPBODBOxaYBdBp7UxpaEVoDPBm
         IzquUXWxcr82uOQrlORpccyTrgUhQC3DqgM97Onei3jnJWPEnmaryIxcmIwc1aUQ1NVZ
         QgltCg9/ee6q79idhH+ah4wE4w94hCH1H9X+wg9IxIsJdlN0gTTvkUb6AQTMQAajw3ye
         aEZWJ/JQuYv+5dsBsqH9riOmm5QZcbFmXhPvr7/UL7ECn2kNwHbadbdQGP0TZFHkyO3f
         INLw==
X-Gm-Message-State: AOAM532XlU+4aO9p9++ZPl34dLZxqbVoKOD3cxyUtZo6mmThypcoJ/8H
        t8n6fm1XOvNcvXWJpm+Fxto=
X-Google-Smtp-Source: ABdhPJwd+6v20JTBtZQvuzTPWbFhe92tw/PTDXfplGlhp25/AXS+PleslelnJuNZ7jV6awFDcXJPWw==
X-Received: by 2002:a50:d691:: with SMTP id r17mr23953653edi.317.1641450206431;
        Wed, 05 Jan 2022 22:23:26 -0800 (PST)
Received: from demon-pc.localdomain ([2a02:2f0e:f707:7c00:2820:56a6:a8aa:5135])
        by smtp.gmail.com with ESMTPSA id qb30sm242697ejc.119.2022.01.05.22.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 22:23:26 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH 2/3] iio: addac: ad74413r: for_each_set_bit_from -> for_each_set_bit
Date:   Thu,  6 Jan 2022 08:22:54 +0200
Message-Id: <20220106062255.3208817-2-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220106062255.3208817-1-cosmin.tanislav@analog.com>
References: <20220106062255.3208817-1-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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

