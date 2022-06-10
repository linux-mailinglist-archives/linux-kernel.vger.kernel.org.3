Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FAC546630
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347556AbiFJMC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347368AbiFJMCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:02:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE433E5C3;
        Fri, 10 Jun 2022 05:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654862541; x=1686398541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fUe1OfJHggHu1g9C1q0AXthmCAvU/GJYCK0MIj3eotA=;
  b=eKhyQ9eX4yWT98PEUBrCDKrenfoR6RXfvGPnp5dP2QWwJHm4WR8VUjU6
   c4GVO7i6KtUb8GPGk91fp70ULjLS0mtv7IJt9GDaRA11NK9+g3ViaKz2R
   /w2DCyoCM60yH9sMSyFkJoUIfO4I5Bep/JsjoqLPM2ypFQEbpPo7SKO+p
   BOavdVKnfgHV7boGYxCRy53Ncj4WbVuS2MJuM5JDjbZKKngEw03Yb9rus
   xWDuEibzBcYWYAtIl5NqmQ9KrSmKAYjFKDZywzeG4yJK9XRiLgiDGux40
   txdvoof4vpYdze0ciwmC05K2pZcs7J+RSUThefor6nwPJJ9HCuLUJkx+G
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="302985841"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="302985841"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 05:02:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="534054638"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 10 Jun 2022 05:02:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0FF61F8; Fri, 10 Jun 2022 15:02:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 2/2] spi: Use device_find_any_child() instead of custom approach
Date:   Fri, 10 Jun 2022 15:02:19 +0300
Message-Id: <20220610120219.18988-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220610120219.18988-1-andriy.shevchenko@linux.intel.com>
References: <20220610120219.18988-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have already a helper to get the first child device, use it and
drop custom approach.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
v2: added tag (Rafael)
 drivers/spi/spi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ea09d1b42bf6..b04be04dddfa 100644
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
+	child = device_find_any_child(&ctlr->dev);
 	return sprintf(buf, "%s\n",
 		       child ? to_spi_device(child)->modalias : NULL);
 }
@@ -2644,7 +2639,7 @@ static ssize_t slave_store(struct device *dev, struct device_attribute *attr,
 	if (rc != 1 || !name[0])
 		return -EINVAL;
 
-	child = device_find_child(&ctlr->dev, NULL, match_true);
+	child = device_find_any_child(&ctlr->dev);
 	if (child) {
 		/* Remove registered slave */
 		device_unregister(child);
-- 
2.35.1

