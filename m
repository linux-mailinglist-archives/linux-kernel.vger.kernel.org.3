Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DA54FC5D6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349860AbiDKUeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349795AbiDKUd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:33:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CD035DD3;
        Mon, 11 Apr 2022 13:31:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e8-20020a17090a118800b001cb13402ea2so519868pja.0;
        Mon, 11 Apr 2022 13:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XLIAY+sHtftiUozOfh7PpmrA81WZfIdoHm67TMrq4Jo=;
        b=cOZ0d8JaHJWYIzJBXu2RbX1g5Xjeh6e5I3TV34aSgTWP2v6n8i/0N2DFAx3NkWQ2Tc
         rJhHTIMN7ORcusaw6WqjkvOLuEamcU/l68roG+0ypF1YDum90UbaiFo2p+/zMemKlMb/
         vYJ0eQF9JX05x8qZCkKSGfWKTQr8GszA54Ac6ARyR/5JQMgDCMRm2F40ZNzGvuBd+SxF
         g0LcqQja5DiLw8kbANSjGlIcU3C6UgwHEwldxeBxyChbr8drRzGcaWCFt2pOsLM5TADj
         ARqD8DoalbHPk2VGCse2asFJfvxXIqBHlsxPEFyDqTr5Lxqny9YjWX1C71ophRJnfceg
         TjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XLIAY+sHtftiUozOfh7PpmrA81WZfIdoHm67TMrq4Jo=;
        b=v58lfQbjb+FhjE5UA37aJOUnN4zHrtuhsD+tzIQOQ7T0u9hpGmbdYaVTeUP7e+0LEK
         Qmb6mq6b3I/j8Vyw0WOVAKUXaAV1YvL/UbwjQYjD5tnEuK9FBGakiS0h+5lVJ8ZjiMTE
         Wx2peGTnmxxIVnpcl3zXGnCv0uQqOUMnzlqwOMMwZM+hu3Aa5on9dkmNgNaU5OT934Yt
         vQM5CUr1KecrFueIf56kOZOxUBkDcvmQ+fGASs8qLk82acHG7FLrEgpVwN+y+T81Qfcp
         VWyf8i2MV0GSL9PFAVVwX1qcWm4H0vdSr6cRamqZuRM8/fNqSPzbDkeZkKEETQE6t/Q8
         Y5Aw==
X-Gm-Message-State: AOAM5334hTsrWHX5Bdm4EtqrYjklVlCx60TVYhiOu+vCfTbkxIaUz0AE
        KfM6vhrliU7mj4jwGOa0N4w=
X-Google-Smtp-Source: ABdhPJxtrndmMLAR1wJaZNppLmgQ91Kk7Y+BuJIdwSnzeRQlOrEOZDtQ/qgG6qAxILTRuPRL7gp4Cg==
X-Received: by 2002:a17:902:b692:b0:151:5474:d3ee with SMTP id c18-20020a170902b69200b001515474d3eemr34129394pls.139.1649709100606;
        Mon, 11 Apr 2022 13:31:40 -0700 (PDT)
Received: from localhost.localdomain ([27.7.99.112])
        by smtp.gmail.com with ESMTPSA id z15-20020a056a001d8f00b004fda37855ddsm34069828pfw.168.2022.04.11.13.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:31:40 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     dan@dlrobertson.com, jic23@kernel.org, andy.shevchenko@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/9] iio: accel: bma400: Fix the scale min and max macro values
Date:   Tue, 12 Apr 2022 02:01:25 +0530
Message-Id: <20220411203133.19929-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220411203133.19929-1-jagathjog1996@gmail.com>
References: <20220411203133.19929-1-jagathjog1996@gmail.com>
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
 drivers/iio/accel/bma400.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index c4c8d74155c2..5d6a1976503f 100644
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
+ * Scale values for +-2g, +-4g, +-8g and +-16g is populated into bma400_scales
+ * array by left shifting BMA400_SCALE_MIN.
+ * eg:
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

