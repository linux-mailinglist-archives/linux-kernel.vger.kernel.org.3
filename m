Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F4349866C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244406AbiAXRUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:20:33 -0500
Received: from mga04.intel.com ([192.55.52.120]:37867 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244359AbiAXRU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643044828; x=1674580828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RVVPkYMMp87PkJON1Ymf9k5n3tLKBCKMpBFOUFvL4KE=;
  b=CNqgUIJpNinmvHkbc5uF6q7BsgPtimJh1pL/FLaTbDLMhJJ46WTtN18F
   ZESEIJcBE8FlFb8cJ/4/y5qKgKR1mFM7K2f4mwROKvn6+ePSv+gA5dOY2
   S0+Jj9GmZJWcK/0bu5Fa658oKPEWdHjzL51v9imoPx8vv/Sm9z05nU//x
   JIlA0MQGtoIoqK0pIZOxwtVGV59IrGaYcwPPzEDKddgAsk26Z9KEFF5vf
   bpAn7BWUaKA5fHDbj3A/zSnt3mSNSyT1hExwyPnvrscKFM1cYZD/pDvW7
   AUPZBgE48I3UkWxWID2Rl2t1XHbJVN+SSgARJMVREa6VAswKWC478aYD+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="244933222"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="244933222"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 09:20:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627578404"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 09:20:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A244AB7; Mon, 24 Jan 2022 19:20:35 +0200 (EET)
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
Subject: [PATCH v3 2/6] iio: adc: rn5t618: Re-use generic struct u16_fract
Date:   Mon, 24 Jan 2022 19:20:28 +0200
Message-Id: <20220124172032.87893-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124172032.87893-1-andriy.shevchenko@linux.intel.com>
References: <20220124172032.87893-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of custom data type re-use generic struct u16_fract.
No changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: no changes
 drivers/iio/adc/rn5t618-adc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/adc/rn5t618-adc.c b/drivers/iio/adc/rn5t618-adc.c
index 7d891b4ea461..6bf32907f01d 100644
--- a/drivers/iio/adc/rn5t618-adc.c
+++ b/drivers/iio/adc/rn5t618-adc.c
@@ -42,11 +42,6 @@ struct rn5t618_adc_data {
 	int irq;
 };
 
-struct rn5t618_channel_ratios {
-	u16 numerator;
-	u16 denominator;
-};
-
 enum rn5t618_channels {
 	LIMMON = 0,
 	VBAT,
@@ -58,7 +53,7 @@ enum rn5t618_channels {
 	AIN0
 };
 
-static const struct rn5t618_channel_ratios rn5t618_ratios[8] = {
+static const struct u16_fract rn5t618_ratios[8] = {
 	[LIMMON] = {50, 32}, /* measured across 20mOhm, amplified by 32 */
 	[VBAT] = {2, 1},
 	[VADP] = {3, 1},
-- 
2.34.1

