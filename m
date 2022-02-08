Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CDD4ACEAB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 03:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345362AbiBHCJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 21:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345421AbiBHCEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 21:04:52 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F75C061355;
        Mon,  7 Feb 2022 18:04:51 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id p14so13705606qtx.0;
        Mon, 07 Feb 2022 18:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4vn2QrbP+FP78/S6RhE3MtkGHax4gBMpmADGrGNkNY=;
        b=acBuVRXE779T3/xBPjTPkCk+f9KQB3pRwtzbHl+qz6/1SLjoHq0C0LHuxnC/RLR7Qx
         KqlDsKuRic7rsBH1rG31gG5vhE0Pah3azz0SCcl6ZhVHXAjFZ3ABHVaOW5Id2oPy+A52
         DrFw8wUZfQN//+SDpj32lR27MRVDSmg587llaKyAFQWeiNRx/bGIONHcsDI9KgqwAwen
         +s9zQHpImpDhL6QI8jzs5wlZpTxPQxygaWKzhNEXkvUOAMbA39E1IZ4Px9BV5FOir0yW
         0V+j8tCQyT0hNgXqpmTPGzMqSVwtiNGFFaFvX/j/Uei28qPiPYYBsofo9QBJwqc/w9hQ
         DLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4vn2QrbP+FP78/S6RhE3MtkGHax4gBMpmADGrGNkNY=;
        b=EAx/aCu4MISpNQzOmMy9Id6bfezDClVGfHNiXlxhOctuetFvaXACeg9F4imCEH7FqW
         D5+qGDiORQGyZt8ZuWzXF1Io3TkkX9ExmxWS1q5eQrdERGrIZv+qMeSN3lT7IdGOSzyD
         pIJcUE2BxZgw5bnBJ7+Ts4WOLMtkM67K8B6Q9u+MVKSQ4mfuR6iR79mCYCJvmrRNk4VZ
         y7wQ22SDuRu+OHnjWwpnuSMAWCNImAHu+4cwXRiqLQawOSc5dJkp09eNh/KTKRWwgMI7
         7XfiSERodkd3X/Fes4f1TwwpRes879HIIbSRyGg1xUKLojiEJUeS9pjGLZGln1hl8WMu
         kjqg==
X-Gm-Message-State: AOAM53315KGEXqJCB5/ADI6kD96VdwZyJUb50keZQOZxaKBWc0dg48Sq
        pEYwZSI2LTrzIn/oy1NCi0fRg7k9xWE=
X-Google-Smtp-Source: ABdhPJxNFjGHNthpn1jVUoBgcHJ4OkygqwvfSTdaDIW81SEkwd4XlEizv5xirVo3Fm2ks4Ok+i1QXQ==
X-Received: by 2002:ac8:58c2:: with SMTP id u2mr1649758qta.509.1644285891180;
        Mon, 07 Feb 2022 18:04:51 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id u9sm1416055qko.130.2022.02.07.18.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 18:04:50 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v14 03/11] iio: afe: rescale: add offset support
Date:   Mon,  7 Feb 2022 21:04:33 -0500
Message-Id: <20220208020441.3081162-4-liambeguin@gmail.com>
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

This is a preparatory change required for the addition of temperature
sensing front ends.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/iio-rescale.c   | 81 +++++++++++++++++++++++++++++++++
 include/linux/iio/afe/rescale.h |  4 ++
 2 files changed, 85 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index f833eb38f8bb..63035b4bce5e 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -3,6 +3,7 @@
  * IIO rescale driver
  *
  * Copyright (C) 2018 Axentia Technologies AB
+ * Copyright (C) 2022 Liam Beguin <liambeguin@gmail.com>
  *
  * Author: Peter Rosin <peda@axentia.se>
  */
@@ -82,11 +83,46 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 	}
 }
 
