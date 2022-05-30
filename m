Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E82537AEA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 14:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbiE3M6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 08:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbiE3M6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 08:58:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C482D43AC0
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653915510; x=1685451510;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zwLZOtzsjIrGjVkgMSw7EhmnbACABlAKZCgHcg080zU=;
  b=KXqwYLZrxTI0oK5lzCzt3jtTTTwJ6fkeLyms9xWAvqF0dvrJUNCmI07p
   BUAIyMe20Rq9sFU1fIavdhRuqVbLM6mkaoevA1PlM82ys2Rj2QDDPhVhA
   tgbH0MDvX+XENL9NceMUMSzc4Ku/Dh+t4Q2FL/loFYZ7AT90T76ReXzO5
   o58U9lq3hiwldwjqrKjzqzL1F1Z2w+XOJH2gaQRJQmC2o1TU1YT9WR93W
   lQxSDdDbJRNte+QbxQ3T8ttf+iTbBPLsR4+IacElxedkUm5Ab7JP/IbrK
   n4eLtx79b8MbqD1CXV9vIgTkd8LW1p37J43RaMIt726i0qhj+Jx2JIS3I
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="275081868"
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="275081868"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 05:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,262,1647327600"; 
   d="scan'208";a="561916818"
Received: from brentlu-brix.itwn.intel.com ([10.5.253.25])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2022 05:58:27 -0700
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
Subject: [PATCH] ASoC: Intel: cirrus-common: fix incorrect channel mapping
Date:   Mon, 30 May 2022 20:54:21 +0800
Message-Id: <20220530125421.885236-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xliu <xiang.liu@cirrus.com>

The default mapping of ASPRX1 Slot is left channel. Map the slots of
right amplifiers (WR and TR) to right channel.

Signed-off-by: xliu <xiang.liu@cirrus.com>
Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/sof_cirrus_common.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/intel/boards/sof_cirrus_common.c b/sound/soc/intel/boards/sof_cirrus_common.c
index e71d74ec1b0b..64ca0e3991dc 100644
--- a/sound/soc/intel/boards/sof_cirrus_common.c
+++ b/sound/soc/intel/boards/sof_cirrus_common.c
@@ -107,6 +107,7 @@ static int cs35l41_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_dai *codec_dai;
 	int clk_freq, i, ret;
+	int rx_ch[2] = {1, 0};
 
 	clk_freq = sof_dai_get_bclk(rtd); /* BCLK freq */
 
@@ -134,6 +135,17 @@ static int cs35l41_hw_params(struct snd_pcm_substream *substream,
 				ret);
 			return ret;
 		}
+
+		/* Setup for R channel Slot: WR and TR */
+		if (i % 2) {
+			ret = snd_soc_dai_set_channel_map(codec_dai, 0, NULL,
+							  ARRAY_SIZE(rx_ch), rx_ch);
+			if (ret < 0) {
+				dev_err(codec_dai->dev, "fail to set channel map, ret %d\n",
+					ret);
+				return ret;
+			}
+		}
 	}
 
 	return 0;
-- 
2.25.1

