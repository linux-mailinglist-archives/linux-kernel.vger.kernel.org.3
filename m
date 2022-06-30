Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524CD56166C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiF3Jdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiF3Jdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:33:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AAB2BB35;
        Thu, 30 Jun 2022 02:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656581630; x=1688117630;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T1ylInVtE0EmcDSIAmU/Rw3OQAzUbZ0+fwUP1lx/0S4=;
  b=UzFKMIUOwCJcJ32QQ84+1hv9hU69kzXtoPA/pCWoLncKp6oKgYnP+FrZ
   okV73pp18cn2XnNmZ2d/rDAjqmvbTmSvBJZDzTGtFMRf5Y2bxcYmf6n++
   Q9jPHTFxY8Ms/HeODxGOa4lG0sdZ3/QIe2GKOx4BI1wH5uppk69ybjT5K
   B4+xakyxppQ815M+0bbeDtWpTX8TUhLFf6AxOHMPaIT9hCrNzq1WrakEl
   XRi3bMdwcp7yjSFiNpIL7Dc9Zs04nEUNtErdJ0n8bX8Id5xwI6vppj4ls
   wvJLh3EqC3wppGPAHcQIDaHn937eUaBw6zA0OkZM9NMch2sLXrF+jsAoX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="307806105"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="307806105"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 02:33:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="588696876"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 Jun 2022 02:33:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 203E611E; Thu, 30 Jun 2022 12:33:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 1/1] serial: 8250_dw: Drop PM ifdeffery
Date:   Thu, 30 Jun 2022 12:33:51 +0300
Message-Id: <20220630093351.27926-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop CONFIG_PM and CONFIG_PM_SLEEP ifdeffery while converting dw8250_pm_ops
to use new PM macros. Since we are using runtime PM, wrap dw8250_pm_ops into
pm_ptr().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: wrapped dw8250_pm_ops into pm_ptr() macro (Paul)
 drivers/tty/serial/8250/8250_dw.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 921ac5c8cb38..927a4a85367a 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -743,7 +743,6 @@ static int dw8250_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int dw8250_suspend(struct device *dev)
 {
 	struct dw8250_data *data = dev_get_drvdata(dev);
@@ -775,9 +774,7 @@ static int dw8250_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-#ifdef CONFIG_PM
 static int dw8250_runtime_suspend(struct device *dev)
 {
 	struct dw8250_data *data = dev_get_drvdata(dev);
@@ -808,11 +805,10 @@ static int dw8250_runtime_resume(struct device *dev)
 	/* TODO: Check if it needs more than it's done in serial8250_console_restore() */
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops dw8250_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(dw8250_suspend, dw8250_resume)
-	SET_RUNTIME_PM_OPS(dw8250_runtime_suspend, dw8250_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(dw8250_suspend, dw8250_resume)
+	RUNTIME_PM_OPS(dw8250_runtime_suspend, dw8250_runtime_resume, NULL)
 };
 
 static const struct dw8250_platform_data dw8250_dw_apb = {
@@ -870,7 +866,7 @@ MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
 static struct platform_driver dw8250_platform_driver = {
 	.driver = {
 		.name		= "dw-apb-uart",
-		.pm		= &dw8250_pm_ops,
+		.pm		= pm_ptr(&dw8250_pm_ops),
 		.of_match_table	= dw8250_of_match,
 		.acpi_match_table = dw8250_acpi_match,
 	},
-- 
2.35.1

