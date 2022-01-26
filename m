Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C0749C085
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiAZBRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:17:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:5135 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235623AbiAZBRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159855; x=1674695855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=3xf4jfiB2XJp4alN6rFXrArNNBQgEJCYpcp1fFvmcbw=;
  b=UaP0AOP1YMAIPy4MlhC/RYP4SmiTtp0K0gXCbJ+HYoeHFGfDO57tDqFY
   qZSV+D1Q8hq1y+OkLvZVIGbJVlGVlS7FQ377GwYB0pbsEEP6CJjqfsO2+
   BnDbMG0BDuEiskhp0C7bikcIcrNAvL50s96Rg1xSF9GbUKVENuMeKMCD/
   rsNFYtsEAcQTl85clYFHpeiq23zxiYigalfVlow6xAEb7OafJGXI2doM6
   KWkEJreFk5EIyHakhPktJ4hq7gQhZHOyrUR1Yg9KT+1OezTUWUJle5Mzu
   C8c8u7i+Xz+gSddgnhYedOPcROpCfRdh0lvq9fhF+zraN0ApwytGF9DYQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246236115"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="246236115"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:35 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="520617352"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:32 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 02/19] soundwire: stream: add slave runtime to list earlier
Date:   Wed, 26 Jan 2022 09:16:58 +0800
Message-Id: <20220126011715.28204-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
References: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

sdw_config_stream() only verifies the compatibility between
information provided by the Slave driver and the stream configuration.

There is no problem if we add the slave runtime to the list earlier.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index a30d0fb4871b..a75d3576bfcf 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1373,21 +1373,12 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 		ret = -ENOMEM;
 		goto stream_error;
 	}
-
-	ret = sdw_config_stream(&slave->dev, stream, stream_config, true);
-	if (ret) {
-		/*
-		 * sdw_release_master_stream will release s_rt in slave_rt_list in
-		 * stream_error case, but s_rt is only added to slave_rt_list
-		 * when sdw_config_stream is successful, so free s_rt explicitly
-		 * when sdw_config_stream is failed.
-		 */
-		kfree(s_rt);
-		goto stream_error;
-	}
-
 	list_add_tail(&s_rt->m_rt_node, &m_rt->slave_rt_list);
 
+	ret = sdw_config_stream(&slave->dev, stream, stream_config, true);
+	if (ret)
+		goto stream_error;
+
 	ret = sdw_slave_port_config(slave, s_rt, port_config, num_ports);
 	if (ret)
 		goto stream_error;
-- 
2.17.1

