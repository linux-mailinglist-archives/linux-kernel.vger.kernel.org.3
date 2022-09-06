Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C105AF53A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiIFUCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiIFUCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:02:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC0BBD74F;
        Tue,  6 Sep 2022 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662494264; x=1694030264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LgTwBaOWh+n+fF41sI+6TN1M3VgiaUgKOiXQk5Dfchw=;
  b=fsLGt+PloY0DkBfgPDKYQc384RnkLY9YrYT8yof2EJeyKhKzHlb3o7P0
   Du7oPMs8CS1v89g3/o3GmF+UdPASn3nEtiMmR8bqabJ2fiMGVex3YYmxu
   kxPbkDJpiKTWXBM38JU/biSBQFkAz/s9hhpu8dqDZBpywKiPxLmRjOQbe
   Vm5KqmjlhOU3c1Mu41rZdJmY7opLnWqRD+caOmrTMz7bZnnnlih9/ldmg
   c8HbI3NMkBCgGm3zwxli7mMyoRLMETjhj2V26w+50ozZrInY91yRk03aM
   /jRhcR5y6EWeC6dmJsfGk8EBb6vVmrTbsdLvWOASBe5O8OWngR4Y0F8tc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="382988348"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="382988348"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="682525516"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 06 Sep 2022 12:57:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 36AED50D; Tue,  6 Sep 2022 22:57:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v1 7/9] pwm: lpss: Make use of bits.h macros for all masks
Date:   Tue,  6 Sep 2022 22:57:33 +0300
Message-Id: <20220906195735.87361-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
References: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
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
index 44f9bb80611d..276b7a3a34ff 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -10,6 +10,7 @@
  * Author: Alan Cox <alan@linux.intel.com>
  */
 
+#include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -24,7 +25,7 @@
 #define PWM_ENABLE			BIT(31)
 #define PWM_SW_UPDATE			BIT(30)
 #define PWM_BASE_UNIT_SHIFT		8
-#define PWM_ON_TIME_DIV_MASK		0x000000ff
+#define PWM_ON_TIME_DIV_MASK		GENMASK(7, 0)
 
 /* Size of each PWM register space if multiple */
 #define PWM_SIZE			0x400
-- 
2.35.1

