Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7531E49CB6D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241673AbiAZNxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:53:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:45919 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240280AbiAZNxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643205224; x=1674741224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qJouR+ZViRGmunL8zNrrQRLVPQFGfDt48qPG03ibSbo=;
  b=muIBuIsNrRAxi+lJ66bFEHHMK1aM+qs6tZNZrNE7hTVBWAXMr63mdt1E
   QVwmvThWDDR5OsA63i6LQHhW7/m5TNQKZGjJlcWYjPFYN1kx06AFCt8NS
   HEHQl8zPFjAoqtdgIERP0Eys0k8fG7KyrLj27CU64Rod+kuLpPTe0QkWB
   51qOiqJ0jzT+ug+szarYgrhG1xcIi3Po+b4a/2i9Slrxu271iMl3uMqeX
   Uhv53LcQ5JN44i2oBaxiAsMCM+s4A8nX3zh+c7Xa81jLLuEU4fVhQMVtd
   CVLV9+Q/osEqCVb42L9TxIhT/Kz9N7Oes7lCMp+C9vysWK/3FC5x5eoSl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246330076"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="246330076"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:53:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="624838921"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jan 2022 05:53:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B3D5B15C; Wed, 26 Jan 2022 15:53:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v4 2/4] iio: adc: rn5t618: Re-use generic struct u16_fract
Date:   Wed, 26 Jan 2022 15:53:51 +0200
Message-Id: <20220126135353.24007-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126135353.24007-1-andriy.shevchenko@linux.intel.com>
References: <20220126135353.24007-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of custom data type re-use generic struct u16_fract.
No changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v4: no changes
v3: no changes
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

