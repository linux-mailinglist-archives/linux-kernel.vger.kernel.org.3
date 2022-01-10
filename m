Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040A048A02E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243896AbiAJTbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:31:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:64406 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243524AbiAJTbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641843062; x=1673379062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IEVag8NNshRnKOir0g6sRMeP3zm3yNszHfDbOqk5TRc=;
  b=eJkqwUVlKDdizoRomwT3l562edW0nP5XHIfN1zxuYwHnPqoYPTcOlL6k
   tqx0qcaM6IID1++kRAMhXt/OBe8gaQ/v43SvL6MNGnfxUbJB0fKEUlY15
   JfADzsnfbxfE9dn8kZrGHySvcTzeeI24hhdi6ANaOD6Ma32XYXVOpDBgE
   vDOCGuNR2Xb4oVQAKVNupWGFyBEQPbwOrS9iDpJkXXBKz5b8CqQ3p7bL+
   4YUVyJbjY+j1LCFMM0z/wyrr6xKnegF7bAks6EFb4Bb5wQn5/PY8eBf6K
   vHZK9WdpcOBg2VHvbEcPbaLn0Vkis/d3KXCdz2rYPsANsvosMax9hgAGS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="243504192"
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="243504192"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 11:31:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,277,1635231600"; 
   d="scan'208";a="558090102"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 Jan 2022 11:30:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2631AD2; Mon, 10 Jan 2022 21:31:09 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 2/5] iio: adc: rn5t618: Re-use generic struct u16_fract
Date:   Mon, 10 Jan 2022 21:31:01 +0200
Message-Id: <20220110193104.75225-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220110193104.75225-1-andriy.shevchenko@linux.intel.com>
References: <20220110193104.75225-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of custom data type re-use generic struct u16_fract.
No changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: no changes

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

