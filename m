Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298675517AF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242081AbiFTLpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241948AbiFTLop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:44:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9B565EC;
        Mon, 20 Jun 2022 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655725483; x=1687261483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rteD4TE3BV4pxnQQ1GhigWDMkMMWcX4i7Vp5gxdWb6Y=;
  b=PuHMlDtDqSjclS7oAapfGIKdJ+DiO2AQcaAWp8xqMcmgNimUQKbFhl52
   60XQP3TfK6hgEpxhB1E0bNocVSlJovlz7peaQncXmvl3LT+PJLv0PcJz1
   fmkWoIIFGe8fySlAKU63GefUXREtTgJihqeqIlHTFPJXhD+UBcKbNzXjr
   TnbtmvCaSTY+vF7IYHlqd0nDBcJ0nDLTDWN0ueAx6PMVzs/t4Tm0cna63
   w4Qf9xaFFUzm1LDoMzvX/MIIoT73weK5X+iBzM60BC22x4ICg9CyKNyHR
   RU1d6BLs6aiQmqakL3qWnLwRTRp+2pUMZHISDkGtNi3izKfABpmv1xKbv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="277422407"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="277422407"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 04:44:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="643081684"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jun 2022 04:44:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CB013174; Mon, 20 Jun 2022 14:44:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 3/7] pinctrl: cherryview: Switch to to embedded struct pingroup
Date:   Mon, 20 Jun 2022 14:44:35 +0300
Message-Id: <20220620114439.31491-3-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/intel/pinctrl-cherryview.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 26b2a425d201..5c4fd16e5b01 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -627,7 +627,7 @@ static const char *chv_get_group_name(struct pinctrl_dev *pctldev,
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
-	return pctrl->soc->groups[group].name;
+	return pctrl->soc->groups[group].grp.name;
 }
 
 static int chv_get_group_pins(struct pinctrl_dev *pctldev, unsigned int group,
@@ -635,8 +635,8 @@ static int chv_get_group_pins(struct pinctrl_dev *pctldev, unsigned int group,
 {
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
-	*pins = pctrl->soc->groups[group].pins;
-	*npins = pctrl->soc->groups[group].npins;
+	*pins = pctrl->soc->groups[group].grp.pins;
+	*npins = pctrl->soc->groups[group].grp.npins;
 	return 0;
 }
 
@@ -721,16 +721,16 @@ static int chv_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	raw_spin_lock_irqsave(&chv_lock, flags);
 
 	/* Check first that the pad is not locked */
-	for (i = 0; i < grp->npins; i++) {
-		if (chv_pad_locked(pctrl, grp->pins[i])) {
+	for (i = 0; i < grp->grp.npins; i++) {
+		if (chv_pad_locked(pctrl, grp->grp.pins[i])) {
 			raw_spin_unlock_irqrestore(&chv_lock, flags);
-			dev_warn(dev, "unable to set mode for locked pin %u\n", grp->pins[i]);
+			dev_warn(dev, "unable to set mode for locked pin %u\n", grp->grp.pins[i]);
 			return -EBUSY;
 		}
 	}
 
-	for (i = 0; i < grp->npins; i++) {
-		int pin = grp->pins[i];
+	for (i = 0; i < grp->grp.npins; i++) {
+		int pin = grp->grp.pins[i];
 		unsigned int mode;
 		bool invert_oe;
 		u32 value;
-- 
2.35.1

