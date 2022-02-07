Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15B34AB931
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352673AbiBGK4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245274AbiBGKtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:49:24 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC03C043189;
        Mon,  7 Feb 2022 02:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644230963; x=1675766963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pWWmXFXMBugnQkDbE72PMjOeQFelu1Mt6Tc+LQ7BGNk=;
  b=f/Mku7l5cfb9QT1Vzs2uGR5oosJuxrEll0zVxwhcfWKt/Gus+oOXGHzf
   Mxlh7c72SwlWf71CX/gPObP7wqYPvMH/gzKZKlQ88V97m+ku2bOhT6sXJ
   bZzXC+u332ZIGOZ5I32ZWQPMYdrlQeNW8cgrKtEgyLf4krPWqR4zzSjc5
   f3fsi9hh2sWryyi6tfOA/xo0rBt5t3al8HtktQiycJINvjDyOI9ZBEFqT
   VSAeZV0ArEvDbYqybgRk0Kce3rziGZ4aigQlQQClEJj6m6DQSLRPKfOVy
   RbxwaD3WH2zZjqwQARof+A9FbkkYlROfnwYWllOK5+MH5Np3yerZ+8mRd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="248902278"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="248902278"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 02:48:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="481545300"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 07 Feb 2022 02:48:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 692B93ED; Mon,  7 Feb 2022 12:48:32 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 2/3] iio: temperature: ltc2983: Use single error path to put OF node
Date:   Mon,  7 Feb 2022 12:48:29 +0200
Message-Id: <20220207104830.83882-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207104830.83882-1-andriy.shevchenko@linux.intel.com>
References: <20220207104830.83882-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
v2: new patch (Jonathan)
 drivers/iio/temperature/ltc2983.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index d272c303c1b0..1a23ff223f21 100644
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

