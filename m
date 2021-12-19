Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AE147A2D7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 23:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbhLSWkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 17:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbhLSWkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 17:40:09 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3291CC06173F;
        Sun, 19 Dec 2021 14:40:09 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id de30so7842122qkb.0;
        Sun, 19 Dec 2021 14:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0SUJD5RhKo4LXIGfIsq/LUpj7WT5zhErdlUyg5eL4QI=;
        b=NCnvE877ligyNhEqqS+D9zSGL8LySaHOkBzljXDiaB+19fnPYkNbjRL9AXvMvLoY+l
         H7ATmcg9+ymsSgMQkiFDNSuqa1A2YYCRk1eUlckTqLpz/pMQcGLAtA9iwRtAjeJ5uNYG
         w7oHU50Ym1bft0Ezw+m1T78GByoFlyyiftE27xztEJvwfERXboQaXqD0I/vWQyQAfm+q
         HLQdZt/6XqrvMltqcL4JoI/fpeqQOz87HZzFK+0waKRZEhSdXLIhPpJ0b1xyE2pFlG1A
         LP7z/MQ75O/pwjp5wPi0StCAonBJpRCmebT1Ihu7Jy3HoGJJiHvo8TO0TmWr6PF7Do9t
         KPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0SUJD5RhKo4LXIGfIsq/LUpj7WT5zhErdlUyg5eL4QI=;
        b=Rwmn495Zm1VUhqzgVv+2bfzEPY8tQS59xBnZUuJmdPLRXMc+JWIm0MpiQoPLOaJUqS
         8y6SMVZz7vXoFObd8H2nlOOk15y3S12Ys0byFQdUPFaoBigWaleBUu2WExfCu4T7Xkqu
         2w0me69JpDdg+FEiRV1mBhej3jEXJZUHgYpmnlMZPnWJ8Eowhh4WbVpON9RnXdKvoIkE
         ni0Ltx8Z6VTvAYS7k747mddkAZaIqXFnsSTaG4zaWYVEn6YMB+EF+ZRcBqYLRO2lZ2RZ
         j0tzUqb63lWiE3Hc6zQ/M4ffkXDNrkM3FJKmDoG5FpFdkVkMWwawmAS3mQ795iyIDjG+
         hqJw==
X-Gm-Message-State: AOAM531+JkO7HTkwBII/FfwPgfpkj0w+TjEQ490k0GdBWR/Y7ZwKAKbM
        Q99KGEeqgjk+P0N7XrTHtKkEJeqV9oM=
X-Google-Smtp-Source: ABdhPJxwtOG+30ANKaFnC7JjwoCkElnwkxwZ1SKPdnKPghF6VyTWvS1nNiOUpeEbiEamiVgDvrbAcQ==
X-Received: by 2002:a37:a693:: with SMTP id p141mr8051888qke.269.1639953608376;
        Sun, 19 Dec 2021 14:40:08 -0800 (PST)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id q7sm4591880qkl.72.2021.12.19.14.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 14:40:08 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v10 07/14] iio: afe: rescale: use s64 for temporary scale calculations
Date:   Sun, 19 Dec 2021 17:39:46 -0500
Message-Id: <20211219223953.16074-8-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211219223953.16074-1-liambeguin@gmail.com>
References: <20211219223953.16074-1-liambeguin@gmail.com>
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
---
 drivers/iio/afe/iio-rescale.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index e88b63747a46..e3680998565e 100644
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

