Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0008247A2C0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 23:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbhLSWkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 17:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbhLSWkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 17:40:03 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F6FC061574;
        Sun, 19 Dec 2021 14:40:03 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id a11so7737917qkh.13;
        Sun, 19 Dec 2021 14:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+BykN4wh/Gl1WUeG25C/oGubDqM9wUUXvBJW6U6ZVso=;
        b=SiLtrLZmowMXwBfoa+gpwff3VtOC+/7+rbQrxZo1FvGab1YrAlysG8AsbHRZiTR5dz
         yl8FykVA6WwfTdv0W0dkAioZ+ARPdd9Tl2aLYYRyRJpr51qOPGrdgDkV947R/DFJGGgG
         fToefhQu5KIj34Ir5a85e8A951M2YSpH9q1gs+Lyp4ar4Fh4fbQjQCa5hz6zhm1XpNVI
         OeuL7mGLVzWqKWpO7TAZcykfrJyyqTurREtqibkCfcdF6TITZZ+B0AOShduIHv8NrWKl
         L7N5baVPsPx4Zy4CHLdJsypuygH19xJw//Oqq9MFLtyxWC1Z66LxvXRv04uhMBk9FFY0
         IAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+BykN4wh/Gl1WUeG25C/oGubDqM9wUUXvBJW6U6ZVso=;
        b=3RDQcSx1Ibit36+tKnWzfAMgmcFghh9zADXhng2O5w96+CajBLig2FeQsNz6LWkLIT
         3JiaJCgrOQgZnc3BdDH+4dGPTWn+FEChIkS1QdR2OLEtDkn1IQxUYLGTBxoF/YvsOgvg
         ZLUERklei/g4GP+8HRl0BHe/t+PSz9oe+1pwgYMqoDdsiYpM/c+AJrP7c5VeU1VnDeFU
         vxc6QlW+sOrDjf6qtAGE99v5txa+BWE7NvvXaq9LUj5y28/z1rUHw1oz+r+Expzwzamt
         WylC/1vrGJIXXEe4BDvmJyMtUl5dG+hIJiMrcOCeYJdRbGZQFnGLPxRuihuXt6NSPJhp
         FXRg==
X-Gm-Message-State: AOAM532l9CiyySRAcbA3M0y3V04BJ7n8iApqRIK/pIdxoRrKRg6DF+J0
        C0tFMVGdPQAqa9kaqVn5Pwo=
X-Google-Smtp-Source: ABdhPJyIKoVbgkXxgGPjjeM30V2vRP1j5uuwLIMySE63XmIbrYrbQaXw4CbwS3U42V8JpsdKSmt0Tg==
X-Received: by 2002:a05:620a:1720:: with SMTP id az32mr5018676qkb.259.1639953602404;
        Sun, 19 Dec 2021 14:40:02 -0800 (PST)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id q7sm4591880qkl.72.2021.12.19.14.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 14:40:02 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v10 02/14] iio: inkern: apply consumer scale when no channel scale is available
Date:   Sun, 19 Dec 2021 17:39:41 -0500
Message-Id: <20211219223953.16074-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211219223953.16074-1-liambeguin@gmail.com>
References: <20211219223953.16074-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

When a consumer calls iio_read_channel_processed() and no channel scale
is available, it's assumed that the scale is one and the raw value is
returned as expected.

On the other hand, if the consumer calls iio_convert_raw_to_processed()
the scaling factor requested by the consumer is not applied.

This for example causes the consumer to process mV when expecting uV.
Make sure to always apply the scaling factor requested by the consumer.

Fixes: adc8ec5ff183 ("iio: inkern: pass through raw values if no scaling")
Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/inkern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 021e1397ffc5..dbe13fad3cbb 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -607,10 +607,10 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 					IIO_CHAN_INFO_SCALE);
 	if (scale_type < 0) {
 		/*
-		 * Just pass raw values as processed if no scaling is
-		 * available.
+		 * If no channel scaling is available apply consumer scale to
+		 * raw value and return.
 		 */
-		*processed = raw;
+		*processed = raw * scale;
 		return 0;
 	}
 
-- 
2.34.0

