Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687A2498672
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244557AbiAXRVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:21:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:35243 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244324AbiAXRU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643044829; x=1674580829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=se/aEC9HgTBzxLx3OJbYihBez8zl3RiKCuUOJXNE4gU=;
  b=EQ3zGLjSjSRMPxfPQkdJ1Th5KxAtTLidmuk1RTQ+z7H/rDj1ykJDP0O0
   Ox3CrJi6WWSxRYydDRGs+TVBm/xPEhfqRE2L/d8yi6lO01BWXM/zOrNo6
   MDsEchm2BaeMlth9N425DeXutbP5b86XdAarPiJ4iqsXF5dwZESfcR9xa
   Om0TDAwqYbF7VUOCWC6gwwulMc0Xn24zB+FP4aNePpIEBYeIsic92A09C
   GcJpEDG4riINVoxJbR6s1FCOg2+iQmMOFjH8e6Tg+pqk2NP4gGlnn0dat
   JcalsGi6voYbyLDE0t1euHQs6KS3xwcIiYiDLpJ/fC2U3a5tayMBROkLb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="233460796"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="233460796"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 09:20:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="532144834"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jan 2022 09:20:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BCD55A51; Mon, 24 Jan 2022 19:20:35 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH v3 5/6] iio: afe: iio-rescale: Group rescale field assignments in ->probe()
Date:   Mon, 24 Jan 2022 19:20:31 +0200
Message-Id: <20220124172032.87893-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124172032.87893-1-andriy.shevchenko@linux.intel.com>
References: <20220124172032.87893-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group rescale field assignments in the ->probe() for better maintenance.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: new patch
 drivers/iio/afe/iio-rescale.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 774eb3044edd..8b9d2aa1502e 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -322,7 +322,7 @@ static int rescale_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	rescale = iio_priv(indio_dev);
-
+	rescale->source = source;
 	rescale->cfg = of_device_get_match_data(dev);
 	rescale->numerator = 1;
 	rescale->denominator = 1;
@@ -338,8 +338,6 @@ static int rescale_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, indio_dev);
 
-	rescale->source = source;
-
 	indio_dev->name = dev_name(dev);
 	indio_dev->info = &rescale_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.34.1

