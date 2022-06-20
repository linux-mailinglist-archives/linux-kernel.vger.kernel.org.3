Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77885517B4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242070AbiFTLpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241891AbiFTLop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:44:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA05A472;
        Mon, 20 Jun 2022 04:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655725484; x=1687261484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=75e3MeWkf9pZn4bmqOuCJjx/Rpz/6M0DP33k+LGsEJI=;
  b=bBLU3mS0wSavOaMjEXFW4Usi/g0iMEgpYQqYMANHBdGtMc+7Kfm7VMHY
   rpJX0mz4ukkOSWgVc88rPntknMz0A3tJMfEecPTGUYFIkhPhRqF8Zntqg
   +ZGK11cBrET3BO8nHnNz1NxWBFN1bPoIegpBpxDecQi8F/W/5eVf9mrNO
   1L6EbyPt9RWQNc//6RH/BO11Cl316e41pOQHtmnxKmHnjn0Txo0YNVaQm
   Jk4TelAx7vlxbSslzmeFa58EwXeNoEffBz2sSJHbsFn3g9A8qJ2MaCjVO
   dpWl7e/bn43LLChtTuVb84KN6C/lQfg/LEViduQ5tkC0LJvt50iGLEAve
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="262908822"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="262908822"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 04:44:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="764069136"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 20 Jun 2022 04:44:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E25D957F; Mon, 20 Jun 2022 14:44:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 5/7] pinctrl: merrifield: Switch to to embedded struct pingroup
Date:   Mon, 20 Jun 2022 14:44:37 +0300
Message-Id: <20220620114439.31491-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620114439.31491-1-andriy.shevchenko@linux.intel.com>
References: <20220620114439.31491-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since struct intel_pingroup got a new member, switch the driver to use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-merrifield.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-merrifield.c b/drivers/pinctrl/intel/pinctrl-merrifield.c
index 3ae141e0b421..5e752818adb4 100644
--- a/drivers/pinctrl/intel/pinctrl-merrifield.c
+++ b/drivers/pinctrl/intel/pinctrl-merrifield.c
@@ -520,7 +520,7 @@ static const char *mrfld_get_group_name(struct pinctrl_dev *pctldev,
 {
 	struct mrfld_pinctrl *mp = pinctrl_dev_get_drvdata(pctldev);
 
-	return mp->groups[group].name;
+	return mp->groups[group].grp.name;
 }
 
 static int mrfld_get_group_pins(struct pinctrl_dev *pctldev, unsigned int group,
@@ -528,8 +528,8 @@ static int mrfld_get_group_pins(struct pinctrl_dev *pctldev, unsigned int group,
 {
 	struct mrfld_pinctrl *mp = pinctrl_dev_get_drvdata(pctldev);
 
-	*pins = mp->groups[group].pins;
-	*npins = mp->groups[group].npins;
+	*pins = mp->groups[group].grp.pins;
+	*npins = mp->groups[group].grp.npins;
 	return 0;
 }
 
@@ -604,15 +604,15 @@ static int mrfld_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	 * All pins in the groups needs to be accessible and writable
 	 * before we can enable the mux for this group.
 	 */
-	for (i = 0; i < grp->npins; i++) {
-		if (!mrfld_buf_available(mp, grp->pins[i]))
+	for (i = 0; i < grp->grp.npins; i++) {
+		if (!mrfld_buf_available(mp, grp->grp.pins[i]))
 			return -EBUSY;
 	}
 
 	/* Now enable the mux setting for each pin in the group */
 	raw_spin_lock_irqsave(&mp->lock, flags);
-	for (i = 0; i < grp->npins; i++)
-		mrfld_update_bufcfg(mp, grp->pins[i], bits, mask);
+	for (i = 0; i < grp->grp.npins; i++)
+		mrfld_update_bufcfg(mp, grp->grp.pins[i], bits, mask);
 	raw_spin_unlock_irqrestore(&mp->lock, flags);
 
 	return 0;
-- 
2.35.1

