Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F125AB84F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiIBSel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiIBSeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:34:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B237110D96;
        Fri,  2 Sep 2022 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662143207; x=1693679207;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=MQdtzzlnd/8Z1I5x7bO0gzZYHKdwVRA8kRquAQW3UtM=;
  b=BSfLl4RcyGTr0kkX4BRp+oRcjl2v/n3Q2AFMFfgJTSmj6GzFgwJrofpU
   nbEdDEiDU7p6vd/VDKxT3ojXdev9w7F274hU+k82Hk5QP05YMfokFd8Oc
   X+JAj3RrowSjwIv6CLyD78ca1Y04ZCQq4dyLz7wMn+NEBGOzvgLpeM0Hv
   pRc9F/BerFYkT3X/G8j7VrSsSdfNtvI60DtMvVxKOjGB0CFRSYXgkuggQ
   m8FpnfeI7IrgN4/feTo+WjCSZqG4E5hECx50HLmivB4AmYO+IvEKJrvEH
   6zKPn9UnzEHuQWQGpdQ26gFQDTk3gDftyCSP2NelW7jjAnpgjow2f4SgA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="296832714"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="296832714"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 11:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="615791648"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 02 Sep 2022 11:26:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E9A65101; Fri,  2 Sep 2022 21:26:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 03/17] pinctrl: cy8c95x0: Allow most of the registers to be cached
Date:   Fri,  2 Sep 2022 21:26:36 +0300
Message-Id: <20220902182650.83098-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
References: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
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

It's unclear why many of static registers were marked as volatile.
They are pretty much bidirectional and static in a sense that
written value is kept there until a new write or chip reset.
Drop those registers from the list to allow them to be cached.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 521acfdeef38..5ef772d29a36 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -303,17 +303,6 @@ static bool cy8c95x0_volatile_register(struct device *dev, unsigned int reg)
 	switch (reg) {
 	case CY8C95X0_INPUT_(0) ... CY8C95X0_INPUT_(7):
 	case CY8C95X0_INTSTATUS_(0) ... CY8C95X0_INTSTATUS_(7):
-	case CY8C95X0_INTMASK:
-	case CY8C95X0_INVERT:
-	case CY8C95X0_PWMSEL:
-	case CY8C95X0_DIRECTION:
-	case CY8C95X0_DRV_PU:
-	case CY8C95X0_DRV_PD:
-	case CY8C95X0_DRV_ODH:
-	case CY8C95X0_DRV_ODL:
-	case CY8C95X0_DRV_PP_FAST:
-	case CY8C95X0_DRV_PP_SLOW:
-	case CY8C95X0_DRV_HIZ:
 		return true;
 	}
 
-- 
2.35.1

