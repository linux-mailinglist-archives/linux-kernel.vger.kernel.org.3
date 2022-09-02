Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536F85AB861
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiIBSgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiIBSg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:36:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99176105B74;
        Fri,  2 Sep 2022 11:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662143779; x=1693679779;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=CEs9JIj75JOFSDMR+9UBVZY6R0aGuxZKEnPwlAb3kDc=;
  b=an/qbitKhKzowjm14DugILxzLkXXUxpMKkjVkTs+x6pC+dtBKhhgibKJ
   eGdj55oEx1iik06QIxd0r3a9UBuZTHVPiImUh/n+d9EjDAYBZF72ir7UB
   6ovupHalURZk/uL9Gs7PCJFPZgWOtbD9udV1M4L9RXZehkopGyvROcWlq
   toJ7TA0OXO1eZsgBAW3+2E4/g4DWzUn3538WKut/LWgJ2SS9x5WUpqUKa
   FgqIObXo0afAPxjJmbFpYrPSXwkIqdd/KVHjrqD4+sEORWXbrRCSI30g5
   OldTTnwOY/rJNu2ybvgbIrCk2jxuspCB8i5dp+TUZHNIpahBAMjIiCnJw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="382351242"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="382351242"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 11:26:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="674457533"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Sep 2022 11:26:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4957A702; Fri,  2 Sep 2022 21:27:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 12/17] pinctrl: cy8c95x0: Implement ->pin_dbg_show()
Date:   Fri,  2 Sep 2022 21:26:45 +0300
Message-Id: <20220902182650.83098-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
References: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
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

The introduced callback ->pin_dbg_show() is useful for debugging.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 40 ++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 6fe442b44cab..ea81b5ae27a6 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -1010,25 +1010,49 @@ static int cy8c95x0_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static const char *cy8c95x0_get_fname(unsigned int selector)
+{
+	if (selector == 0)
+		return "gpio";
+	else
+		return "pwm";
+}
+
+static void cy8c95x0_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
+				  unsigned int pin)
+{
+	struct cy8c95x0_pinctrl *chip = pinctrl_dev_get_drvdata(pctldev);
+	DECLARE_BITMAP(mask, MAX_LINE);
+	DECLARE_BITMAP(pwm, MAX_LINE);
+
+	bitmap_zero(mask, MAX_LINE);
+	__set_bit(pin, mask);
+
+	if (cy8c95x0_read_regs_mask(chip, CY8C95X0_PWMSEL, pwm, mask)) {
+		seq_puts(s, "not available");
+		return;
+	}
+
+	seq_printf(s, "MODE:%s", cy8c95x0_get_fname(test_bit(pin, pwm)));
+}
+
 static const struct pinctrl_ops cy8c95x0_pinctrl_ops = {
 	.get_groups_count = cy8c95x0_pinctrl_get_groups_count,
 	.get_group_name = cy8c95x0_pinctrl_get_group_name,
 	.get_group_pins = cy8c95x0_pinctrl_get_group_pins,
 	.dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
 	.dt_free_map = pinconf_generic_dt_free_map,
+	.pin_dbg_show = cy8c95x0_pin_dbg_show,
 };
 
-static int cy8c95x0_get_functions_count(struct pinctrl_dev *pctldev)
+static const char *cy8c95x0_get_functions_name(struct pinctrl_dev *pctldev, unsigned int selector)
 {
-	return 2;
+	return cy8c95x0_get_fname(selector);
 }
 
-static const char *cy8c95x0_get_fname(struct pinctrl_dev *pctldev, unsigned int selector)
+static int cy8c95x0_get_functions_count(struct pinctrl_dev *pctldev)
 {
-	if (selector == 0)
-		return "gpio";
-	else
-		return "pwm";
+	return 2;
 }
 
 static int cy8c95x0_get_groups(struct pinctrl_dev *pctldev, unsigned int selector,
@@ -1077,7 +1101,7 @@ static int cy8c95x0_set_mux(struct pinctrl_dev *pctldev, unsigned int selector,
 
 static const struct pinmux_ops cy8c95x0_pmxops = {
 	.get_functions_count = cy8c95x0_get_functions_count,
-	.get_function_name = cy8c95x0_get_fname,
+	.get_function_name = cy8c95x0_get_functions_name,
 	.get_function_groups = cy8c95x0_get_groups,
 	.set_mux = cy8c95x0_set_mux,
 	.strict = true,
-- 
2.35.1

