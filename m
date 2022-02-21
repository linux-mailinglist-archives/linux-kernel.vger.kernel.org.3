Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F194BD624
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 07:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345549AbiBUGpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 01:45:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345636AbiBUGoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 01:44:54 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1D649269
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 22:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645425796; x=1676961796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ef2HXbSqDvS9Glrw6CB1QeV3AdDoUJ86lJQ/slSWZXw=;
  b=NVAvfKIJQcH8vIMoxHpL2bKJ2ZmNc5XHLBLagQlQqb6B4RvKCaPFe5u8
   MoHi3YqhgqzuN6ShSiAnZmUdVonoT2r706VJVI73p2k9Bq73DVJKlx5o2
   jzcYefWxT7wi2sVB9M11/INvQpIRHPNuYgIkt1FX6uLhDP2n9RwbBjKJB
   ZkGCR6qk26Xx0JocY9j3XFKYGnjSFA4poJvQDkXv30i/oQyziAo/FPGKK
   Sv5hYND8vCTlUFCbHgNef0RBt029PWW8jlIgkaYHoaXRDTVyQdLPTeB2d
   NSDemdP6td0aN81fv77f69Jvk1o7rgUUtWfvJ9T9QZi7ABEGzEA2+kp3Q
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="276037977"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="276037977"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 22:43:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="531734085"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.25])
  by orsmga007.jf.intel.com with ESMTP; 20 Feb 2022 22:43:10 -0800
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
        Brent Lu <brent.lu@intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH v2] ASoC: SOF: Intel: Add topology overwrite for Felwinter
Date:   Mon, 21 Feb 2022 14:40:05 +0800
Message-Id: <20220221064005.1752500-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

