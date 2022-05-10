Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ED252205F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiEJQAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347239AbiEJPwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:52:08 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5751C110;
        Tue, 10 May 2022 08:48:00 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id t16so13810793qtr.9;
        Tue, 10 May 2022 08:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JH6FCKgVvpyM/CUSOGxGawAHjQOzmxSo0FiMXcNNQR0=;
        b=FaBd2ixjBk7/GliZhXs0HDiV5kgLBYPB7SKr0q2FlW/0EvPvlEvKOWZnDOKhZyOrmb
         Km6tyPTpfkvzxIkyS9lhLZegj8B6LocfHY3XCNef442bwbaK9GkccfM51jH4gO0/0FTn
         7x2rmGpqKpMkPW2U5V8jNMUE+JYx0Sp+SmSABDdGRgu0CmaVz2Xsf0KaNvrDFYeSvRMZ
         TSg7KF3ivDe20IOjxOYY4T03BAaRtNXvIVLH3FsvqVSFltmUGp56UFdEX81S/WynqvKt
         xa8w94DQY/mn6ieYorGxnmjk8aydlWEg/zGkVmESlpB6rl+FwFRFmMCoZ4Mmhgb9CDi5
         dnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JH6FCKgVvpyM/CUSOGxGawAHjQOzmxSo0FiMXcNNQR0=;
        b=fJXg28IhH7ekdBR/ob6+MLc5UGxv4R9JlCKEXXq0VpFDHVZNZOFSEHhu1O4awYSUMW
         rzqlml5y97Z1MU9S//LMS7g5i3j1qgER1sEjnveodOSiSrvSp3sdKRTHLrpF79qd78nM
         Vpjlepb8DAyt+MnU1i0WHjRdlyFujxqKDf/fcWKDIRz619l/gGerVTjvbwhCJDgsjbZU
         P4i/BpSUwg29/oz8p1UvSJZbA2N5Bdg1J0v+JvAef/IRBAxT2RgmvhJtWFSpPBFQF5Qi
         3QHZb6sKRPjyaoOnj9vETQvSKzQ9hiT/npLrmIepIjKXE7R1HqJQsGwmxBUCTc94boxG
         TFIw==
X-Gm-Message-State: AOAM533eSqls7b1aR/JqQUMrkCZjmLaPuD/4C/q4lB7XtyXXhwmwFQIY
        cmDoVWBhA2HWj716t75f284=
X-Google-Smtp-Source: ABdhPJylp/SaGGGIPQEhhG+6lZJxx6dLQq6Bqk2BLgbTztZ5hgS4GTpLRbdUJuM9djFz5zjSjKbejw==
X-Received: by 2002:ac8:598f:0:b0:2f3:be36:9be5 with SMTP id e15-20020ac8598f000000b002f3be369be5mr20627899qte.204.1652197680116;
        Tue, 10 May 2022 08:48:00 -0700 (PDT)
Received: from localhost ([98.242.65.84])
        by smtp.gmail.com with ESMTPSA id o2-20020ac841c2000000b002f39b99f691sm9288175qtm.43.2022.05.10.08.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:47:59 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org
Subject: [PATCH 05/22] iio: replace bitmap_weight with bitmap_weitght_{eq,le} where appropriate
Date:   Tue, 10 May 2022 08:47:33 -0700
Message-Id: <20220510154750.212913-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220510154750.212913-1-yury.norov@gmail.com>
References: <20220510154750.212913-1-yury.norov@gmail.com>
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

bitmap_weight_{eq,le} is better than bitmap_weight because it
may return earlier.

CC: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>
CC: Michael Hennerich <Michael.Hennerich@analog.com>
CC: linux-iio@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/iio/adc/ad_sigma_delta.c  | 2 +-
 drivers/iio/industrialio-buffer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 261a9a6b45e1..6445b591f071 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -525,7 +525,7 @@ static bool ad_sd_validate_scan_mask(struct iio_dev *indio_dev, const unsigned l
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 
-	return bitmap_weight(mask, indio_dev->masklength) <= sigma_delta->num_slots;
+	return bitmap_weight_le(mask, indio_dev->masklength, sigma_delta->num_slots);
 }
 
 static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 06141ca27e1f..18d3d756aee1 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1824,7 +1824,7 @@ void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev)
 bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
 	const unsigned long *mask)
 {
-	return bitmap_weight(mask, indio_dev->masklength) == 1;
+	return bitmap_weight_eq(mask, indio_dev->masklength, 1);
 }
 EXPORT_SYMBOL_GPL(iio_validate_scan_mask_onehot);
 
-- 
2.32.0

