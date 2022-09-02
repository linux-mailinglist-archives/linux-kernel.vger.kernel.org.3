Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204BF5AB85A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiIBSgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiIBSgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:36:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DC386FF2;
        Fri,  2 Sep 2022 11:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662143770; x=1693679770;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=AEMYuFe/5gkoHwFFx3sE9BEZPNNMfh8MtP/d/z5X8tE=;
  b=aKX386kdrPxBdENRK48yHFTDr2thBmVvRMHq3pMoSKn80SprO3/07B9I
   nd9IfPL8kpTMoEzhDzi3rRAjQmXtc+W6oK0tj7k06XbpToPQ9xJeM7KBf
   M+OSF2xG0KC0MSMAImOTWOD9ZCoc6nk5sW3CQgSwPJfii3JaQoPIm4eBH
   zkeGRNFSA5z+EiprEyq9+Qgeln5x3jWOueuJ5Kqj+B6x1Ry37IeDN78aw
   4vM7BfqbFuwnwm3mQtLwdL3qL9yt9oPgutCVwBiv2igOHDm+E1rmBdA2Q
   aaA0xByNktbwkv+B9s2+at0VVjNYBuse9SWf5Fcd2PEx4gNO4R1WQ+JQX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="382351229"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="382351229"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 11:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="674457514"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Sep 2022 11:26:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0E05819D; Fri,  2 Sep 2022 21:27:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/17] pinctrl: cy8c95x0: Fix pin control name to enable more than one
Date:   Fri,  2 Sep 2022 21:26:38 +0300
Message-Id: <20220902182650.83098-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
References: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The Cypress GPIO expander is an I²C discrete component. Hence
the platform may contain more than one of a such. Currently
this has limitations in the driver due to same name used for
all chips of a type. Replace this with device instance specific
name.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index f016c283af57..a05fbf818bf2 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -1188,8 +1188,7 @@ static int cy8c95x0_setup_pinctrl(struct cy8c95x0_pinctrl *chip)
 	pd->confops = &cy8c95x0_pinconf_ops;
 	pd->pmxops = &cy8c95x0_pmxops;
 	pd->npins = chip->gpio_chip.ngpio;
-	pd->name = devm_kasprintf(chip->dev, GFP_KERNEL, "pinctrl-%s",
-				  chip->name);
+	pd->name = dev_name(chip->dev);
 	pd->pins = cy8c9560_pins;
 	pd->npins = chip->tpin;
 	pd->owner = THIS_MODULE;
-- 
2.35.1

