Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F59567622
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiGESGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiGESGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:06:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEC0E2D;
        Tue,  5 Jul 2022 11:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657044363; x=1688580363;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dQ7CpIOtBJlN0Msqc+NPtDbr2+VNA+oYzyJ96WNcmaI=;
  b=Xv32nHfAuEQqz4NTdk7mutFx1pPgg2/bqBO5xUwOA5KBhT0ug12ylFWb
   xor8QHibARDS2VsHyg2+flkOirI/5GHWYrBxKUXc2tIvf/hjv9qM12zzL
   BoUxT9BHrf0Wh1V+V+uYEHt7DC3K0CTw1slCIYTZHAl4+3tD+WvYHHttd
   MEFw1J5Tn04V5Y/cPURN96TnpozJMj3dwoxLGV2itb10oeDveWvXdurjU
   raHf6NELl24mee5jVPVuZVlcqUwG5HTLuEiH7BcM+560z3ThmoNzr+BYf
   6M6Fxoykt/bXAO9IN7lN1I5RchvMFgioAZxEzq64j8pUf9MJukCQbLb/B
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="347414608"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="347414608"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 11:02:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="660649549"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jul 2022 11:02:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 67E6E1A0; Tue,  5 Jul 2022 21:02:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bastien Nocera <hadess@hadess.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] Input: goodix - switch use of acpi_gpio_get_*_resource() APIs
Date:   Tue,  5 Jul 2022 21:02:51 +0300
Message-Id: <20220705180252.963-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to open code functionality that is provided by the
acpi_gpio_get_irq_resource() and acpi_gpio_get_io_resource().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/touchscreen/goodix.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 3ad9870db108..cc52f0d21dbb 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -822,22 +822,16 @@ static int goodix_resource(struct acpi_resource *ares, void *data)
 	struct device *dev = &ts->client->dev;
 	struct acpi_resource_gpio *gpio;
 
-	switch (ares->type) {
-	case ACPI_RESOURCE_TYPE_GPIO:
-		gpio = &ares->data.gpio;
-		if (gpio->connection_type == ACPI_RESOURCE_GPIO_TYPE_INT) {
-			if (ts->gpio_int_idx == -1) {
-				ts->gpio_int_idx = ts->gpio_count;
-			} else {
-				dev_err(dev, "More then one GpioInt resource, ignoring ACPI GPIO resources\n");
-				ts->gpio_int_idx = -2;
-			}
+	if (acpi_gpio_get_irq_resource(ares, &gpio)) {
+		if (ts->gpio_int_idx == -1) {
+			ts->gpio_int_idx = ts->gpio_count;
+		} else {
+			dev_err(dev, "More then one GpioInt resource, ignoring ACPI GPIO resources\n");
+			ts->gpio_int_idx = -2;
 		}
 		ts->gpio_count++;
-		break;
-	default:
-		break;
-	}
+	} else if (acpi_gpio_get_io_resource(ares, &gpio))
+		ts->gpio_count++;
 
 	return 0;
 }
-- 
2.35.1

