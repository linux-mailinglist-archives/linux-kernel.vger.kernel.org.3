Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFFF4B3911
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 03:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbiBMC6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 21:58:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbiBMC6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 21:58:02 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9497606C2;
        Sat, 12 Feb 2022 18:57:50 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id m25so11620520qka.9;
        Sat, 12 Feb 2022 18:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BCRNBtw2ZVQIHStbST26aXf3YexYOa7wLDw0BGaj3EY=;
        b=pXTgaFQnFPlL08FDRNs7mlVjO2aJtX8rVPmkGxqgufEQAsAf3JAvqC7PcxIvQft5x3
         7q+Y5KP8mvoaSU5WrVZGIGf8eODL8T2JFEMmR7Hz8FSGBuTA7MxI/iemo/OfyHuUtChu
         3iXa8fMqiZChiUMjLdL6AJrDUHAd9Wd91CunBR98mmjwQLVUhGjhw0q5VdZrb3Xo+A3n
         bQ/5+J3fnJpQosk5N3R/xtlYvG5aAEtByIQIjqN32PUg0ybmHTC5V2FsKHdnqnBv1nl/
         HQj7EDwCpez+AA1BbQq0mJdJFlxG9LL/wlyh/CfZNKjDlXgUpRwS/PbVgGtVloZ1i/KW
         IBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BCRNBtw2ZVQIHStbST26aXf3YexYOa7wLDw0BGaj3EY=;
        b=x+1FIkUac7hpJaquBPyv88KwhwnvgPPlqvJ3ZFNredD3z+IqvWyXF1EDhLcQz2ylPZ
         Aton8+YX6EbgE1sy3o2x1YobEe6pFiJyUCypfYLY8Xoa4+4CiiTldrBNlw/UZnZuujU/
         anX7pJdxbXwjM2uwUYfPYgqRUe+3cPi1rCvl8UzkCCa4pBehz9I3XwBm/NJZAeuzZZ/c
         UG+3lBrePdbLQ9T+naN17p/Kae8xr1nKE98/cNeHo6ruZ4GUX3yDu1Umi13j4R0cXXkF
         i5lBbED3S/sPd6nucGS9/7K91ZxJRYd+18+JiFKfK+na3ujYpdjAVslJwt/MLfq+JzR2
         iNXg==
X-Gm-Message-State: AOAM53329ctkkOgNuOwNmC1bMbOPRR1HpTV4twN6axCf6U7tiG8aAO4H
        kur0cjBtoRMQGA7Of0VeB6w=
X-Google-Smtp-Source: ABdhPJyOrjexsHQk4uxeYEqg1fFNC7SWuRdj5h+Bl12Jdl3ViCPB+NDEgMbqBV86dA9oSqX6re8MxQ==
X-Received: by 2002:a05:620a:2481:: with SMTP id i1mr4163940qkn.159.1644721069819;
        Sat, 12 Feb 2022 18:57:49 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id y15sm14551106qkp.22.2022.02.12.18.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 18:57:49 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v15 05/10] iio: afe: rescale: reduce risk of integer overflow
Date:   Sat, 12 Feb 2022 21:57:34 -0500
Message-Id: <20220213025739.2561834-6-liambeguin@gmail.com>
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

Reduce the risk of integer overflow by doing the scale calculation on
a 64-bit integer. Since the rescaling is only performed on *val, reuse
the IIO_VAL_FRACTIONAL_LOG2 case.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/iio-rescale.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 5d78f0cf47d2..46947c68d3a9 100644
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
2.35.1.4.g5d01301f2b86

