Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BDD5A8813
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiHaV1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbiHaV1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:27:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88F2F4935
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661981253; x=1693517253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m3s12TGYjWSlxsDVLCLH+j+oxn8X4YKyWRyMNxD+r3o=;
  b=A9iMkozpiN5nnyu1OA0nWjsKjYEPqipYD6nYvk/RPTBDjUQJR3kiYKnK
   1Kf3DcB9O79Nx2u0xfVqpJAD6P0CFLC8iNJL/63aIT0QBwDrEmXYRQHqa
   GPpqw6uFEPqGi0IwInta47MaKmiveJW1nPcxv+89hT53Ll6qytx49zDPM
   TuuYn217yIAmm02zEHJ9ePvEIwJ1HlBjGQ1zp/u4gCqgofH1/iCdcL5dF
   cJUxViTLujVhPXvFd/sNu+IrW+drGAGAa5DpPi7B4ihImboHBRM3sLUwT
   FpxApndEsyzsGu0c1stwR2XsZUP6C2p1T+Vi4hvxgmNyocBtPBD9+i4ld
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296828925"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="296828925"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 14:27:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="612236180"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 31 Aug 2022 14:27:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8C5E519D; Thu,  1 Sep 2022 00:27:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 3/3] regmap: spi-avmm: Use swabXX_array() helpers
Date:   Thu,  1 Sep 2022 00:27:44 +0300
Message-Id: <20220831212744.56435-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220831212744.56435-1-andriy.shevchenko@linux.intel.com>
References: <20220831212744.56435-1-andriy.shevchenko@linux.intel.com>
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

Since we have a few helpers to swab elements of a given size in an array
use them instead of open coded variants.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed compilation error (LKP)
 drivers/base/regmap/regmap-spi-avmm.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/base/regmap/regmap-spi-avmm.c b/drivers/base/regmap/regmap-spi-avmm.c
index ad1da83e849f..4c2b94b3e30b 100644
--- a/drivers/base/regmap/regmap-spi-avmm.c
+++ b/drivers/base/regmap/regmap-spi-avmm.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
+#include <linux/swab.h>
 
 /*
  * This driver implements the regmap operations for a generic SPI
@@ -162,19 +163,12 @@ struct spi_avmm_bridge {
 	/* bridge buffer used in translation between protocol layers */
 	char trans_buf[TRANS_BUF_SIZE];
 	char phy_buf[PHY_BUF_SIZE];
-	void (*swap_words)(char *buf, unsigned int len);
+	void (*swap_words)(void *buf, unsigned int len);
 };
 
-static void br_swap_words_32(char *buf, unsigned int len)
+static void br_swap_words_32(void *buf, unsigned int len)
 {
-	u32 *p = (u32 *)buf;
-	unsigned int count;
-
-	count = len / 4;
-	while (count--) {
-		*p = swab32p(p);
-		p++;
-	}
+	swab32_array(buf, len / 4);
 }
 
 /*
-- 
2.35.1

