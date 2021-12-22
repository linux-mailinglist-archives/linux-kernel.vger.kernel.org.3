Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8845B47CBE6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242228AbhLVDrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242208AbhLVDrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:47:01 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEEDC06173F;
        Tue, 21 Dec 2021 19:47:01 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id p19so774117qtw.12;
        Tue, 21 Dec 2021 19:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BDkFtZR4GcVfPI2FAnt2gKNxJlGgIx5025z/PArQTSg=;
        b=hmhACLBVidwWeIBUvFwJTuDfbcxgEIfQ8CLsjIpb0uF8rLeVfPTFuDMLVeM2DWZjk2
         Lg+iiOzUIYbM9pyjgCsghW7kSomnYChIKZQyhKYdhQlhYALaRGLNaD5YzaquzRqOLKXN
         WV7D+4zRyjJA1YhwemjuoIAacqpjhi3QYbuyH5/mCjLBKnA0Igczn9f1TyQNxXRiQl9h
         i836I5u3EacczEk+/HQn0EMcLAsIx4+oGZfNZxm2L2sD+jQKSX5J3DbJ47Ju1Fz3gHpu
         rv2NdLPp6VdJ8prdnGArhOMgLjXmUwnsmf84nj9UgA9afvw6dFarnQGo9i1Z/zVwMAxZ
         bqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BDkFtZR4GcVfPI2FAnt2gKNxJlGgIx5025z/PArQTSg=;
        b=lYQTeM8Bpc5tmRZOHxvJ2ZUVR7Y8AdZjB3f5EybPCUQXoK1dr9cIVrrxF+siRdCYkP
         4jYOuU2uNGeWBJL3SMh+wKutgXQme/0+OkGL2I+sEs/qgkmgRp49sdzcCPtslo6mrzWU
         1SzRzXQk8pptRAWJInHcVyxr/xUUgZi/tqxwkjnlIlXtMPEgU+viKnI/g0w4lEqCXZmL
         xMQUFwLqbYsDidN2C1soX2adI0rpjes2j16ziaH8rvA9VirKkX6o9jxFpuW8A3Ynkcwq
         lqr+spBDsiyK7EcndKYb+oq9rXoFbdtFDZsGlK5/R6Bel9cCQFjeG7mA3ktvP9RJJmjX
         rUdQ==
X-Gm-Message-State: AOAM530VtQwdycR1cOgUwt2DSyNdf5d335L4Y5gFqXTLnxEkuhZQfqGA
        OzV9dkYw/4bWir3tP3Kv24A=
X-Google-Smtp-Source: ABdhPJzRqVp6q+2KRVioVVU+SUQ2i7jXZSiSONTaFZuIku/5yrQeFFIRowOwJt6WaIhyEBKkYGifyA==
X-Received: by 2002:ac8:5a4a:: with SMTP id o10mr916786qta.91.1640144820596;
        Tue, 21 Dec 2021 19:47:00 -0800 (PST)
Received: from shaak.xiphos.ca (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id f18sm918944qko.34.2021.12.21.19.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:47:00 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v11 05/15] iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
Date:   Tue, 21 Dec 2021 22:46:36 -0500
Message-Id: <20211222034646.222189-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211222034646.222189-1-liambeguin@gmail.com>
References: <20211222034646.222189-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
Add support for these to allow using the iio-rescaler with them.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/iio-rescale.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index d0669fd8eac5..190a83e08008 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -17,11 +17,15 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/units.h>
 
 int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
 	unsigned long long tmp;
+	s32 rem;
+	u32 mult;
+	u32 neg;
 
 	switch (scale_type) {
 	case IIO_VAL_FRACTIONAL:
@@ -40,6 +44,37 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		tmp *= rescale->numerator;
 		do_div(tmp, 1000000000LL);
 		*val = tmp;
+		return scale_type;
+	case IIO_VAL_INT_PLUS_NANO:
+	case IIO_VAL_INT_PLUS_MICRO:
+		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? NANO : MICRO;
+
+		/*
+		 * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if either *val
+		 * OR *val2 is negative the schan scale is negative, i.e.
+		 * *val = 1 and *val2 = -0.5 yields -1.5 not -0.5.
+		 */
+		neg = *val < 0 || *val2 < 0;
+
+		tmp = (s64)abs(*val) * abs(rescale->numerator);
+		*val = div_s64_rem(tmp, abs(rescale->denominator), &rem);
+
+		tmp = (s64)rem * mult + (s64)abs(*val2) * abs(rescale->numerator);
+		tmp = div_s64(tmp, abs(rescale->denominator));
+
+		*val += div_s64_rem(tmp, mult, val2);
+
+		/*
+		 * If only one of the rescaler elements or the schan scale is
+		 * negative, the combined scale is negative.
+		 */
+		if (neg ^ ((rescale->numerator < 0) ^ (rescale->denominator < 0))) {
+			if (*val)
+				*val = -*val;
+			else
+				*val2 = -*val2;
+		}
+
 		return scale_type;
 	default:
 		return -EOPNOTSUPP;
-- 
2.34.0

