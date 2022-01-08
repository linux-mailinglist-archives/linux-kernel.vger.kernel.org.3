Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B013448860C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 21:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiAHUxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 15:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiAHUxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:53:34 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35804C06173F;
        Sat,  8 Jan 2022 12:53:34 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id bp39so9569965qtb.6;
        Sat, 08 Jan 2022 12:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OecU8XiB4j/XKZWsY12TD6ThPis9wE2cHR5/jhGyLBM=;
        b=etknok4layZ6IPMp8o2EbWyZcYWPqyMmutqF6YpfCRoHhwK/cZZk2iPLhg5HvJB0My
         gIXG5Ip/K2Axtz6Vu01FXXaR7VPaLJnzdcrEsq1mley+FTN8aPVVn5vQ4JJbT89LpQmb
         Qh3DIBX5RET7aIvJiEXfAoLNXdMRQGHvSqmo2SYBu3v2mwzATmr4/XIwnTn3/hQdjCLE
         uMx9DZPazsp1RNQr8t5yffYe3dlWMDlZHC8f/L43Hfn0qO46mwG/6YgKx5zN7fjNy8FU
         0sS0jzqtSIGRRIhpbf6Olj/3QWx7o953uraF5Eyt6+8Dau5b3I06U5/Khc0cxTlHaPR3
         /dDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OecU8XiB4j/XKZWsY12TD6ThPis9wE2cHR5/jhGyLBM=;
        b=HL8eCZ47KF+zT+R5D9arowkydhBw/ffWWv5WuV5qUl9IKunRj9lfch/ObO/Tcql7QV
         rehrbbKanf27bWG+f+ZPAs6q+RkruOhI68uOauJYe/PUOwBBGabPfQY9aUBEqT6i7wpW
         j7QmwVHkn8KnCfwvbEeFRK8T8jp8oxXsQKLEChlHxQtd/6VniT8rE9vTKmBHwJ6djvIL
         RJktsMC9Iq1ijOIXbroYLhOYQzopMWEpyzWn6ITFaioSCwC9jHL510DhlN4iOuKnf2Rd
         y5OXv24S19pTSxiC7GKZmtAm3/dR+QhH9ILn6b8S69FOP/+yqMW5mU/z/Ryp6OAqxnfz
         XCHg==
X-Gm-Message-State: AOAM530wX21vZzeX4y3dvJekzEKiQnMhW5KmzcIb0NPgdWPlLn+V/FlV
        dFhUSxDuInt7imGAlvYNrY4=
X-Google-Smtp-Source: ABdhPJzRoe6Umbg+WbRadLhN6FszPgkbpOd+YQ9Vc7mrbejHNZGlCCpN+krtkacsWpVR87A2nZA7Tw==
X-Received: by 2002:ac8:5952:: with SMTP id 18mr56830855qtz.429.1641675213407;
        Sat, 08 Jan 2022 12:53:33 -0800 (PST)
Received: from shaak.. (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id p16sm1650377qtx.19.2022.01.08.12.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 12:53:33 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v12 03/16] iio: inkern: make a best effort on offset calculation
Date:   Sat,  8 Jan 2022 15:53:06 -0500
Message-Id: <20220108205319.2046348-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220108205319.2046348-1-liambeguin@gmail.com>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iio_convert_raw_to_processed_unlocked() assumes the offset is an
integer. Make a best effort to get a valid offset value for fractional
cases without breaking implicit truncations.

Fixes: 48e44ce0f881 ("iio:inkern: Add function to read the processed value")
Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
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

