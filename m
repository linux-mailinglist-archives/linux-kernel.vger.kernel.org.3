Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0895542262
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385535AbiFHAke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445247AbiFGXD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:03:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4856C3508A2;
        Tue,  7 Jun 2022 13:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654633292; x=1686169292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hj4Bi9Kc6WsQtRSs1xjE/8Rm+BZ4jVZvSsyYrBi4QgI=;
  b=LgipjXroiOlg7jBQvGbQTHB8KYEa3pA6NzA+PMNNBxQFiXafJFMi7zTA
   vg4Y5uLt4xfmnhPoGaA5Lf+pjnyU9kngDfZqtZDrznCisOwXDBNikOb6y
   be4+d7lClFJMC616wzpM5sCJaYyYOi0+bRR7LqOCOWcyHjxkZxH2jaF9J
   YpkhZIPKF6RvF5xGQz0ggpFbVHKUWYR1MDFo+5OIuSTSiVJQXg8xC2Bu7
   A3gGqn0yG+yLkCkarbNbhPQ1k16PmaBKnDyIAoAR/5zR6RL4iv7Q1CnNi
   ph1S7wu2S2D4IVEfT49Q9rKKKm56FLyPexJOkhCe7W3nxXC3brwxQkNJQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="275518398"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="275518398"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 13:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="532772013"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 07 Jun 2022 13:20:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2B63649; Tue,  7 Jun 2022 23:21:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] spi: Use device_find_first_child() instead of custom approach
Date:   Tue,  7 Jun 2022 23:20:58 +0300
Message-Id: <20220607202058.8304-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220607202058.8304-1-andriy.shevchenko@linux.intel.com>
References: <20220607202058.8304-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have already a helper to get the first child device, use it and
drop custom approach.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ea09d1b42bf6..87dc8773108b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2613,11 +2613,6 @@ int spi_slave_abort(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_slave_abort);
 
-static int match_true(struct device *dev, void *data)
-{
-	return 1;
-}
-
 static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
@@ -2625,7 +2620,7 @@ static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
 						   dev);
 	struct device *child;
 
-	child = device_find_child(&ctlr->dev, NULL, match_true);
+	child = device_find_first_child(&ctlr->dev);
 	return sprintf(buf, "%s\n",
 		       child ? to_spi_device(child)->modalias : NULL);
 }
@@ -2644,7 +2639,7 @@ static ssize_t slave_store(struct device *dev, struct device_attribute *attr,
 	if (rc != 1 || !name[0])
 		return -EINVAL;
 
-	child = device_find_child(&ctlr->dev, NULL, match_true);
+	child = device_find_first_child(&ctlr->dev);
 	if (child) {
 		/* Remove registered slave */
 		device_unregister(child);
-- 
2.35.1

