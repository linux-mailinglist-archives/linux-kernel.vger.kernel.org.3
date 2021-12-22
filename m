Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A6E47CBE3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbhLVDrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242225AbhLVDrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:47:04 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C57C061747;
        Tue, 21 Dec 2021 19:47:03 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id kk22so1247146qvb.0;
        Tue, 21 Dec 2021 19:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/IzWlRLf5sgpJcd8IRlM3A1f2sn7deh22dzHI1NbenQ=;
        b=hcvGWMnZF+lSbiJEzlVt4JnRteJW7J4+jclBnpPJRrIJDINVBFcgfcnw9hjOuKCtXa
         KwGZsZL+iLog/pCvMQNN3/+AMWb1Z8T/LCEc8KCQMNdQE1raxjHLKM1ATcXa10YvEVMC
         ZEz2XKSxVbmVzlm8aCYQI0jCil/D8Jnul1RfKJvOxvtxZgvRK+m+vMSoFxAPg2Em4GFG
         V+kVNNdAkgxOVR6gd/pFrHia39vAInljcCbhh3InjSjukMnrEb8U1bfqQiNbk3wXSLDM
         qTZKaY0uTeMeizycJ88k9ZcyKyVN95QxosNbi5ww3JYSLsYQNnkyWzX3VR7mx0gEYrcV
         bDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/IzWlRLf5sgpJcd8IRlM3A1f2sn7deh22dzHI1NbenQ=;
        b=KAQWIfn0+F84QITM5LRJz3a7qo1AjJaZ5sDGozirNojXqRAvUyFNmrNGYwJPuAeB2G
         iwynPUeHV39r3BOSNgcJoCcorE65sDUbHD24fw6fQDzb/2wb9ESGsy2qvPjTYS98w5F1
         18ugGvPB0tlXMtu1GlrUH2QszGmptISv3wsAxN/XcjKlc48xrJaTASTOBNvm86dPxugy
         9Y0knurtm8W9uhDUMFxwFVa/Puv7ENbU8pcTfQcs+VsjshySQqDkRDmtNcyL/qkMSfoP
         sS4RVO/CJER9DZRPgGLkBuoh22k05s1k3y81a2hu0XvlNMqo/lyoOnuh1L7g9ndqh2tn
         NkMg==
X-Gm-Message-State: AOAM530Ul8Ja7BED2ptZZd0y66xlaNfvmIQCP7cl1/mJKl70kcuPHS07
        qMMM7TJ1d6XtXzA1QIDpSDM=
X-Google-Smtp-Source: ABdhPJwG2klhNV7gpWn9e/NX6RvPfJbGPLEFYjzvXaWfv9ZDpCKWjKN9gUaceihEhRr32/OqfnrY6w==
X-Received: by 2002:a05:6214:1c06:: with SMTP id u6mr1104768qvc.35.1640144823223;
        Tue, 21 Dec 2021 19:47:03 -0800 (PST)
Received: from shaak.xiphos.ca (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id f18sm918944qko.34.2021.12.21.19.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:47:02 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v11 07/15] iio: afe: rescale: use s64 for temporary scale calculations
Date:   Tue, 21 Dec 2021 22:46:38 -0500
Message-Id: <20211222034646.222189-8-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211222034646.222189-1-liambeguin@gmail.com>
References: <20211222034646.222189-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

All four scaling coefficients can take signed values.
Make tmp a signed 64-bit integer and switch to div_s64() to preserve
signs during 64-bit divisions.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/iio-rescale.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 6a2d4ae80652..a7297b4ba17e 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -22,7 +22,7 @@
 int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
-	unsigned long long tmp;
+	s64 tmp;
 	s32 rem;
 	u32 mult;
 	u32 neg;
@@ -39,10 +39,10 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		*val2 = rescale->denominator;
 		return IIO_VAL_FRACTIONAL;
 	case IIO_VAL_FRACTIONAL_LOG2:
-		tmp = *val * 1000000000LL;
-		do_div(tmp, rescale->denominator);
+		tmp = (s64)*val * 1000000000LL;
+		tmp = div_s64(tmp, rescale->denominator);
 		tmp *= rescale->numerator;
-		do_div(tmp, 1000000000LL);
+		tmp = div_s64(tmp, 1000000000LL);
 		*val = tmp;
 		return scale_type;
 	case IIO_VAL_INT_PLUS_NANO:
-- 
2.34.0

