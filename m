Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533325740E1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 03:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiGNBLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 21:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiGNBLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 21:11:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5527A20BC7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 18:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657761060; x=1689297060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8SMHRnXoeT6L4p7RodtZBZZihIj9AUSv6QZ/I0bJEq0=;
  b=YWxFg1vhZI/JcWCtvSrl4YINa/BGQV5qvDHCtl2eaQn4yyRR3gNchoxR
   ciZQJGpYCWCwY90gTOr0tJiPXUxEy+5JzCcORpiUAYi4LTXOJXFXkCp/q
   RcpLTuFuNGfjY1e/wP2lIyFDll0cipXmBAmgPkn9t6VNugL3j7RBe8ptq
   nf702bcOOF2gglAlC3wt+vFMp8nXIYEB3DeXRsG7nqSYbCNOiBHRaQGyV
   t2ADXb+i4b5ERqSQUI+C85Y4ZexzsF7JJR9D5QL0sEW9L0nSDIm+ZWG/Q
   6VsFMYmo+PoTwDqZlrsrD6BClfZAVW6wGxHP4rN2mNtgIbFR6RhRGoXa8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="282937931"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="282937931"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 18:10:59 -0700
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="593192539"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 18:10:57 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com
Subject: [PATCH 4/4] ASoC: codecs: show PING status on resume failures
Date:   Thu, 14 Jul 2022 09:10:43 +0800
Message-Id: <20220714011043.46059-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714011043.46059-1-yung-chuan.liao@linux.intel.com>
References: <20220714011043.46059-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This helper should help identify cases where devices fall off the bus
and don't resync.

BugLink: https://github.com/thesofproject/linux/issues/3638
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/codecs/max98373-sdw.c   | 2 ++
 sound/soc/codecs/rt1308-sdw.c     | 2 ++
 sound/soc/codecs/rt1316-sdw.c     | 2 ++
 sound/soc/codecs/rt5682-sdw.c     | 2 ++
 sound/soc/codecs/rt700-sdw.c      | 2 ++
 sound/soc/codecs/rt711-sdca-sdw.c | 2 ++
 sound/soc/codecs/rt715-sdca-sdw.c | 2 ++
 sound/soc/codecs/rt715-sdw.c      | 2 ++
 8 files changed, 16 insertions(+)

diff --git a/sound/soc/codecs/max98373-sdw.c b/sound/soc/codecs/max98373-sdw.c
index f47e956d4f55..7bed8e146b78 100644
--- a/sound/soc/codecs/max98373-sdw.c
+++ b/sound/soc/codecs/max98373-sdw.c
@@ -281,6 +281,8 @@ static __maybe_unused int max98373_resume(struct device *dev)
 					   msecs_to_jiffies(MAX98373_PROBE_TIMEOUT));
 	if (!time) {
 		dev_err(dev, "Initialization not complete, timed out\n");
+		sdw_show_ping_status(slave->bus, true);
+
 		return -ETIMEDOUT;
 	}
 
diff --git a/sound/soc/codecs/rt1308-sdw.c b/sound/soc/codecs/rt1308-sdw.c
index 1c11b42dd76e..0049c6c66855 100644
--- a/sound/soc/codecs/rt1308-sdw.c
+++ b/sound/soc/codecs/rt1308-sdw.c
@@ -727,6 +727,8 @@ static int __maybe_unused rt1308_dev_resume(struct device *dev)
 				msecs_to_jiffies(RT1308_PROBE_TIMEOUT));
 	if (!time) {
 		dev_err(&slave->dev, "Initialization not complete, timed out\n");
+		sdw_show_ping_status(slave->bus, true);
+
 		return -ETIMEDOUT;
 	}
 
