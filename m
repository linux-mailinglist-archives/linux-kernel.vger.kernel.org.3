Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FB649C084
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbiAZBRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:17:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:5135 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235611AbiAZBRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159853; x=1674695853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=r96d366BOZOklC6E0TxFNatMgTAwkA3B2SyQlBSc03c=;
  b=FBLREh3MDHpwXJdRBdsc44dIvFJcqxuWtFLSIwa6AkLBPGyNobxgGKQu
   htpfr59KvmE5XTZE+AQXhHbfQYF2/kN87QQUXm3s5qqs2OwDWM4hxNSMZ
   nka30p1Wmz0RcoLR9kR1KNiu22MBJPltxlq8qqCt43PtOjR+juV+o0D/o
   r2Ip/uJZTOqVrwuWyb9Cjump2nnD5puKyASoRA4PqspVbQ7Oxpaj8EDuF
   w3Ku+vzBWpvuMbmfm4w1DwNPdpAHqaZ7BSsjo1w6Ac8bTUAlT4mR2OWiB
   SM5brL3nZPe53xdOukEnYflo6bRRgUJsKaLbNAXsnTFMabvK9XoHfC4JG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246236109"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="246236109"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="520617318"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:30 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 01/19] soundwire: stream: remove unused parameter in sdw_stream_add_slave
Date:   Wed, 26 Jan 2022 09:16:57 +0800
Message-Id: <20220126011715.28204-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
References: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The stream parameter is not used, remove before further simplifications.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 980f26d49b66..a30d0fb4871b 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -968,14 +968,12 @@ static struct sdw_master_runtime
  *
  * @slave: Slave handle
  * @stream_config: Stream configuration
- * @stream: Stream runtime handle
  *
  * This function is to be called with bus_lock held.
  */
 static struct sdw_slave_runtime
 *sdw_alloc_slave_rt(struct sdw_slave *slave,
-		    struct sdw_stream_config *stream_config,
-		    struct sdw_stream_runtime *stream)
+		    struct sdw_stream_config *stream_config)
 {
 	struct sdw_slave_runtime *s_rt;
 
@@ -1367,7 +1365,7 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 		goto error;
 	}
 
-	s_rt = sdw_alloc_slave_rt(slave, stream_config, stream);
+	s_rt = sdw_alloc_slave_rt(slave, stream_config);
 	if (!s_rt) {
 		dev_err(&slave->dev,
 			"Slave runtime config failed for stream:%s\n",
-- 
2.17.1

