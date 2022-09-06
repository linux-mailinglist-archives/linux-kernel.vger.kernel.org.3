Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9BC5AE6E3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiIFLuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiIFLuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:50:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4CC248DD;
        Tue,  6 Sep 2022 04:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662465016; x=1694001016;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kFyXJulK0j1hcoGy8usN4XdbvXPR01T+6NsIRoXpSkA=;
  b=cwi65sTDpYvXHnrNHPhtztU5DhWjAOm31epP+EMDUea7x3NFHXehS20g
   2HZWTnY4kEgeT2Dyd4VPoNvQquBE1ePeWXISeFuA4svGMYrPibDVayiQl
   U7nX5+PXZLPbOm8N4phPgJy0Fu80UtsZimOqTjK/Jmu3ttkzzoKaZNSHL
   PYBQMPOMqpb8pZJGKgKfjsSJR7mRkOvU4CNplsZS/hO+AJ+px96L0RvIo
   9drJx6kGLFx7BYI+3Chdcnh8/vtj35iPADjk5OtUkk1wP0Klq1+vlYpcN
   vng4oZ6/l3PUFjvHvsc0ecJBnx5z4BAG4v718aMr11iZDC16Art8aZl+T
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="296573082"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="296573082"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 04:50:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="756341259"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2022 04:50:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BF303101; Tue,  6 Sep 2022 14:50:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Michael Walle <michael@walle.cc>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] pinctrl: microchip-sgpio: Correct the fwnode_irq_get() return value check
Date:   Tue,  6 Sep 2022 14:50:21 +0300
Message-Id: <20220906115021.8661-1-andriy.shevchenko@linux.intel.com>
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
Reviewed-by: Michael Walle <michael@walle.cc>
---
v2: added tag (Michael), fixed typo in the Subject
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

