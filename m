Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AFC47E3FB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 14:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348585AbhLWNPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 08:15:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:24843 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236068AbhLWNPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640265336; x=1671801336;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C4cpr8C0H6b71Zcd3Bigf/5RpQBynM7RGvZ/WcdzWX8=;
  b=aiwqDRFsKuZ8fUzFeZ/7NbI9dleCqvJeu48x3X9hUwyLrH9TwHaa4tf3
   cLjkv1fc/eVSrMCoMT0bZNZ8FFOkSQie2fatxobLXI3I8aptxeFf4Qm0Z
   tUqhomsu43V5nMvsOcXtM4Vqkn/ZKekMoQ8nniw0Dsj/wZbkw3yGJJDi2
   W/qQEdfF82zMu270+Qbe1+Wfue9AQEdWC90xZUnYBkzWfAnrAp7qFAYdh
   sdRnFM9d9YGwYRXRvsEvX9WpmMcu7XVy7lpbnN+hPr0Ta+QFbWo8hExvN
   QeXICPxp7++IFjK94f5Nx9nvvNwHwPl7Lu+QVvaWLG7rN4VGarzlJqD/1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="238357790"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="238357790"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 05:15:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="617486131"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 23 Dec 2021 05:15:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4B0AC150; Thu, 23 Dec 2021 15:15:41 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v1 1/1] gpio: brcmstb: Use local variable to access OF node
Date:   Thu, 23 Dec 2021 15:15:38 +0200
Message-Id: <20211223131538.88768-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have a local variable that contains a copy of OF node pointer.
Use it instead of dereferencing it again from struct device.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 176c264bb959..74ef89248867 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -704,7 +704,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 		}
 
 		gc->owner = THIS_MODULE;
-		gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", dev->of_node);
+		gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);
 		if (!gc->label) {
 			err = -ENOMEM;
 			goto fail;
-- 
2.34.1

