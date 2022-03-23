Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477A14E53DD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244521AbiCWODt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbiCWODr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:03:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CA77EA34;
        Wed, 23 Mar 2022 07:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648044137; x=1679580137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ze1002XyM8dK8szVuNAh2rfCJViHlNl/Z7OGWqP1oJY=;
  b=h5z9RzxI3Km0N2aCDCmjHtg4y9up0F1LNkTha0B+ZYDluX51tSOCBDny
   aOJfmpqkTNKsfQWlF+NYKSKFQI1AY25NcyiaDVeot/z61LyR+R02jxSN4
   2baIXyYHoZhxvxBMXIV7fkv9nrpvR07Uz4QCvtoltYAzHoijrGDRqFUM3
   B5PqlZuUFK90pGvB+cISMg+GxJMmZfV1SIAKJkUJwTKjmwZFSFcZi24td
   97deriLRJr3JoF2FnNaH7ddOYqdyvBpArqPez5C9T45V6eqNjMAWcZLvc
   WNdi9TovqkwdEG+8zKyhMO3TXXfis+kLao2an1uPvrVK2vhpD/+j+zEk8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="258304807"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="258304807"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 07:01:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="785796350"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 23 Mar 2022 07:01:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E5E5518E; Wed, 23 Mar 2022 16:02:17 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/4] spidev: Convert BUILD_BUG_ON() to static_assert()
Date:   Wed, 23 Mar 2022 16:02:13 +0200
Message-Id: <20220323140215.2568-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
References: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

static_assert() is a preferred method to fail build when the certain
constraints are not met. Convert BUILD_BUG_ON() to static_assert().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spidev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index daeaa4a30290..125da8d0e719 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -46,6 +46,7 @@
 
 static DECLARE_BITMAP(minors, N_SPI_MINORS);
 
+static_assert(N_SPI_MINORS > 0 && N_SPI_MINORS <= 256);
 
 /* Bit masks for spi_device.mode management.  Note that incorrect
  * settings for some settings can cause *lots* of trouble for other
@@ -856,7 +857,6 @@ static int __init spidev_init(void)
 	 * that will key udev/mdev to add/remove /dev nodes.  Last, register
 	 * the driver which manages those device numbers.
 	 */
-	BUILD_BUG_ON(N_SPI_MINORS > 256);
 	status = register_chrdev(SPIDEV_MAJOR, "spi", &spidev_fops);
 	if (status < 0)
 		return status;
-- 
2.35.1

