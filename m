Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8C848A8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348631AbiAKHr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348620AbiAKHr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:47:56 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80855C06173F;
        Mon, 10 Jan 2022 23:47:55 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o6so63659861edc.4;
        Mon, 10 Jan 2022 23:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nM/uwZwpqJW2H4ac2VQWs6cOpPGqITY+VBtnGv3nTiE=;
        b=XTwGvD53MBV256bvS8LuVW3PvGGeLrJslg/rc7qaD1PF+hfb5208xwdDXBGQPyO1Bb
         F1HtEoCrMfXLunOM3Hl78wR+K1oJsls1InG8qWY0FPZZ7oRpbWQX+DRxyFzOkUKh3plb
         oLIaZZ4JT9aW1R6Q/FdjelU+PdmxzPkXOz8lvrojeck6WOjumPjrqpNc5rzmgXfhB2xT
         amINwuXgXUbtQf5PMT13LhXqqUsZAAjfGZm9LW3y0fPSQRlwIQslAS1AySysIz1hF/Nz
         SYtolXo85W9yNm3s4wUKFLNydeVJYc9McjwC+XOUdqTcXE0s681x7WvGmlSqAoLr1fc7
         fbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nM/uwZwpqJW2H4ac2VQWs6cOpPGqITY+VBtnGv3nTiE=;
        b=SdsZUJFlWlmIkdxfXPiWE6TP4OqBEY9NJD1oUbjM2kCTfbmjEd4ukdG+e2zY4sm50g
         KpAicHvV/iBffhUSIP2X6Z9NpTQWUzeeCXBx5pSn9mXvPIr4jIby5SDcU81zUv8YMe6X
         oO3N/Sy1ZzOSTaRriZktB4CsVf6jVoLZ/in2sSG7MdAVSxiHC0U6mKZim7gLNrgVQkdt
         TFmcooNANvaxtucIVp4hyekqGRbEU/J81AZWBrdV5sA+/U6DCKkQnMbCPwFV3FvXP9Go
         2g8SrolWjRXzZPhNczQRIv49ogjgQ1lMuXQWRWejIhBSl31mosm9aV3gF7cdH4tF147S
         KqEw==
X-Gm-Message-State: AOAM533Pj/AT2+LGqdNI5W5Jm0n2rXexArrKPqcLalX+RtNRx1rrWCOJ
        dAj6Ch2Hdii7XDAZ0wffhgXe2IFaEs6WjQ==
X-Google-Smtp-Source: ABdhPJzjyMLOpWeTbx1gSQaL8x3d5JjLlwmJarPjnmSW/CfZug1OrOzJuN39Hg9sgFVh+CqQjMRqNQ==
X-Received: by 2002:a17:906:16d5:: with SMTP id t21mr2724958ejd.547.1641887274130;
        Mon, 10 Jan 2022 23:47:54 -0800 (PST)
Received: from demon-pc.localdomain ([79.119.107.253])
        by smtp.gmail.com with ESMTPSA id ga10sm3318827ejc.12.2022.01.10.23.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 23:47:53 -0800 (PST)
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
Subject: [PATCH v3 1/3] iio: addac: ad74413r: use ngpio size when iterating over mask
Date:   Tue, 11 Jan 2022 09:47:01 +0200
Message-Id: <20220111074703.3677392-1-cosmin.tanislav@analog.com>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

