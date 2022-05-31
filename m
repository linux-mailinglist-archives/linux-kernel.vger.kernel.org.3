Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604EE5398E3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 23:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348068AbiEaVjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 17:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242347AbiEaVj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 17:39:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FE17356A;
        Tue, 31 May 2022 14:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654033166; x=1685569166;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+yFy6pGKjBGDEm6WBT//MXILBMPlN1TRcy5qtEEqe+Y=;
  b=A+qsUG4QJYYFS3nBRP2gSaaF21qALcDeUfTCcXTeGKv6tNUhWJlw9v8e
   WvB6ingOkm2j+wHv7uCb3fn6D2xFpkOL+uoq85BRcWDMeOh2+XGx69J28
   Vpj2Vxr00qxg5U0kgYu5MmuNpJZa1shOnrgKMfTmG2y6RNj7/XYbvamHA
   /ik1feLjn80jpeXYBdpXKfKR2AY9FgrPG/jzb0vlsRlDeNRDIISsD4zfi
   KeTISESO3YZI1GKRqVCBF9P0Ycf2qklfbJYCbnH1Iwdb7wltpqOTuAmbd
   X3k83FCLTCPi4enXxW11niq+hToOh0cUibLJNMfDl65Mb0ttsitt6ibzp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="300743936"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="300743936"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 14:39:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="904160591"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2022 14:39:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9B9F518B; Wed,  1 Jun 2022 00:39:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] iio: adc: nau7802: Convert driver to use ->probe_new()
Date:   Wed,  1 Jun 2022 00:39:21 +0300
Message-Id: <20220531213922.72992-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the ->probe_new() callback.

The driver does not use const struct i2c_device_id * argument,
so convert it to utilise the simplified I²C driver registration.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/nau7802.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
index 976c235f3079..2d71cdbcd82f 100644
--- a/drivers/iio/adc/nau7802.c
+++ b/drivers/iio/adc/nau7802.c
@@ -407,8 +407,7 @@ static const struct iio_info nau7802_info = {
 	.attrs = &nau7802_attribute_group,
 };
 
-static int nau7802_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int nau7802_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
 	struct nau7802_state *st;
@@ -417,11 +416,6 @@ static int nau7802_probe(struct i2c_client *client,
 	u8 data;
 	u32 tmp = 0;
 
-	if (!client->dev.of_node) {
-		dev_err(&client->dev, "No device tree node available.\n");
-		return -EINVAL;
-	}
-
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
@@ -550,7 +544,7 @@ static const struct of_device_id nau7802_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, nau7802_dt_ids);
 
 static struct i2c_driver nau7802_driver = {
-	.probe = nau7802_probe,
+	.probe_new = nau7802_probe,
 	.id_table = nau7802_i2c_id,
 	.driver = {
 		   .name = "nau7802",
-- 
2.35.1

