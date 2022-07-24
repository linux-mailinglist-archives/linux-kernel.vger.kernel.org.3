Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBE657F609
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 18:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiGXQpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 12:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGXQpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 12:45:06 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38E0DFDF;
        Sun, 24 Jul 2022 09:45:02 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d17so12677383lfa.12;
        Sun, 24 Jul 2022 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MuA7bUK1vPsyvnnRjvygkOnBLlHAQP1fUUPE8cGCTKU=;
        b=P5sgjKwsaoaJMZA2RBJQY1WlmL17hTLIgSoNSzbH+ZRSUCHAw5EXC5g6W/Alg2tTrw
         DjMLBhpOJlA9mxpvI/oJH0eLDr6knefcxQsMROBAP4XUomHb9Pw+BtPrXw6uSQmpP3cQ
         Y3C8pK63hyXtEC9sIm2L9aRxFZKKxiAttsWJ8x7MQ1tVPa2SqcMmmM86QkI1t6NPCh2p
         nbntf860xxsFYixNA2btRSD2EtOQPFJcEEr2T6QcJsriDdabHvVxCIrIHoMhiIqQey8Y
         POujt9BfNuuFhc996M4QKXTdLvGUTd85izfhOJF3clFPb9B2EVmY+Kc5bMMa8vfTHJgA
         ttJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MuA7bUK1vPsyvnnRjvygkOnBLlHAQP1fUUPE8cGCTKU=;
        b=Oo9acZHguwck0H52Ppn2bzzcAuPXCiZ1e1UaVJ+4NXsHxnkowAhGj/Qjts4sryTJ7e
         LhtkdJbMl/hKTnus57hoQvL2xiaiZG/SpEd26tMk1Tjt0EULN0bFhljqM5A729e6kFMx
         dY4vTmeyLd0JzEhYXETrM25VUF/DkysgIBOy8hX1TnS19hi7VlLJmMHVXbIxnG/8WnIk
         ljd72KDJQcms8nnnHFU/plaG4Bme33fqRL8xOw0xQ+sFxvpLNz+kraVL1ln+uO7NgRNv
         pVcukQ7c8Up2GAXm1xYGILxqrTGudKqR5zkr1dP47yIWj3qsCkSDqtTUOR8HP/IHuRja
         prqQ==
X-Gm-Message-State: AJIora+lm3Q2lW4Knh95CCHcVHU8+3ND1MsPoYfDZY/nC/92ypj6oMCe
        UmYTOhyP6teOofM/Rxs2izpYr/oXW0cLRu1GL0U=
X-Google-Smtp-Source: AGRyM1vuxEcTb3Pr3xKx2cO93efjRep/PFRh2eJQYA9lgkVEvc3wcAZdwerS2VOq+2rfD7IrhEh/GQ==
X-Received: by 2002:a05:6512:13a1:b0:47f:787b:4e6a with SMTP id p33-20020a05651213a100b0047f787b4e6amr3112530lfa.64.1658681100823;
        Sun, 24 Jul 2022 09:45:00 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id k12-20020a2eb74c000000b0025d40241c1dsm2267566ljo.6.2022.07.24.09.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 09:45:00 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: st_sensors: Retry ID verification on failure
Date:   Sun, 24 Jul 2022 19:43:15 +0300
Message-Id: <20220724164316.68393-1-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some sensors do not always start fast enough to read a valid ID from
registers at first attempt. Let's retry at most 3 times with short sleep
in between to fix random timing issues.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 9910ba1da085..106f7953683e 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -21,6 +21,8 @@
 
 #include "st_sensors_core.h"
 
+#define VERIFY_ID_RETRY_COUNT 3
+
 int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
 				    u8 reg_addr, u8 mask, u8 data)
 {
@@ -619,11 +621,18 @@ EXPORT_SYMBOL_NS(st_sensors_get_settings_index, IIO_ST_SENSORS);
 int st_sensors_verify_id(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
-	int wai, err;
+	int wai, err, i;
 
 	if (sdata->sensor_settings->wai_addr) {
-		err = regmap_read(sdata->regmap,
-				  sdata->sensor_settings->wai_addr, &wai);
+		for (i = 0; i < VERIFY_ID_RETRY_COUNT; i++) {
+			err = regmap_read(sdata->regmap,
+					  sdata->sensor_settings->wai_addr, &wai);
+
+			if (!err && sdata->sensor_settings->wai == wai)
+				return 0;
+
+			msleep(20);
+		}
 		if (err < 0) {
 			dev_err(&indio_dev->dev,
 				"failed to read Who-Am-I register.\n");
-- 
2.34.1