diff --git a/sound/soc/codecs/rt1316-sdw.c b/sound/soc/codecs/rt1316-sdw.c
index 60baa9ff1907..34ca2b77ee4f 100644
--- a/sound/soc/codecs/rt1316-sdw.c
+++ b/sound/soc/codecs/rt1316-sdw.c
@@ -712,6 +712,8 @@ static int __maybe_unused rt1316_dev_resume(struct device *dev)
 				msecs_to_jiffies(RT1316_PROBE_TIMEOUT));
 	if (!time) {
 		dev_err(&slave->dev, "Initialization not complete, timed out\n");
+		sdw_show_ping_status(slave->bus, true);
+
 		return -ETIMEDOUT;
 	}
 
diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
index 248257a2e4e0..b4e722bb7e25 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -790,6 +790,8 @@ static int __maybe_unused rt5682_dev_resume(struct device *dev)
 				msecs_to_jiffies(RT5682_PROBE_TIMEOUT));
 	if (!time) {
 		dev_err(&slave->dev, "Initialization not complete, timed out\n");
+		sdw_show_ping_status(slave->bus, true);
+
 		return -ETIMEDOUT;
 	}
 
diff --git a/sound/soc/codecs/rt700-sdw.c b/sound/soc/codecs/rt700-sdw.c
index bda594899664..132e60f72c03 100644
--- a/sound/soc/codecs/rt700-sdw.c
+++ b/sound/soc/codecs/rt700-sdw.c
@@ -538,6 +538,8 @@ static int __maybe_unused rt700_dev_resume(struct device *dev)
 				msecs_to_jiffies(RT700_PROBE_TIMEOUT));
 	if (!time) {
 		dev_err(&slave->dev, "Initialization not complete, timed out\n");
+		sdw_show_ping_status(slave->bus, true);
+
 		return -ETIMEDOUT;
 	}
 
diff --git a/sound/soc/codecs/rt711-sdca-sdw.c b/sound/soc/codecs/rt711-sdca-sdw.c
index aaf5af153d3f..d1d8327cf72f 100644
--- a/sound/soc/codecs/rt711-sdca-sdw.c
+++ b/sound/soc/codecs/rt711-sdca-sdw.c
@@ -442,6 +442,8 @@ static int __maybe_unused rt711_sdca_dev_resume(struct device *dev)
 				msecs_to_jiffies(RT711_PROBE_TIMEOUT));
 	if (!time) {
 		dev_err(&slave->dev, "Initialization not complete, timed out\n");
+		sdw_show_ping_status(slave->bus, true);
+
 		return -ETIMEDOUT;
 	}
 
diff --git a/sound/soc/codecs/rt715-sdca-sdw.c b/sound/soc/codecs/rt715-sdca-sdw.c
index 0ecd2948f7aa..796b5e982b8a 100644
--- a/sound/soc/codecs/rt715-sdca-sdw.c
+++ b/sound/soc/codecs/rt715-sdca-sdw.c
@@ -233,6 +233,8 @@ static int __maybe_unused rt715_dev_resume(struct device *dev)
 					   msecs_to_jiffies(RT715_PROBE_TIMEOUT));
 	if (!time) {
 		dev_err(&slave->dev, "Enumeration not complete, timed out\n");
+		sdw_show_ping_status(slave->bus, true);
+
 		return -ETIMEDOUT;
 	}
 
diff --git a/sound/soc/codecs/rt715-sdw.c b/sound/soc/codecs/rt715-sdw.c
index a7b21b03c08b..42b8c176b821 100644
--- a/sound/soc/codecs/rt715-sdw.c
+++ b/sound/soc/codecs/rt715-sdw.c
@@ -551,6 +551,8 @@ static int __maybe_unused rt715_dev_resume(struct device *dev)
 					   msecs_to_jiffies(RT715_PROBE_TIMEOUT));
 	if (!time) {
 		dev_err(&slave->dev, "Initialization not complete, timed out\n");
+		sdw_show_ping_status(slave->bus, true);
+
 		return -ETIMEDOUT;
 	}
 
-- 
2.25.1

