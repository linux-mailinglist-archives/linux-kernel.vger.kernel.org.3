Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D78B5673EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbiGEQL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiGEQLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:11:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9FA1A3A5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657037480; x=1688573480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8/q1hXVhKg9yQEzY3bhW4w5a4akFV783q++XCNoIrns=;
  b=BcQlQ4rniQqG3QMgcOF1+78mH4YrJF4vcV4CEHIFr0CCWw2rybStfJm+
   Y+ytFVpsNr55SXEmEHaijphTx+O6RudnZEozfYf6cA1sPM4QvtCkA6/ad
   G3pdouSsMMDN2VxJyp5P2boox9WFwq+VcqBQ2acs0pFvK1ivMuJnKlBLk
   u3p1BFygOu6Ej4CXxsDPV9HGlZyvU+CPSA72u5G7UrdfPy3p4S5rXNj2J
   2/IN4ayuQmgemzbhgdOlN48Xvv6v/y1K1kptFPzvBWb+PFr/stJ3t/UhB
   VYnBfeWsTvNk991BugBRutsKDA9keOkjNiBPKTOePoneJ+mw2gP8jVsoa
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="282148871"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="282148871"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 09:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="592972442"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 05 Jul 2022 09:11:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2B286CE; Tue,  5 Jul 2022 19:11:07 +0300 (EEST)
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
Subject: [PATCH v2 2/2] ASoC: SOF: Intel: byt: remove duplicating driver data retrieval
Date:   Tue,  5 Jul 2022 19:11:02 +0300
Message-Id: <20220705161102.76250-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220705161102.76250-1-andriy.shevchenko@linux.intel.com>
References: <20220705161102.76250-1-andriy.shevchenko@linux.intel.com>
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
v2: new patch (Pierre)
 sound/soc/sof/intel/byt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index 4ed8381eceda..e6dc4ff531c3 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -465,10 +465,7 @@ static int sof_baytrail_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	desc = device_get_match_data(&pdev->dev);
-	if (!desc)
-		return -ENODEV;
-
+	desc = (const struct sof_dev_desc *)id->driver_data;
 	if (desc == &sof_acpi_baytrail_desc && soc_intel_is_byt_cr(pdev))
 		desc = &sof_acpi_baytrailcr_desc;
 
-- 
2.35.1

