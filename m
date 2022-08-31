Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256D85A80AB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiHaOyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiHaOx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:53:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFDDCAC78
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661957638; x=1693493638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wQjO2Qr9DHvGPdGhD873KnHloO/hAygxHjzc3ypaSxQ=;
  b=kMXf3QllTg+76WAIBzaVxrIf4TJKFrp0oxhGEv7zyAEFfwGd9vruTXxq
   HNov69A4O6ehmmLmqlpqPybc2wRyvBF5ETCAVmAGgvmvcAqCk9tx1on9Z
   daZ4W/ciDpljy0I7K+XISPRQeL5IdGA5H3bQyhN6vtf00Ub7dewJ8k4E7
   QcgsUB6yHq3uBRf1AAI1u8KtesWSYwXJqCGzGecTBBNbGTsbNDnRKos/l
   W8wcv917iA47hCMXuCzW3ACzZ434hkho+A8xus+O5SCYq0qwW1inWOlpx
   j/lzwDFm4NxfZ4QJGakYxmqR9eX/YS7SmC3Lxk++hRq6WI35gmh9Of+zg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="275865921"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="275865921"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:53:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="940456856"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 31 Aug 2022 07:53:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E07C019D; Wed, 31 Aug 2022 17:54:10 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 3/3] regmap: spi-avmm: Use swabXX_array() helpers
Date:   Wed, 31 Aug 2022 17:54:07 +0300
Message-Id: <20220831145407.78166-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220831145407.78166-1-andriy.shevchenko@linux.intel.com>
References: <20220831145407.78166-1-andriy.shevchenko@linux.intel.com>
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
 drivers/base/regmap/regmap-spi-avmm.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/base/regmap/regmap-spi-avmm.c b/drivers/base/regmap/regmap-spi-avmm.c
index ad1da83e849f..1cf133c49bd4 100644
--- a/drivers/base/regmap/regmap-spi-avmm.c
+++ b/drivers/base/regmap/regmap-spi-avmm.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
+#include <linux/swab.h>
 
 /*
  * This driver implements the regmap operations for a generic SPI
@@ -167,14 +168,7 @@ struct spi_avmm_bridge {
 
 static void br_swap_words_32(char *buf, unsigned int len)
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

