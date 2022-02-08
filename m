Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414364ACEA8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 03:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbiBHCJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 21:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345422AbiBHCEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 21:04:53 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B06C061355;
        Mon,  7 Feb 2022 18:04:53 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id g3so8328651qvb.8;
        Mon, 07 Feb 2022 18:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9LZuh2BJBRJTUtNvsar+NW2892hNjIAPPNUSFSiWG50=;
        b=SvlM8ahOM9nO7PoAOfmwocpFkfx5v04cPdoCLLTqiwy7Pnj/xmMBw8GzJjDEn3MxBr
         /nTL3iNY2F5fQyA1Ot38HdqJth6eXJfzTl0ab9rpzukqcg3yMfIQvcqJim06lQ03UAk1
         yUnshwQOa3HRZxwkgR3Bx/vvqe6POOp/SaPLFGWGKnu3bH5a6vU9rjKsd/4bAI90vcAa
         l51wLrPuLQ7DgzReQzngZXM98X8+ll7r1aoBP7Qbmb0sNWa9dcvkMDPacFssx4eM6I88
         K9PJ04+wc9/fjtnkkzybJQP3PBKqV3EEXpmuUtlHVow9hHBiXHCCnBlJIRPxrEURuA8o
         pu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9LZuh2BJBRJTUtNvsar+NW2892hNjIAPPNUSFSiWG50=;
        b=l7D4ubDQ77a1sqHatYO8DWzJVbqyIrlPGN4U9vlvRJhDJe5wpYCQdMp9OccVFr8D0Z
         Hyvy9+sRELveNSV3aLGEte8QsplbEB5AOoBQ0sG499BgWHnFYa9a7pNELAANFuKrz6qh
         9rhAMiZQKwGMs5QgYqjgePXJ6niNzUcWk/irVZBGI6l1ZeR9x4JZEowDQ2S79ENvGIzh
         4WenTHWyxfy3LBGnU80NW2SwHnrp3ULKIXVeTGNcvvYZpPDg3Je06uZtW2vHjbvm1xn1
         9BkSWD7PcmeotzfdPi6AHgLiIVQoKxYRXpc5EeJjUY1GiPN7bu8WIOXO08YGfOkN79Vl
         2PtQ==
X-Gm-Message-State: AOAM5315ZapTG1lEm2pfU+W80teO9ROlgI4TPhSJoUAjWDnrpBoLIAvA
        hCMnRpBdmshA9tc0SI2T0aY=
X-Google-Smtp-Source: ABdhPJzddHNo0VkvB0gKgxLXaodI6FKikX3jNh68zo1g2xsFuIBNUiV+LkcdYbZTnnSGRqr/OErAZA==
X-Received: by 2002:a05:6214:27e9:: with SMTP id jt9mr1606975qvb.65.1644285892345;
        Mon, 07 Feb 2022 18:04:52 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id u9sm1416055qko.130.2022.02.07.18.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 18:04:51 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v14 04/11] iio: afe: rescale: fix accuracy for small fractional scales
Date:   Mon,  7 Feb 2022 21:04:34 -0500
Message-Id: <20220208020441.3081162-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220208020441.3081162-1-liambeguin@gmail.com>
References: <20220208020441.3081162-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 63035b4bce5e..468e6c345bd1 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -25,7 +25,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
 	s64 tmp;
-	s32 rem;
+	s32 rem, rem2;
 	u32 mult;
 	u32 neg;
 
@@ -44,9 +44,23 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
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
2.35.1.4.g5d01301f2b86

