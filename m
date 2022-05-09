Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13629520381
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbiEIR0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239574AbiEIRZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:25:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3A524FDAB;
        Mon,  9 May 2022 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652116891; x=1683652891;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I4V4xhLbqiqJOKcdU+RpD14ssw/t4JQP8jT2I6gAeBc=;
  b=MBdZ95lzLqb5TsdkyWuqKsCE0MSluxezRwuyDMdRbtOv6W94ywKjeYyD
   G67NApJy5CW2/c3U5xATJw4BluzUQjgDvT49vLQsxTpwGC4RCREr6AxBL
   NmqneoXxGv3RPliR5w9iByWtqIOD/ncH7ES/bDhb5ZQvTsolBdmAuv6DP
   YYT1ndlXG0Gkle+dnJ1IQkSERG5n+5I7rUVvMH+q4iWBFnuKrSMnYVSfM
   O/cszBgthwcVTxxa97TKJvJBHz+x7sAxC6vWgM78w6760uF/AbS3aNW/b
   TSv1jIMMRSoRCHt+iOGpVL5vin+ZSkfDQW2esw7h6aFMHKMiKjsoMejsa
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="329710546"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="329710546"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 10:21:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="592915418"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 09 May 2022 10:21:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4A80DD1; Mon,  9 May 2022 20:21:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v1 1/2] serial: 8250_dw: Use devm_add_action_or_reset()
Date:   Mon,  9 May 2022 20:21:28 +0300
Message-Id: <20220509172129.37770-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slightly simplify ->probe() and drop a few goto labels by using
devm_add_action_or_reset() for clock and reset cleanup.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 63 +++++++++++++++----------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 7934e4658281..e7ef61899576 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -484,6 +484,16 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 	}
 }
 
+static void dw8250_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+static void dw8250_reset_control_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 static int dw8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {}, *up = &uart;
@@ -585,35 +595,43 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (err)
 		dev_warn(dev, "could not enable optional baudclk: %d\n", err);
 
+	err = devm_add_action_or_reset(dev, dw8250_clk_disable_unprepare, data->clk);
+	if (err)
+		return err;
+
 	if (data->clk)
 		p->uartclk = clk_get_rate(data->clk);
 
 	/* If no clock rate is defined, fail. */
 	if (!p->uartclk) {
 		dev_err(dev, "clock rate not defined\n");
-		err = -EINVAL;
-		goto err_clk;
+		return -EINVAL;
 	}
 
 	data->pclk = devm_clk_get_optional(dev, "apb_pclk");
-	if (IS_ERR(data->pclk)) {
-		err = PTR_ERR(data->pclk);
-		goto err_clk;
-	}
+	if (IS_ERR(data->pclk))
+		return PTR_ERR(data->pclk);
 
 	err = clk_prepare_enable(data->pclk);
 	if (err) {
 		dev_err(dev, "could not enable apb_pclk\n");
-		goto err_clk;
+		return err;
 	}
 
+	err = devm_add_action_or_reset(dev, dw8250_clk_disable_unprepare, data->pclk);
+	if (err)
+		return err;
+
 	data->rst = devm_reset_control_get_optional_exclusive(dev, NULL);
-	if (IS_ERR(data->rst)) {
-		err = PTR_ERR(data->rst);
-		goto err_pclk;
-	}
+	if (IS_ERR(data->rst))
+		return PTR_ERR(data->rst);
+
 	reset_control_deassert(data->rst);
 
+	err = devm_add_action_or_reset(dev, dw8250_reset_control_assert, data->rst);
+	if (err)
+		return err;
+
 	dw8250_quirks(p, data);
 
 	/* If the Busy Functionality is not implemented, don't handle it */
@@ -631,10 +649,8 @@ static int dw8250_probe(struct platform_device *pdev)
 	}
 
 	data->data.line = serial8250_register_8250_port(up);
-	if (data->data.line < 0) {
-		err = data->data.line;
-		goto err_reset;
-	}
+	if (data->data.line < 0)
+		return data->data.line;
 
 	/*
 	 * Some platforms may provide a reference clock shared between several
@@ -655,17 +671,6 @@ static int dw8250_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 
 	return 0;
-
-err_reset:
-	reset_control_assert(data->rst);
-
-err_pclk:
-	clk_disable_unprepare(data->pclk);
-
-err_clk:
-	clk_disable_unprepare(data->clk);
-
-	return err;
 }
 
 static int dw8250_remove(struct platform_device *pdev)
@@ -683,12 +688,6 @@ static int dw8250_remove(struct platform_device *pdev)
 
 	serial8250_unregister_port(data->data.line);
 
-	reset_control_assert(data->rst);
-
-	clk_disable_unprepare(data->pclk);
-
-	clk_disable_unprepare(data->clk);
-
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
 
-- 
2.35.1

