Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0775157D3F3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbiGUTQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiGUTQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:16:11 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C135281;
        Thu, 21 Jul 2022 12:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1658430935; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LREkjgo/OLUP8VZvhRzR1bR2iChWZ8LSMmvhzG4e+xA=;
        b=Rq13j/a0og8OKoNapQcUcTC6HDoz6hyVYgWFEX6rmoIMoMYv3/wBrvuwc033Neo4pN2Z58
        5PRFieWuiGZE3w08SVyuqXCbMSOD2J/Ny/q8D8I0qKkvqD5oUkEXJpjv789tyzSqPKsJk5
        jvNiSw+VtHse775vvuX0fJFYXmKEBlk=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>, Peter Rosin <peda@axentia.se>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/4] iio: core: Add support for IIO_AVAIL_LIST_WITH_TYPE
Date:   Thu, 21 Jul 2022 20:15:24 +0100
Message-Id: <20220721191526.374152-3-paul@crapouillou.net>
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

The IIO_AVAIL_LIST_WITH_TYPE specifies that the array that corresponds
to the available values is composed by cells of 3 integers, the first
two representing the value itself (similar to what you would have with
IIO_AVAIL_LIST), and the third integer representing the encoding type of
the value.

This can be used for instance when a driver's .read_avail() callback
returns values which cannot be represented with an unique encoding type.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/industrialio-core.c | 25 +++++++++++++++++++++++++
 drivers/iio/inkern.c            | 23 +++++++++++++++++++++++
 include/linux/iio/consumer.h    |  6 ++++--
 include/linux/iio/types.h       |  1 +
 4 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index adf054c7a75e..99ced9eab069 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -838,6 +838,29 @@ static ssize_t iio_format_avail_range(char *buf, const int *vals, int type)
 	return iio_format_list(buf, vals, type, 3, "[", "]");
 }
 
+static ssize_t iio_format_avail_list_with_type(char *buf, const int *vals,
+					       int length)
+{
+	ssize_t len = 0;
+	int i;
+
+	for (i = 0; i < length; i += 3) {
+		if (i != 0) {
+			len += sysfs_emit_at(buf, len, " ");
+			if (len >= PAGE_SIZE)
+				return -EFBIG;
+		}
+
+		len += __iio_format_value(buf, len, vals[i + 2], 2, &vals[i]);
+		if (len >= PAGE_SIZE)
+			return -EFBIG;
+	}
+
+	len += sysfs_emit_at(buf, len, "\n");
+
+	return len;
+}
+
 static ssize_t iio_read_channel_info_avail(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
@@ -860,6 +883,8 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
 		return iio_format_avail_list(buf, vals, type, length);
 	case IIO_AVAIL_RANGE:
 		return iio_format_avail_range(buf, vals, type);
+	case IIO_AVAIL_LIST_WITH_TYPE:
+		return iio_format_avail_list_with_type(buf, vals, length);
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index e8a25852f0df..92d225f1ddd5 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -855,6 +855,29 @@ static int iio_channel_read_max(struct iio_channel *chan,
 		}
 		return 0;
 
+	case IIO_AVAIL_LIST_WITH_TYPE:
+		if (length <= 0 || length % 3 != 0)
+			return -EINVAL;
+
+		if (vals[length - 1] != IIO_VAL_INT) {
+			/* FIXME: learn about max for other iio values */
+			return -EINVAL;
+		}
+
+		*val = vals[length - 3];
+		length -= 3;
+
+		for (; length; length -= 3) {
+			if (vals[length - 1] != IIO_VAL_INT) {
+				/* FIXME: learn about max for other iio values */
+				return -EINVAL;
+			}
+
+			if (vals[length - 3] > *val)
+				*val = vals[length - 3];
+		}
+		return 0;
+
 	default:
 		return ret;
 	}
diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 5fa5957586cf..99dd12e10fb6 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -309,7 +309,8 @@ int iio_read_max_channel_raw(struct iio_channel *chan, int *val);
  * @vals:		Available values read back.
  * @length:		Number of entries in vals.
  *
- * Returns an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST.
+ * Returns an error code, IIO_AVAIL_RANGE, IIO_AVAIL_LIST or
+ * IIO_AVAIL_LIST_WITH_TYPE.
  *
  * For ranges, three vals are always returned; min, step and max.
  * For lists, all the possible values are enumerated.
@@ -328,7 +329,8 @@ int iio_read_avail_channel_raw(struct iio_channel *chan,
  * @length:		Number of entries in vals.
  * @attribute:		info attribute to be read back.
  *
- * Returns an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST.
+ * Returns an error code, IIO_AVAIL_RANGE, IIO_AVAIL_LIST or
+ * IIO_AVAIL_LIST_WITH_TYPE.
  */
 int iio_read_avail_channel_attribute(struct iio_channel *chan,
 				     const int **vals, int *type, int *length,
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index a7aa91f3a8dc..9777d1357080 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -32,6 +32,7 @@ enum iio_event_info {
 enum iio_available_type {
 	IIO_AVAIL_LIST,
 	IIO_AVAIL_RANGE,
+	IIO_AVAIL_LIST_WITH_TYPE,
 };
 
 enum iio_chan_info_enum {
-- 
2.35.1

