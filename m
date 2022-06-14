Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172DD54AA14
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353047AbiFNHIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353222AbiFNHIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:08:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B8631901
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655190512; x=1686726512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=GC/A2SjBlztsHvLlZ8tf63JxqBUMLWhTshFRZpzc/hM=;
  b=krT9bU6rZaQEe7UjTPN4ry/sjLYg98N3V0Kio5P7xw9sWxrGV+ILpT23
   Wt5KjBa8slYLxf5CwIUED81Cm2Q6dhHXqVAX8TLr/OBp66Ag73gjtn/nw
   CqFHtyh8JNaJPqIGlQfh/6ppSsaHfapAwMfnKrhjGFUlVHAQWDDk3zx+B
   xSdFXfC8YaNKy7E1LcGiSpR97mAGP8WWlJq/LajMboR3iLxgdl+rJFvdU
   vBQvo+0cdMvCt06T3pmDXP+jqTo7ucb3bhOHaKfSgh0S6Jtgadf/DSkTS
   wPqJ0CdYpzirJ3eDtMA34fRdkiFxWb+1yfHaCsItoDuDExtXFO+KOWJ0g
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258363539"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="258363539"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:08:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="640185936"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:08:29 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 1/2] soundwire: Intel: add trigger callback
Date:   Tue, 14 Jun 2022 15:08:16 +0800
Message-Id: <20220614070817.2508-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220614070817.2508-1-yung-chuan.liao@linux.intel.com>
References: <20220614070817.2508-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
---
 drivers/soundwire/intel.c           | 8 ++++++++
 include/linux/soundwire/sdw_intel.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 505c5ef061e3..2e7c27d303b4 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1004,9 +1004,17 @@ static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct sn
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_intel_link_res *res = sdw->link_res;
 	struct sdw_cdns_dma_data *dma;
 	int ret = 0;
 
+	/* The .trigger callback is used to send required IPC to audio
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
index 67e0d3e750b5..f638707fd712 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -119,6 +119,7 @@ struct sdw_intel_ops {
 			     struct sdw_intel_stream_params_data *params_data);
 	int (*free_stream)(struct device *dev,
 			   struct sdw_intel_stream_free_data *free_data);
+	int (*trigger)(struct snd_soc_dai *dai, int cmd, int stream);
 };
 
 /**
-- 
2.17.1

