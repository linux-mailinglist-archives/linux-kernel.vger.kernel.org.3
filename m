Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125135517A7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbiFTLoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240786AbiFTLoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:44:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26417267D;
        Mon, 20 Jun 2022 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655725483; x=1687261483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VjOG4QNEdzqs+142WUjAwVeE5Y9mA990EmwcytHHZdM=;
  b=en+8WrWLoWt4rYkHq9BrPx5OVQJNx8BWbfCbAa3gLaN1MYTFB32Mh/WS
   H3ctFHS0HTP5CpYfZF27+mj12Zl/RE8ChAgxLIAFppexa3gcbok7cB9mz
   RXfbdBHOacRZ/CJFlPtfhSdDSq06O6wOQ42C2nGguarHXsTX/SFGGYS6L
   mp0mh6NLos1uXL4/cXV3VltgLhaiwoFH3BlAnoieEuxfceO/OnCcPfiWi
   ScNRhT/TVVKM52VvvFcE+iJgli+Hl8XJ9RA4gNYE/rtOfDmxqBFbd+VN4
   BhBMMftLJANLNRjVxvAPssh+kwJaiucUzO6gndCSiZH6OtmOma82a1Tmf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280930274"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280930274"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 04:44:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="561913478"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 20 Jun 2022 04:44:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C814AD9; Mon, 20 Jun 2022 14:44:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 2/7] pinctrl: baytrail: Switch to to embedded struct pingroup
Date:   Mon, 20 Jun 2022 14:44:34 +0300
Message-Id: <20220620114439.31491-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620114439.31491-1-andriy.shevchenko@linux.intel.com>
References: <20220620114439.31491-1-andriy.shevchenko@linux.intel.com>
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

Since struct intel_pingroup got a new member, switch the driver to use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 31f8f271628c..67db79f38051 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -603,7 +603,7 @@ static const char *byt_get_group_name(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *vg = pinctrl_dev_get_drvdata(pctldev);
 
-	return vg->soc->groups[selector].name;
+	return vg->soc->groups[selector].grp.name;
 }
 
 static int byt_get_group_pins(struct pinctrl_dev *pctldev,
@@ -613,8 +613,8 @@ static int byt_get_group_pins(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *vg = pinctrl_dev_get_drvdata(pctldev);
 
-	*pins		= vg->soc->groups[selector].pins;
-	*num_pins	= vg->soc->groups[selector].npins;
+	*pins		= vg->soc->groups[selector].grp.pins;
+	*num_pins	= vg->soc->groups[selector].grp.npins;
 
 	return 0;
 }
@@ -662,15 +662,15 @@ static void byt_set_group_simple_mux(struct intel_pinctrl *vg,
 
 	raw_spin_lock_irqsave(&byt_lock, flags);
 
-	for (i = 0; i < group.npins; i++) {
+	for (i = 0; i < group.grp.npins; i++) {
 		void __iomem *padcfg0;
 		u32 value;
 
-		padcfg0 = byt_gpio_reg(vg, group.pins[i], BYT_CONF0_REG);
+		padcfg0 = byt_gpio_reg(vg, group.grp.pins[i], BYT_CONF0_REG);
 		if (!padcfg0) {
 			dev_warn(vg->dev,
 				 "Group %s, pin %i not muxed (no padcfg0)\n",
-				 group.name, i);
+				 group.grp.name, i);
 			continue;
 		}
 
@@ -692,15 +692,15 @@ static void byt_set_group_mixed_mux(struct intel_pinctrl *vg,
 
 	raw_spin_lock_irqsave(&byt_lock, flags);
 
-	for (i = 0; i < group.npins; i++) {
+	for (i = 0; i < group.grp.npins; i++) {
 		void __iomem *padcfg0;
 		u32 value;
 
-		padcfg0 = byt_gpio_reg(vg, group.pins[i], BYT_CONF0_REG);
+		padcfg0 = byt_gpio_reg(vg, group.grp.pins[i], BYT_CONF0_REG);
 		if (!padcfg0) {
 			dev_warn(vg->dev,
 				 "Group %s, pin %i not muxed (no padcfg0)\n",
-				 group.name, i);
+				 group.grp.name, i);
 			continue;
 		}
 
-- 
2.35.1

