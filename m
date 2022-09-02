Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95845AB862
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiIBSgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiIBSgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:36:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96599F54A5;
        Fri,  2 Sep 2022 11:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662143779; x=1693679779;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=n3flIGifqT0/3LYVkgKHJ/DinDGHYI69R63FhYW3Scc=;
  b=a999vR8qtA/IBWtlGN76jq56eAaiHvMP9quls+J+Kz0k+OjpOs7Gp/Dx
   sVJBtnc1vSZO/hCiGjofwVa4IoVweoRi06UhfY0f1WFM0KqsxfqxIlnJx
   NASwxMmpIE4v2lrbATHUrfCscVkkEISacj2q3bDqA4goJg4IXe7GfXWnw
   EhgxNAC00hEPzXeavzdqP7SHhzraPhZszQUHl5lcPsL18pVSPL3vIjWoQ
   fVQ3L0i/11nQnvK29pOvrL433SiWxWJrd/rI14WjoMMI2dgmSVnn4iAoi
   4jax6Kcv9erWXiunKMDU3i7Tar8PKJ0Vs2tskqjxhr+G3XOqE75vatcJl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="382351249"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="382351249"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 11:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="615791668"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 02 Sep 2022 11:26:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 65319238; Fri,  2 Sep 2022 21:27:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 16/17] pinctrl: cy8c95x0: use bits.h macros for all masks
Date:   Fri,  2 Sep 2022 21:26:49 +0300
Message-Id: <20220902182650.83098-16-andriy.shevchenko@linux.intel.com>
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

Make use of the GENMASK() (far less error-prone, far more concise).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index f38e7dc794e9..57302cb0186f 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -363,14 +363,14 @@ static bool cy8c95x0_precious_register(struct device *dev, unsigned int reg)
 }
 
 static const struct reg_default cy8c95x0_reg_defaults[] = {
-	{ CY8C95X0_OUTPUT_(0), 0xff },
-	{ CY8C95X0_OUTPUT_(1), 0xff },
-	{ CY8C95X0_OUTPUT_(2), 0xff },
-	{ CY8C95X0_OUTPUT_(3), 0xff },
-	{ CY8C95X0_OUTPUT_(4), 0xff },
-	{ CY8C95X0_OUTPUT_(5), 0xff },
-	{ CY8C95X0_OUTPUT_(6), 0xff },
-	{ CY8C95X0_OUTPUT_(7), 0xff },
+	{ CY8C95X0_OUTPUT_(0), GENMASK(7, 0) },
+	{ CY8C95X0_OUTPUT_(1), GENMASK(7, 0) },
+	{ CY8C95X0_OUTPUT_(2), GENMASK(7, 0) },
+	{ CY8C95X0_OUTPUT_(3), GENMASK(7, 0) },
+	{ CY8C95X0_OUTPUT_(4), GENMASK(7, 0) },
+	{ CY8C95X0_OUTPUT_(5), GENMASK(7, 0) },
+	{ CY8C95X0_OUTPUT_(6), GENMASK(7, 0) },
+	{ CY8C95X0_OUTPUT_(7), GENMASK(7, 0) },
 	{ CY8C95X0_PORTSEL, 0 },
 	{ CY8C95X0_PWMSEL, 0 },
 };
@@ -1257,7 +1257,7 @@ static int cy8c95x0_detect(struct i2c_client *client,
 	ret = i2c_smbus_read_byte_data(client, CY8C95X0_DEVID);
 	if (ret < 0)
 		return ret;
-	switch (ret & 0xf0) {
+	switch (ret & GENMASK(7, 4)) {
 	case 0x20:
 		name = cy8c95x0_id[0].name;
 		break;
-- 
2.35.1

