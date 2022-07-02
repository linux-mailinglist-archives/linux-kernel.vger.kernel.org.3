Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF91D564316
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 00:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiGBWcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 18:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGBWco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 18:32:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADC95591
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 15:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656801163; x=1688337163;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cGLiC8mmOC+hPN2iurZ2+B4LWJ9RFal0ibK69bgVPuo=;
  b=caKumOF7J/iccNRK1D/aNz4hS7yAzuZjonQiklWKS0b+vJXp8OMBJDy7
   ugqiM0FaaziijwEgnBREiFM6uWYDpCZcsw5Iob/q4unB42QBMGaSPmjc4
   Sd8CQ614ZcLYkK808YMcwzvO6AtFJCeQdVt8HuSShiT3+mmElEMn7REe7
   +/oO2D3MyXf/7AZDGedXinfbswf2GqbxPtqRicD3Be00zyHjJ1ci8tsOD
   H72NbBlRRDqvFQiNRwvWcK2Q7nPE5nrd2IsHoSZp/rKHBCncbbvYdHbF2
   VN5eer65/KaY50aW9U/3RkJmRp4h9AjnN/w2Qtp434T64t8j3/1vp4xg7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="263268111"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="263268111"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 15:32:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="838434018"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2022 15:32:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5F52711D; Sun,  3 Jul 2022 01:32:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 1/1] ASoC: Intel: catpt: remove duplicating driver data retrieval
Date:   Sun,  3 Jul 2022 01:32:43 +0300
Message-Id: <20220702223243.51364-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_get_match_data() in ACPI case calls similar to acpi_match_device() API.
Hence there is no need to duplicate the call. Just check what the former
returns.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/catpt/device.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/catpt/device.c b/sound/soc/intel/catpt/device.c
index 85a34e37316d..21856a394c3d 100644
--- a/sound/soc/intel/catpt/device.c
+++ b/sound/soc/intel/catpt/device.c
@@ -12,13 +12,14 @@
 // helping backtrack its historical background
 //
 
-#include <linux/acpi.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <sound/intel-dsp-config.h>
 #include <sound/soc.h>
 #include <sound/soc-acpi.h>
@@ -244,8 +245,8 @@ static int catpt_acpi_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret;
 
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (!id)
+	spec = device_get_match_data(dev);
+	if (!spec)
 		return -ENODEV;
 
 	ret = snd_intel_acpi_dsp_driver_probe(dev, id->id);
@@ -254,10 +255,6 @@ static int catpt_acpi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	spec = device_get_match_data(dev);
-	if (!spec)
-		return -ENODEV;
-
 	cdev = devm_kzalloc(dev, sizeof(*cdev), GFP_KERNEL);
 	if (!cdev)
 		return -ENOMEM;
-- 
2.35.1

