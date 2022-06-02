Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E8853B2F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 07:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiFBFXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 01:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiFBFXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 01:23:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554DD1E227F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 22:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654147414; x=1685683414;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R7muiVv/9fpCE6xhaxI4/K+31SjhHgOvwPjMsc4fiJo=;
  b=PBNo5bXI79I7cnhmvm86vceBgdptqLtPEaDXkOl68bpsArkeBeBvdpuk
   zOFScWCciZBkS0nB0fFQc2ua6IgTmEWiB4NGvW0fWqBEfmdSiOE7KMIFM
   YqzmvKDvB/LuqP0yetZH0ZyexFIS4pyw5+rWZDBZLZUGkKCTRaiLpb94e
   kF0VrHjGN/eHd/DRjbk8yfl74vfugEI5iN9xLhjw01bS6y25ivgRy86iL
   IArDE6FR2C7tBLBJr4O+3aEmZTTi4hvwJ7f48ajpM66mfoAkdU7BXsSFN
   PkfcIyd5xBV1nolKwrted5j9Gu0TNQvVRxQT72Ffqoulb0Z1LNE5Rx01a
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="256306021"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="256306021"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 22:23:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="563136430"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.25])
  by orsmga002.jf.intel.com with ESMTP; 01 Jun 2022 22:23:31 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        xliu <xiang.liu@cirrus.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: Intel: cirrus-common: fix incorrect channel mapping
Date:   Thu,  2 Jun 2022 13:19:22 +0800
Message-Id: <20220602051922.1232457-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xliu <xiang.liu@cirrus.com>

The default mapping of ASPRX1 (DAC source) is slot 0. Change the slot
mapping of right amplifiers (WR and TR) to slot 1 to receive right
channel data. Also update the ACPI instance ID mapping according to HW
configuration.

Signed-off-by: xliu <xiang.liu@cirrus.com>
Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/sof_cirrus_common.c | 40 +++++++++++++++++++---
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/sof_cirrus_common.c b/sound/soc/intel/boards/sof_cirrus_common.c
index e71d74ec1b0b..f4192df962d6 100644
--- a/sound/soc/intel/boards/sof_cirrus_common.c
+++ b/sound/soc/intel/boards/sof_cirrus_common.c
@@ -54,22 +54,29 @@ static struct snd_soc_dai_link_component cs35l41_components[] = {
 	},
 };
 
+/*
+ * Mapping between ACPI instance id and speaker position.
+ *
+ * Four speakers:
+ *         0: Tweeter left, 1: Woofer left
+ *         2: Tweeter right, 3: Woofer right
+ */
 static struct snd_soc_codec_conf cs35l41_codec_conf[] = {
 	{
 		.dlc = COMP_CODEC_CONF(CS35L41_DEV0_NAME),
-		.name_prefix = "WL",
+		.name_prefix = "TL",
 	},
 	{
 		.dlc = COMP_CODEC_CONF(CS35L41_DEV1_NAME),
-		.name_prefix = "WR",
+		.name_prefix = "WL",
 	},
 	{
 		.dlc = COMP_CODEC_CONF(CS35L41_DEV2_NAME),
-		.name_prefix = "TL",
+		.name_prefix = "TR",
 	},
 	{
 		.dlc = COMP_CODEC_CONF(CS35L41_DEV3_NAME),
-		.name_prefix = "TR",
+		.name_prefix = "WR",
 	},
 };
 
@@ -101,6 +108,21 @@ static int cs35l41_init(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
+/*
+ * Channel map:
+ *
+ * TL/WL: ASPRX1 on slot 0, ASPRX2 on slot 1 (default)
+ * TR/WR: ASPRX1 on slot 1, ASPRX2 on slot 0
+ */
+static const struct {
+	unsigned int rx[2];
+} cs35l41_channel_map[] = {
+	{.rx = {0, 1}}, /* TL */
+	{.rx = {0, 1}}, /* WL */
+	{.rx = {1, 0}}, /* TR */
+	{.rx = {1, 0}}, /* WR */
+};
+
 static int cs35l41_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
 {
@@ -134,6 +156,16 @@ static int cs35l41_hw_params(struct snd_pcm_substream *substream,
 				ret);
 			return ret;
 		}
+
+		/* setup channel map */
+		ret = snd_soc_dai_set_channel_map(codec_dai, 0, NULL,
+						  ARRAY_SIZE(cs35l41_channel_map[i].rx),
+						  (unsigned int *)cs35l41_channel_map[i].rx);
+		if (ret < 0) {
+			dev_err(codec_dai->dev, "fail to set channel map, ret %d\n",
+				ret);
+			return ret;
+		}
 	}
 
 	return 0;
-- 
2.25.1

