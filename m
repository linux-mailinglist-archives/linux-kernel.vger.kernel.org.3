Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B01F5AD962
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 21:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiIETIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 15:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiIETIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 15:08:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6F73B958;
        Mon,  5 Sep 2022 12:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662404921; x=1693940921;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WwmzwywTSAN6ZMOyQiemN7PKzXK7Aa4TUDjqPx95sFw=;
  b=nGJ9gClCXbeTe0sGgjEqSJXXYetCVPrfmTS3Hgl50ZC41uh0ZpTrA6qb
   lOXuIc6BKAYtNn99/AeByusCPDreQXJ77MHuL2jx8IGEsyeiePd2KPdEE
   O1Eu4WF6r1n05M1qV1qBi9AkAbO6thxf0vWvhlk+HXKfcRszMrOT0ptjN
   /rL3FLoFH6zV+1+7/IVWt2Jv3xGSyqBPE1+tU0Ns6mS129H1ApzeZ8g82
   dR4grUhBAa0TowoZ+01Uhxy/J8h4HigM9K7tbqgBkyEEaMF+DhsuN/kdo
   vQSg/6QKb69HouXoXfDgvSBRTNAF/gd60G0Sb6IoE67bpqcRwbxm1o2cb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="294028715"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="294028715"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 12:08:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="609738324"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 05 Sep 2022 12:08:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F1BE6101; Mon,  5 Sep 2022 22:08:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Michael Walle <michael@walle.cc>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pinctr: microchip-sgpio: Correct the fwnode_irq_get() return value check
Date:   Mon,  5 Sep 2022 22:08:49 +0300
Message-Id: <20220905190849.73194-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fwnode_irq_get() may return all possible signed values, such as Linux
error code. Fix the code to handle this properly.

Fixes: be2dc859abd4 ("pinctrl: pinctrl-microchip-sgpio: Add irq support (for sparx5)")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-microchip-sgpio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
index 6f55bf7d5e05..0771b743a940 100644
--- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
+++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
@@ -864,9 +864,10 @@ static int microchip_sgpio_register_bank(struct device *dev,
 	gc->can_sleep		= !bank->is_input;
 
 	if (bank->is_input && priv->properties->flags & SGPIO_FLAGS_HAS_IRQ) {
-		int irq = fwnode_irq_get(fwnode, 0);
+		int irq;
 
-		if (irq) {
+		irq = fwnode_irq_get(fwnode, 0);
+		if (irq > 0) {
 			struct gpio_irq_chip *girq = &gc->irq;
 
 			gpio_irq_chip_set_chip(girq, &microchip_sgpio_irqchip);
-- 
2.35.1

