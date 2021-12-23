Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACB947E333
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348220AbhLWM1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:27:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:51618 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243438AbhLWM07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640262419; x=1671798419;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EsO/C6TP2k5lECpkQDcYXdFNp6zHeSuOgOuojLwJg/U=;
  b=T/HBN5SFjur99cMzlvFznjkUaOUY2dba1Go99ZLOVrCCfPVDwyt9wMmS
   DvZlj3aGmib7IDaXtqIixv5PXpr1EqNkqSD8SqJL5jXG962FG4WolUOue
   QD6aHkpwxdtfDYyOd0M19eC9RJ4zNIZK5hVTEPJnqSmqbNO/K+Dl0wlXP
   Dp/RQZzXfLDiZMBfSv/Z4l+ipBq4LEU2z7G+dqAdb1wnRS8juBBmWQhRN
   jVKGv0yApgFmE18H+vha7zNH7v4LRVxXJWtcj+MMGPd+VDNxkMDnsSwG0
   zlPkDl2EpPp8EX092YgtD2yWN9MIPYl8FpQS0Oi3Baa+N93PuXdo3zEsR
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="240769028"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="240769028"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 04:26:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="522077258"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 23 Dec 2021 04:26:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 94A4A120; Thu, 23 Dec 2021 14:26:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] gpio: tegra: Get rid of duplicate of_node assignment
Date:   Thu, 23 Dec 2021 14:26:39 +0200
Message-Id: <20211223122639.86923-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library does copy the of_node from the parent device of
the GPIO chip, there is no need to repeat this in the individual
drivers. Remove these assignment all at once.

For the details one may look into the of_gpio_dev_init() implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 7f5bc10a6479..ff2d2a1f9c73 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -691,7 +691,6 @@ static int tegra_gpio_probe(struct platform_device *pdev)
 	tgi->gc.base			= 0;
 	tgi->gc.ngpio			= tgi->bank_count * 32;
 	tgi->gc.parent			= &pdev->dev;
-	tgi->gc.of_node			= pdev->dev.of_node;
 
 	tgi->ic.name			= "GPIO";
 	tgi->ic.irq_ack			= tegra_gpio_irq_ack;
-- 
2.34.1

