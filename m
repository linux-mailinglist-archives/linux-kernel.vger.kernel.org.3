Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDA65386DE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 19:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239956AbiE3Rnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 13:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiE3Rnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 13:43:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD12E9C2D4;
        Mon, 30 May 2022 10:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653932616; x=1685468616;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ADYpM5J+3w78+Zt0VuDuMsgTux/+bW0Mv/yO7SYsttQ=;
  b=USgTCBhGwwdlPTu2k23ZTElP6NPf13GWnvL9mH+Ts/GxdC/oHWvBvwBN
   9tv0hcHqmgHcz3SkQF13bAg1d++cpiZ51u56MrabaHFvUBW/0wSOsvtPS
   o4Ouai689e2AjEyrHh4aeyHCx5HgGmJNrw5214ZCW6OxPxGw42rrPmaFB
   qAP0wdSoHB6qjKoVGlTbQ9kCv5EQahTGMolsT+0Jv7EESd4VIzp6nZ9qc
   uns7TrOI20zlWKjJzzSciSSQ8mivM6Q4CDASwemzkv5mfczNDkI84C9QB
   8VxyOeTDPGzQbbZL0KF0VbxetnNmm2+nEI95rbT5y3pR4HpRasoqGBe9B
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="361429631"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="361429631"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 10:43:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="903640517"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 30 May 2022 10:43:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4F1D0147; Mon, 30 May 2022 20:43:35 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: proximity: sx_common: Allow IIO core to take care of firmware node
Date:   Mon, 30 May 2022 20:43:26 +0300
Message-Id: <20220530174326.1381-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IIO core correctly will take care of firmware node if it's not set in
the driver. Drop ACPI and OF specifics from the driver and allow IIO
core to handle this.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/proximity/sx_common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
index 8ad814d96b7e..6bb68c1835da 100644
--- a/drivers/iio/proximity/sx_common.c
+++ b/drivers/iio/proximity/sx_common.c
@@ -5,7 +5,6 @@
  * Common part of most Semtech SAR sensor.
  */
 
-#include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/byteorder/generic.h>
 #include <linux/delay.h>
@@ -520,8 +519,6 @@ int sx_common_probe(struct i2c_client *client,
 	if (ret)
 		return dev_err_probe(dev, ret, "error reading WHOAMI\n");
 
-	ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(dev));
-	indio_dev->dev.of_node = client->dev.of_node;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	indio_dev->channels =  data->chip_info->iio_channels;
-- 
2.35.1

