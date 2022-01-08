Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30299488621
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 21:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbiAHUyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 15:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiAHUxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:53:44 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FCEC061401;
        Sat,  8 Jan 2022 12:53:44 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id b85so10075670qkc.1;
        Sat, 08 Jan 2022 12:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6WptJPRGNHV4JiwPZI5nOc7RDaGnvmwg6Kkf+gxMu70=;
        b=OEE7TekimQgT4bxMXn9a8aNdshdo47366NwGlzJ2JAK3OifIhXJIdRrptrYxG8H3WD
         ORRVV0z47Tjs0sJOUb8CLHJXgnPP3wJ4q1N+F5AB5tyEwgJiN8LI4IDPxLZLbeTNVkn7
         GvdQAALYzbdLaul87LwocaDuVhMUT/46hHIGg1XGQlBOAqhOEe/5a1FqUbks/i7auqq+
         ozMOIx3I92MarUlC9wXAZa/Luti5GJVBP24/O3QG+34Lfr8d5BLZp3M4XRbG+UIrilUh
         Eosij7MEeWVY7CPC8ea5AP6BC5Vf4boNwvYG7hKUvCzjmuPvioJZTO4GtVAClVSAemEk
         r6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6WptJPRGNHV4JiwPZI5nOc7RDaGnvmwg6Kkf+gxMu70=;
        b=oqpx+1afd0HXtECPf/HLTzKsCVqRqYAMfclLYGr1kw4dcmM85ocs8tpJmTlfOHAtNK
         W9XgaT8NpZ6M5Vu1VLLGeTUcCZ/+KJ/TbZPrGq33Vnzfegerb5CvYhg2NqOcHhZHWotH
         wzJqiAfAW/LfYYGWaLfyMvytS0IBVSRNUSZtDxsFYjEODGYaIWvzcz0kAjXH7Wgw8xGN
         3wm619UPSJzsS8I+Mxvezok0Jex8zrZHbJnbpIp1S3F0ybVPN4r+OEzWsog2aRq1L4TV
         EwYdFYe3gJa8wAD6zC6jWPTxtyatR6T3o1Mh0oei6RqpXiBrMOGMZL5ja4KZByKs4kR8
         BrYw==
X-Gm-Message-State: AOAM532M3pUpHftRi2C7AkIIvlK4NQUMPNeNOImaDoWzu/x+jTjcvPoR
        oN2Td2KenyfbD6KJ0arS7Vup0pqUl9E=
X-Google-Smtp-Source: ABdhPJyK2XSOi+n9HjGB8u6iCAvYBUgQQP4Z601nCpG3sPFk7Jqgk1oaynWUZDxcktZuiRkueHB5xg==
X-Received: by 2002:a05:620a:1588:: with SMTP id d8mr8573795qkk.174.1641675223279;
        Sat, 08 Jan 2022 12:53:43 -0800 (PST)
Received: from shaak.. (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id p16sm1650377qtx.19.2022.01.08.12.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 12:53:42 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v12 10/16] iio: afe: rescale: reduce risk of integer overflow
Date:   Sat,  8 Jan 2022 15:53:13 -0500
Message-Id: <20220108205319.2046348-11-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220108205319.2046348-1-liambeguin@gmail.com>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce the risk of integer overflow by doing the scale calculation on
a 64-bit integer. Since the rescaling is only performed on *val, reuse
the IIO_VAL_FRACTIONAL_LOG2 case.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/iio-rescale.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index ed3ef994997f..5b87965482d2 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -24,21 +24,31 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
 	s64 tmp;
+	int _val, _val2;
 	s32 rem, rem2;
 	u32 mult;
 	u32 neg;
 
 	switch (scale_type) {
-	case IIO_VAL_FRACTIONAL:
-		*val *= rescale->numerator;
-		*val2 *= rescale->denominator;
-		return scale_type;
 	case IIO_VAL_INT:
 		*val *= rescale->numerator;
 		if (rescale->denominator == 1)
 			return scale_type;
 		*val2 = rescale->denominator;
 		return IIO_VAL_FRACTIONAL;
+	case IIO_VAL_FRACTIONAL:
+		/*
+		 * When the product of both scales doesn't overflow, avoid
+		 * potential accuracy loss (for in kernel consumers) by
+		 * keeping a fractional representation.
+		 */
+		if (!check_mul_overflow(*val, rescale->numerator, &_val) &&
+		    !check_mul_overflow(*val2, rescale->denominator, &_val2)) {
+			*val = _val;
+			*val2 = _val2;
+			return IIO_VAL_FRACTIONAL;
+		}
+		fallthrough;
 	case IIO_VAL_FRACTIONAL_LOG2:
 		tmp = (s64)*val * 1000000000LL;
 		tmp = div_s64(tmp, rescale->denominator);
@@ -50,7 +60,10 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		if (!rem)
 			return scale_type;
 
-		tmp = 1 << *val2;
+		if (scale_type == IIO_VAL_FRACTIONAL)
+			tmp = *val2;
+		else
+			tmp = ULL(1) << *val2;
 
 		rem2 = *val % (int)tmp;
 		*val = *val / (int)tmp;
-- 
2.34.0

