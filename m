Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606B15AB85D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiIBSgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiIBSgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:36:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1626994EFB;
        Fri,  2 Sep 2022 11:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662143773; x=1693679773;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=PmaBa0A40FNoymQJbeinRG5loNg9jLUksJeBjTU6ICE=;
  b=DwJBkDmhburHkSmVs09CWg2AKL6Mn6wxs/6+iAjyd1ax0pm/EsaZ2jof
   miF8uN5l7q5kSWFMLXJKq8EHSSX1hzZ3QxlyPjRvlqoVsHG2TrHvUx6mn
   jghL2uKErrUqWxFkYK2ekM6nHlpg/OIKWZ80GzYA1D9aQycRlwQlgypRI
   bTmgH+ShwOh6FzNY7z08KsC2wR+j+S+lzoqzRHGgbGQRD9rwCBS6/bHJR
   zc0FY2C+8h6pCAmsnV5PfqRQ7ipt9FxX7bMTWpZ2WsF4qp8+RDBsBqgks
   GknVb2JaMNNt5tn9RybjAPVJQCIA0A4tJD7dJRclwMFBGSsBrDBg85jbn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="382351238"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="382351238"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 11:26:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="716614439"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 02 Sep 2022 11:26:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2C8AB607; Fri,  2 Sep 2022 21:27:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 09/17] pinctrl: cy8c95x0: Remove useless conditionals
Date:   Fri,  2 Sep 2022 21:26:42 +0300
Message-Id: <20220902182650.83098-9-andriy.shevchenko@linux.intel.com>
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

The pin control framework checks pin boundaries before calling
the respective driver's callbacks. Hence no need to check for
pin boundaries, the respective conditionals won't be ever true.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index b09f9485e57d..97da22016cce 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -1029,14 +1029,6 @@ static int cy8c95x0_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
 					   const unsigned int **pins,
 					   unsigned int *num_pins)
 {
-	struct cy8c95x0_pinctrl *chip = pinctrl_dev_get_drvdata(pctldev);
-
-	if (group >= chip->tpin) {
-		*pins = NULL;
-		*num_pins = 0;
-		return 0;
-	}
-
 	*pins = &cy8c9560_pins[group].number;
 	*num_pins = 1;
 	return 0;
@@ -1104,9 +1096,6 @@ static int cy8c95x0_set_mux(struct pinctrl_dev *pctldev, unsigned int selector,
 {
 	struct cy8c95x0_pinctrl *chip = pinctrl_dev_get_drvdata(pctldev);
 
-	if (group >= chip->tpin)
-		return -EINVAL;
-
 	return cy8c95x0_pinmux_cfg(chip, selector, group);
 }
 
@@ -1133,9 +1122,6 @@ static int cy8c95x0_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 	int ret = 0;
 	int i;
 
-	if (WARN_ON(pin >= chip->tpin))
-		return -EINVAL;
-
 	for (i = 0; i < num_configs; i++) {
 		ret = cy8c95x0_gpio_set_pincfg(chip, pin, configs[i]);
 		if (ret)
-- 
2.35.1

