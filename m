Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BED54E7CE1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiCYTyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbiCYTxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:53:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CF726EC8C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648237231; x=1679773231;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jInU92ALuYd6pU9oOkeB8Xo6OXwF6ae4kwHZusQjiIM=;
  b=VmGJbdfqhxDjFua5THeVN+a/FOWku+SPqhlXGZOJxCWmvq1SK/BvFA0L
   oScZIf3EbkHmvNdVVf5a7r27q/QrwAqf7XON/CnjIDtIpfzPCtbO9R0LR
   fMsqn1HevfP5QwvsJj+P58bRGZjmk5FJFojHbhWclXSDQwIis9H1rdnbO
   KyNHFT95u62iMBRCggDuvNhbBoJ8qdW1cXcXqboWpgFnEjHuWSIB5Hg4c
   UQNAgeHmmvUyPpRJvIOuDE91VhT5j6gfzRkB/+iVGA1XSyuy7PMh7E2JR
   Qxm/nm1GNs5pxZyka2T18H98Gkb7FEwbp8exawFPiX0ag2a2gipZ4XEzR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="321888017"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="321888017"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 11:44:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="648352387"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2022 11:44:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1A5BC11E; Fri, 25 Mar 2022 20:45:14 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Detlev Casanova <detlev.casanova@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] regulator/rpi-panel-attiny: Get rid of duplicate of_node assignment
Date:   Fri, 25 Mar 2022 20:45:08 +0200
Message-Id: <20220325184508.45670-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library does copy the of_node from the parent device of
the GPIO chip, there is no need to repeat this in the individual
drivers. Remove these assignment all at once.

For the details one may look into the of_gpio_dev_init() implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/regulator/rpi-panel-attiny-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/rpi-panel-attiny-regulator.c b/drivers/regulator/rpi-panel-attiny-regulator.c
index f7df0f4b2f87..fa8706a352ce 100644
--- a/drivers/regulator/rpi-panel-attiny-regulator.c
+++ b/drivers/regulator/rpi-panel-attiny-regulator.c
@@ -364,7 +364,6 @@ static int attiny_i2c_probe(struct i2c_client *i2c,
 	state->gc.parent = &i2c->dev;
 	state->gc.label = i2c->name;
 	state->gc.owner = THIS_MODULE;
-	state->gc.of_node = i2c->dev.of_node;
 	state->gc.base = -1;
 	state->gc.ngpio = NUM_GPIO;
 
-- 
2.35.1

