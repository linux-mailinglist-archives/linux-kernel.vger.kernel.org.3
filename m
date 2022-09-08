Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCB15B1FD5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiIHN5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiIHN4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:56:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68749FD20C;
        Thu,  8 Sep 2022 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662645411; x=1694181411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8zfu+zvno5BcAKYp0i5ifmD3cU2wynvKRO8gGgRKGw8=;
  b=NoRIrVD59Nd1xwXx1VXkgkKzRdnBM/lXmMxrMLHPOUhZbCoGfl+OmCmT
   2BiPh1YFwcaDsgE1Tqc73f5YSmVX+xbeCnFQ50byl6yDIZiVJAnEMdKGo
   KQR1Dx7fFkZMBgPZGaOsn40VtHy2em2GfSnbJJnhqCJJ4Swd9l8IVFgFY
   ybGP2vcpJ1Lvo5yWlli6cPdK9sOWIkl8SSshZkRUapN4gd3F61EtuqnrC
   N5hVsDCOjW2RWZbjpg3aa7Lzpttpg7pjs9n6W+nuEeGdBFDfy5Aafm143
   bfpHt3CtEllDqWe0KUJ+biNjsMGcy0SUXeIbXIyhyMvt5hvZysI14R4hR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="361137305"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="361137305"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:56:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="648049645"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 08 Sep 2022 06:56:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A505D57F; Thu,  8 Sep 2022 16:57:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 7/9] pwm: lpss: Make use of bits.h macros for all masks
Date:   Thu,  8 Sep 2022 16:56:56 +0300
Message-Id: <20220908135658.64463-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the GENMASK() (far less error-prone, far more concise).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index a20915459809..accdef5dd58e 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -10,6 +10,7 @@
  * Author: Alan Cox <alan@linux.intel.com>
  */
 
+#include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -26,7 +27,7 @@
 #define PWM_ENABLE			BIT(31)
 #define PWM_SW_UPDATE			BIT(30)
 #define PWM_BASE_UNIT_SHIFT		8
-#define PWM_ON_TIME_DIV_MASK		0x000000ff
+#define PWM_ON_TIME_DIV_MASK		GENMASK(7, 0)
 
 /* Size of each PWM register space if multiple */
 #define PWM_SIZE			0x400
-- 
2.35.1

