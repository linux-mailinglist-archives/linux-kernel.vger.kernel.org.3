Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B0456B292
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 08:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbiGHGNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 02:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237249AbiGHGNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:13:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3DE28715
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 23:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657260805; x=1688796805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=CbaOVcWxuYtKb9VQz1JziVwNeJk78hde01+2gM0jJ4w=;
  b=Ew/bZGjb9YaJRvaDufGuN3Z3nPhcNpBky0IKdDhFZayUXRqqGu+/Iyzv
   wvShJ4aWzx/ATdiwTrau0Sw48jKxupwcNTOSZVXZKY9tjfPZh2J1O0Ah/
   o3k5cLA6kX5bMGNMECzQ9i1t3sSoFg512zzq6bjpyKkTykkgw2hrOHVzd
   KatA87x+681GB6RghAn6tBDfq72MgCs47+xeCxjlqDMsl5qkv1fmb8oUJ
   xFfWGM0o8jhpy+l4Y1UIV2TAQ3mL1UjEldBwOza43p3OBagzK2j5e5JWp
   78WVBrozKl8qX51qN4VBWvHfILRuoYSnmVArTYPb3WijY4a7DFxrnLJvU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="267232762"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="267232762"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 23:13:25 -0700
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="651440349"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 23:13:22 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [RESEND PATCH v3 1/2] soundwire: Intel: add trigger callback
Date:   Fri,  8 Jul 2022 14:13:11 +0800
Message-Id: <20220708061312.25878-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220708061312.25878-1-yung-chuan.liao@linux.intel.com>
References: <20220708061312.25878-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a pipeline is split into FE and BE parts, the BE pipeline may need to
be triggered separately in the BE trigger op. So add the trigger callback
in the link_res ops that will be invoked during BE DAI trigger.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/intel.c           | 9 +++++++++
 include/linux/soundwire/sdw_intel.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 0268fa527c0c..fed6418d6375 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1004,9 +1004,18 @@ static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct sn
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_intel_link_res *res = sdw->link_res;
 	struct sdw_cdns_dma_data *dma;
 	int ret = 0;
 
+	/*
+	 * The .trigger callback is used to send required IPC to audio
+	 * firmware. The .free_stream callback will still be called
+	 * by intel_free_stream() in the TRIGGER_SUSPEND case.
+	 */
+	if (res->ops && res->ops->trigger)
+		res->ops->trigger(dai, cmd, substream->stream);
+
 	dma = snd_soc_dai_get_dma_data(dai, substream);
 	if (!dma) {
 		dev_err(dai->dev, "failed to get dma data in %s\n",
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index b5b489ea1aef..ec16ae49e6a4 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -121,6 +121,7 @@ struct sdw_intel_ops {
 			     struct sdw_intel_stream_params_data *params_data);
 	int (*free_stream)(struct device *dev,
 			   struct sdw_intel_stream_free_data *free_data);
+	int (*trigger)(struct snd_soc_dai *dai, int cmd, int stream);
 };
 
 /**
-- 
2.17.1

