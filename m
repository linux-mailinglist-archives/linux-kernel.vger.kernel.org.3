Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992C655FF23
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbiF2L6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiF2L6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:58:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69561B781;
        Wed, 29 Jun 2022 04:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656503917; x=1688039917;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=it0o5X8wvmU06Ag0kXW6qQNUEgcDLGltmXFOUHtaqR8=;
  b=kv3wsnSDmor9IuTyQ0vPoLPtDqc1Ydetp8XdVPuP9+tD1WCS/ct5Opxy
   B9T04y5x+ISLq//KQD++AkIsIXnr/shj6PkpmwwMRZ0jaduCYwgEoa8fu
   BjnRDtA4RTEb+uZOjcTqaLjsP1tbIC02sWaRT1T2bIsB1ORUOw0DK4sD9
   9YJCKU0RfqbkC3eoiEeoQDSkqktMv70UVCG4wlaWFM8lbcnithMRvFi/y
   29B1BZm0xn2gDJ3YYCmSpzcWt+QxhYwL5vqAjpcJDWL4XIJUZUTSei5XL
   nO5v9LC94x70Y+mW0LGEAcjMRPsw5zxPyDBURNcD/1XEJvHpzIig4E2A5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="343700045"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="343700045"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 04:58:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="693550391"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jun 2022 04:58:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 24F76109; Wed, 29 Jun 2022 14:58:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pinctrl: core: Use device_match_of_node() helper
Date:   Wed, 29 Jun 2022 14:58:40 +0300
Message-Id: <20220629115840.16241-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open coding, use device_match_of_node() helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index ffe39336fcac..9e57f4c62e60 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -126,7 +126,7 @@ struct pinctrl_dev *get_pinctrl_dev_from_of_node(struct device_node *np)
 	mutex_lock(&pinctrldev_list_mutex);
 
 	list_for_each_entry(pctldev, &pinctrldev_list, node)
-		if (pctldev->dev->of_node == np) {
+		if (device_match_of_node(pctldev->dev, np)) {
 			mutex_unlock(&pinctrldev_list_mutex);
 			return pctldev;
 		}
-- 
2.35.1

