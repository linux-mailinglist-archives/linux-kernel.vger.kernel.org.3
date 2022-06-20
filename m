Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBF15517A9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242003AbiFTLpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241753AbiFTLop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:44:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A301565FF;
        Mon, 20 Jun 2022 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655725483; x=1687261483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U2tG/KTz7ahZRzsolt4qelQbIWRvazZUailTCYJ+mns=;
  b=K7Dd3zhqtynJf+eDX6kud5C3NURsztDaoHsB25mFIQbz7EZAMD2XJW1k
   qcQ9DhBdMRhUAMEdkm0AaP51CSl/t7TopMu0yz7t/syQx+4V7k+rZ9yBJ
   81FkuRVVzHHIzJEpfxntpiC7epAPU1aEo/UH7n6iq5316dRo6LRopOEgl
   gIxXRTDqo3uoGN7pV9gGC8/YGQv5U+lAC5dkrYFI6hz9Z1cHaRRGphYYH
   8bHI7loY+IIS7ouvBsVOHitvRd8n4IUJRPYtPlAkCHsY1CMWYahEg8YC4
   NqaM03ylld41Xa6WANdaSKzBYvSt+WrqSG+qvcxB48vSzHxoMI2l+WZSP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280604249"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280604249"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 04:44:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="584862146"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 20 Jun 2022 04:44:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D7AE9363; Mon, 20 Jun 2022 14:44:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 4/7] pinctrl: lynxpoint: Switch to to embedded struct pingroup
Date:   Mon, 20 Jun 2022 14:44:36 +0300
Message-Id: <20220620114439.31491-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620114439.31491-1-andriy.shevchenko@linux.intel.com>
References: <20220620114439.31491-1-andriy.shevchenko@linux.intel.com>
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

Since struct intel_pingroup got a new member, switch the driver to use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-lynxpoint.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-lynxpoint.c b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
index 4fb39eb30902..5d1abee30f8f 100644
--- a/drivers/pinctrl/intel/pinctrl-lynxpoint.c
+++ b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
@@ -282,7 +282,7 @@ static const char *lp_get_group_name(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *lg = pinctrl_dev_get_drvdata(pctldev);
 
-	return lg->soc->groups[selector].name;
+	return lg->soc->groups[selector].grp.name;
 }
 
 static int lp_get_group_pins(struct pinctrl_dev *pctldev,
@@ -292,8 +292,8 @@ static int lp_get_group_pins(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *lg = pinctrl_dev_get_drvdata(pctldev);
 
-	*pins		= lg->soc->groups[selector].pins;
-	*num_pins	= lg->soc->groups[selector].npins;
+	*pins		= lg->soc->groups[selector].grp.pins;
+	*num_pins	= lg->soc->groups[selector].grp.npins;
 
 	return 0;
 }
@@ -366,8 +366,8 @@ static int lp_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	raw_spin_lock_irqsave(&lg->lock, flags);
 
 	/* Now enable the mux setting for each pin in the group */
-	for (i = 0; i < grp->npins; i++) {
-		void __iomem *reg = lp_gpio_reg(&lg->chip, grp->pins[i], LP_CONFIG1);
+	for (i = 0; i < grp->grp.npins; i++) {
+		void __iomem *reg = lp_gpio_reg(&lg->chip, grp->grp.pins[i], LP_CONFIG1);
 		u32 value;
 
 		value = ioread32(reg);
-- 
2.35.1

