Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA2947A2B9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 23:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbhLSWkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 17:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbhLSWkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 17:40:02 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB9CC061574;
        Sun, 19 Dec 2021 14:40:01 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id b67so7782085qkg.6;
        Sun, 19 Dec 2021 14:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=175owKn8svKTjKHpJ6j/PlL+nNrbx2r36iN22vV80Jc=;
        b=gpKMkqCcjORx7YraGeFlnVGrcsWa8TUewN5J3OAz4bLRhsblU3zgqj6qATpDaB4yi2
         69WOpt1e+XL5l0a6aTayp5Dsa89J9TIRYW/ThU5Iz5hGvRaJe0hmWKUGISheAtU6NWkE
         mIYQMERykEB8OYL7nP0bngLPmm9JDVenJLJNaPaYGSieF3oqmbpFY3cR5U8Ynh811nq8
         QNJ4Qz7oNQJ5whLFBpKSqezkb78q1izVCXALIahIEzok8TbJhE8gWwMU1MQkiUXHt3ot
         bStHaWNIlZujZD8H/31sm8sKKT6eXFm2QspNX6oT7NHVXoKBhp6/w+p31Ieno+nK9rx9
         rvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=175owKn8svKTjKHpJ6j/PlL+nNrbx2r36iN22vV80Jc=;
        b=yKGURKtNMHyVq3qAxj6do3AFZbyBts0uCKH5HyGG3V7fHvUYWwEHjNzya3DPiqPmPs
         7Z/bx+J/a4aJRfqBApYZfcDb1vf8B3nSUvZlrHWDnLP6XNJFAuklJS2JlOhFQ7vSKKnX
         mQGrcwWshQma7tgwotWVU0JtslEc20F2hzH3uzB5bXiIM+oQnM2H0tjHNFqRMg4fEbPo
         zfJbhH3vdqJ1pG58aE57V+Pd5AHrQk7l1gsh6sFx57nogvtB9vFxOHdGI5X1uDfOKHGJ
         m9Ir2xI0IFJaz1WCn0QdzqaJEk7JzrvMbLDNCHL8O/ciZK/ABx/P81MkBln1QXujhRYx
         dTpw==
X-Gm-Message-State: AOAM5337gUbuHYofOevOMfoE1qiIsIzgaNDyndlW1sU3oaDKNvpukX5K
        6R2F5intWMvz7SMJ6z3HwzY=
X-Google-Smtp-Source: ABdhPJxjeIkqFpkfmsgLB2ZZzfMZG5ck51J/rj08gDQ52chE2sN9Uzmtwx8cZ9CjN8/zn5CUnDq4gA==
X-Received: by 2002:a05:620a:4495:: with SMTP id x21mr8039187qkp.604.1639953600977;
        Sun, 19 Dec 2021 14:40:00 -0800 (PST)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id q7sm4591880qkl.72.2021.12.19.14.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 14:40:00 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v10 01/14] iio: inkern: apply consumer scale on IIO_VAL_INT cases
Date:   Sun, 19 Dec 2021 17:39:40 -0500
Message-Id: <20211219223953.16074-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211219223953.16074-1-liambeguin@gmail.com>
References: <20211219223953.16074-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

When a consumer calls iio_read_channel_processed() and the channel has
an integer scale, the scale channel scale is applied and the processed
value is returned as expected.

On the other hand, if the consumer calls iio_convert_raw_to_processed()
the scaling factor requested by the consumer is not applied.

This for example causes the consumer to process mV when expecting uV.
Make sure to always apply the scaling factor requested by the consumer.

Fixes: 48e44ce0f881 ("iio:inkern: Add function to read the processed value")
Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/inkern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 0222885b334c..021e1397ffc5 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -616,7 +616,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 
 	switch (scale_type) {
 	case IIO_VAL_INT:
-		*processed = raw64 * scale_val;
+		*processed = raw64 * scale_val * scale;
 		break;
 	case IIO_VAL_INT_PLUS_MICRO:
 		if (scale_val2 < 0)
-- 
2.34.0

