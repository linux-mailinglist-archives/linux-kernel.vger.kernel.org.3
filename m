Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B2348860D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 21:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiAHUxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 15:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiAHUxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:53:36 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64B2C06173F;
        Sat,  8 Jan 2022 12:53:35 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id kk22so9521781qvb.0;
        Sat, 08 Jan 2022 12:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mxK+sc1QAs60zDhKd9gn07PMGjZ4i6lT+9wHQfHyyaM=;
        b=V0WjO27mbKRadm7b0rB51N+fdPHef06KY+IBUlwSqIhQr40tdWAC15srIXtcoaTDqq
         C6ayQ/9ee05huo7Tn7iQs9QZKiOUkf21YnSC79nKbtPSZUNsCJd4u9OD8t0SnB7EZmYs
         l5l5xYTlhBoWHYFWmC+yNVCTjrQrGcYEDYv5VoI1HYdCSz57X1XmRe3f0PcWEFGK/CPt
         zU7nOgTjoieSTvQffF26ZIvakpEeY6CqIgPrEAuyVAv8ETY6IQwk7aqORSQXC8bmBp+3
         thoNai9E1VpH02FaBDr5fu7A82A96vais07/OVT6DHlBOde/kzzopWTIpDS5gzurnq+H
         TnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mxK+sc1QAs60zDhKd9gn07PMGjZ4i6lT+9wHQfHyyaM=;
        b=nxD9eDh53aWSmsmksQo7cF3pHswxSsXkWLPpJC7TsK8Rlw15EIhqyquW4KV1lt/P8a
         WmZ6sZ6DTKG034L7xq2HBiLHJ5jj0k0cqst3teAJi1JQCbhEUM/i83+u7yA1wUNeGWKs
         679hRrCnTK2/KNX82Jqxbce29716MM5DHs5/ZAddzzbM9p89NRK6jWuyKy+vlkZ9CYnr
         omBX/IHQeLhbs99xT2dG21EJNkbotAHXu7hA0iqf/lk5xjIpbt3LNsariEq/CIExD6yS
         Ru9Ki2IjZ6vU5CAtFfKlWXhQ6hs2WqpbP/iyOhveb8p4eSZ5rRDz5ExCjNxIULOHMO5n
         pStQ==
X-Gm-Message-State: AOAM530fiTMZafWwdUQdGNm4hZOPUPaeLeEWDtZATKKXUJXP8dLZu1ZR
        iT+aQedDyOhAjhtXffO1a1U=
X-Google-Smtp-Source: ABdhPJyUFfqlTD4tQ4zrDLICb2V6gmDFuxC9gPXl9Wcw3zQ2DtYaTCHzCbU4tu1ji2BcT+N526hvgg==
X-Received: by 2002:a05:6214:1761:: with SMTP id et1mr61119161qvb.131.1641675214996;
        Sat, 08 Jan 2022 12:53:34 -0800 (PST)
Received: from shaak.. (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id p16sm1650377qtx.19.2022.01.08.12.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 12:53:34 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v12 04/16] iio: afe: rescale: use s64 for temporary scale calculations
Date:   Sat,  8 Jan 2022 15:53:07 -0500
Message-Id: <20220108205319.2046348-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220108205319.2046348-1-liambeguin@gmail.com>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All four scaling coefficients can take signed values.
Make tmp a signed 64-bit integer and switch to div_s64() to preserve
signs during 64-bit divisions.

Fixes: 8b74816b5a9a ("iio: afe: rescale: new driver")
Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/iio-rescale.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 774eb3044edd..271d73e420c4 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -39,7 +39,7 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct rescale *rescale = iio_priv(indio_dev);
-	unsigned long long tmp;
+	s64 tmp;
 	int ret;
 
 	switch (mask) {
@@ -77,10 +77,10 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 			*val2 = rescale->denominator;
 			return IIO_VAL_FRACTIONAL;
 		case IIO_VAL_FRACTIONAL_LOG2:
-			tmp = *val * 1000000000LL;
-			do_div(tmp, rescale->denominator);
+			tmp = (s64)*val * 1000000000LL;
+			tmp = div_s64(tmp, rescale->denominator);
 			tmp *= rescale->numerator;
-			do_div(tmp, 1000000000LL);
+			tmp = div_s64(tmp, 1000000000LL);
 			*val = tmp;
 			return ret;
 		default:
-- 
2.34.0

