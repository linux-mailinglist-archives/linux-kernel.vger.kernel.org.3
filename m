Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820CD47CBD1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242206AbhLVDrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242185AbhLVDq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:46:57 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B67C061574;
        Tue, 21 Dec 2021 19:46:57 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id q3so1175830qvc.7;
        Tue, 21 Dec 2021 19:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=12xfYndy4GLO1P8S68dDnZdcfNV0/po3RgsVeOg3A6s=;
        b=h97Lke+QI1VFG0/C6kGFCVXWHvPV5tQAlTeFYGMKh6SobJMDZCItBZpPRG9+5T2DPr
         XCtHy555yney34+q7X9Bt7Ecm0wSNSIQ7THZYTEP83okE2E7VhnRczgESCEKmGgxItML
         nCsR9l/4rQptrmivmbyS6S/3+Rx+WRQoZT3HEW3sDmrIbiig8/c1rWE0T1fU894QekRi
         VbJ31vE3Zps5JpB4aGz3knnHFDeaTGgDuMEcWcd7KfnkEjyfWgQFdy9nVVlAq+H3kDxd
         /tRI2LlUzuwTZ5l2GPrBRPJ3aNDtGnML/amiYr2AL7ZLGsVYKGXH0ia6b/Z8VUv61dHf
         Knew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=12xfYndy4GLO1P8S68dDnZdcfNV0/po3RgsVeOg3A6s=;
        b=3mQIfQjcQ6c7cRBZu9wfGlszZuM9tq1XysZfDzTdSGU21T529D58F5Jmj8113El0Xb
         +Q2BRuxbV/jJbTcCAcZF5MtFPbH74cWH7ntIjbyVv7v8lf7CmNsXnYQ/8KRavBmFCugp
         LYCdtypnb2T+M2kRWMXd5NxOOQfvuHWSrp4op8p62x6KM8Th3oMpRsaDu+nHL+1NMA0X
         yNoWhdNcJ50LgUZXyMNzGGLjT5F0dBt22E6XEgXo3SET+mcb3kjuMRtxxYgdgwxOajSR
         tt8iZSJuPgZRg95M7BZ1jBJ4UWniqApQC7cXgoRuEqxaz2cB6KfZWbbpbrqGEhI3WWWy
         pX7A==
X-Gm-Message-State: AOAM531DEImw4B/cVYRB65C47Rn+tHruqvGYB4+pn9D37tGeLwhlwlUe
        c1HA7aV0SSvRw72RT66TURg=
X-Google-Smtp-Source: ABdhPJyZQUF72w9wgDGg1uldz1qZm8CfEHCZCv+PeBOzZTn0B3mXndc2VNvprZRLW552ULV1mzAlaQ==
X-Received: by 2002:a05:6214:c42:: with SMTP id r2mr1116414qvj.70.1640144816317;
        Tue, 21 Dec 2021 19:46:56 -0800 (PST)
Received: from shaak.xiphos.ca (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id f18sm918944qko.34.2021.12.21.19.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:46:55 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v11 02/15] iio: inkern: apply consumer scale when no channel scale is available
Date:   Tue, 21 Dec 2021 22:46:33 -0500
Message-Id: <20211222034646.222189-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211222034646.222189-1-liambeguin@gmail.com>
References: <20211222034646.222189-1-liambeguin@gmail.com>
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
Reviewed-by: Peter Rosin <peda@axentia.se>
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

