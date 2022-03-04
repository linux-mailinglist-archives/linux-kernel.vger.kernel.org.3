Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43814CDBAB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241482AbiCDSDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241460AbiCDSDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:03:32 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40EAE0C4;
        Fri,  4 Mar 2022 10:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646416964; x=1677952964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rVFnKmMZZ9DWqLHjmCaZvL7C3v2+5Lw0Q+OH0POJSNI=;
  b=PdrTIfNWWXX9UCPzpSbJs38IT2UEDOnfI+H19siNHq9U/qNx5p60QGJI
   KjdiguL2M+f/4rzlwvLZNScIk8TdD17vUIJqds1lIX9ypw5dDRp5dtaf8
   2zm3xvu6xRwdeQ9yLPC5TxX/G/2YJ/Jdo7WdmNjHMpkGWsSA7V/KhEDik
   leNIVtretg6gajr5i0DPtghnQwPUU0k5Fdz560xxGuqL5m2LjSoT+zB16
   0xa14yWFLAGkaA2Se/4s3fgXA1OvokPek36Pu+4i0UguV+56hF4/fo2xt
   Aa25lUT9BdtHuM37P72zwZHjbSfr1LrF9ViTPcn8krlzpX29OsBrFnNGx
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="251603591"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="251603591"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 10:02:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="536355542"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 04 Mar 2022 10:02:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 580AA9B; Fri,  4 Mar 2022 20:03:00 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v4 2/3] iio: temperature: ltc2983: Use single error path to put OF node
Date:   Fri,  4 Mar 2022 20:02:56 +0200
Message-Id: <20220304180257.80298-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220304180257.80298-1-andriy.shevchenko@linux.intel.com>
References: <20220304180257.80298-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
---
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

