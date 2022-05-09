Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19141520232
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbiEIQXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238951AbiEIQXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:23:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4C020D264;
        Mon,  9 May 2022 09:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652113154; x=1683649154;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jmk+PtjQ8yGVKSJMYJgoYsjlnVaz/MyJP7drHN3Mnts=;
  b=ON8RnFE6nefusZwwFyG6XgNuvoeNNat2+BXm1bcjjW/DKiU4v4Wx4fUJ
   uDMjv51kTdVJw31ITmGvaALg+iXzbDsZKTikR+BdBrBOPhEdhePXQ2xiA
   dndjALOKo0HWXj6r02BChBDTm1JSgn3jPZWfqcGOIpq0F/2OprJM0A5/4
   Sb+TIDEuqH5Iag0vRj6Cu7yBWNL35YiMGOXkmPzfVcq53Y9PwxYNAZstk
   XNPxrmGJG5lVJVmox2Wk/NCFv5Y9Kx+EftoN62pAd6Zanbl0judxxgQr9
   gsinmukd4NpsHqS+5tuwFJwgM6+ZqQN8Woojo7XsgYugMY0CEi9PgM4hn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="248999141"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="248999141"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 09:19:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="894423716"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 09 May 2022 09:19:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 948F0D1; Mon,  9 May 2022 19:19:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_dw: Update the list of OF headers used by driver
Date:   Mon,  9 May 2022 19:19:11 +0300
Message-Id: <20220509161911.37164-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_irq.h and of_platform.h are not used by the driver. On the
other hand, the mod_devicetable.h missed. Drop the former two and
add the latter one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 31422e44c64f..7934e4658281 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -12,12 +12,11 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/workqueue.h>
-- 
2.35.1

