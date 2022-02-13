Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B2A4B3910
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 03:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbiBMC6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 21:58:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiBMC5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 21:57:54 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B3460077;
        Sat, 12 Feb 2022 18:57:49 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id s1so12539035qtw.9;
        Sat, 12 Feb 2022 18:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+bue5/qYkq1jRa6IPWu4PMPydpu6fVwowylJcvYqJHI=;
        b=OlFgLVFlYAdAYd3R74hutAqlvhcSyWzi0hfYrzfZFD9HzmToDlcMqLqnr9SGdnWoO7
         v1xfhyr46y4sLed0Z1GbwFSAF3AUCsLsI7iQz++xZ+DQ//8VlOJj49qn3vEsamD2Zu/l
         urvEWm8gaW6PsF4yRkMjkHz/1O7SdH8V845iEOBwgC3ZcConUDzsVr2avas6iVLv7z6v
         3codfnVvwEh/EPAtLiFnGi4udbxltZSZFZ3e3RkX6E00mVwXbczxC5pFkTz+UaFyVJkJ
         xSDvPbCx4HAOuOPI06HvYknI2Lot5YItpuLlipIVBsrOWJj5JXjNyKQ6mGXnw3FXM5Q4
         A8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+bue5/qYkq1jRa6IPWu4PMPydpu6fVwowylJcvYqJHI=;
        b=0rROxEqp0H7uMSa4Td/ghJhgtGNJbjgH5F8MlHOqT1cegG2stEJz+JP7ilJ9y/sElb
         Ai6iZ7WorA2D+a1ZzwCYE4b6EcmJkaUGmhTpdP4fgKf5RVlij2XYG/fd7734XhCr5zPr
         MWYIyo+xuvQERPeNOKoI/x0WrOLwF3nBxr2X1B8+Z5wucPcpNdOLeB5jYQJlNmdIQTiQ
         anuWp+GfqjySKo8bh0P9M/Sl+Qe0wumeXhz41Kd4bBQicUvu4+c2uMgBY6fPI1HvhWC7
         iC58R11+m9By03qybnlo4yaHmwZ4AukVV+IbKwF2atwGfUADkhCyFiQF25Au0Yt+w6f1
         f7gQ==
X-Gm-Message-State: AOAM531R2enq7YRL04FRf2XO3gA3k4HX+5a/5V+0z1Wmjsj7X2nFjzP9
        jtT1ypQugy+l19IbQWQRbsvRRFXrz+g=
X-Google-Smtp-Source: ABdhPJxyP0Kt3bGoL8IuCyvnEDfGOjYBh38k1BhbjpFbUr9DNzUDdM+/O5l6mGiNn1/2ozQYTPt3sQ==
X-Received: by 2002:a05:622a:1ba7:: with SMTP id bp39mr5829613qtb.626.1644721068762;
        Sat, 12 Feb 2022 18:57:48 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id y15sm14551106qkp.22.2022.02.12.18.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 18:57:48 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v15 04/10] iio: afe: rescale: fix accuracy for small fractional scales
Date:   Sat, 12 Feb 2022 21:57:33 -0500
Message-Id: <20220213025739.2561834-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220213025739.2561834-1-liambeguin@gmail.com>
References: <20220213025739.2561834-1-liambeguin@gmail.com>
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

The approximation caused by integer divisions can be costly on smaller
scale values since the decimal part is significant compared to the
integer part. Switch to an IIO_VAL_INT_PLUS_NANO scale type in such
cases to maintain accuracy.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/iio-rescale.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 8eaf766e28cc..5d78f0cf47d2 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -24,7 +24,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
 	s64 tmp;
-	s32 rem;
+	s32 rem, rem2;
 	u32 mult;
 	u32 neg;
 
@@ -43,9 +43,23 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		tmp = (s64)*val * 1000000000LL;
 		tmp = div_s64(tmp, rescale->denominator);
 		tmp *= rescale->numerator;
-		tmp = div_s64(tmp, 1000000000LL);
+
+		tmp = div_s64_rem(tmp, 1000000000LL, &rem);
 		*val = tmp;
-		return scale_type;
+
+		if (!rem)
+			return scale_type;
+
+		tmp = 1 << *val2;
+
+		rem2 = *val % (int)tmp;
+		*val = *val / (int)tmp;
+
+		*val2 = rem / (int)tmp;
+		if (rem2)
+			*val2 += div_s64((s64)rem2 * 1000000000LL, tmp);
+
+		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_VAL_INT_PLUS_NANO:
 	case IIO_VAL_INT_PLUS_MICRO:
 		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? 1000000000L : 1000000L;
-- 
2.35.1.4.g5d01301f2b86

