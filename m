Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D2251C0BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379616AbiEENeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379551AbiEENeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:34:09 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42161B7A5;
        Thu,  5 May 2022 06:30:28 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id x12so3638348pgj.7;
        Thu, 05 May 2022 06:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ScUwdLygZAJBLNzZb5DPx3aH0d7kiLkb+57GQJMLhHA=;
        b=O1J0ZczFqlulozW3TK0yGqCukjH8F98Zz1I6QTbtsESqDOsOYZPYv/W4c1Bgbk4Gbb
         bw8mdougfWtlGfdBJf9FuwhWLnAEtr9mUfRaaFaRZx33h1Y2Qq8ebPJlUsyRH9AE3QQQ
         WNurtbQjyY8z0iJGw4Dd4WQQrIPib1ZtW9Db5tTx7oY3EueesQ/2GdQ2SDLEpOb5kVet
         IJTeMeyteomOQKFjMMoL4U3ZtjXuEN35/c/Sf/diqCjlRP7u76CxlcDhScfNVVE5xNc5
         D0+7VfxGc+5uHZVNKfNfoXIgdXNBio0XjuUIEPtbgnzllgGy2ebEmEmefi0msGffwjX8
         01Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ScUwdLygZAJBLNzZb5DPx3aH0d7kiLkb+57GQJMLhHA=;
        b=igWTr/1GhZL2gEt5YZg9mBtc7HBP2GBg4XRIwYaDDofKur6z0NCsAgvSOd5l9C6tfc
         FN85fGzZIUk/rwJxCI3ZkyHK/oV9e1qP82jwMSWlKHNcw20X7uEXoq6qksUJrZdWE++S
         4m1bkKp3sVAx10Kva1wiiKpWZvdTIRR/8OX2OCTDV2TBwgkjNIc3xj5XowsUHPnK+arg
         ZiTRguUOmYSpzBgr8cyKtPkVqT/UvuBhI9wpKsyMWRD+2T21o2rPSEkL+tIawT513JVS
         mizEOFgkK+UUPupe51KsDj5zs0i3uHrv7GQy3DEBg7mrjTTG6KGgGkLceP720ySom1aL
         Ziiw==
X-Gm-Message-State: AOAM531DLwmxAmYUgFNabaS+HWMLk4U+EvC0FwffjH9y7x5ok3ATdwDe
        Bal7JNjIylOA/yfvDASgrVw=
X-Google-Smtp-Source: ABdhPJySIgxdmwQRP2IujD0e+3L/vIqmNvj9kR1ndSvCJc0prO703GqFJWQNamNWvXiHEpH/QxvkFQ==
X-Received: by 2002:a63:84c3:0:b0:3aa:f229:45c5 with SMTP id k186-20020a6384c3000000b003aaf22945c5mr21977602pgd.415.1651757428359;
        Thu, 05 May 2022 06:30:28 -0700 (PDT)
Received: from localhost.localdomain ([115.99.184.228])
        by smtp.gmail.com with ESMTPSA id c64-20020a624e43000000b0050dc7628135sm1420120pfb.15.2022.05.05.06.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 06:30:27 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/10] iio: accel: bma400: Fix the scale min and max macro values
Date:   Thu,  5 May 2022 19:00:12 +0530
Message-Id: <20220505133021.22362-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220505133021.22362-1-jagathjog1996@gmail.com>
References: <20220505133021.22362-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing the scale macro values to match the bma400 sensitivity
for 1 LSB of all the available ranges.

Fixes: 465c811f1f20 ("iio: accel: Add driver for the BMA400")
Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/accel/bma400.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index c4c8d74155c2..80330c7ce17f 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -83,8 +83,27 @@
 #define BMA400_ACC_ODR_MIN_WHOLE_HZ 25
 #define BMA400_ACC_ODR_MIN_HZ       12
 
-#define BMA400_SCALE_MIN            38357
-#define BMA400_SCALE_MAX            306864
+/*
+ * BMA400_SCALE_MIN macro value represents m/s^2 for 1 LSB before
+ * converting to micro values for +-2g range.
+ *
+ * For +-2g - 1 LSB = 0.976562 milli g = 0.009576 m/s^2
+ * For +-4g - 1 LSB = 1.953125 milli g = 0.019153 m/s^2
+ * For +-16g - 1 LSB = 7.8125 milli g = 0.076614 m/s^2
+ *
+ * The raw value which is used to select the different ranges is determined
+ * by the first bit set position from the scale value, so BMA400_SCALE_MIN
+ * should be odd.
+ *
+ * Scale values for +-2g, +-4g, +-8g and +-16g are populated into bma400_scales
+ * array by left shifting BMA400_SCALE_MIN.
+ * e.g.:
+ * To select +-2g = 9577 << 0 = raw value to write is 0.
+ * To select +-8g = 9577 << 2 = raw value to write is 2.
+ * To select +-16g = 9577 << 3 = raw value to write is 3.
+ */
+#define BMA400_SCALE_MIN            9577
+#define BMA400_SCALE_MAX            76617
 
 #define BMA400_NUM_REGULATORS       2
 #define BMA400_VDD_REGULATOR        0
-- 
2.17.1

