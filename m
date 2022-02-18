Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A724BB42B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiBRIbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:31:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiBRIbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:31:00 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06C71FA41
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645173044; x=1676709044;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X4dKIlW+L1OU06c5P3qQy/8tIznfj0CKwjIgQAnzeTI=;
  b=Z+6IjH61vXt93+DUxxbZ0JHD5eFomXnyLpYKvaBBDuncXYfsb+r0FCMt
   7nSOyikp47Aqgcp+wNNnzRiNN0cvbQoGDTy4EClQjsu1DwJvUj9oIcSWR
   dmKNTD9BE2clzxbGWnbDYtOKOQJwl2pdlPs+SVnsKdGMb9KUxNY13yl6L
   YCt8r+coUxsn2Qz4i6Jxf9Wx4jjlUn6NYj9u9WP151oWJPEpyhYZDGQcM
   qxc6zhbTAAzyH3gyUxFDWrYEKJzcfPe1XNvvFGOTSCtpYdNJn8KZ1Y+TY
   zSsUIfuuE6CJ81/BpE6uEC9rl9ft1ohxp6eNCgr0zoBTwZ2tX54znyZBX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231718455"
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="231718455"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 00:30:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="503921065"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.25])
  by orsmga002.jf.intel.com with ESMTP; 18 Feb 2022 00:30:42 -0800
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Brent Lu <brent.lu@intel.com>
Subject: [PATCH] ASoC: SOF: Intel: Add topology overwrite for Felwinter
Date:   Fri, 18 Feb 2022 16:27:41 +0800
Message-Id: <20220218082741.1707209-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>

The Felwinter uses four max98360a amplifiers on corresponding CH0~CH3.
There are four amps on the board connecting to headphone to SSP0 port,
amp to SSP1,and the DAI format would be DSP_A,8-slots, 32 bit slot-width.

CH0: L(Woofer), CH1:R(Woofer), CH2:L(Tweeter), CH3:R(Tweeter)

Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/sof/sof-pci-dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index 20c6ca37dbc4..61f2afd54c3e 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -67,6 +67,14 @@ static const struct dmi_system_id sof_tplg_table[] = {
 		},
 		.driver_data = "sof-adl-max98390-ssp2-rt5682-ssp0.tplg",
 	},
+	{
+		.callback = sof_tplg_cb,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Brya"),
+			DMI_MATCH(DMI_OEM_STRING, "AUDIO_AMP-MAX98360_ALC5682VS_I2S_2WAY"),
+		},
+		.driver_data = "sof-adl-max98360a-rt5682-2way.tplg",
+	},
 
 	{}
 };
-- 
2.25.1

