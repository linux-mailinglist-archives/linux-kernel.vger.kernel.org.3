Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F6F561739
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbiF3KFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbiF3KFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:05:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972CE44A3A;
        Thu, 30 Jun 2022 03:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656583524; x=1688119524;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kT/kZDfevuA69/cTLuoFJQXd96jvzmZdqgDk3HeCPbQ=;
  b=ZsWvBtQ/+RhX4+If9kd9GAZ+Rjsrpvm8vUbQykwHuy47Pds26vutuk74
   MRfwsvsWV9TK9t0qlbjgSwhzRQnZH2U6sR+unK3TkPZs8Kikjp2j0hixQ
   vEVnL0jvdRs0B8DkI8LUFaX7CFsHtQu8cHqrFFlfT9f1ZrPoeTSxMSIhF
   Vmtd3yha5Yu67kwDDHpb5aXvbvOgSLghzdyjMiXchyw4e0PkB/hyyFI0l
   MKkEzWLuzxmGK57YuiJ1zDrAcRTj2F+t9lXwvcE/qQMZeP7caK2HBDn14
   AIDQ4ngvNWeT7TLB8Cd5yPkoQk5wZL4Lp7W+62jfVLKD+4cfSAu/v3ugO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="271074412"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="271074412"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 03:05:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="680915678"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jun 2022 03:05:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CFE5011E; Thu, 30 Jun 2022 13:05:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v3 1/1] serial: 8250_dw: Drop PM ifdeffery
Date:   Thu, 30 Jun 2022 13:05:07 +0300
Message-Id: <20220630100507.31113-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v3: rebased on top of tty/tty-next (LKP)
 drivers/tty/serial/8250/8250_dw.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index b24c7b25ef7f..45bf032b9891 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -691,7 +691,6 @@ static int dw8250_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int dw8250_suspend(struct device *dev)
 {
 	struct dw8250_data *data = dev_get_drvdata(dev);
@@ -709,9 +708,7 @@ static int dw8250_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-#ifdef CONFIG_PM
 static int dw8250_runtime_suspend(struct device *dev)
 {
 	struct dw8250_data *data = dev_get_drvdata(dev);
@@ -733,11 +730,10 @@ static int dw8250_runtime_resume(struct device *dev)
 
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
@@ -795,7 +791,7 @@ MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
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

