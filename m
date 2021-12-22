Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D988847CBE1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242298AbhLVDrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242233AbhLVDrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:47:07 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FD8C061747;
        Tue, 21 Dec 2021 19:47:06 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id o10so1191128qvc.5;
        Tue, 21 Dec 2021 19:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EgxBJt4KJLwPCnRlFoogBKl1bDW0aQ7la8JVMlwDvkQ=;
        b=BJjb0KftF5Av3FGcq0xlbS4fS4JVaETnGFPkCt59NEH7FEVv4CeW07jNlhhSOQ1sh4
         R4cbIZUb0hoxzNX8Zrk5/xIt298yq8uugef5AfEU3cdgIFvs+938VMFljcAsHYj44tLd
         feJp+XUE+1fMn1E95QL2H1bE0JMJB7nXgAKgiaD1aIofWfAGoEMlip/hPlpbVa5MgGCG
         cO0OXgKmAjCcg1yB9aG7ndFEhFLaod4hSktRYU74Lb+A/RsM85QeZQem5Pk4stmHeU4M
         qvK2qdteaL4G/U67mAZTu4Cd2O4InkVUxIgQa7Xq7soUmtICUX6tJCtA+2B4orjNZpoO
         zc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EgxBJt4KJLwPCnRlFoogBKl1bDW0aQ7la8JVMlwDvkQ=;
        b=eC43cbDJDG/9JLSZN8pByEKZ0Kjmwddo0NEe03o4wn7yGx4woIb4omRIUQuBr9nkcw
         QMijxCgXGwXaNrY9CXgxflFRhPP21Nd2tL0E++ZDcE0SjJYlU7NA21v3YoThGiyjfWxG
         s7rfuUq6odGQ+rGp4e7x1mOY8rT26KNpkKp1VCzABZgrCgiKL1JIc/9GZxDhki1er82Z
         yln7H6OF4dtHmMs1T+2ExavkqOTrI8sU+IhoOFSjsROWV97n8HQA4W9wLFNOZKreGYjM
         J1uY1p1Ft6/kmA7l5N76dp6o4iEvyAlHgwWB/heAp7SJUI1N5Syo5dXAl63pz2EUZmlQ
         ClAg==
X-Gm-Message-State: AOAM5323wTY+xvjZdrvoizBmd4/kWimvbRCPnlmPYxTKNN6A43VtwwYG
        wQKXa7j+YRMV1JjYCrW597nWm6oU5DmJeg==
X-Google-Smtp-Source: ABdhPJyUbWbKGjAvS2c+7+yZt3kdHDdAxfjLac3bLpyUgFaWxdb8uK11uhmHUVQC5oeW/L2pTJwC2A==
X-Received: by 2002:a05:6214:5096:: with SMTP id kk22mr1076664qvb.117.1640144826109;
        Tue, 21 Dec 2021 19:47:06 -0800 (PST)
Received: from shaak.xiphos.ca (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id f18sm918944qko.34.2021.12.21.19.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:47:05 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v11 09/15] iio: afe: rescale: reduce risk of integer overflow
Date:   Tue, 21 Dec 2021 22:46:40 -0500
Message-Id: <20211222034646.222189-10-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211222034646.222189-1-liambeguin@gmail.com>
References: <20211222034646.222189-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Reduce the risk of integer overflow by doing the scale calculation on
a 64-bit integer. Since the rescaling is only performed on *val, reuse
the IIO_VAL_FRACTIONAL_LOG2 case.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/iio-rescale.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index ca8fd69bfe46..0000a58bab9d 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -23,21 +23,31 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
 	s64 tmp;
+	int _val, _val2;
 	s32 rem, rem2;
 	u32 mult;
 	u32 neg;
 
 	switch (scale_type) {
-	case IIO_VAL_FRACTIONAL:
-		*val *= rescale->numerator;
-		*val2 *= rescale->denominator;
-		return scale_type;
 	case IIO_VAL_INT:
 		*val *= rescale->numerator;
 		if (rescale->denominator == 1)
 			return scale_type;
 		*val2 = rescale->denominator;
 		return IIO_VAL_FRACTIONAL;
+	case IIO_VAL_FRACTIONAL:
+		/*
+		 * When the product of both scales doesn't overflow, avoid
+		 * potential accuracy loss (for in kernel consumers) by
+		 * keeping a fractional representation.
+		 */
+		if (!check_mul_overflow(*val, rescale->numerator, &_val) &&
+		    !check_mul_overflow(*val2, rescale->denominator, &_val2)) {
+			*val = _val;
+			*val2 = _val2;
+			return IIO_VAL_FRACTIONAL;
+		}
+		fallthrough;
 	case IIO_VAL_FRACTIONAL_LOG2:
 		tmp = (s64)*val * 1000000000LL;
 		tmp = div_s64(tmp, rescale->denominator);
@@ -49,7 +59,10 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		if (!rem)
 			return scale_type;
 
-		tmp = 1 << *val2;
+		if (scale_type == IIO_VAL_FRACTIONAL)
+			tmp = *val2;
+		else
+			tmp = 1 << *val2;
 
 		rem2 = *val % (int)tmp;
 		*val = *val / (int)tmp;
-- 
2.34.0

