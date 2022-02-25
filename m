Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25CF4C4C04
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243612AbiBYRYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242096AbiBYRYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:24:39 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BDC199D5C;
        Fri, 25 Feb 2022 09:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645809846; x=1677345846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9LLMwd1jVSyGmHE1y7UKIpXT8gXtNszNsq3PrfwGTQs=;
  b=Ask8sbcZDuYWi8mVupXDEwTGWi3tS5xiy2p57XsgTfrVJMFXJ0+PvmMV
   BDtbBeMifis8bzd8olYyl6+dGDegmn5wD5wIlY0EQD3iNJAdO6NqoklZR
   3098tYx06tJVWVfItxbrbvHBEDy19l1VGbjnX40++bhVD5P9AHQUao/L6
   /SvHjNzRTuaMLjLFT4EdZsojwSyCeygc38z3vR5Z5sO2J4jQ7PYF8PMfD
   pRJ84AEGdIDHI5V9cYwMcy8tzp1mVuQ3GIJ/igZK5gZLXqdz/+1pJt+O4
   6ksvxiEk9ty3i/zMqEq4awo4KBWcZhh9xvQBH9rSZMb/ph45SO8O/epds
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="313259062"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="313259062"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 09:24:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="574661102"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2022 09:24:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4D0CD12C; Fri, 25 Feb 2022 19:24:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 03/11] spi: pxa2xx-pci: Drop redundant NULL check in ->probe()
Date:   Fri, 25 Feb 2022 19:23:42 +0200
Message-Id: <20220225172350.69797-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225172350.69797-1-andriy.shevchenko@linux.intel.com>
References: <20220225172350.69797-1-andriy.shevchenko@linux.intel.com>
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

Since all platforms are using ->setup() function, drop unneeded check.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 4d617ad72bca..90b95e49a164 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -255,11 +255,9 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 		return ret;
 
 	c = &spi_info_configs[ent->driver_data];
-	if (c->setup) {
-		ret = c->setup(dev, c);
-		if (ret)
-			return ret;
-	}
+	ret = c->setup(dev, c);
+	if (ret)
+		return ret;
 
 	memset(&spi_pdata, 0, sizeof(spi_pdata));
 	spi_pdata.num_chipselect = c->num_chipselect;
-- 
2.34.1

