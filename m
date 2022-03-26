Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF6B4E83DB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 20:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbiCZTne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 15:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiCZTna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 15:43:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB4B171EE9;
        Sat, 26 Mar 2022 12:41:53 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m22so10494130pja.0;
        Sat, 26 Mar 2022 12:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2MUvttVDJrqfDquwKrENIil7MJ5lIrh0ddfHwkgcdCU=;
        b=OxUshMVF0J2GRicRE0VwXbMqn/Uv0RTovqyRQ7iZJ5ldXyDhXvk4kREeQZVXhL7iGT
         9x8NT/sKke1qJo+Wdg27rWyZ3zpH+EvpFSLsgZrB9TcE9lHrfgRUiAvIkj6hSkUVqsjW
         dlOvQjrlwLcyZ48g3GPYOGtp7zi3zhPMyUL8KugrRxX89cFltDbaZIC3XP3AxQcdDys9
         GU6pJmgZG6i+AnaUdCEM0ZBEhGcxyzdd+g2eHhagZr/aHQekjv3mjAgiG8wsYYMKWmCF
         bT2wqem6cQCtCJ73aDhKHkdzSsq9CEx+0o2WQX/rn0yfAn/uVSflFtyUaOMZccGoQ/lp
         YUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2MUvttVDJrqfDquwKrENIil7MJ5lIrh0ddfHwkgcdCU=;
        b=jtZauhcxJdCIa6Mx5uBddGzr50rfVfcuvMKntvSM35Zb4t/RQTrpLQtMMmfAZAmvTX
         C3/2qGu0x3Dq0SjPszyfekA4PFDFWdnKsizkNMbInNKx0Aa1f4eWA579ZPDQYcBaC+hv
         DYYk0EkzSDZrhfHvX/jk02HdEjluhtP4tMHag+V+lJyXH1CcGCJNkiz1/akUe8+L0US0
         6Mwco95klFFtDFepA2X1pQdwAomi14jtBUjHiMFonqUfwwFjQGwx0lYhAyLEDRgxAlbG
         EIdS3uJMX65hOWb4lOBYVL7FEBW8wuLM7CNCS4eW1SN34e0zAIbfdMMEMYuCmx4sWvoX
         JTfg==
X-Gm-Message-State: AOAM530xrP0N28CXF77yKYPUC0sXhf+GF2++LhyQ2ANG5ft3nBTHyon6
        ZQqHqei3POKnE8iVXaTTnpbfsAA0b1rrFnyH
X-Google-Smtp-Source: ABdhPJzwL0aLG/LFozEXKZCpc3YUpTiwsoD/EkJPVyuYh88UkHScEPkkQ1AfnKQLe+wuZHkESct5ew==
X-Received: by 2002:a17:902:b113:b0:153:1d99:9cc7 with SMTP id q19-20020a170902b11300b001531d999cc7mr18253683plr.6.1648323713024;
        Sat, 26 Mar 2022 12:41:53 -0700 (PDT)
Received: from localhost.localdomain ([116.75.119.161])
        by smtp.gmail.com with ESMTPSA id k185-20020a6384c2000000b003821dcd9020sm8778784pgd.27.2022.03.26.12.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 12:41:52 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] iio: accel: bma400: Fix the scale min and max macro values
Date:   Sun, 27 Mar 2022 01:11:42 +0530
Message-Id: <20220326194146.15549-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220326194146.15549-1-jagathjog1996@gmail.com>
References: <20220326194146.15549-1-jagathjog1996@gmail.com>
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

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/iio/accel/bma400.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index c4c8d74155c2..190366debdb3 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -83,8 +83,26 @@
 #define BMA400_ACC_ODR_MIN_WHOLE_HZ 25
 #define BMA400_ACC_ODR_MIN_HZ       12
 
-#define BMA400_SCALE_MIN            38357
-#define BMA400_SCALE_MAX            306864
+/* BMA400_SCALE_MIN macro value represents m/s^2 for 1 LSB before
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
+ * Scale values for +-2g, +-4g, +-8g and +-16g is populated into bma400_scales
+ * array by left shifting BMA400_SCALE_MIN.
+ * eg:
+ * To select +-2g = 9577 << 0 = raw value to write is 0.
+ * To select +-8g = 9577 << 2 = raw value to write is 2.
+ * To select +-16g = 9677 << 3 = raw value to write is 3.
+ */
+#define BMA400_SCALE_MIN            9577
+#define BMA400_SCALE_MAX            76617
 
 #define BMA400_NUM_REGULATORS       2
 #define BMA400_VDD_REGULATOR        0
-- 
2.17.1

