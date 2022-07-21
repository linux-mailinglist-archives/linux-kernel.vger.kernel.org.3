Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F245F57D3F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiGUTQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiGUTQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:16:09 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD37F88E22;
        Thu, 21 Jul 2022 12:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1658430934; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xLBaXOfpO4qyAy7Jvs3CDBcjV0wCVjhwgyi0HxwjqVY=;
        b=iKxXW9LVarH8R+m9bHd1XF8FZt8OoF4phsTTDiBPEKk6EzeIzlGU7CSKGakZxx0ZFywwn4
        7ipeetzNKzACpn+O5wHjzfAueMyZ2MOu3CKZDwxlqomPF1WnChiACCv9gowP2RP4HIIigu
        yvXX2N+Ux3MnMbmsUKzD1AbmdTNhn3w=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>, Peter Rosin <peda@axentia.se>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/4] iio: inkern: Remove useless argument to iio_channel_read_max()
Date:   Thu, 21 Jul 2022 20:15:23 +0100
Message-Id: <20220721191526.374152-2-paul@crapouillou.net>
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

The 'type' argument was passed by the only caller of the
iio_channel_read_max() function as a pointer to return an extra value,
but the value of the variable passed by the caller was never read
afterwards.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/inkern.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index df74765d33dc..e8a25852f0df 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -813,21 +813,22 @@ int iio_read_avail_channel_raw(struct iio_channel *chan,
 EXPORT_SYMBOL_GPL(iio_read_avail_channel_raw);
 
 static int iio_channel_read_max(struct iio_channel *chan,
-				int *val, int *val2, int *type,
+				int *val, int *val2,
 				enum iio_chan_info_enum info)
 {
 	int unused;
 	const int *vals;
 	int length;
 	int ret;
+	int type;
 
 	if (!val2)
 		val2 = &unused;
 
-	ret = iio_channel_read_avail(chan, &vals, type, &length, info);
+	ret = iio_channel_read_avail(chan, &vals, &type, &length, info);
 	switch (ret) {
 	case IIO_AVAIL_RANGE:
-		switch (*type) {
+		switch (type) {
 		case IIO_VAL_INT:
 			*val = vals[2];
 			break;
@@ -840,7 +841,7 @@ static int iio_channel_read_max(struct iio_channel *chan,
 	case IIO_AVAIL_LIST:
 		if (length <= 0)
 			return -EINVAL;
-		switch (*type) {
+		switch (type) {
 		case IIO_VAL_INT:
 			*val = vals[--length];
 			while (length) {
@@ -863,7 +864,6 @@ int iio_read_max_channel_raw(struct iio_channel *chan, int *val)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
 	int ret;
-	int type;
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
 	if (!chan->indio_dev->info) {
@@ -871,7 +871,7 @@ int iio_read_max_channel_raw(struct iio_channel *chan, int *val)
 		goto err_unlock;
 	}
 
-	ret = iio_channel_read_max(chan, val, NULL, &type, IIO_CHAN_INFO_RAW);
+	ret = iio_channel_read_max(chan, val, NULL, IIO_CHAN_INFO_RAW);
 err_unlock:
 	mutex_unlock(&iio_dev_opaque->info_exist_lock);
 
-- 
2.35.1

