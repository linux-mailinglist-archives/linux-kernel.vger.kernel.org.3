Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC94648861B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 21:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbiAHUxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 15:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiAHUxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:53:43 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC82AC061401;
        Sat,  8 Jan 2022 12:53:42 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id l17so9595381qtk.7;
        Sat, 08 Jan 2022 12:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k3+NdqmX0cfn1TfZEbC1RxKDwjuL4tYh51nEZNOIN1E=;
        b=DcaS1v6uwXsuBBurqPOMQZyMThHALFBdi/5vjVU7HyWLBGOFs5W0szWoi3LZTOzYvb
         /DJ9ySkKEzvh8GQ5MtxEhUTj4d2brtrikp6A6zsoHDK+fgFWR2+XVsr+3OEN1ip+Tfgn
         jsolRgWKsGLz42t0DAscsP/1+k2BDEPhjhQpj/2OMKN4loU9R7nI6Lk+nqrq0zCWcc6l
         0V8gThu1MAsMPp8RV+Z0dPMlULP9V6MUm9P4JftRZp9bPrvO1LnPCNsmISoLOBthsnYO
         4YJoK8cVfrdLX2BR58eo1oUqfub0plDuX6+hSlEmDuQDp3fcuh0t9lkEWi6D3B77Us1B
         aXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k3+NdqmX0cfn1TfZEbC1RxKDwjuL4tYh51nEZNOIN1E=;
        b=N8EQJU/54s+R4TMkE5vFoaean/1Ryg0PLc0NHYnC2L8f79Ot6WB1GR7dNXQ0Qe9uO5
         Wp3knU8nHwihlGVtlGVyn0+Rv2IdL4uhGd2cFHPeiUTSGeXx5DhhIqEljf36mDSOdjp3
         R9KBZik2R1oCQ6Lo9LKtUqTHHNYZpMhuwqEd+OvvL7CrSLkRH/d9S0E9ZJz/ski4/lKq
         nFHQpTaMkPoaKu1sAedRvAN1EpW8CdJ99wNuc13llS0CJgJQotf1zVP4Xkfg/gtZd34L
         X1CKLcrQ+6dvSIhAsNNNBBl9IyEbzdCLW2DYmfx648tU7gV6Bqb7YqnsvsEJF/yL5fuw
         Y/+A==
X-Gm-Message-State: AOAM533nsTfG/cJDn04n16CP7J21rN9jKHR6RsHVEYFRp/7b7Gd5FjcI
        ykEzJUTgFBWdh+VwtSnRHrI=
X-Google-Smtp-Source: ABdhPJx/0uryou7f2wFxej8UmNYzsiFOfRF2kDL11B1C8QZPTRlNIdP02Q8AFODnNJGh2aDEufD3lQ==
X-Received: by 2002:ac8:5809:: with SMTP id g9mr2948517qtg.312.1641675222138;
        Sat, 08 Jan 2022 12:53:42 -0800 (PST)
Received: from shaak.. (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id p16sm1650377qtx.19.2022.01.08.12.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 12:53:41 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v12 09/16] iio: afe: rescale: fix accuracy for small fractional scales
Date:   Sat,  8 Jan 2022 15:53:12 -0500
Message-Id: <20220108205319.2046348-10-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220108205319.2046348-1-liambeguin@gmail.com>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The approximation caused by integer divisions can be costly on smaller
scale values since the decimal part is significant compared to the
integer part. Switch to an IIO_VAL_INT_PLUS_NANO scale type in such
cases to maintain accuracy.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/iio-rescale.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 68eb3e341939..ed3ef994997f 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -24,7 +24,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
 	s64 tmp;
-	s32 rem;
+	s32 rem, rem2;
 	u32 mult;
 	u32 neg;
 
@@ -43,9 +43,23 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		tmp = (s64)*val * 1000000000LL;
 		tmp = div_s64(tmp, rescale->denominator);
 		tmp *= rescale->numerator;
-		tmp = div_s64(tmp, 1000000000LL);
+
+		tmp = div_s64_rem(tmp, 1000000000LL, &rem);
 		*val = tmp;
-		return scale_type;
+
+		if (!rem)
+			return scale_type;
+
+		tmp = 1 << *val2;
+
+		rem2 = *val % (int)tmp;
+		*val = *val / (int)tmp;
+
+		*val2 = rem / (int)tmp;
+		if (rem2)
+			*val2 += div_s64((s64)rem2 * 1000000000LL, tmp);
+
+		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_VAL_INT_PLUS_NANO:
 	case IIO_VAL_INT_PLUS_MICRO:
 		mult = scale_type == IIO_VAL_INT_PLUS_NANO ? GIGA : MEGA;
-- 
2.34.0

