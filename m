Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADE048A267
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242194AbiAJWFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345233AbiAJWFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:05:30 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C819FC061748;
        Mon, 10 Jan 2022 14:05:29 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o6so59438646edc.4;
        Mon, 10 Jan 2022 14:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7qTgRogzHIjz3RKxh1ZqDUQUFjrtnjfdm+rxB2VFGYs=;
        b=jJ9d1QXcjM+7clYoRP5Td1uYItfEqQb4ShBVPtPj6HuvwR00zICme3sSDdgxCbadEe
         Bjc42QV3Gl80hYuV0KGzdPsbYuM7o7ZbXJHJzx1uhBwZcw87sy7BmgxdXzRJF9p7TZYP
         ugvkeJvVSu1mdlM+kl813dxorQfucU4sCybsn+h123M+q665Vlg+S3fqMRM31WCIhajO
         YMYP+6Wpv1g2W7oPSdCYxM6GPIdG0D8UUrXYzewpvhPmLjgV05nIhX55gHJL0vm3/w3Z
         j4MikSKqB7XJiLoUwWhaiKpXRDRA94EO1fquWXpOjD8JLYZElIwouZ3sFMqmkYLvV67M
         pOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7qTgRogzHIjz3RKxh1ZqDUQUFjrtnjfdm+rxB2VFGYs=;
        b=yH/65bBYphjh1Sr/U0ZGTPKQSHTqS4VLVzAaiHRLirW0ukNBoiwZ7EIbTQKRSyztTC
         bE+DScv1Zu96xSWqamfjF11WIn0LlK+WiWCc2PtLCUBirneRe7hFcWfnIO79KcdCGs9o
         ypZRUen8uolnWwET73bX6liKTub1aIcfwjZeX36QPGtD1D3l6vrViWBON/D/L6y+XLkg
         VOrfC5YeUK82+VUDeaVFcE/T1EnkKVrRq+0mExsBdVPqm32FNwAmigM3QxEefbulrbxc
         WXr0Ut3xHztdeyuXNmXlJ5br/57Lx6qCCV1rtoQ7p+AoX0Xa5sPOB/IKE7xMICzv2Bf+
         QqLg==
X-Gm-Message-State: AOAM533MOuxxGLF6fgoKtffxfmSpM4GZgE4UW8HjFcaMeBt/D9rnrn97
        lSybpf591C1nPT39wufIJZB4ddftg6MZBg==
X-Google-Smtp-Source: ABdhPJyKxkpzHy/amPKgIYRSwC/0jEiQlHDkAMQtXuLZJ1l0MTo+6gbVaqNZI0TVTR12hi7xgVsbNg==
X-Received: by 2002:aa7:d383:: with SMTP id x3mr1609957edq.392.1641852328423;
        Mon, 10 Jan 2022 14:05:28 -0800 (PST)
Received: from demon-pc.localdomain ([79.119.107.253])
        by smtp.gmail.com with ESMTPSA id q21sm2842672ejn.107.2022.01.10.14.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 14:05:28 -0800 (PST)
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
Subject: [PATCH v2 3/3] iio: addac: ad74413r: correct comparator gpio getters mask usage
Date:   Tue, 11 Jan 2022 00:05:09 +0200
Message-Id: <20220110220509.3527402-3-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110220509.3527402-1-cosmin.tanislav@analog.com>
References: <20220110220509.3527402-1-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of the GPIOs is currently altered using offsets rather
than masks. Make use of __assign_bit and the BIT macro to turn
the offsets into masks.

Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
V1 -> V2
 * add Fixes tag
 * use __assign_bit
 * remove bitmap_zero
---
 drivers/iio/addac/ad74413r.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 3d089c0b6f7a..8a8d60e592a8 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -134,7 +134,6 @@ struct ad74413r_state {
 #define AD74413R_CH_EN_MASK(x)		BIT(x)
 
 #define AD74413R_REG_DIN_COMP_OUT		0x25
-#define AD74413R_DIN_COMP_OUT_SHIFT_X(x)	x
 
 #define AD74413R_REG_ADC_RESULT_X(x)	(0x26 + (x))
 #define AD74413R_ADC_RESULT_MAX		GENMASK(15, 0)
@@ -316,7 +315,7 @@ static int ad74413r_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	if (ret)
 		return ret;
 
-	status &= AD74413R_DIN_COMP_OUT_SHIFT_X(real_offset);
+	status &= BIT(real_offset);
 
 	return status ? 1 : 0;
 }
@@ -336,9 +335,7 @@ static int ad74413r_gpio_get_multiple(struct gpio_chip *chip,
 
 	for_each_set_bit(offset, mask, chip->ngpio) {
 		unsigned int real_offset = st->comp_gpio_offsets[offset];
-
-		if (val & BIT(real_offset))
-			*bits |= offset;
+		__assign_bit(offset, bits, val & BIT(real_offset));
 	}
 
 	return ret;
-- 
2.34.1

