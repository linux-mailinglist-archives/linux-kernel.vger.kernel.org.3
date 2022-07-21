Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE5957D3FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiGUTQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiGUTQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:16:19 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB5688F31;
        Thu, 21 Jul 2022 12:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1658430935; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4deDKaInTPPI431B2aFwgBdfpUrMgmqvd/2POX4jGg8=;
        b=N0a4h7r90Owsb3XFhJyLBauhbzyBIY7yIH+CAlbl8I7enq6xqFbIOddTmpi+wF8Jq+cmr2
        jDVG8ute2ilHNHCBquyQZ/QVEWPOZb3cA9PviiNb4iB6V+UjaFUdJclwWkMpoT2eiv/HwQ
        S7XILqM6j9Zag6Y9km8er7mT/MmL3YM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>, Peter Rosin <peda@axentia.se>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/4] iio: afe/rescale: Add support for converting scale avail table
Date:   Thu, 21 Jul 2022 20:15:25 +0100
Message-Id: <20220721191526.374152-4-paul@crapouillou.net>
In-Reply-To: <20220721191526.374152-1-paul@crapouillou.net>
References: <20220721191526.374152-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the IIO channel has a scale_available attribute, we want the values
contained to be properly converted the same way the scale value is.

Since rescale_process_scale() may change the encoding type, we must
convert the IIO_AVAIL_LIST to a IIO_AVAIL_LIST_WITH_TYPE.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/afe/iio-rescale.c   | 85 +++++++++++++++++++++++++++++++++
 include/linux/iio/afe/rescale.h |  2 +
 2 files changed, 87 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 6949d2151025..5c9970b93384 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -232,6 +232,18 @@ static int rescale_read_avail(struct iio_dev *indio_dev,
 		*type = IIO_VAL_INT;
 		return iio_read_avail_channel_raw(rescale->source,
 						  vals, length);
+	case IIO_CHAN_INFO_SCALE:
+		if (rescale->chan_processed) {
+			return iio_read_avail_channel_attribute(rescale->source,
+								vals, type,
+								length,
+								IIO_CHAN_INFO_SCALE);
+		} else if (rescale->scale_len) {
+			*length = rescale->scale_len;
+			*vals = rescale->scale_data;
+			return IIO_AVAIL_LIST_WITH_TYPE;
+		}
+		fallthrough;
 	default:
 		return -EINVAL;
 	}
@@ -266,11 +278,74 @@ static ssize_t rescale_write_ext_info(struct iio_dev *indio_dev,
 					  buf, len);
 }
 
+static int rescale_init_scale_avail(struct device *dev, struct rescale *rescale)
+{
+	int ret, type, length, *data;
+	const int *scale_raw;
+	unsigned int i;
+	size_t out_len;
+
+	ret = iio_read_avail_channel_attribute(rescale->source, &scale_raw,
+					       &type, &length,
+					       IIO_CHAN_INFO_SCALE);
+	if (ret < 0)
+		return ret;
+
+	switch (ret) {
+	case IIO_AVAIL_LIST_WITH_TYPE:
+		out_len = length;
+		break;
+	case IIO_AVAIL_LIST:
+		if (type == IIO_VAL_INT)
+			out_len = length * 3 / 1;
+		else
+			out_len = length * 3 / 2;
+		break;
+	default:
+		/* TODO: Support IIO_AVAIL_RANGE */
+		return -EOPNOTSUPP;
+	}
+
+	data = devm_kzalloc(dev, sizeof(*data) * out_len, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	if (ret == IIO_AVAIL_LIST_WITH_TYPE) {
+		memcpy(data, scale_raw, sizeof(*scale_raw) * length);
+	} else if (type == IIO_VAL_INT) {
+		for (i = 0; i < length; i++) {
+			data[i * 3 + 0] = scale_raw[i];
+			data[i * 3 + 2] = IIO_VAL_INT;
+		}
+	} else {
+		for (i = 0; i < length / 2; i++) {
+			data[i * 3 + 0] = scale_raw[i * 2];
+			data[i * 3 + 1] = scale_raw[i * 2 + 1];
+			data[i * 3 + 2] = type;
+		}
+	}
+
+	for (i = 0; i < out_len; i += 3) {
+		ret = rescale_process_scale(rescale, data[i + 2],
+					    &data[i], &data[i + 1]);
+		if (ret < 0)
+			return ret;
+
+		data[i + 2] = ret;
+	}
+
+	rescale->scale_len = out_len;
+	rescale->scale_data = data;
+
+	return 0;
+}
+
 static int rescale_configure_channel(struct device *dev,
 				     struct rescale *rescale)
 {
 	struct iio_chan_spec *chan = &rescale->chan;
 	struct iio_chan_spec const *schan = rescale->source->channel;
+	int ret;
 
 	chan->indexed = 1;
 	chan->output = schan->output;
@@ -303,6 +378,16 @@ static int rescale_configure_channel(struct device *dev,
 	    !rescale->chan_processed)
 		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
 
+	if (iio_channel_has_available(schan, IIO_CHAN_INFO_SCALE)) {
+		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_SCALE);
+
+		if (!rescale->chan_processed) {
+			ret = rescale_init_scale_avail(dev, rescale);
+			if (ret)
+				return ret;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/iio/afe/rescale.h b/include/linux/iio/afe/rescale.h
index 6eecb435488f..74de2962f864 100644
--- a/include/linux/iio/afe/rescale.h
+++ b/include/linux/iio/afe/rescale.h
@@ -26,6 +26,8 @@ struct rescale {
 	s32 numerator;
 	s32 denominator;
 	s32 offset;
+	int scale_len;
+	int *scale_data;
 };
 
 int rescale_process_scale(struct rescale *rescale, int scale_type,
-- 
2.35.1