+int rescale_process_offset(struct rescale *rescale, int scale_type,
+			   int scale, int scale2, int schan_off,
+			   int *val, int *val2)
+{
+	s64 tmp, tmp2;
+
+	switch (scale_type) {
+	case IIO_VAL_FRACTIONAL:
+		tmp = (s64)rescale->offset * scale2;
+		*val = div_s64(tmp, scale) + schan_off;
+		return IIO_VAL_INT;
+	case IIO_VAL_INT:
+		*val = div_s64(rescale->offset, scale) + schan_off;
+		return IIO_VAL_INT;
+	case IIO_VAL_FRACTIONAL_LOG2:
+		tmp = (s64)rescale->offset * (1 << scale2);
+		*val = div_s64(tmp, scale) + schan_off;
+		return IIO_VAL_INT;
+	case IIO_VAL_INT_PLUS_NANO:
+		tmp = (s64)rescale->offset * GIGA;
+		tmp2 = ((s64)scale * GIGA) + scale2;
+		*val = div64_s64(tmp, tmp2) + schan_off;
+		return IIO_VAL_INT;
+	case IIO_VAL_INT_PLUS_MICRO:
+		tmp = (s64)rescale->offset * MEGA;
+		tmp2 = ((s64)scale * MEGA) + scale2;
+		*val = div64_s64(tmp, tmp2) + schan_off;
+		return IIO_VAL_INT;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int rescale_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
 {
 	struct rescale *rescale = iio_priv(indio_dev);
+	int scale, scale2;
+	int schan_off = 0;
 	int ret;
 
 	switch (mask) {
@@ -113,6 +149,47 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 			ret = iio_read_channel_scale(rescale->source, val, val2);
 		}
 		return rescale_process_scale(rescale, ret, val, val2);
+	case IIO_CHAN_INFO_OFFSET:
+		/*
+		 * Processed channels are scaled 1-to-1 and source offset is
+		 * already taken into account.
+		 *
+		 * In other cases, real world measurement are expressed as:
+		 *
+		 *	schan_scale * (raw + schan_offset)
+		 *
+		 * Given that the rescaler parameters are applied recursively:
+		 *
+		 *	rescaler_scale * (schan_scale * (raw + schan_offset) +
+		 *		rescaler_offset)
+		 *
+		 * Or,
+		 *
+		 *	(rescaler_scale * schan_scale) * (raw +
+		 *		(schan_offset +	rescaler_offset / schan_scale)
+		 *
+		 * Thus, reusing the original expression the parameters exposed
+		 * to userspace are:
+		 *
+		 *	scale = schan_scale * rescaler_scale
+		 *	offset = schan_offset + rescaler_offset / schan_scale
+		 */
+		if (rescale->chan_processed) {
+			*val = rescale->offset;
+			return IIO_VAL_INT;
+		}
+
+		if (iio_channel_has_info(rescale->source->channel,
+					 IIO_CHAN_INFO_OFFSET)) {
+			ret = iio_read_channel_offset(rescale->source,
+						      &schan_off, NULL);
+			if (ret != IIO_VAL_INT)
+				return ret < 0 ? ret : -EOPNOTSUPP;
+		}
+
+		ret = iio_read_channel_scale(rescale->source, &scale, &scale2);
+		return rescale_process_offset(rescale, ret, scale, scale2,
+					      schan_off, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -189,6 +266,9 @@ static int rescale_configure_channel(struct device *dev,
 	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_SCALE);
 
+	if (rescale->offset)
+		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
+
 	/*
 	 * Using .read_avail() is fringe to begin with and makes no sense
 	 * whatsoever for processed channels, so we make sure that this cannot
@@ -353,6 +433,7 @@ static int rescale_probe(struct platform_device *pdev)
 	rescale->cfg = of_device_get_match_data(dev);
 	rescale->numerator = 1;
 	rescale->denominator = 1;
+	rescale->offset = 0;
 
 	ret = rescale->cfg->props(dev, rescale);
 	if (ret)
diff --git a/include/linux/iio/afe/rescale.h b/include/linux/iio/afe/rescale.h
index 8a2eb34af327..6eecb435488f 100644
--- a/include/linux/iio/afe/rescale.h
+++ b/include/linux/iio/afe/rescale.h
@@ -25,8 +25,12 @@ struct rescale {
 	bool chan_processed;
 	s32 numerator;
 	s32 denominator;
+	s32 offset;
 };
 
 int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2);
+int rescale_process_offset(struct rescale *rescale, int scale_type,
+			   int scale, int scale2, int schan_off,
+			   int *val, int *val2);
 #endif /* __IIO_RESCALE_H__ */
-- 
2.35.1.4.g5d01301f2b86

