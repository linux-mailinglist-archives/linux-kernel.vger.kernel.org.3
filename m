Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC785091D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 23:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382369AbiDTVOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 17:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382353AbiDTVN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:13:59 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43F13B2A1;
        Wed, 20 Apr 2022 14:11:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id q3so2948555plg.3;
        Wed, 20 Apr 2022 14:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4ROcGHuFTnTL2fbWmLOSf06EmqWWnhDvcVWXtNXGstI=;
        b=dtdXqku7t/c6bQ12fBhLC3WNa1pewG3OxAFM2pWllY2YFRbL/fvdRm+dNoPywCBGzH
         8n61Dcox8RxUuf8vq4xG/GlzYPdVS4CsiN0iVdSe++BPHsf6SHwQ10GXbPo8Ev39u+el
         8uH/8rr5l2EUcNbb2L5yV9XcC6Kxa06VpjMID4CxYJU6pAnqhps8pW6ANQuKBlNPOucU
         QOixqOzZK82Z7eJDRxtA5tHa91frQT8mp7/hE88REUpwA3D+VhUfnQOJW/LISEBGEm6O
         u8+YKAzTnMgKg8Wb8vAgJz5BEkUY3CBHUBOC2rr8RA66CiW7ocVMfZfqgj9UgfoFfDY6
         QcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4ROcGHuFTnTL2fbWmLOSf06EmqWWnhDvcVWXtNXGstI=;
        b=mu495PcW3YtFr0PXogAhL3Slo+iE2TU+tzIT+26CK4QYT1xwj2mX1qPZNY0cveuSy5
         EX+m9JtYRI9c4nX1KPlnVRSoSeu7VS6INMGZH1RnY12lS8fvQzWg5ZTNnOyMtSSo2A0o
         u6X3SrasCc1G/lVkYOL3sW9SCkkQDQv09cyzz4/EfL9hrGRCa7i5W6N5NWxcJ8Lvpe2m
         sMoVCsEalO9UcJycjIuJVRxTnrakXAmqwlNpY5FaCFQD4rH8SE3NhG4DGTz0mWWap0nS
         Fampqlefq2F/JhLuyycchyUmVlnn7NbcMcFIeK6tOesvKsEM59taGRWp/ACkNdEeTjqH
         wrOQ==
X-Gm-Message-State: AOAM532KOLYdvI6r+7FvL6HDQEMUp61m7698gFgjb4pGW+4h4opsYzJ7
        7EBybrFMv/TvhCpUPmREboA=
X-Google-Smtp-Source: ABdhPJzGBxzQznDitw8/o43TMI+x10hD2vaevjzwGsjFxXXg1UWDzcO3RqAFHJYZcrv33zs6/dqI1w==
X-Received: by 2002:a17:902:bd06:b0:158:8973:b16b with SMTP id p6-20020a170902bd0600b001588973b16bmr22532902pls.129.1650489072179;
        Wed, 20 Apr 2022 14:11:12 -0700 (PDT)
Received: from localhost.localdomain ([27.7.104.83])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090a00cd00b001cd4989fee4sm106652pjd.48.2022.04.20.14.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 14:11:11 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/9] iio: accel: bma400: Fix the scale min and max macro values
Date:   Thu, 21 Apr 2022 02:40:57 +0530
Message-Id: <20220420211105.14654-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420211105.14654-1-jagathjog1996@gmail.com>
References: <20220420211105.14654-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing the scale macro values to match the bma400 sensitivity
for 1 LSB of all the available ranges.

Fixes: 465c811f1f20 ("iio: accel: Add driver for the BMA400")
Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
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

