Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66114D1B63
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347802AbiCHPMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347769AbiCHPMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:12:05 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183E13E5FF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646752269; x=1678288269;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=47b7LI/ch1oK3/X8Hz9eMlj+fgbvsXZxfFjuCheoWD8=;
  b=NAyiLzKiNDGtnauIP5vbq2ylfdT2cg9UWB+EGLQInNyfw0sSbvwrOX5c
   FY3TH4jRJYJNykQNG75TmOeBR/uv0KnLMAdB1nBqDOYlzHiATLE8/K/zL
   dIup2HJHhDHyx0pPd6OzfhELx0FLGWG5aTCJ2+bkz3Qj33xB22v95LgDH
   mZAHwQ8yUecXHLyZLdFTGzHbAh5b0mDskgHRU/AKoVflgv0HirzPdizaF
   ExstCrA/wtdhNcq4pwxBiA3JP7BQ5PLRi4eSQI3JYM+r/T+6ystSH4gSM
   us0bW27wbm7Plh19uJk4nalx5o4QlBfbjXZbLCwSJ5OiNg0YNLpR3SKgO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="341135449"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="341135449"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 07:11:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="643682376"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2022 07:11:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7DB4D2AF; Tue,  8 Mar 2022 17:11:22 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] auxdisplay: lcd2s: make use of device property API
Date:   Tue,  8 Mar 2022 17:11:16 +0200
Message-Id: <20220308151119.48412-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of device property API in this driver so that both OF based
system and ACPI based system can use this driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/lcd2s.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/auxdisplay/lcd2s.c b/drivers/auxdisplay/lcd2s.c
index 2578b2d45439..c75e9d66aaa1 100644
--- a/drivers/auxdisplay/lcd2s.c
+++ b/drivers/auxdisplay/lcd2s.c
@@ -12,7 +12,9 @@
  *  All rights reserved.
  */
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
@@ -355,20 +357,16 @@ static const struct i2c_device_id lcd2s_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, lcd2s_i2c_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id lcd2s_of_table[] = {
 	{ .compatible = "modtronix,lcd2s" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, lcd2s_of_table);
-#endif
 
 static struct i2c_driver lcd2s_i2c_driver = {
 	.driver = {
 		.name = "lcd2s",
-#ifdef CONFIG_OF
-		.of_match_table = of_match_ptr(lcd2s_of_table),
-#endif
+		.of_match_table = lcd2s_of_table,
 	},
 	.probe = lcd2s_i2c_probe,
 	.remove = lcd2s_i2c_remove,
-- 
2.34.1

