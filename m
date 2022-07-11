Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821FA570CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiGKVfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiGKVf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:35:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82D22717A;
        Mon, 11 Jul 2022 14:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657575328; x=1689111328;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=FQe57KEmBLslNh9Y1duRWYZHRmbKKEi9R/4+thYRIlo=;
  b=kLeaiXKx50IzQc+Mbyv3KCFxdOz6OOIJMgO56ogzjtLzlAfmAGqw9bE0
   QhrVzxgcFVqLcLSdvTKZQu7uBgqZVRPDXpAkPtMxURC5Ro5DBo0hwu398
   oUrjHjmCn3lNNg+EMC7KJv8WNjBm2t9iVIb4j7n6bDUAFIdf/Nk60p9DG
   2O8DxqEaPctRqBjiyFn+6Q/UGaSZ1SFbCCZHrM5HZu2FHD3WNvmB+7QlE
   YUJceKE2uxmpLMRGhBxdi1wZC3lTt4dKn2SEf55Jwu3KuHx+n31HGOfSm
   9nB5uYpX9LqhwTCutdLTIOJFPcPp67p/GC3CpFqUgMqCkXyOZHTFhh2Kc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="310383931"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="310383931"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 14:35:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="841148414"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jul 2022 14:35:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 90F905AD; Tue, 12 Jul 2022 00:35:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] leds: is31fl319x: use simple i2c probe function
Date:   Tue, 12 Jul 2022 00:35:23 +0300
Message-Id: <20220711213524.3587-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220711213524.3587-1-andriy.shevchenko@linux.intel.com>
References: <20220711213524.3587-1-andriy.shevchenko@linux.intel.com>
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

The i2c probe functions here don't use the id information provided in
their second argument, so the single-parameter i2c probe function
("probe_new") can be used instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/leds-is31fl319x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index 233ed67830a3..52b59b62f437 100644
--- a/drivers/leds/leds-is31fl319x.c
+++ b/drivers/leds/leds-is31fl319x.c
@@ -494,8 +494,7 @@ static inline int is31fl3196_db_to_gain(u32 dezibel)
 	return dezibel / IS31FL3196_AUDIO_GAIN_DB_STEP;
 }
 
-static int is31fl319x_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id)
+static int is31fl319x_probe(struct i2c_client *client)
 {
 	struct is31fl319x_chip *is31;
 	struct device *dev = &client->dev;
@@ -597,7 +596,7 @@ static struct i2c_driver is31fl319x_driver = {
 		.name           = "leds-is31fl319x",
 		.of_match_table = of_is31fl319x_match,
 	},
-	.probe    = is31fl319x_probe,
+	.probe_new = is31fl319x_probe,
 	.id_table = is31fl319x_id,
 };
 
-- 
2.35.1

