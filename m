Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CC55740DD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 03:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiGNBK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 21:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiGNBKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 21:10:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ED8201A3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 18:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657761055; x=1689297055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=64zHAd0VO/In2o8u2a2F5KFDhUcSaQ7u0ws37chHb6o=;
  b=F4GNPwOdq/XrbfRZslMVkzlZ2+4mxPEUUGCG1BbCyPooMDKxCF+xh4jn
   nmxF2qOvyv2mqhVftCzXrrLB7dF/7o0zodSt3JMEDxdhWkApRalFieQbU
   uAkbU4E7AhXMvrNdo9yfneYlL/1FcEVfdfUjAjtHVwWAUCqjzx7c2oJ5Q
   LCnQtfEFFzynRYM1ajRcN8OOS0epmXoiw9st0EGG0uJ420s3hLT0G8f7N
   3+Au9fWXz2ezv1NcCyEOjzg6ml97R4X2SPDOQGetxYCW5XRDhNDovVeur
   FKnHKJOF/TNZEHzYMGCW45Q+LaY9FS8/oskyIXa5jLMg9wAVgxvD9xKId
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="282937916"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="282937916"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 18:10:55 -0700
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="593192522"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 18:10:52 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
        bard.liao@intel.com
Subject: [PATCH 2/4] soundwire: intel/cadence: expose PING status in manager ops
Date:   Thu, 14 Jul 2022 09:10:41 +0800
Message-Id: <20220714011043.46059-3-yung-chuan.liao@linux.intel.com>
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

Simple indirection to existing register.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 8 ++++++++
 drivers/soundwire/cadence_master.h | 2 ++
 drivers/soundwire/intel.c          | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 4fbb19557f5e..615b0b63a3e1 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -756,6 +756,14 @@ cdns_reset_page_addr(struct sdw_bus *bus, unsigned int dev_num)
 }
 EXPORT_SYMBOL(cdns_reset_page_addr);
 
+u32 cdns_read_ping_status(struct sdw_bus *bus)
+{
+	struct sdw_cdns *cdns = bus_to_cdns(bus);
+
+	return cdns_readl(cdns, CDNS_MCP_SLAVE_STAT);
+}
+EXPORT_SYMBOL(cdns_read_ping_status);
+
 /*
  * IRQ handling
  */
diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 595d72c15d97..ca9e805bab88 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -177,6 +177,8 @@ enum sdw_command_response
 cdns_xfer_msg_defer(struct sdw_bus *bus,
 		    struct sdw_msg *msg, struct sdw_defer *defer);
 
+u32 cdns_read_ping_status(struct sdw_bus *bus);
+
 int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params);
 
 int cdns_set_sdw_stream(struct snd_soc_dai *dai,
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 25b27cd1be1d..e1e943396e36 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1255,6 +1255,7 @@ static struct sdw_master_ops sdw_intel_ops = {
 	.set_bus_conf = cdns_bus_conf,
 	.pre_bank_switch = intel_pre_bank_switch,
 	.post_bank_switch = intel_post_bank_switch,
+	.read_ping_status = cdns_read_ping_status,
 };
 
 static int intel_init(struct sdw_intel *sdw)
-- 
2.25.1

