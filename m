Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DF547CBD5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242244AbhLVDrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242193AbhLVDq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:46:58 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E50C061746;
        Tue, 21 Dec 2021 19:46:58 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id n15so1113743qta.0;
        Tue, 21 Dec 2021 19:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Gr+hfyXSmVuc3I7nGeWbuucj1tCjCUpPYNUNmCPI3E=;
        b=FlI4StCgijESKymNVPP9cPVKmDlfYQrBO6LxmYKeR/nA1DAJQzcuGa9p+qcuQD8UYT
         ZqQrKBGjTvfwG1zA/SvYrXWYbL/lq2AWkON65atByrodqcNpRpB0HdEs2l8UXo92Y8pw
         0q+UJXrNjtWIEx0h+i8EOJlEfFlRjeQ+RndORmcp66vmatiLLlZdwCuIzzo2x9GlTCbp
         V4k3Ka1Wg/j1JRHkIJ5Jt0GHRB2ixsEVlwXaKzIp6emqy3AhWNgPfZj+SDg3nUjc5VNr
         aJ8M8GxiuKihuH6gWgsAPiKzK4EJtwYNU5aw3Y3JYDrQJZSXWeMNTAp1b2O0ier4CKOq
         83hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Gr+hfyXSmVuc3I7nGeWbuucj1tCjCUpPYNUNmCPI3E=;
        b=TBOnZwMEPb17fuicE74yGTvt4cNKjegyDK7k72Q12f8t9BSNWUTFTnTmr1YAYbxzHb
         Zufk34NLB1QYdrS9YJcUlkBeodwU20N6Seqqo6G1RY6Sz0lYdKU2/7r5aX4WyUxg754D
         NJM2m/QkQrJJoFec0JuZ1/H1Yck2RlCPSZcX+wckQnFZ9Qx/eDN1nR/De9g0u5+TqoB0
         3O5TPM8xtcK/VsOxtfUnv9xW9jZAm4SengzJ1I+lTZhEYH2QJImwxza4zN3NzEK7sllw
         ghrJd8PCxRuL/gDCddNgvcsIwAbCgPQq+tkbAqrEheMTATub7/BuxC45N8UTXqWpK2VR
         oI0A==
X-Gm-Message-State: AOAM532c0Y5nqJCdItlElc3xSGsMDdHtWeDvyWZsFdGDTZVHYxcXy3pj
        8votIFkAnwn1E4IwW+ZuJqPU4fCqDO7k8A==
X-Google-Smtp-Source: ABdhPJyqw/v3WnEQcjraAy9L7d7S1oWNcLq+EZ97VHK1L3z+DM4iCdWoEqFIOAyY2/tvBhD9Mnk34Q==
X-Received: by 2002:a05:622a:50a:: with SMTP id l10mr897703qtx.491.1640144817690;
        Tue, 21 Dec 2021 19:46:57 -0800 (PST)
Received: from shaak.xiphos.ca (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id f18sm918944qko.34.2021.12.21.19.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:46:57 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v11 03/15] iio: inkern: make a best effort on offset calculation
Date:   Tue, 21 Dec 2021 22:46:34 -0500
Message-Id: <20211222034646.222189-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211222034646.222189-1-liambeguin@gmail.com>
References: <20211222034646.222189-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

iio_convert_raw_to_processed_unlocked() assumes the offset is an
integer. Make a best effort to get a valid offset value for fractional
cases without breaking implicit truncations.

Fixes: 48e44ce0f881 ("iio:inkern: Add function to read the processed value")
Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/inkern.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index dbe13fad3cbb..df74765d33dc 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -595,13 +595,35 @@ EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
 static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 	int raw, int *processed, unsigned int scale)
 {
-	int scale_type, scale_val, scale_val2, offset;
+	int scale_type, scale_val, scale_val2;
+	int offset_type, offset_val, offset_val2;
 	s64 raw64 = raw;
-	int ret;
 
-	ret = iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_OFFSET);
-	if (ret >= 0)
-		raw64 += offset;
+	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,
+				       IIO_CHAN_INFO_OFFSET);
+	if (offset_type >= 0) {
+		switch (offset_type) {
+		case IIO_VAL_INT:
+			break;
+		case IIO_VAL_INT_PLUS_MICRO:
+		case IIO_VAL_INT_PLUS_NANO:
+			/*
+			 * Both IIO_VAL_INT_PLUS_MICRO and IIO_VAL_INT_PLUS_NANO
+			 * implicitely truncate the offset to it's integer form.
+			 */
+			break;
+		case IIO_VAL_FRACTIONAL:
+			offset_val /= offset_val2;
+			break;
+		case IIO_VAL_FRACTIONAL_LOG2:
+			offset_val >>= offset_val2;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		raw64 += offset_val;
+	}
 
 	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
 					IIO_CHAN_INFO_SCALE);
-- 
2.34.0

