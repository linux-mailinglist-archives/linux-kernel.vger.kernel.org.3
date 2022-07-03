Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A697E564826
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 16:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiGCOvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 10:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGCOvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:51:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA0E263B
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 07:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656859911; x=1688395911;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1Swa9EyBO2RNDfjUjVHJNEs947l9uCAsdG7L2gwvtBE=;
  b=fxyReEXdZYSqPcIu1Q1vriyraxbkdeEgGLiVxoGyvZiPbzOLiWsbvMEN
   u2ebxrncmuOyJQLHXK1k/YCGY8eFlLg8yOyKwtJ6HitcomH5xUE7dsC1S
   ofQc8Fdh/yiO4CWu+yZDeHSb7gs+tXoi0wZydmUrhoLMZBcwC984tFKil
   awH2x9P0sRRqa8yEl+KL5IPczv7cUyk5G7GeO/hId7okhy1P76nIViWwm
   xE/1wA2ej0mXTeZUA5WikoUHEUShluADXz8seEQZUtL/MI493868WQy3x
   +YMWQuYlh0Y11/nwvv+iiUY7w5ri/GScXPUV/us1pNYpeebdRcKSfzk1d
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="284063995"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="284063995"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 07:51:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="838564919"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jul 2022 07:51:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 066E311D; Sun,  3 Jul 2022 17:51:53 +0300 (EEST)
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
Subject: [PATCH v2 1/1] ASoC: Intel: catpt: remove duplicating driver data retrieval
Date:   Sun,  3 Jul 2022 17:51:52 +0300
Message-Id: <20220703145152.62297-1-andriy.shevchenko@linux.intel.com>
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

device_get_match_data() in ACPI case calls similar to acpi_match_device().
Hence there is no need to duplicate the call. Just assign what is in
the id->driver_data.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: dropped device_get_match_data() and rewrote commit message
 sound/soc/intel/catpt/device.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/intel/catpt/device.c b/sound/soc/intel/catpt/device.c
index 85a34e37316d..2eeaeb962532 100644
--- a/sound/soc/intel/catpt/device.c
+++ b/sound/soc/intel/catpt/device.c
@@ -247,6 +247,7 @@ static int catpt_acpi_probe(struct platform_device *pdev)
 	id = acpi_match_device(dev->driver->acpi_match_table, dev);
 	if (!id)
 		return -ENODEV;
+	spec = (const struct catpt_spec *)id->driver_data;
 
 	ret = snd_intel_acpi_dsp_driver_probe(dev, id->id);
 	if (ret != SND_INTEL_DSP_DRIVER_ANY && ret != SND_INTEL_DSP_DRIVER_SST) {
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

