Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4175A6C50
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiH3SgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiH3Sf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:35:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873136EF09;
        Tue, 30 Aug 2022 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661884558; x=1693420558;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/pwVlxD0Nr2IM8YJuZISeUWEWBiGFVzCOOFkYtzCtIE=;
  b=MsuRF7vU1rYgCFSDm3d9eEm+DsCbPZDfKBGS1hdUHdRawm0E7Eec79gf
   w5kau9hvShBmip1e9ITwlV7Mhb6vQvSG/GNTT8HyWoEm19b8+sjnZtVhF
   C2kNkYMvtjwd7pHo0vQr/KWmF15R8733fkkgHH+z6QA7SysXLCalXRzsp
   fq/i8PP2BsETph1mLqySVed2SON8h690liKXtgNrAlUtjnyFF/762CgK9
   lPgHu2TWkHR6W/uS3G/A9Td24Gnp+QUD2Mag8pCkxie1SkpwuMyDlayzR
   SEjs2AI4A72iAdIu1OS/p+haYzMrCb+zEH0Mmy9ZJif2890Prg2JEiAsJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="275019773"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="275019773"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 11:35:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="562765580"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2022 11:35:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BEDDA174; Tue, 30 Aug 2022 21:35:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v1 1/1] Input: matrix_keypad - replace of_gpio_named_count() by gpiod_count()
Date:   Tue, 30 Aug 2022 21:35:52 +0300
Message-Id: <20220830183552.50695-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparation to unexport of_gpio_named_count(), convert the
driver to use gpiod_count() instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/keyboard/matrix_keypad.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 30924b57058f..63f078f2bc4a 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -416,9 +416,9 @@ matrix_keypad_parse_dt(struct device *dev)
 		return ERR_PTR(-ENOMEM);
 	}
 
-	pdata->num_row_gpios = nrow = of_gpio_named_count(np, "row-gpios");
-	pdata->num_col_gpios = ncol = of_gpio_named_count(np, "col-gpios");
-	if (nrow <= 0 || ncol <= 0) {
+	pdata->num_row_gpios = nrow = gpiod_count(dev, "row");
+	pdata->num_col_gpios = ncol = gpiod_count(dev, "col");
+	if (nrow < 0 || ncol < 0) {
 		dev_err(dev, "number of keypad rows/columns not specified\n");
 		return ERR_PTR(-EINVAL);
 	}
-- 
2.35.1

