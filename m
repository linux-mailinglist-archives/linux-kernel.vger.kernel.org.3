Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F0848A8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348648AbiAKHr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348628AbiAKHr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:47:57 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049C2C06173F;
        Mon, 10 Jan 2022 23:47:57 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id c71so52075358edf.6;
        Mon, 10 Jan 2022 23:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9J4sXRF843dXBbYU89Qr1DSQHRtG4M472WmhcYlGSGM=;
        b=J1tfV/JI+HdcNH6RWUPg5V1WifYMdHWLsC8qTwMWwnKVQMlgJSuEKx66S/J8MTg7ml
         zXfcLTj8oFqpnRqlsdkUGBzzHF5dZArs+d3kQ9L/xBSMCxgyF6k3gjcRG1WAun7kXlLy
         /dEiaXZ5DLBr8bbx3ep66yP5rZn9qJ0rQVDqqQAPHIkIXsNQIs4wM/hGDZmVCO/IumEo
         rHENzVaQZOEq4/lyV6893rRTfvWNQ8jKFmkWoGhQQn/p6zsvYrb6wOBIB2ZVZLw3JOyD
         CsHvlZCWig4G2FVp8qrqaJzQI58qyjRgZuceWj92f0AMRvFBWklpHX8chA/S4/YcZhKA
         19OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9J4sXRF843dXBbYU89Qr1DSQHRtG4M472WmhcYlGSGM=;
        b=OqmifdAEK30vOzRnCv82SvOQNy6yxRK9xUwS8CqrJZgmUGhMAoWPIz5GktIaixz+oR
         wpWo1e1Nq8phfWabRk0347xiCCF75pDkNH9OIfoojEiszGGl8Xp7foeIXQmTt57MGk5z
         Fyp+kIyC93N3WdpiX4hEuVrTfoJSAapcguZqHAdnjCAPUiLTAW7Ix/qtNcA2JITxL6nU
         Y0kkvdhh6G9ZgMwapJCE39kvILj97KRiJmHjdSZ81iKWNz5Wd//TF8HtwMF4w0vY882T
         CgGITSeNg//fR/BWg4Z/eeP4ph6Xqu/dnHAToItbD7iGxeDlkCOqR0wqKbe2mkBGlB0k
         OhEQ==
X-Gm-Message-State: AOAM5339IcO2KvEbgrb8rzDzgprHoYTLDHf+eGCZo4nx6OeX8AVXmEqq
        1kJlEVCg6UB+jCSpejmMBms=
X-Google-Smtp-Source: ABdhPJyfuZs06WNtGUKGD/3UN0ppEPrhdEdfmGcxNbE8H0N/t3JqTNZScA6E4D/quOR0LGJYXCyBuQ==
X-Received: by 2002:a05:6402:5112:: with SMTP id m18mr3184969edd.45.1641887275676;
        Mon, 10 Jan 2022 23:47:55 -0800 (PST)
Received: from demon-pc.localdomain ([79.119.107.253])
        by smtp.gmail.com with ESMTPSA id ga10sm3318827ejc.12.2022.01.10.23.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 23:47:55 -0800 (PST)
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
Subject: [PATCH v3 2/3] iio: addac: ad74413r: correct comparator gpio getters mask usage
Date:   Tue, 11 Jan 2022 09:47:02 +0200
Message-Id: <20220111074703.3677392-2-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111074703.3677392-1-cosmin.tanislav@analog.com>
References: <20220111074703.3677392-1-cosmin.tanislav@analog.com>
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

V2 -> V3
 * add back line between real_offset declaration and __assign_bit call
 * move before patch 2
---
 drivers/iio/addac/ad74413r.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 6ea3cd933d05..b13cd5407df3 100644
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
@@ -337,8 +336,7 @@ static int ad74413r_gpio_get_multiple(struct gpio_chip *chip,
 	for_each_set_bit_from(offset, mask, chip->ngpio) {
 		unsigned int real_offset = st->comp_gpio_offsets[offset];
 
-		if (val & BIT(real_offset))
-			*bits |= offset;
+		__assign_bit(offset, bits, val & BIT(real_offset));
 	}
 
 	return ret;
-- 
2.34.1

