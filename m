Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19BA55EED5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiF1UIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbiF1UII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:08:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DF0427CD;
        Tue, 28 Jun 2022 12:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656446379; x=1687982379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MWOE/QpEiWYaLBtx6/XzU26LpmFkbAIZHsQaXwOr60Q=;
  b=lsQiFrsV8TFUtY9cDXDJiaAxv+HV9/2rSWua1NYnZ2+g+jSVf/TttgG+
   OzQK6tnPwx8kR4QHCGLPdr48mBvMSohbMJhETXYJmKaOGWoU+fooIu7ES
   0lArxp2Jgq1+moy2HOU4YIbsAuykJ1EEH47KQDxj8qHusKYSYEPWTG65f
   x8/FMai9RciCgzho+oOnvn63ux5E9x3taXBi+Wpyj88o2cUTDhrVjS2So
   FtUVVni9QQaWSzjUlHTV3DKJo41vbxhxL+iPoRM6+9rHOZWh7Vecm2EhK
   0RnlJLv3vl8U+mCTpl4jlhDtjGixLzhapCVAJx5LmBey5otsFO35DpUhe
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="261637371"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="261637371"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 12:59:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="658259992"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jun 2022 12:59:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9C124CE; Tue, 28 Jun 2022 22:59:16 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/2] gpio: adnp: use simple i2c probe function
Date:   Tue, 28 Jun 2022 22:59:12 +0300
Message-Id: <20220628195913.36940-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c probe functions here don't use the id information provided in
their second argument, so the single-parameter i2c probe function
("probe_new") can be used instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-adnp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-adnp.c b/drivers/gpio/gpio-adnp.c
index cc349d4e4973..075782831044 100644
--- a/drivers/gpio/gpio-adnp.c
+++ b/drivers/gpio/gpio-adnp.c
@@ -485,8 +485,7 @@ static int adnp_gpio_setup(struct adnp *adnp, unsigned int num_gpios,
 	return 0;
 }
 
-static int adnp_i2c_probe(struct i2c_client *client,
-				    const struct i2c_device_id *id)
+static int adnp_i2c_probe(struct i2c_client *client)
 {
 	struct device_node *np = client->dev.of_node;
 	struct adnp *adnp;
@@ -535,7 +534,7 @@ static struct i2c_driver adnp_i2c_driver = {
 		.name = "gpio-adnp",
 		.of_match_table = adnp_of_match,
 	},
-	.probe = adnp_i2c_probe,
+	.probe_new = adnp_i2c_probe,
 	.id_table = adnp_i2c_id,
 };
 module_i2c_driver(adnp_i2c_driver);
-- 
2.35.1

