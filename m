Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7E054C7B2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243983AbiFOLr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbiFOLru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:47:50 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9171E25EAE;
        Wed, 15 Jun 2022 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655293668; x=1686829668;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QbIkcyUw/L14+nIayRRYoRVuzlGbZsXJBtcZC1EJL9o=;
  b=YHpKRDPJyQnqZEzFRFYRevwBwirC+xV1rwYc/00wzqiDanFyrfqTGsAt
   jAH+vGLh9+k3GCaXCRiC7EC4i+Znw9ZliCeDoHR9SDF3F5jDhpm4TB3Zm
   vWEvhwfo37rakcc3FSR6aUkzBQTrNBnVXsOGZYH9A2+fA9LEGT/g+EHr1
   uJ162YbkdAcHdhZxZWcGcNzboxZMG7iCsGu5Juv0gJef6s7Jss0jv1omv
   T+q/wFrJ/dFftRzQYI6Kx9zcUxzSxYSYNSvnPTCyiHgmhv2dlSsR1rIUB
   10iPxytcw90NMfcw8hSve7jomOLKCa4x9G2zswbklWCbYu4VTIbyBfqmQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="267621696"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="267621696"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 04:47:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="618424942"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2022 04:47:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3C8BA18F; Wed, 15 Jun 2022 14:47:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 1/2] iio: proximity: sx_common: Don't use IIO device for properties
Date:   Wed, 15 Jun 2022 14:47:45 +0300
Message-Id: <20220615114746.2767-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not correct to use artificial device created by IIO core to
retrieve device properties. Even ->get_default_reg() callback
takes a simple struct device pointer which suggests it wants to
operate on the real device.

Correct this by replacing pointer to IIO device by a real device
pointer in the caller of ->get_default_reg().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch (necessary prerequisite for the following change)
 drivers/iio/proximity/sx_common.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
index 8ad814d96b7e..9f2e47385198 100644
--- a/drivers/iio/proximity/sx_common.c
+++ b/drivers/iio/proximity/sx_common.c
@@ -434,7 +434,7 @@ static void sx_common_regulator_disable(void *_data)
 
 #define SX_COMMON_SOFT_RESET				0xde
 
-static int sx_common_init_device(struct iio_dev *indio_dev)
+static int sx_common_init_device(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct sx_common_data *data = iio_priv(indio_dev);
 	struct sx_common_reg_default tmp;
@@ -456,8 +456,7 @@ static int sx_common_init_device(struct iio_dev *indio_dev)
 
 	/* Program defaults from constant or BIOS. */
 	for (i = 0; i < data->chip_info->num_default_regs; i++) {
-		initval = data->chip_info->ops.get_default_reg(&indio_dev->dev,
-							       i, &tmp);
+		initval = data->chip_info->ops.get_default_reg(dev, i, &tmp);
 		ret = regmap_write(data->regmap, initval->reg, initval->def);
 		if (ret)
 			return ret;
@@ -530,7 +529,7 @@ int sx_common_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, indio_dev);
 
-	ret = sx_common_init_device(indio_dev);
+	ret = sx_common_init_device(dev, indio_dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Unable to initialize sensor\n");
 
-- 
2.35.1

