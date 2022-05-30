Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFDC53870D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240751AbiE3SJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiE3SJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:09:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64980880E4;
        Mon, 30 May 2022 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653934153; x=1685470153;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=APf9H3bQaLX5xdgeDhr5uhdcMm7qld03/mguKjCk4tE=;
  b=Q7qDT/rxBB0Oq2t9pJo/9NNQwyKz66hQzxc+Uu4/WXJaBvlU6+EAtR0w
   HawyDIkBzVMldpax1GUwZEVu8nzgcJDOdMl1zs6ukX9V4Kn0jIym/6Eea
   r8M1L6v/33C9735vCTVMiakmpe7/VoKv9R4hjtPj67MWiQaXpFfPzMs8R
   /z0lTjjW1u99WrhJfauINS7ylEVe0wcfP71BvjsfZJzZ/ZaEKqtY+DDxL
   dJv5KSyE1vXT7X+dvAzxHGhZGRJ1rLOff7DsOG7VfJuy8JTPHColaM4Ds
   61qHKDeqZNKk9KoWtgLOcyOGVvhOwIGBEcQPJ4YVXwZgOXKYu+AqerSx4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="274776794"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="274776794"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 11:09:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="551439362"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 30 May 2022 11:09:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4EB8F147; Mon, 30 May 2022 21:09:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Cixi Geng <cixi.geng1@unisoc.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: adc: sc27xx_adc: Re-use generic struct u32_fract
Date:   Mon, 30 May 2022 21:09:10 +0300
Message-Id: <20220530180910.2533-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of custom data type re-use generic struct u32_fract.
No changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/sc27xx_adc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index e9ff2d6a8a57..f8421cbba8fa 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -579,15 +579,14 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 	return ret;
 }
 
-static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
-				  int channel, int scale,
-				  u32 *div_numerator, u32 *div_denominator)
+static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data, int channel, int scale,
+				  struct u32_fract *fract)
 {
 	u32 ratio;
 
 	ratio = data->var_data->get_ratio(channel, scale);
-	*div_numerator = ratio >> SC27XX_RATIO_NUMERATOR_OFFSET;
-	*div_denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
+	fract->numerator = ratio >> SC27XX_RATIO_NUMERATOR_OFFSET;
+	fract->denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
 }
 
 static int adc_to_volt(struct sc27xx_adc_linear_graph *graph,
@@ -615,7 +614,7 @@ static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
 static int sc27xx_adc_convert_volt(struct sc27xx_adc_data *data, int channel,
 				   int scale, int raw_adc)
 {
-	u32 numerator, denominator;
+	struct u32_fract fract;
 	u32 volt;
 
 	/*
@@ -637,9 +636,9 @@ static int sc27xx_adc_convert_volt(struct sc27xx_adc_data *data, int channel,
 		break;
 	}
 
-	sc27xx_adc_volt_ratio(data, channel, scale, &numerator, &denominator);
+	sc27xx_adc_volt_ratio(data, channel, scale, &fract);
 
-	return DIV_ROUND_CLOSEST(volt * denominator, numerator);
+	return DIV_ROUND_CLOSEST(volt * fract.denominator, fract.numerator);
 }
 
 static int sc27xx_adc_read_processed(struct sc27xx_adc_data *data,
-- 
2.35.1

