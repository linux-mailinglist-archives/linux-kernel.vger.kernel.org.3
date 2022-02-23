Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0019D4C17A0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbiBWPr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242408AbiBWPrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:47:37 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88499522F1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645631229; x=1677167229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pl1D/bHNyCfDdw8mak/gKlyNsOm/trpVn5ERWYOWuA4=;
  b=Ipl9FA422NN8cGtlrBBPWxWVnzqxUiuXd6a5MgevckSoAik7rzRYuX6j
   lkqoH1OxmyGSoFbLgFtaEPt/xXrOFf6ta3yu5C1uDikIUBGMJuvrv8rbx
   Km9pRVDzOwSkF/VKRhmtzZfchPrdMQ84e2WD5tjsRFpwTK3vvm9Webkqt
   adkt4lDoka6zZUsJWXblC9d/qUQslb9dMHjjd1Kig1CJeYkCMAeNtEVke
   rpWOWYQu7a3qXZbDnc86ujqLiLh2+z2M18l02mmw7CqATV/ZHie0f+eGi
   DTO6phsnELA6jv7qjYd5Y1ycZEN/DaJ8E4egWXJ7kRQSYiTG0gaGANQ8C
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="250819713"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="250819713"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 07:47:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="491238834"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 23 Feb 2022 07:47:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 115F43BC; Wed, 23 Feb 2022 17:47:24 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH v1 3/3] auxdisplay: lcd2s: Use proper API to free the instance of charlcd object
Date:   Wed, 23 Feb 2022 17:47:18 +0200
Message-Id: <20220223154718.83500-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220223154718.83500-1-andriy.shevchenko@linux.intel.com>
References: <20220223154718.83500-1-andriy.shevchenko@linux.intel.com>
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

While it might work, the current approach is fragile in a few ways:
- whenever members in the structure are shuffled, the pointer will be wrong
- the resource freeing may include more than covered by kfree()

Fix this by using charlcd_free() call instead of kfree().

Fixes: 8c9108d014c5 ("auxdisplay: add a driver for lcd2s character display")
Cc: Lars Poeschel <poeschel@lemonage.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/lcd2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/lcd2s.c b/drivers/auxdisplay/lcd2s.c
index 7b9cfbbaf007..2578b2d45439 100644
--- a/drivers/auxdisplay/lcd2s.c
+++ b/drivers/auxdisplay/lcd2s.c
@@ -336,7 +336,7 @@ static int lcd2s_i2c_probe(struct i2c_client *i2c,
 	return 0;
 
 fail1:
-	kfree(lcd);
+	charlcd_free(lcd2s->charlcd);
 	return err;
 }
 
@@ -345,7 +345,7 @@ static int lcd2s_i2c_remove(struct i2c_client *i2c)
 	struct lcd2s_data *lcd2s = i2c_get_clientdata(i2c);
 
 	charlcd_unregister(lcd2s->charlcd);
-	kfree(lcd2s->charlcd);
+	charlcd_free(lcd2s->charlcd);
 	return 0;
 }
 
-- 
2.34.1

