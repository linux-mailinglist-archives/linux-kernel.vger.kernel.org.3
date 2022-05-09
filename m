Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601C5520382
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbiEIR0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239699AbiEIRZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:25:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A612550AE;
        Mon,  9 May 2022 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652116905; x=1683652905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OM3Varxhxi2BcziCEIc6O4+P8VaqtkEv57QNu+7YGgE=;
  b=XjH1oxELNbcnx1Wx9jlvxtaF4cN4LKtRwQvD+OcDTb62h7mwSgeFY3EI
   fBbRBKk2u4fJO2n8nv2gMQKtVw6FjnO7MmUOQguCGq0RMPkItAacR1rKx
   YFD5EoPEzjWfAyaCVh59keVHQM+Y1nANqp1fk/UAM311wJoikekxWvJrj
   1KpXqN8ex39d73mBJFGR//e1TjbubUDVoZnidkAMB6Hvkixv731OHUtDt
   mC1nuXaQRX45QSTYJnnYylGYNxP3it8oTOivPBoDYvp68QYpMptsPZ70g
   E7wzCJD6mdhY8ZxFPsNTZRmJJ2OsAN2RxuSm21ShttcR/M5wxxl+m9yu6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="294340475"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="294340475"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 10:21:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="738269217"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 09 May 2022 10:21:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 07FA2183; Mon,  9 May 2022 20:21:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v1 2/2] serial: 8250_dw: Use dev_err_probe()
Date:   Mon,  9 May 2022 20:21:29 +0300
Message-Id: <20220509172129.37770-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220509172129.37770-1-andriy.shevchenko@linux.intel.com>
References: <20220509172129.37770-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the error path in ->probe() a bit by using dev_err_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index e7ef61899576..f57bbd32ef11 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -497,18 +497,17 @@ static void dw8250_reset_control_assert(void *data)
 static int dw8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {}, *up = &uart;
-	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	struct uart_port *p = &up->port;
 	struct device *dev = &pdev->dev;
 	struct dw8250_data *data;
+	struct resource *regs;
 	int irq;
 	int err;
 	u32 val;
 
-	if (!regs) {
-		dev_err(dev, "no registers defined\n");
-		return -EINVAL;
-	}
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs)
+		return dev_err_probe(dev, -EINVAL, "no registers defined\n");
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -593,7 +592,7 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	err = clk_prepare_enable(data->clk);
 	if (err)
-		dev_warn(dev, "could not enable optional baudclk: %d\n", err);
+		return dev_err_probe(dev, err, "could not enable optional baudclk\n");
 
 	err = devm_add_action_or_reset(dev, dw8250_clk_disable_unprepare, data->clk);
 	if (err)
@@ -603,20 +602,16 @@ static int dw8250_probe(struct platform_device *pdev)
 		p->uartclk = clk_get_rate(data->clk);
 
 	/* If no clock rate is defined, fail. */
-	if (!p->uartclk) {
-		dev_err(dev, "clock rate not defined\n");
-		return -EINVAL;
-	}
+	if (!p->uartclk)
+		return dev_err_probe(dev, -EINVAL, "clock rate not defined\n");
 
 	data->pclk = devm_clk_get_optional(dev, "apb_pclk");
 	if (IS_ERR(data->pclk))
 		return PTR_ERR(data->pclk);
 
 	err = clk_prepare_enable(data->pclk);
-	if (err) {
-		dev_err(dev, "could not enable apb_pclk\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "could not enable apb_pclk\n");
 
 	err = devm_add_action_or_reset(dev, dw8250_clk_disable_unprepare, data->pclk);
 	if (err)
@@ -660,9 +655,8 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (data->clk) {
 		err = clk_notifier_register(data->clk, &data->clk_notifier);
 		if (err)
-			dev_warn(p->dev, "Failed to set the clock notifier\n");
-		else
-			queue_work(system_unbound_wq, &data->clk_work);
+			return dev_err_probe(dev, err, "Failed to set the clock notifier\n");
+		queue_work(system_unbound_wq, &data->clk_work);
 	}
 
 	platform_set_drvdata(pdev, data);
-- 
2.35.1

