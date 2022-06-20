Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A67C5517B3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbiFTLpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241993AbiFTLoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:44:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B59267D;
        Mon, 20 Jun 2022 04:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655725485; x=1687261485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DzFeSHJN21o/a0uqe1taS1DmcnD0Iz7eQe8z3Y7MRb4=;
  b=T3B0IBNcMEloXH6quvZr3Miek/5Tql9VLCz2wNDA5AlfKMwrhk3toP2p
   XR7gpb+BpnRkYU4BIxJuwdKSj2AKAG9y3sAzjDxxlhbXFyYoGuawairgr
   iuIW+bpCclY7W5+0s1nntqFZFk79nhwa46W5lLqGU+fRxqesfVVk9pIRz
   NvPbH7nRaBM5nvZfHChfDThtI6luS0YQVpM8g9/181a31o0ZQG6sb/HjF
   MxpiKgAtcFaY6g4i/3VasHmYwGH6asGb3p79UJphjyeyhhFRSKvvMHbxt
   N5lTw3tCo090QFOgEMqlP50ziWpCOwcVQAEzqa22GLuS8zBP42zCZE6cY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="277422414"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="277422414"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 04:44:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="714591464"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 20 Jun 2022 04:44:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E8F3158F; Mon, 20 Jun 2022 14:44:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 6/7] pinctrl: intel: Switch to to embedded struct pingroup
Date:   Mon, 20 Jun 2022 14:44:38 +0300
Message-Id: <20220620114439.31491-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620114439.31491-1-andriy.shevchenko@linux.intel.com>
References: <20220620114439.31491-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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
 drivers/pinctrl/intel/pinctrl-intel.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index ffc045f7bf00..0e704f34156a 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -279,7 +279,7 @@ static const char *intel_get_group_name(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
-	return pctrl->soc->groups[group].name;
+	return pctrl->soc->groups[group].grp.name;
 }
 
 static int intel_get_group_pins(struct pinctrl_dev *pctldev, unsigned int group,
@@ -287,8 +287,8 @@ static int intel_get_group_pins(struct pinctrl_dev *pctldev, unsigned int group,
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
-	*pins = pctrl->soc->groups[group].pins;
-	*npins = pctrl->soc->groups[group].npins;
+	*pins = pctrl->soc->groups[group].grp.pins;
+	*npins = pctrl->soc->groups[group].grp.npins;
 	return 0;
 }
 
@@ -391,19 +391,19 @@ static int intel_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	 * All pins in the groups needs to be accessible and writable
 	 * before we can enable the mux for this group.
 	 */
-	for (i = 0; i < grp->npins; i++) {
-		if (!intel_pad_usable(pctrl, grp->pins[i])) {
+	for (i = 0; i < grp->grp.npins; i++) {
+		if (!intel_pad_usable(pctrl, grp->grp.pins[i])) {
 			raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 			return -EBUSY;
 		}
 	}
 
 	/* Now enable the mux setting for each pin in the group */
-	for (i = 0; i < grp->npins; i++) {
+	for (i = 0; i < grp->grp.npins; i++) {
 		void __iomem *padcfg0;
 		u32 value;
 
-		padcfg0 = intel_get_padcfg(pctrl, grp->pins[i], PADCFG0);
+		padcfg0 = intel_get_padcfg(pctrl, grp->grp.pins[i], PADCFG0);
 		value = readl(padcfg0);
 
 		value &= ~PADCFG0_PMODE_MASK;
-- 
2.35.1

