Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EEA5812CB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239100AbiGZMGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239045AbiGZMF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:05:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7072B19D;
        Tue, 26 Jul 2022 05:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658837157; x=1690373157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/pMpcO4DRoaktxrLUp1GwMzfi5O0xvdqzoWKuaXXOB0=;
  b=DI+Q+3/+VmtzEnzEKjZCs5X4M91ZH26cM27g3mxVopmj73suNRWRxdLP
   A6SblMEiiREHXdQR55DLwmVVHGuvleHqw6ibkucKuw6efqLnfhsTEJ3NO
   xXL3Ck6tvhqW9+RBG+sgYJr7PmPMoCNa39dTZuTpit2AD4NaPpf8BKYtP
   qNbzzI/Ba/PAsDOOLDb4glM3IG5onrm2QRAtbPMfaRsSQV2d2W9NhpFmY
   fya1NuXJjz6049/btPYKEUuQV+o2F+E+z9QIn87Teu1iTBEBouiSoozRP
   dkLGRfwRM/2jaHNPJaFmrXUnHzYcelOmL0JED+unteLxRw4WNgfj1p78y
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="270971295"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="270971295"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 05:05:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="702871738"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2022 05:05:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8CD68347; Tue, 26 Jul 2022 15:06:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianshu Qiu <tian.shu.qiu@intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v1 8/8] media: ov2740: Use traditional pattern when checking error codes
Date:   Tue, 26 Jul 2022 15:05:56 +0300
Message-Id: <20220726120556.2881-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
References: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of 'if (!ret)' switch to "check for the error first" rule.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/i2c/ov2740.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ov2740.c b/drivers/media/i2c/ov2740.c
index c4c511f90257..afd591be6526 100644
--- a/drivers/media/i2c/ov2740.c
+++ b/drivers/media/i2c/ov2740.c
@@ -1112,7 +1112,6 @@ static int ov2740_register_nvmem(struct i2c_client *client,
 	struct nvmem_config nvmem_config = { };
 	struct regmap *regmap;
 	struct device *dev = &client->dev;
-	int ret;
 
 	nvm = devm_kzalloc(dev, sizeof(*nvm), GFP_KERNEL);
 	if (!nvm)
@@ -1142,12 +1141,11 @@ static int ov2740_register_nvmem(struct i2c_client *client,
 	nvmem_config.size = CUSTOMER_USE_OTP_SIZE;
 
 	nvm->nvmem = devm_nvmem_register(dev, &nvmem_config);
+	if (IS_ERR(nvm->nvmem))
+		return PTR_ERR(nvm->nvmem);
 
-	ret = PTR_ERR_OR_ZERO(nvm->nvmem);
-	if (!ret)
-		ov2740->nvm = nvm;
-
-	return ret;
+	ov2740->nvm = nvm;
+	return 0;
 }
 
 static int ov2740_probe(struct i2c_client *client)
-- 
2.35.1

