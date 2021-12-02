Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09332466B27
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 21:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349003AbhLBUwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 15:52:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:46127 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238643AbhLBUwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 15:52:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="237053520"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="237053520"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 12:48:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="460609423"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 02 Dec 2021 12:48:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 105DF109; Thu,  2 Dec 2021 22:48:41 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ASoC: zl38060: Setup parent device and get rid of unnecessary of_node assignment
Date:   Thu,  2 Dec 2021 22:48:38 +0200
Message-Id: <20211202204838.75287-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the drivers do not set parent device. This may lead to obstacles
during debugging or understanding the device relations from the Linux
point of view. Assign parent device for GPIO chips created by these
drivers.

While at it, let GPIO library to assign of_node from the parent device.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/codecs/zl38060.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/zl38060.c b/sound/soc/codecs/zl38060.c
index d20ec1571010..6cae0fb08093 100644
--- a/sound/soc/codecs/zl38060.c
+++ b/sound/soc/codecs/zl38060.c
@@ -589,9 +589,7 @@ static int zl38_spi_probe(struct spi_device *spi)
 				       sizeof(template_chip), GFP_KERNEL);
 	if (!priv->gpio_chip)
 		return -ENOMEM;
-#ifdef CONFIG_OF_GPIO
-	priv->gpio_chip->of_node = dev->of_node;
-#endif
+	priv->gpio_chip->parent = dev;
 	err = devm_gpiochip_add_data(dev, priv->gpio_chip, priv->regmap);
 	if (err)
 		return err;
-- 
2.33.0

