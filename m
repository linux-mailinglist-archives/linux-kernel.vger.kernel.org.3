Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D097749C086
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbiAZBRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:17:49 -0500
Received: from mga09.intel.com ([134.134.136.24]:5135 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235637AbiAZBRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159857; x=1674695857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=7Vi0ipWt+SE4d8d/Oad96LsqbZ3AwLIRa7/Y3EQ/lyM=;
  b=R2Zvb547bjfpnbOKFVsT3AHmj/Don/DmJLOlme54kSGysTvNYUmd0vI0
   K77IY5rMDmwWuVHAXr/Mffu94LP0fVc3HKh0bDAKk3Uz2Rme7o/GqK4Gu
   6mbYuslIl85TjqlQhWxHDmScIRa3Kdza+bvZm8o16dc8Q9Q/COVn5u1xI
   OP7RaJdbD5tDCeHAptjwcaPTNt6LpQI7P4GRUXz3YkPfKi+z/+iUYrpD1
   ppn5xy+bTTMhuvVrFwgbqUMtVOgiXoKk0CWDi4uYkX3Y4C48/kUdtpOIv
   ZyJXRRs5ux2uRk0iZU0cvH3ZI217Yhepu5UQZQUi2/x4rMRf6yDWbIys+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246236128"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="246236128"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="520617385"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:35 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 03/19] soundwire: stream: simplify check on port range
Date:   Wed, 26 Jan 2022 09:16:59 +0800
Message-Id: <20220126011715.28204-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
References: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Pass the index directly to sdw_is_valid_port_range(), this will be
useful for further simplifications.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index a75d3576bfcf..3ac2e5a66700 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1177,12 +1177,10 @@ static int sdw_config_stream(struct device *dev,
 	return 0;
 }
 
-static int sdw_is_valid_port_range(struct device *dev,
-				   struct sdw_port_runtime *p_rt)
+static int sdw_is_valid_port_range(struct device *dev, int num)
 {
-	if (!SDW_VALID_PORT_RANGE(p_rt->num)) {
-		dev_err(dev,
-			"SoundWire: Invalid port number :%d\n", p_rt->num);
+	if (!SDW_VALID_PORT_RANGE(num)) {
+		dev_err(dev, "SoundWire: Invalid port number :%d\n", num);
 		return -EINVAL;
 	}
 
@@ -1249,7 +1247,7 @@ static int sdw_slave_port_config(struct sdw_slave *slave,
 		 * TODO: Check valid port range as defined by DisCo/
 		 * slave
 		 */
-		ret = sdw_is_valid_port_range(&slave->dev, p_rt);
+		ret = sdw_is_valid_port_range(&slave->dev, port_config[i].num);
 		if (ret < 0) {
 			kfree(p_rt);
 			return ret;
-- 
2.17.1

