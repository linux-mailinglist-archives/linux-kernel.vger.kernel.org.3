Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78666488605
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 21:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiAHUxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 15:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiAHUxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:53:31 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CB0C06173F;
        Sat,  8 Jan 2022 12:53:30 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id f138so10014588qke.10;
        Sat, 08 Jan 2022 12:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zrHQRo0zoQMTPRIHvDLoRVw1z6+WqQ9h09dSoESChVo=;
        b=XusMXkWDcFk2RmekDBV1nALtpM65w7Y/2YNVjCGDDPbXuSrqGRnZNuE7jpkiCKdYGF
         iCEAwWr1k+IYCQosJmo1znIRoz0xQepPRSpy+Mm8HQM/ogiz56ec3ihqblbuHs0tk5J2
         9p8La0+OsmcQ0ktse83nYtuvcWO5iTxT1DrGPPGLHPl1vduBZOP5vPb2usFtzZvd7NYm
         Nsue8bHrl0c+X4MA4Ayo0mjMb5Shb5wvNDWEZbln1KknU2QkTbpc1G3/BlCWBDtUsxlO
         3J/UsiwqmF5AkEL8ac24dWmzjZo9nlJzWpPENH17Ny25Uyc8cyQRwscjN93+D9knVzPe
         cS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zrHQRo0zoQMTPRIHvDLoRVw1z6+WqQ9h09dSoESChVo=;
        b=mLLtz8VcxJBVeItOvW0ibvMdjoxaQv5jsrycrEX9LRfiwmexhx1YrtUEz14F3XGARf
         o/ka9NvC8MoC/4aA8WGHQyfYB9MS2T63hpIznJivPT6pAr2IT8P/4BNPQFP8XcSAMHvB
         q7fjYBZJFP66io8CEE/LbxAScSfs21tPeCyLhucbn54j/jtVcpyhOkgJnlr605sqYhWM
         5LSjaB35GE9xikoku/nCaSWrzIzCMbd6Ih1hwM/UAoDpZmKH+Em5unRBsteACQ8J/J+u
         kmj53U4wVFLvB6W2qUg1kzvh8A4fJbOXUuo+F6+7J2tJvMJRC2lwEPVvjIYcO98cwgAR
         7bPg==
X-Gm-Message-State: AOAM530LdQuqjj/vKPkD3XDWQ/hsyW1SXnuN4lHHPOunYo9cZtl33xjo
        HtNoOvqNWEphW3Y44LxPiP8lHO9mnwQoeA==
X-Google-Smtp-Source: ABdhPJwcACzNsk8tiXVW5nA8D1d5dliMHsNfe77E0uLwgrECHzcJc2mjwaNpA/bj0udli3r34PJ0gA==
X-Received: by 2002:a05:620a:1903:: with SMTP id bj3mr2618896qkb.37.1641675210162;
        Sat, 08 Jan 2022 12:53:30 -0800 (PST)
Received: from shaak.. (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id p16sm1650377qtx.19.2022.01.08.12.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 12:53:29 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v12 01/16] iio: inkern: apply consumer scale on IIO_VAL_INT cases
Date:   Sat,  8 Jan 2022 15:53:04 -0500
Message-Id: <20220108205319.2046348-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220108205319.2046348-1-liambeguin@gmail.com>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a consumer calls iio_read_channel_processed() and the channel has
an integer scale, the scale channel scale is applied and the processed
value is returned as expected.

On the other hand, if the consumer calls iio_convert_raw_to_processed()
the scaling factor requested by the consumer is not applied.

This for example causes the consumer to process mV when expecting uV.
Make sure to always apply the scaling factor requested by the consumer.

Fixes: 48e44ce0f881 ("iio:inkern: Add function to read the processed value")
Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
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

