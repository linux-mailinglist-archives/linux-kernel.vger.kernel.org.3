Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E220594EF5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 05:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiHPDKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 23:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiHPDJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 23:09:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4528E2EB18D;
        Mon, 15 Aug 2022 16:39:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e27so5990765wra.11;
        Mon, 15 Aug 2022 16:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=fNZ/gu4y7lfnFdkzN59SrFsjLrasJHIFSJmdJSlw+Vg=;
        b=Wi7h8LTYLPTSh3B5af4Y32gM2Hz99rqlKJV3ZCftNwtNAT/ECYv/kQSWZnzEnYojwK
         b9QMuGsS0E5OV1NBLuVFVozNAMa6693lC13WRCl60Aa8hTRa+O5FYwQM1xLue5stgWcN
         sCJxTOW6D2x3VGTn5eI5Lo4yYP0QvCsBHfqkD0YCgREqFP/n5xMi184wwxmqnvfuCNL/
         InQs/7Srm8qpchb+sH0H8193B78OKT64MDSGcdazcGE/qXg4JSNl+jQfx3WrmsLHWTBV
         YBJgtTYb7TCl+aE2u0xPECWZjCisRsnWKTdliM7/pObogqKBwVcouaUHWsKDlqdvv0az
         r3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=fNZ/gu4y7lfnFdkzN59SrFsjLrasJHIFSJmdJSlw+Vg=;
        b=R30pL2oXlzrVwV2u1yPBpBdYPqs3D3sIWY+5fdrlJCmpMwfBhHPH4oYWsrtBaXbeLo
         /y/pykEkttlUIHR0EecxQ1/RfQfzLTp1kTIdfaMb55eJjSkY9DN7fTGush9FB7NPANRx
         8akB9keY7S+H7E41awjGAeNsR2xugDeYaxEheVjjattH058pgxYOLMIXO87UcR5DwkEq
         PgkQDbchJZfCK6sjj/9s6Ztq/4QFS/VEMD8W3901rx2/jT0zA6O5IDmnF2PdiVaWQn25
         QXVZXFc/OMwgzolfB1i8tMjw2ZMYNqNklBzNlEOno2zXc8/LJc93AjV1katK13+X1gAq
         feow==
X-Gm-Message-State: ACgBeo1sM8nL0OSd8bin+8pBItLrtn9voHhqgDOuZdR3qGDdL1lwe6H8
        A+PzGpTOXmROY919dLQ8d8MHfF+2qFo=
X-Google-Smtp-Source: AA6agR6mCwlJu7tApOQkto2S84JFh2mY8NPl3dwKAYlBSYbO7MwVT8vcMJU/LKsS4wdnmwNp+0X8mA==
X-Received: by 2002:adf:d1c4:0:b0:220:7a85:ad7c with SMTP id b4-20020adfd1c4000000b002207a85ad7cmr9426609wrd.128.1660606793976;
        Mon, 15 Aug 2022 16:39:53 -0700 (PDT)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id bh13-20020a05600c3d0d00b003a550be861bsm11197144wmb.27.2022.08.15.16.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 16:39:53 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio <linux-iio@vger.kernel.org>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: pressure: bmp280: fix datasheet links
Date:   Tue, 16 Aug 2022 01:38:54 +0200
Message-Id: <6e908cc827c70b95dae683717592aff0b003e7c9.1660606478.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Updated links for BMP280 and BME280 datasheets on Bosch website.
Datasheet of BMP180 is no longer available on the manufacturer's website,
changed the link to a copy hosted by a third party.

Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index fe7aa81e7cc9..e98b024d510b 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -9,9 +9,9 @@
  * Driver for Bosch Sensortec BMP180 and BMP280 digital pressure sensor.
  *
  * Datasheet:
- * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP180-DS000-121.pdf
- * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP280-DS001-12.pdf
- * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME280_DS001-11.pdf
+ * https://cdn-shop.adafruit.com/datasheets/BST-BMP180-DS000-09.pdf
+ * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp280-ds001.pdf
+ * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme280-ds002.pdf
  */
 
 #define pr_fmt(fmt) "bmp280: " fmt

base-commit: b82217e73b5aa6db8453ad91b929ca2366e47184
-- 
2.37.2

