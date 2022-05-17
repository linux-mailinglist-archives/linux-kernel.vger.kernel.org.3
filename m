Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5DB52A841
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349568AbiEQQig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351035AbiEQQi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:38:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1710633E86;
        Tue, 17 May 2022 09:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652805507; x=1684341507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T7Duo2KDAAYE18QSBhb5vxqT20qzgjq8uzh+AeSioMY=;
  b=C8wMroHU/SfyTs06kBG+JOonmnuOiyXsp5EJ5jEHBgRxBsBYz0dCEBLJ
   l5XGtfdE0SN/KvJtRXThU2zJtuFZq0e5MeSxHz5LwyvYVJ2Tw17vULhZz
   60BIQ7pPaCwIfzqQLfaatmWulHfO20AsYIXLKYq5u4wSAc0RVMDfASYNz
   KSV0f4bMR5ZChtFEmqr+qDscEXyzbRSSMuapEEIN72w5xjJH8JmMTLGKj
   RKqmO5Y/whzsq0MDpWoPqChgX1mqsOnJ2HqIhbUYLT5Zmma+ll72MnTYf
   BL3aJTS/frMQMr5xpj32P1TRlxNlggcxZmby41VrbLYX4cyB1e1eFewmg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="268827681"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="268827681"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 09:38:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="597225299"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 17 May 2022 09:38:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BF64B159; Tue, 17 May 2022 19:38:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 2/2] pinctrl: intel: Drop unsued irqchip member in struct intel_pinctrl
Date:   Tue, 17 May 2022 19:38:20 +0300
Message-Id: <20220517163820.86768-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517163820.86768-1-andriy.shevchenko@linux.intel.com>
References: <20220517163820.86768-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no users of irqchip member in struct intel_pinctrl. Drop it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/pinctrl/intel/pinctrl-intel.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index c4fef03b663f..710341bb67cc 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -223,7 +223,6 @@ struct intel_pinctrl_context {
  * @pctldesc: Pin controller description
  * @pctldev: Pointer to the pin controller device
  * @chip: GPIO chip in this pin controller
- * @irqchip: IRQ chip in this pin controller
  * @soc: SoC/PCH specific pin configuration data
  * @communities: All communities in this pin controller
  * @ncommunities: Number of communities in this pin controller
@@ -236,7 +235,6 @@ struct intel_pinctrl {
 	struct pinctrl_desc pctldesc;
 	struct pinctrl_dev *pctldev;
 	struct gpio_chip chip;
-	struct irq_chip irqchip;
 	const struct intel_pinctrl_soc_data *soc;
 	struct intel_community *communities;
 	size_t ncommunities;
-- 
2.35.1

