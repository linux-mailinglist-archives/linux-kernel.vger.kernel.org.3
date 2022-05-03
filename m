Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FD551881A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbiECPT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238090AbiECPS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:18:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6675D1FCEA;
        Tue,  3 May 2022 08:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651590926; x=1683126926;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SAvtnj8H2V8n6qwqUBlvJTEgN+vKWN6fJ/OR2VQoynY=;
  b=QREXGvjHfPMvML/M5vaSawgOjLL9/hJ655OYL9eU9gBqR+SDu62Cytiv
   /fz9lzzCO0ivciMiTnyOpQTTVU2ZOKE68z4tuXGIBbVtST9HHZGUbewHc
   49BJK5f9ZlJOss6O9KsRsBeKnv7I+z54hUJ7btIsru3JXzadbTfU0IYED
   LilBhcvNkISRUMCpxZKtVV/M3O33zrD0vEiXH06Kkp6iqxIpfyH/yba26
   E9PRe3rHRJdgzwlNZsj+OFoIZ2zJk1fcEjGMIhfGNFiC9HvEsPA8rKif+
   q2r86FwUX33vk1SogE8vmCMrKdlo0fzP3/5FqxhkZk0nfHhTLFHP870K+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="328042678"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="328042678"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 08:15:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="567677331"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 03 May 2022 08:15:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DDB46179; Tue,  3 May 2022 18:15:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Michael Walle <michael@walle.cc>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pinctrl: microchip-sgpio: Switch to use fwnode instead of of_node
Date:   Tue,  3 May 2022 18:15:17 +0300
Message-Id: <20220503151517.59115-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library now accepts fwnode as a firmware node, so
switch the driver to use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-microchip-sgpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
index 80a8939ad0c0..71367ed04082 100644
--- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
+++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
@@ -840,7 +840,7 @@ static int microchip_sgpio_register_bank(struct device *dev,
 	gc			= &bank->gpio;
 	gc->label		= pctl_desc->name;
 	gc->parent		= dev;
-	gc->of_node		= to_of_node(fwnode);
+	gc->fwnode		= fwnode;
 	gc->owner		= THIS_MODULE;
 	gc->get_direction	= microchip_sgpio_get_direction;
 	gc->direction_input	= microchip_sgpio_direction_input;
-- 
2.35.1

