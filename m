Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7699D50DF4C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240394AbiDYLuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241632AbiDYLtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:49:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68568403E7;
        Mon, 25 Apr 2022 04:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650887150; x=1682423150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xisIqBPfK3hbnc2CtpiE8UPIMI89IMKbraF5w1peXJ8=;
  b=P49VHpODxk9sP4bJWHt6JBOUtnwEnnIvTPGShKbfD7rLeDRI4JcisEnV
   H7yFzt0rJy+9Z7+hq/bp5w7GlUvNKO4wzif7VmAADnxqqDN5LLwyMBI3q
   u0xpyhH7TE5IRz4DHDZv5gZcud9jADQ+mOqZduK0tULWKn1leWNZ/ZXIF
   NoKlto1xpXQCLSkn1uEtu5LBADMr8rI422w6WaIXvKA8ykzg55bkNUh/Y
   IYTJ+Dnyd1Spz7iAR8Y9aslqKGJFUgiXlnJlI4wdcf7ByzFBBh4lo8Xnn
   ObdFJGHEkHUk87MsT4Arpm5TZaaq5V3XdhsSlGqGneneu4/+xBvPoe68i
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="264075343"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="264075343"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 04:45:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="704526078"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Apr 2022 04:45:46 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v1 1/2] usb: typec: ucsi: acpi: Map the mailbox with memremap()
Date:   Mon, 25 Apr 2022 14:45:43 +0300
Message-Id: <20220425114544.37595-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425114544.37595-1-heikki.krogerus@linux.intel.com>
References: <20220425114544.37595-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UCSI mailbox is always in main memory.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 6771f05e32c29..7455e3aff2be0 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -19,7 +19,7 @@
 struct ucsi_acpi {
 	struct device *dev;
 	struct ucsi *ucsi;
-	void __iomem *base;
+	void *base;
 	struct completion complete;
 	unsigned long flags;
 	guid_t guid;
@@ -51,7 +51,7 @@ static int ucsi_acpi_read(struct ucsi *ucsi, unsigned int offset,
 	if (ret)
 		return ret;
 
-	memcpy(val, (const void __force *)(ua->base + offset), val_len);
+	memcpy(val, ua->base + offset, val_len);
 
 	return 0;
 }
@@ -61,7 +61,7 @@ static int ucsi_acpi_async_write(struct ucsi *ucsi, unsigned int offset,
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
 
-	memcpy((void __force *)(ua->base + offset), val, val_len);
+	memcpy(ua->base + offset, val, val_len);
 
 	return ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_WRITE);
 }
@@ -132,18 +132,7 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	/* This will make sure we can use ioremap() */
-	status = acpi_release_memory(ACPI_HANDLE(&pdev->dev), res, 1);
-	if (ACPI_FAILURE(status))
-		return -ENOMEM;
-
-	/*
-	 * NOTE: The memory region for the data structures is used also in an
-	 * operation region, which means ACPI has already reserved it. Therefore
-	 * it can not be requested here, and we can not use
-	 * devm_ioremap_resource().
-	 */
-	ua->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	ua->base = devm_memremap(&pdev->dev, res->start, resource_size(res), MEMREMAP_WB);
 	if (!ua->base)
 		return -ENOMEM;
 
-- 
2.35.1

