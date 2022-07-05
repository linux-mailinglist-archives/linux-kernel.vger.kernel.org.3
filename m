Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2015673E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiGEQLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiGEQLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:11:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474361B798
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 09:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657037478; x=1688573478;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yoKSCm0Wqcpnljjt7Wuswbh2I5IXv4zoZfRChOAk8MQ=;
  b=ilqsbm4FIJmkVvOSMuiK67n/pH5SuDjdqdDwF0qylmohEhqrUnMsjbjl
   I1aCOWybRmfobOXWLeIcirwmzLGmdypwUyP3X2AIuVgf0a3hNAr2hM6bP
   o5l8yhFfKTDe9uVcGJ1KdK7eT29T2YRJ9siLj0GJwe7FphuRcOueiLbbn
   1JBoKeOoW4bpUNT793qFVhSsymii6NjL7fiFNg2T03cgZcozhTqV3q/Nb
   8NR9ZhcqOHimfm9qA5AAKWGQ64LQa1+ODGkr8N4IR82Doid20xxo5R6Cl
   +DE+B1Lw+tRLHoT+66ArlqU/j5Ko8g4h9wVbUBqz2X0+ELa/rKvLM10+U
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284508239"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="284508239"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 09:11:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="919774183"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jul 2022 09:11:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1A9AC1A0; Tue,  5 Jul 2022 19:11:07 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] ASoC: SOF: Intel: bdw: remove duplicating driver data retrieval
Date:   Tue,  5 Jul 2022 19:11:01 +0300
Message-Id: <20220705161102.76250-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
v2: moved desc assignment closer to its user (Péter)
 sound/soc/sof/intel/bdw.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/intel/bdw.c b/sound/soc/sof/intel/bdw.c
index 26df780c702e..a446154f2803 100644
--- a/sound/soc/sof/intel/bdw.c
+++ b/sound/soc/sof/intel/bdw.c
@@ -681,11 +681,8 @@ static int sof_broadwell_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	desc = device_get_match_data(dev);
-	if (!desc)
-		return -ENODEV;
-
-	return sof_acpi_probe(pdev, device_get_match_data(dev));
+	desc = (const struct sof_dev_desc *)id->driver_data;
+	return sof_acpi_probe(pdev, desc);
 }
 
 /* acpi_driver definition */
-- 
2.35.1

