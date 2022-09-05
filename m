Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC3D5AD974
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 21:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiIETOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 15:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiIETOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 15:14:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F44A3A49D;
        Mon,  5 Sep 2022 12:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662405240; x=1693941240;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ATRm0xw22WfFaEoiYkPnoJTK/cXHL3nSucFclcwn+Ac=;
  b=CSC0FCm+urDcbMYJ4F40eunBVlhC5vTOR42saIaMBG58JjrE9rBhzgc8
   CR33Yx4oz3z1aYvenwFtTvgJ2hgFj1A/KOxsYqrhMbgipMtSbbj+9VX+B
   DezSUOYhCaYXj2UWKyQfZvt1b6eRhDOy6t/Yjl6r0J1XeP+LCkdUbzi8d
   6sJ3/93sHSRrjbae4+Kcx55XplD6ED4293PIJuXqLq1uv1NptsSpcxjfy
   kZCe4MyWs2S4AlvKwFDz7rjPUlERyDF2Rzr5YXKI4a9rIy7rQr6r9tuCP
   LellkDqTxk4NEBKuFjqPF++fDr5e36oPv9c3xW71XVPYNu1oA+y6eDHfw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="295180851"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="295180851"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 12:13:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="609738990"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 05 Sep 2022 12:13:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 92687101; Mon,  5 Sep 2022 22:14:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pinctrl: wpcm450: Correct the fwnode_irq_get() return value check
Date:   Mon,  5 Sep 2022 22:14:08 +0300
Message-Id: <20220905191408.73794-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

fwnode_irq_get() may return all possible signed values, such as Linux
error code. Fix the code to handle this properly.

Fixes: a1d1e0e3d80a ("pinctrl: nuvoton: Add driver for WPCM450")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
index 0dbeb91f0bf2..8193b92da403 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
@@ -1081,10 +1081,13 @@ static int wpcm450_gpio_register(struct platform_device *pdev,
 
 		girq->num_parents = 0;
 		for (i = 0; i < WPCM450_NUM_GPIO_IRQS; i++) {
-			int irq = fwnode_irq_get(child, i);
+			int irq;
 
+			irq = fwnode_irq_get(child, i);
 			if (irq < 0)
 				break;
+			if (!irq)
+				continue;
 
 			girq->parents[i] = irq;
 			girq->num_parents++;
-- 
2.35.1

