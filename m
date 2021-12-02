Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DE7466B38
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 21:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhLBU7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 15:59:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:52987 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230242AbhLBU7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 15:59:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="224068564"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="224068564"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 12:56:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="459805325"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 02 Dec 2021 12:56:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A9C86109; Thu,  2 Dec 2021 22:56:15 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] ASoC: ti: davinci-mcasp: Get rid of duplicate of_node assignment
Date:   Thu,  2 Dec 2021 22:56:11 +0200
Message-Id: <20211202205612.76216-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO library does copy the of_node from the parent device of
the GPIO chip, there is no need to repeat this in the individual
drivers. Remove assignment here.

For the details one may look into the of_gpio_dev_init() implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/ti/davinci-mcasp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 56a19eeec5c7..81c1ccec5904 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -2230,9 +2230,6 @@ static int davinci_mcasp_init_gpiochip(struct davinci_mcasp *mcasp)
 	mcasp->gpio_chip = davinci_mcasp_template_chip;
 	mcasp->gpio_chip.label = dev_name(mcasp->dev);
 	mcasp->gpio_chip.parent = mcasp->dev;
-#ifdef CONFIG_OF_GPIO
-	mcasp->gpio_chip.of_node = mcasp->dev->of_node;
-#endif
 
 	return devm_gpiochip_add_data(mcasp->dev, &mcasp->gpio_chip, mcasp);
 }
-- 
2.33.0

