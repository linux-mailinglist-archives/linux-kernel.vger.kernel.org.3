Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA6A5392BD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345443AbiEaNyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345409AbiEaNya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:54:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711298FFB0;
        Tue, 31 May 2022 06:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654005208; x=1685541208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LltwEzJ1PPFMhj2wpaN+6JtJMLZwcYWN9NWBcvqkjy4=;
  b=dMg6MVArOvTNpo8VRXhLAUJylq1uQwQIMcv5k2tc3vLLTWxXo6NOksuu
   +rpKpJ00pvFkdRhbUvpCV1p82lwNNyIEDNIge2X9dYmBLQuLTVx5F7Ei+
   F4Ij3slX2BjTdWdgXZqOLT96Jk1pV/GbvDRnzWHs7pga/RNJkm/CxKQcs
   ABzopF7/MEl9HvFDKcDh6ayGtlg1G2G6E/Y6i/JUd7FAr8VGlMa18nP7N
   FBQrIhXqvjIbzzjbQ18XR54GZ3V8zSRC8Z62LFGVrHHrky0dJ8wXUUlh/
   GTeYBLEW/Qn4AQkOJtwf7f1CU6JoDct/3DeGABOdYpyEtYoXgjvURxofc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="335916866"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="335916866"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 06:53:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="666927157"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 31 May 2022 06:53:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 03F081AA; Tue, 31 May 2022 16:53:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: dac: ad5592r: Get rid of OF specifics
Date:   Tue, 31 May 2022 16:53:20 +0300
Message-Id: <20220531135320.63096-1-andriy.shevchenko@linux.intel.com>
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

Use dev_fwnode() instead of direct OF node dereference when checking
for regulator API error code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/dac/ad5592r-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 4434c1b2a322..7a9b5fc1e579 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -603,7 +603,7 @@ int ad5592r_probe(struct device *dev, const char *name,
 
 	st->reg = devm_regulator_get_optional(dev, "vref");
 	if (IS_ERR(st->reg)) {
-		if ((PTR_ERR(st->reg) != -ENODEV) && dev->of_node)
+		if ((PTR_ERR(st->reg) != -ENODEV) && dev_fwnode(dev))
 			return PTR_ERR(st->reg);
 
 		st->reg = NULL;
-- 
2.35.1

