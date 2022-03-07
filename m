Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8BA4D0869
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245276AbiCGUg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238751AbiCGUgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:36:50 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B1D71EF1;
        Mon,  7 Mar 2022 12:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646685355; x=1678221355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g+6w6TnPsi4QhrBAbx8/tcPqsNp9GS1bfnvEasCEFrQ=;
  b=UU5LKLXLi20Wz6u48ImuacsZ4N8ScDU5kkj7i6tzJ4x4UPHC3l0siOHb
   zEfQ74+2VNJekhcCCmBgLrnLS0yFekgHxwAWapUYIjtLfNoYdsWJtJ6Xe
   QMpnKw4dY7ZgguJedCKnVIFTCGBIRni9wZUXbRRwtzjfXrL8WSskgbN4E
   /LGKKezXpck3mEaGNURo7YJ4owsdtXzQjG28ZMBhY9YjkxM46IyJ3GdCj
   hSDEJC4qYPBOZ9jIcvrA5WfdiOfXsp31wVnfcSQSuHmf7dAqtpcYBQ0wN
   y+OgYYGr6qKdyzCBW6o3ySRrVc2wpvgLN7cEYRO9KGW5x4ZniIaDlOZu1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="241934238"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="241934238"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:35:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="711247474"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 07 Mar 2022 12:35:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E54B19B; Mon,  7 Mar 2022 22:36:10 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v5 2/3] iio: temperature: ltc2983: Use single error path to put OF node
Date:   Mon,  7 Mar 2022 22:36:05 +0200
Message-Id: <20220307203606.87258-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220307203606.87258-1-andriy.shevchenko@linux.intel.com>
References: <20220307203606.87258-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several, possibly copied'n'pasted, places in the functions,
where OF node is put and error returned directly, while the common
exit point exists. Unify all these cases to use a single error path.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
---
v5: added tag (Nuno)
v4: no changes
v3: no changes
 drivers/iio/temperature/ltc2983.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 94d6dd4db47a..636bbc9011b9 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -653,8 +653,6 @@ static struct ltc2983_sensor *ltc2983_thermocouple_new(
 
 	phandle = of_parse_phandle(child, "adi,cold-junction-handle", 0);
 	if (phandle) {
-		int ret;
-
 		ret = of_property_read_u32(phandle, "reg",
 					   &thermo->cold_junction_chan);
 		if (ret) {
@@ -663,8 +661,7 @@ static struct ltc2983_sensor *ltc2983_thermocouple_new(
 			 * the error right away.
 			 */
 			dev_err(&st->spi->dev, "Property reg must be given\n");
-			of_node_put(phandle);
-			return ERR_PTR(-EINVAL);
+			goto fail;
 		}
 	}
 
@@ -676,8 +673,8 @@ static struct ltc2983_sensor *ltc2983_thermocouple_new(
 							     propname, false,
 							     16384, true);
 		if (IS_ERR(thermo->custom)) {
-			of_node_put(phandle);
-			return ERR_CAST(thermo->custom);
+			ret = PTR_ERR(thermo->custom);
+			goto fail;
 		}
 	}
 
@@ -687,6 +684,10 @@ static struct ltc2983_sensor *ltc2983_thermocouple_new(
 
 	of_node_put(phandle);
 	return &thermo->sensor;
+
+fail:
+	of_node_put(phandle);
+	return ERR_PTR(ret);
 }
 
 static struct ltc2983_sensor *ltc2983_rtd_new(const struct device_node *child,
@@ -803,8 +804,8 @@ static struct ltc2983_sensor *ltc2983_rtd_new(const struct device_node *child,
 							  "adi,custom-rtd",
 							  false, 2048, false);
 		if (IS_ERR(rtd->custom)) {
-			of_node_put(phandle);
-			return ERR_CAST(rtd->custom);
+			ret = PTR_ERR(rtd->custom);
+			goto fail;
 		}
 	}
 
@@ -926,8 +927,8 @@ static struct ltc2983_sensor *ltc2983_thermistor_new(
 								 steinhart,
 								 64, false);
 		if (IS_ERR(thermistor->custom)) {
-			of_node_put(phandle);
-			return ERR_CAST(thermistor->custom);
+			ret = PTR_ERR(thermistor->custom);
+			goto fail;
 		}
 	}
 	/* set common parameters */
-- 
2.34.1

