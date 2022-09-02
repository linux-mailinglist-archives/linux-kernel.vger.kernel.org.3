Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068B75AB83D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiIBSbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiIBSa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:30:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B7C70E4F;
        Fri,  2 Sep 2022 11:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662143456; x=1693679456;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=DniUnueTY3Xs7L6hV7C4s2m6UQ2FC9TCsvhg8kdaFrQ=;
  b=IgT1fpbSUT4sSxNNv0R2P3dtJwlkyMMc33x2DcAwPHH1c9GLytkdgdJM
   0o7XTKrqocaC1cW09CfroksE1d5lD9qRHlootSpxSnUxMnn3wK8srjTk8
   x51Z/KOIg175JcIpNoED5RUFm3oHpdF4IKucM/Y7vW++XkCIwgLA8HYMm
   ILAmzUQ+Ebr1io+KOEvzDkwaLdetYKSt6HemVGqRfS/N64uujlKnkshcE
   w8j5LCzYTG8UOLQbLkd10i3NeZ9PnsGLBE6sS6a+rUCbwp3KN2BdrnNHJ
   ZGlp0TpfzA863+91Ki5rTiQiYpn6GoI94JkMPVGySy07p2EZY/J19eCdU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="294790980"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="294790980"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 11:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="613125405"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 02 Sep 2022 11:26:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 043FC1C3; Fri,  2 Sep 2022 21:26:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 04/17] pinctrl: cy8c95x0: Fix return value in cy8c95x0_detect()
Date:   Fri,  2 Sep 2022 21:26:37 +0300
Message-Id: <20220902182650.83098-4-andriy.shevchenko@linux.intel.com>
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

It's an obvious typo in never tested piece of code that
successful detection shouldn't fail. Fix that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-cy8c95x0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
index 5ef772d29a36..f016c283af57 100644
--- a/drivers/pinctrl/pinctrl-cy8c95x0.c
+++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
@@ -1255,7 +1255,7 @@ static int cy8c95x0_detect(struct i2c_client *client,
 	dev_info(&client->dev, "Found a %s chip at 0x%02x.\n", name, client->addr);
 	strscpy(info->type, name, I2C_NAME_SIZE);
 
-	return -ENODEV;
+	return 0;
 }
 
 static int cy8c95x0_probe(struct i2c_client *client)
-- 
2.35.1

