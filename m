Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A41527370
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 20:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbiENSUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 14:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiENSUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 14:20:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB7338197;
        Sat, 14 May 2022 11:20:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i19so21694289eja.11;
        Sat, 14 May 2022 11:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pUYpeImbAqOBUb0UBcRbQZgfeNt+9zMkDd+UbinLleA=;
        b=TmlrIscHfjet5fM7ny4Eh6Xbh+mWdtBBO7ss6zTRY1omVxhzjs04O8WPMU5hxry2Lj
         4wLQNRkn5tWDQ6U2bMnFTlG9Yciuby5/x43us+M437SrnYenHrxv0o7IQ66KL/XSK8x7
         P38gYkW8mK/6nmU3IluX9s1pPZKYDNP76WJGe0xgJk0DEtDOIxV8MbPXSEuAv+TmH8KZ
         aaVaD3txz5gQkcDAxO+mwfBTU+gj12bfJh6FSZzR7ABn94OZJSxxVjBUlBRyisgs5jiE
         MOQb3g/tYywGZbsm9IrvoL1Igo1dG+c0ZCcQARsbgCy90SHfpCenBOBAyQ9UaRJ9n9NS
         U2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pUYpeImbAqOBUb0UBcRbQZgfeNt+9zMkDd+UbinLleA=;
        b=DMuxZg8Zmpolcq0BWChysPfxHGvZrjX0xhy6EJzLvcW7xGwkMN24walxDQqMn6voKU
         zcprHbcQ7hSFD0TQt/jEpR/wxnZjp+lplMaEChz8VQDfsNMHwDSKSk7ygqyNQvmmwtFn
         012fqzOxvEfGgU/7/OmRCPAuN+0sokPGdDcndZkDDL0TiclGlvX88YxNcXZBYI15OeI8
         NTEkkhQJtWpwx5XIdhloYeHwwpV+qyRikJXgSVHYaFZKdb4RIJijSB66+UWegYXlQoyx
         jMmb2spdlZG4BK4khd9kFc37dD2jT5XEyxe2RFe3DW12XO5RuBO379t06q+SYnuBY206
         hScw==
X-Gm-Message-State: AOAM532I+6RFq3p7WlcGp0VjR8pr8uSQ9cMNMnnssC/wFPAN4dUfQq8O
        bSNevr+gWpnvNH4o91vlDNs=
X-Google-Smtp-Source: ABdhPJz//1N2TaHTmvRE+BqJmQ7ek/bMQ69s5SkVHYV2UoKUWLD6Ru7aV5G+UnzvM+K9lKwg9DL7Dw==
X-Received: by 2002:a17:906:b48:b0:6f5:132c:1a17 with SMTP id v8-20020a1709060b4800b006f5132c1a17mr9127666ejg.748.1652552430577;
        Sat, 14 May 2022 11:20:30 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.86.218])
        by smtp.gmail.com with ESMTPSA id jz25-20020a17090775f900b006fa6a51459asm1925898ejc.96.2022.05.14.11.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 11:20:30 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH] iio: accel: adxl367: do not update FIFO watermark on scan mode update
Date:   Sat, 14 May 2022 21:20:10 +0300
Message-Id: <20220514182010.152784-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the driver updates the FIFO watermark inside both
update_scan_mode() and hwfifo_set_watermark(). Inside the IIO core,
hwfifo_set_watermark() is called immediately after update_scan_mode(),
making the first call to set_fifo_samples() redundant.

Remove the first call to set_fifo_samples(), and merge the
set_fifo_samples() function into the set_fifo_watermark()
function. Also, since fifo_set_size is always set inside of
update_scan_mode(), and it cannot be set to 0, remove the
zero check from set_fifo_samples().

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/iio/accel/adxl367.c | 46 ++++++++-----------------------------
 1 file changed, 9 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index 0289ed8cf2c6..72a8c3fb27b9 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -447,21 +447,17 @@ static int adxl367_set_fifo_format(struct adxl367_state *st,
 					     fifo_format));
 }
 
-static int adxl367_set_fifo_samples(struct adxl367_state *st,
-				    unsigned int fifo_watermark,
-				    unsigned int fifo_set_size)
+static int adxl367_set_fifo_watermark(struct adxl367_state *st,
+				      unsigned int fifo_watermark)
 {
-	unsigned int fifo_samples = fifo_watermark * fifo_set_size;
+	unsigned int fifo_samples = fifo_watermark * st->fifo_set_size;
 	unsigned int fifo_samples_h, fifo_samples_l;
 	int ret;
 
 	if (fifo_samples > ADXL367_FIFO_MAX_WATERMARK)
 		fifo_samples = ADXL367_FIFO_MAX_WATERMARK;
 
-	if (fifo_set_size == 0)
-		return 0;
-
-	fifo_samples /= fifo_set_size;
+	fifo_samples /= st->fifo_set_size;
 
 	fifo_samples_h = FIELD_PREP(ADXL367_SAMPLES_H_MASK,
 				    FIELD_GET(ADXL367_SAMPLES_VAL_H_MASK,
@@ -475,30 +471,8 @@ static int adxl367_set_fifo_samples(struct adxl367_state *st,
 	if (ret)
 		return ret;
 
-	return regmap_update_bits(st->regmap, ADXL367_REG_FIFO_SAMPLES,
-				  ADXL367_SAMPLES_L_MASK, fifo_samples_l);
-}
-
-static int adxl367_set_fifo_set_size(struct adxl367_state *st,
-				     unsigned int fifo_set_size)
-{
-	int ret;
-
-	ret = adxl367_set_fifo_samples(st, st->fifo_watermark, fifo_set_size);
-	if (ret)
-		return ret;
-
-	st->fifo_set_size = fifo_set_size;
-
-	return 0;
-}
-
-static int adxl367_set_fifo_watermark(struct adxl367_state *st,
-				      unsigned int fifo_watermark)
-{
-	int ret;
-
-	ret = adxl367_set_fifo_samples(st, fifo_watermark, st->fifo_set_size);
+	ret = regmap_update_bits(st->regmap, ADXL367_REG_FIFO_SAMPLES,
+				 ADXL367_SAMPLES_L_MASK, fifo_samples_l);
 	if (ret)
 		return ret;
 
@@ -1276,14 +1250,11 @@ static int adxl367_update_scan_mode(struct iio_dev *indio_dev,
 {
 	struct adxl367_state *st  = iio_priv(indio_dev);
 	enum adxl367_fifo_format fifo_format;
-	unsigned int fifo_set_size;
 	int ret;
 
 	if (!adxl367_find_mask_fifo_format(active_scan_mask, &fifo_format))
 		return -EINVAL;
 
-	fifo_set_size = bitmap_weight(active_scan_mask, indio_dev->masklength);
-
 	mutex_lock(&st->lock);
 
 	ret = adxl367_set_measure_en(st, false);
@@ -1294,11 +1265,12 @@ static int adxl367_update_scan_mode(struct iio_dev *indio_dev,
 	if (ret)
 		goto out;
 
-	ret = adxl367_set_fifo_set_size(st, fifo_set_size);
+	ret = adxl367_set_measure_en(st, true);
 	if (ret)
 		goto out;
 
-	ret = adxl367_set_measure_en(st, true);
+	st->fifo_set_size = bitmap_weight(active_scan_mask,
+					  indio_dev->masklength);
 
 out:
 	mutex_unlock(&st->lock);
-- 
2.35.3

