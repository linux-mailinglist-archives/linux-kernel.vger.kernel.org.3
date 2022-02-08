Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438224ACEB0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 03:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345670AbiBHCKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 21:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345423AbiBHCEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 21:04:54 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339AFC061A73;
        Mon,  7 Feb 2022 18:04:54 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id s1so13625527qtw.9;
        Mon, 07 Feb 2022 18:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A3rHofytIHL6hqd3yZWm4UUK7FUFMg5OI+YIKcI4+yE=;
        b=n6A3CQsLf20f3kv2RMwudyWlMDW9dto76/g0Hm7lKUP1SR1LiHMG8uZfiyI1yIyaP3
         4CKzZASKDcfEMaVk6/3YF/3x4G2Rwd0y8vRDg6FI7zDGoSuWboAAIKVUkg4sRDl/pmQu
         64m8Wmg11YKID+fAMZqBJmE9SX9AG0Ay4rES6gi0y1HMd8UqAQOyMmpqbKp8cin+y2WZ
         jE1IMiQWLrwVe4iSxZBs6kqbF0OGxGyc20r8SH021xiKLCXoH5Z7yXs/muVmApivt8rT
         K+2XBr4m6j1XsTNKWFEmx/5+rRBxgAD2DdAnCNPyDulKpHeg+9W0CuGMd+udc5EyCa6e
         AcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A3rHofytIHL6hqd3yZWm4UUK7FUFMg5OI+YIKcI4+yE=;
        b=L8SWpVEPox5r8nqsGelLrE3ozrlZr8XyAwI9UDyZZIlDLnDSW84q7AoDVhx7eY5j4t
         HOrC34g31uzA1fJGOErK7yq6tDQuSiZ1LGxzYPcO0sc6kj2KYK+bPjDquGyytVYXAlMg
         ROV0uSSTZlrmHH7bvwJGR3JN0QdKkqrC1DtKLfEzD3y15GKxFG9mjTW5ChdZbJucEXHt
         S+C5AHFda4jvTLVJDEVC5iW1tQzvjub0hM/6ywFj6hERx5KzyhoEh4wmZd8aahjwKfmM
         0ifMZT7lAw7OPbpYRJraamGshmU1XNxpwb7vyG0dLP1gjIJnJpX3wpIPgpiF7RLSNOZc
         XB6w==
X-Gm-Message-State: AOAM533VVd1QgqJGANMkCml9jQKRq/JB0ZYlYspoLiz6gatU4TlqarSK
        uStGIMAtETRQd5TP99BF6B3Gpxewuzo=
X-Google-Smtp-Source: ABdhPJzEcQkwqQ4iRPCPNJdtO9sLm61x0xXKzmQMgQ2HwUTbMRTJpEd3gEIdgUfwymeRG53c3jMFqA==
X-Received: by 2002:ac8:5d91:: with SMTP id d17mr1675104qtx.341.1644285893393;
        Mon, 07 Feb 2022 18:04:53 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id u9sm1416055qko.130.2022.02.07.18.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 18:04:52 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v14 05/11] iio: afe: rescale: reduce risk of integer overflow
Date:   Mon,  7 Feb 2022 21:04:35 -0500
Message-Id: <20220208020441.3081162-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220208020441.3081162-1-liambeguin@gmail.com>
References: <20220208020441.3081162-1-liambeguin@gmail.com>
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
index 468e6c345bd1..67273de46843 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -25,21 +25,31 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
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
@@ -51,7 +61,10 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
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

