Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BC34CA911
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243472AbiCBPcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243436AbiCBPcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:32:15 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB441377EF;
        Wed,  2 Mar 2022 07:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646235092; x=1677771092;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xAc+gk2/+uUrxuyv4q2tiGwH2PWivQpVZzG75sglYWE=;
  b=evVfxgtKL9xJj3enedq5hXvm2JsFaE4MT0GCTONJyTh2iLxO03Dbt0SX
   ttnHeZwen5Sd/KXGeJsoTEETL8iLe4TMnIJD1d6h4r9grmsn4iisyo8hu
   YWy8VqJTO49MZrn8p/9DS0X+AuxDNtpuGkwOpd8nkuPNtfAu6cmznjJMh
   GTWOL+M/Nwnablerd8N56uCcQ9Jxb8tGcftq0iPjA4tosWZxrY7hJPkra
   3m/dQ6VXTa7QETCnwU+27o7FuN/rv5l49xqVCsV/cXkwpMco7zAfwUPAR
   v7l60EuGKh1vPqj36ubnQ/NGT8LjgFw7lPHHx6oi2MffNUKBv5bqM6Bes
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="240839916"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="240839916"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 07:31:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="508235462"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2022 07:31:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 42F1E183; Wed,  2 Mar 2022 17:31:45 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: dac: ltc2688: Use temporary variable for struct device
Date:   Wed,  2 Mar 2022 17:31:42 +0200
Message-Id: <20220302153142.52743-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Use temporary variable for struct device to make code neater.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/dac/ltc2688.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
index e41861d29767..d249fa28202c 100644
--- a/drivers/iio/dac/ltc2688.c
+++ b/drivers/iio/dac/ltc2688.c
@@ -703,21 +703,20 @@ static int ltc2688_tgp_clk_setup(struct ltc2688_state *st,
 				 struct ltc2688_chan *chan,
 				 struct fwnode_handle *node, int tgp)
 {
+	struct device *dev = &st->spi->dev;
 	unsigned long rate;
 	struct clk *clk;
 	int ret, f;
 
-	clk = devm_get_clk_from_child(&st->spi->dev, to_of_node(node), NULL);
+	clk = devm_get_clk_from_child(dev, to_of_node(node), NULL);
 	if (IS_ERR(clk))
-		return dev_err_probe(&st->spi->dev, PTR_ERR(clk),
-				     "failed to get tgp clk.\n");
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get tgp clk.\n");
 
 	ret = clk_prepare_enable(clk);
 	if (ret)
-		return dev_err_probe(&st->spi->dev, ret,
-				     "failed to enable tgp clk.\n");
+		return dev_err_probe(dev, ret, "failed to enable tgp clk.\n");
 
-	ret = devm_add_action_or_reset(&st->spi->dev, ltc2688_clk_disable, clk);
+	ret = devm_add_action_or_reset(dev, ltc2688_clk_disable, clk);
 	if (ret)
 		return ret;
 
@@ -858,6 +857,7 @@ static int ltc2688_channel_config(struct ltc2688_state *st)
 
 static int ltc2688_setup(struct ltc2688_state *st, struct regulator *vref)
 {
+	struct device *dev = &st->spi->dev;
 	struct gpio_desc *gpio;
 	int ret;
 
@@ -865,10 +865,9 @@ static int ltc2688_setup(struct ltc2688_state *st, struct regulator *vref)
 	 * If we have a reset pin, use that to reset the board, If not, use
 	 * the reset bit.
 	 */
-	gpio = devm_gpiod_get_optional(&st->spi->dev, "clr", GPIOD_OUT_HIGH);
+	gpio = devm_gpiod_get_optional(dev, "clr", GPIOD_OUT_HIGH);
 	if (IS_ERR(gpio))
-		return dev_err_probe(&st->spi->dev, PTR_ERR(gpio),
-				     "Failed to get reset gpio");
+		return dev_err_probe(dev, PTR_ERR(gpio), "Failed to get reset gpio");
 	if (gpio) {
 		usleep_range(1000, 1200);
 		/* bring device out of reset */
@@ -887,7 +886,7 @@ static int ltc2688_setup(struct ltc2688_state *st, struct regulator *vref)
 	 * Duplicate the default channel configuration as it can change during
 	 * @ltc2688_channel_config()
 	 */
-	st->iio_chan = devm_kmemdup(&st->spi->dev, ltc2688_channels,
+	st->iio_chan = devm_kmemdup(dev, ltc2688_channels,
 				    sizeof(ltc2688_channels), GFP_KERNEL);
 	if (!st->iio_chan)
 		return -ENOMEM;
-- 
2.34.1

