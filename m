Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4603488623
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 21:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiAHUyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 15:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiAHUxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:53:42 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5371C061747;
        Sat,  8 Jan 2022 12:53:41 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id o17so9653950qtk.1;
        Sat, 08 Jan 2022 12:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UW/B2X5MfhYVZnFmf8491KJHtOUBdLNdyCanOaNTorM=;
        b=HrvtWVtOPobsAb6hXarWkL3EiLPSPbd8PxLJfQZem6pmAEEC1JW1t0t2HPkBE5K1a7
         0QuCnaySfD2VM3VFQISl1QJVHJMmrXnm2eDl5/iFrc2qQGolCQn8g+5pqMAz1ZB0eLPc
         06GqNw7ZsE6uiJNKw69HNNGTSUPYca4ZDe6fO2QPVuKrUgvh7FYMQELx5o8DBuvw5CVv
         a9duixAK4/X9S15aexqr64HOfS4pVSyQPJcEnQTjknpX1paKdqvaPcP2nNbKRm8f6u33
         eNzYdFTsedTq6MzyGHJSQIrmnI1dClTddkowQDK2qHqib1fu8qJQaXBi7rZUCGyMVLRI
         NSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UW/B2X5MfhYVZnFmf8491KJHtOUBdLNdyCanOaNTorM=;
        b=NDRNukb70JIlH+H+ZEL+I98UrhVgqc113mYn9ne5oXUgxuWFep4w62EcwdZuL2TSHx
         wRzGYVORJLBhjUQLEgVb5/2ShgPC/qDb69Q5tf42aJSjtlr+5lyCoVe3tSbA66SZrnaN
         8cnMRohg+Wn+JiCJdqzsNoYkJ9O8H7cjjSW8bIv3O5FTEoXXeMwJoJxTk9qtG+hRmi32
         9MAJJN0H48q3dFB3rynELylse99nV/E1IzegROSLgrLP8y7JAohw8llZa9gW/mBluQKa
         U1wGnENb1xXrgJWbB9r3CdjLu0043NJKNA1vdWU/3/rnK5mLWJhgS8vRwy3gtQAFnWWc
         rE0g==
X-Gm-Message-State: AOAM532kKQmCcir87yGyo47KZwcrcb7WJ33ZT7vRSgwMjn8w8h5ug56Q
        5FOzh4BzArEUPr93+end3Og=
X-Google-Smtp-Source: ABdhPJzaJ81mu/nSAW4l4hlUBA7uRRu9GYQk46XwFMYvQTE/E3u6E96QdqVC81Q7MojZtmBBTMpT1w==
X-Received: by 2002:a05:622a:c:: with SMTP id x12mr61230640qtw.502.1641675221005;
        Sat, 08 Jan 2022 12:53:41 -0800 (PST)
Received: from shaak.. (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id p16sm1650377qtx.19.2022.01.08.12.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 12:53:40 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v12 08/16] iio: afe: rescale: add offset support
Date:   Sat,  8 Jan 2022 15:53:11 -0500
Message-Id: <20220108205319.2046348-9-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220108205319.2046348-1-liambeguin@gmail.com>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory change required for the addition of temperature
sensing front ends.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/iio-rescale.c   | 80 +++++++++++++++++++++++++++++++++
 include/linux/iio/afe/rescale.h |  4 ++
 2 files changed, 84 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index f833eb38f8bb..68eb3e341939 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -82,11 +82,46 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
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
@@ -113,6 +148,47 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
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
@@ -189,6 +265,9 @@ static int rescale_configure_channel(struct device *dev,
 	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_SCALE);
 
+	if (rescale->offset)
+		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
+
 	/*
 	 * Using .read_avail() is fringe to begin with and makes no sense
 	 * whatsoever for processed channels, so we make sure that this cannot
@@ -353,6 +432,7 @@ static int rescale_probe(struct platform_device *pdev)
 	rescale->cfg = of_device_get_match_data(dev);
 	rescale->numerator = 1;
 	rescale->denominator = 1;
+	rescale->offset = 0;
 
 	ret = rescale->cfg->props(dev, rescale);
 	if (ret)
diff --git a/include/linux/iio/afe/rescale.h b/include/linux/iio/afe/rescale.h
index 698092b6cbb1..891bc935a396 100644
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
2.34.0

