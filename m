Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7BB489F02
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbiAJSRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:17:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:52096 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238905AbiAJSRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641838626; x=1673374626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A/zBlgpho5sICynBSgHlKGJaa3VuSdECcydKaQ/t4dA=;
  b=HF7fmspbg4hSY5nbN6ETjXz26GwW7WsmOZglH45OxZy8ErMvvlM0R0uV
   V072EJbzhMXfsbBN1Q7rqezyoiSAKFq6hM33TA1acF9lOBcqdIAAHD3TE
   7Ju9ZlYL59jKX/uh3AfBxz0+jDpTMhTlyu4H+gfibtMqt6XPR1anKUVl9
   9haV4yHCmuUSLZnzGelIGg3NZQq04ndgIBu8/BBXeqlFD2A/kjO5k0dAl
   OnCjvbNnxLS9MWsm6Wn7Kdk8yZSyp0i+mMsoaEm+M0Ty8/R1YBblUL+3s
   1y+lAXu79952WBg0LyM71+ATc6HCPVklripET70MHkpdQTOimW2ndeKDY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10222"; a="243083582"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="243083582"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 10:17:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="669528410"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jan 2022 10:17:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D905ED2; Mon, 10 Jan 2022 20:17:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH v1 2/5] iio: adc: rn5t618: Re-use generic struct u16_fract
Date:   Mon, 10 Jan 2022 20:17:08 +0200
Message-Id: <20220110181711.65054-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110181711.65054-1-andriy.shevchenko@linux.intel.com>
References: <20220110181711.65054-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of custom data type re-use generic struct u16_fract.
No changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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

