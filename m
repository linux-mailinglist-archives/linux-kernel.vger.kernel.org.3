Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5334D1B5F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347774AbiCHPMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiCHPME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:12:04 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A876133E86
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646752265; x=1678288265;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=LgS2wVuLMcDEbEbGcny/0cnFoCudtTMp1htRDUXNiro=;
  b=MmHRhLvC6MgD9AiNpnuslYa0iCi3Y4eEoso9rvqd16Ist9onp6iFkqO4
   zrKaKWel0KyksxhaDbH0qS3W6aFZL9SlX36YsXGXKTPNhjGBeg4mVEeJJ
   pk1YWt434XJFigQGKVjozGVdybFQpweH4/HMyVZN80wmnokshDD84XyHR
   7SIGGo3AHJ8cWnp32V6SvfPzCO5RCJnFTJqvm4ZE/zZFWVlCrLtCp4YEy
   R7BQ/rg6L01jzh4BVtlMdm11fwEEsGWFwPszanJnqSXPCGdD9apbXOnYs
   6IHIY+HXomjNk/ot0Gqex7kjeE6SHcii5ps0LzYk1pUehUTDCeZmOQ4Vc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="234658745"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="234658745"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 07:11:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="513136913"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 08 Mar 2022 07:11:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 88CEB93; Tue,  8 Mar 2022 17:11:22 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] auxdisplay: lcd2s: use module_i2c_driver to simplify the code
Date:   Tue,  8 Mar 2022 17:11:17 +0200
Message-Id: <20220308151119.48412-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220308151119.48412-1-andriy.shevchenko@linux.intel.com>
References: <20220308151119.48412-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the module_i2c_driver() macro to make the code smaller
and a bit simpler.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/lcd2s.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/auxdisplay/lcd2s.c b/drivers/auxdisplay/lcd2s.c
index c75e9d66aaa1..5201a621de45 100644
--- a/drivers/auxdisplay/lcd2s.c
+++ b/drivers/auxdisplay/lcd2s.c
@@ -372,24 +372,7 @@ static struct i2c_driver lcd2s_i2c_driver = {
 	.remove = lcd2s_i2c_remove,
 	.id_table = lcd2s_i2c_id,
 };
-
-static int __init lcd2s_modinit(void)
-{
-	int ret = 0;
-
-	ret = i2c_add_driver(&lcd2s_i2c_driver);
-	if (ret != 0)
-		pr_err("Failed to register lcd2s driver\n");
-
-	return ret;
-}
-module_init(lcd2s_modinit)
-
-static void __exit lcd2s_exit(void)
-{
-	i2c_del_driver(&lcd2s_i2c_driver);
-}
-module_exit(lcd2s_exit)
+module_i2c_driver(lcd2s_i2c_driver);
 
 MODULE_DESCRIPTION("LCD2S character display driver");
 MODULE_AUTHOR("Lars Poeschel");
-- 
2.34.1

