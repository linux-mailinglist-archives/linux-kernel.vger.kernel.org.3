Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C81466B39
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 21:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbhLBU7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 15:59:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:39901 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232768AbhLBU7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 15:59:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="223705347"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="223705347"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 12:56:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="513356078"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 02 Dec 2021 12:56:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5A47C165; Thu,  2 Dec 2021 22:56:16 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] ASoC: ti: davinci-mcasp: Remove unnecessary conditional
Date:   Thu,  2 Dec 2021 22:56:12 +0200
Message-Id: <20211202205612.76216-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211202205612.76216-1-andriy.shevchenko@linux.intel.com>
References: <20211202205612.76216-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of double validating of_node, return value of
the boolean property directly.

We can't remove ifdeffery, because in OF_GPIO=n cases
it might bring unwanted surprises.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/ti/davinci-mcasp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 81c1ccec5904..3e105caac95e 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -1870,12 +1870,10 @@ static int mcasp_reparent_fck(struct platform_device *pdev)
 static bool davinci_mcasp_have_gpiochip(struct davinci_mcasp *mcasp)
 {
 #ifdef CONFIG_OF_GPIO
-	if (mcasp->dev->of_node &&
-	    of_property_read_bool(mcasp->dev->of_node, "gpio-controller"))
-		return true;
-#endif
-
+	return of_property_read_bool(mcasp->dev->of_node, "gpio-controller");
+#else
 	return false;
+#endif
 }
 
 static int davinci_mcasp_get_config(struct davinci_mcasp *mcasp,
-- 
2.33.0

