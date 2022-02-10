Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F2C4B0F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbiBJNzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:55:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242473AbiBJNzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:55:09 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644A4BF5;
        Thu, 10 Feb 2022 05:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644501310; x=1676037310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sqUnAdEkShnN39QBJD9Pml4jv0bPb6RKc2JeSj5RwA8=;
  b=akzWXmOOZ1fSQFRerwo+wnkcgkJ5+FuyK85r6lSsYsG7SnM4kL4UdX/D
   n8itEzhKwrAh0gRdWYqLMKWbj2wE8oWMcq1BTsLV25mjUSigVFcidxmbs
   51wZvsWuLWIZIZxNe/yV4M1/TnxfiCBXdh96yc+CYqzXZ0v1fTWgG7pIb
   7mTpCJyJ/45VljTYqfBEsnVtvSVjj6p6v6fjCRcLmlNcq3saR134GPcfE
   Aj7LX1XxQXqWRo3hnsILnSQagMTeWYizXNa/sJXOI/gYOFX/hbSIquWtN
   CTAfks+QUuE7D78v5p4WUQW0faFCrdcRMt8A7NlBDyrMO2kf51Mv4HQbe
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="236896717"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="236896717"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 05:55:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="622684442"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Feb 2022 05:55:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2F0A131D; Thu, 10 Feb 2022 15:55:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 2/3] iio: temperature: ltc2983: Use single error path to put OF node
Date:   Thu, 10 Feb 2022 15:55:21 +0200
Message-Id: <20220210135522.26562-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210135522.26562-1-andriy.shevchenko@linux.intel.com>
References: <20220210135522.26562-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
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

