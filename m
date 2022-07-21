Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97A257D3F8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiGUTQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGUTQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:16:23 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F4A8CCB6;
        Thu, 21 Jul 2022 12:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1658430936; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TpEIrkLg+RjeEMsJEobFd+We3zuNbgRhORtJwFe7tLo=;
        b=bxnjjU7WPFUAxSxikQTXmPCNzA1fAgt26b0E6uUpzMunNZ/fDl4LU9xzq4vrInKEr/Pn1k
        vio8/kSsjlAy99y7jhf6P6GkDRWP/v45euOEg9Im5xKhWoVD66isfNMCNE18/cDsnYwHY1
        F6wO1Kg5nNbieDMoMR/09y/QH06DVdo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>, Peter Rosin <peda@axentia.se>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/4] iio: afe/rescale: Implement write_raw
Date:   Thu, 21 Jul 2022 20:15:26 +0100
Message-Id: <20220721191526.374152-5-paul@crapouillou.net>
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

Implement write_raw by converting the value if writing the scale, or
just calling the managed channel driver's write_raw otherwise.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/afe/iio-rescale.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 5c9970b93384..0edb62ee4508 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -141,6 +141,27 @@ int rescale_process_offset(struct rescale *rescale, int scale_type,
 	}
 }
 
+static int rescale_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct rescale *rescale = iio_priv(indio_dev);
+	unsigned long long tmp;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		tmp = val * 1000000000LL;
+		do_div(tmp, rescale->numerator);
+		tmp *= rescale->denominator;
+		do_div(tmp, 1000000000LL);
+		return iio_write_channel_attribute(rescale->source, tmp, 0,
+						   IIO_CHAN_INFO_SCALE);
+	default:
+		return iio_write_channel_attribute(rescale->source,
+						   val, val2, mask);
+	}
+}
+
 static int rescale_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -250,6 +271,7 @@ static int rescale_read_avail(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info rescale_info = {
+	.write_raw = rescale_write_raw,
 	.read_raw = rescale_read_raw,
 	.read_avail = rescale_read_avail,
 };
-- 
2.35.1

