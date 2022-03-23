Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC714E57C2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343758AbiCWRpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343744AbiCWRo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:44:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7996D3BE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648057408; x=1679593408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jn+HiqIMvCI5Ag0vA8t+qIxmidEK/HlIdGCSWeHdw80=;
  b=TdRgi5B1VxtygIuutapuLWNU9lJPpZNSum7Yu/mmyRtWoOGpDES0BEEN
   IEy+vmOhK9rgU+pQDx3ATSjcbMadV1cxnZs7BeIeTegjrwSNJo1ojkjIp
   cZ9OrbQgFTGuc4b3Mvr1pykJq4bknZ8eRd/g5NhpFDna2AX+1QEoGCaUv
   z1tmhR9AZ63q21HP9ottGNIOND3EGjb/Q8lQ6umJleRu9uof1qi/OkvoO
   CZ5okkiTkO+1d8VUMkNE0pK9x/YB3dIS4OUyhJSUqgq/g4kyGc64R4mnS
   eUbFq4k9eSH47vxRTo4Obk3fbjkA8+/1+Ki9BTqFB94cHF3etliq9oIVo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="238790574"
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="238790574"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 10:43:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,204,1643702400"; 
   d="scan'208";a="693031305"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Mar 2022 10:43:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 30515120; Wed, 23 Mar 2022 19:43:45 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Scott Wood <oss@buserror.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] powerpc/83xx/mpc8349emitx: Get rid of of_node assignment
Date:   Wed, 23 Mar 2022 19:43:42 +0200
Message-Id: <20220323174342.56187-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

Let GPIO library to assign of_node from the parent device.
This allows to move GPIO library and drivers to use fwnode
APIs instead of being stuck with OF-only interfaces.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
index a38372f9ac12..26b502773b3f 100644
--- a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
+++ b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
@@ -8,15 +8,15 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/i2c.h>
 #include <linux/gpio/driver.h>
-#include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <linux/kthread.h>
+#include <linux/property.h>
 #include <linux/reboot.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
@@ -116,21 +116,17 @@ static int mcu_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 
 static int mcu_gpiochip_add(struct mcu *mcu)
 {
-	struct device_node *np;
+	struct device *dev = &mcu->client->dev;
 	struct gpio_chip *gc = &mcu->gc;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,mcu-mpc8349emitx");
-	if (!np)
-		return -ENODEV;
-
 	gc->owner = THIS_MODULE;
-	gc->label = kasprintf(GFP_KERNEL, "%pOF", np);
+	gc->label = kasprintf(GFP_KERNEL, "%pfw", dev_fwnode(dev));
 	gc->can_sleep = 1;
 	gc->ngpio = MCU_NUM_GPIO;
 	gc->base = -1;
 	gc->set = mcu_gpio_set;
 	gc->direction_output = mcu_gpio_dir_out;
-	gc->of_node = np;
+	gc->parent = dev;
 
 	return gpiochip_add_data(gc, mcu);
 }
-- 
2.35.1

