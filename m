Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F9F49C08A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbiAZBSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:18:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:5166 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235667AbiAZBRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159867; x=1674695867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=xZmGpFkcCtXPjWmVmWhZ85WsZ2zk0Q4pSLwBoWfgeT8=;
  b=bGhzR+OkGmmkbhJcyt+FGpD00ZK7JScUf90U6TqtYYI9fjem1fvizZyC
   oVyl0SPkFHkl/mSgYnO+R3sPIbyljnrun1QchzcvuLjFmqwzUGMI/9RMZ
   sXwVuVmDuRbw2UGtFpEZS15aRAJHm9bQKm71sCj1OJhyxrzUqKLgp9NOu
   QQiyo3HdC+alTfv2dZjWVqMArGkxtVDpbZM7lBGS0qzpimx9EelcPNOPt
   R2kiYUj2RhlNEHJCKB+k47BFhP02NDPiQf5/Sqfp2g5wxlwcfX4l5t31D
   99uVG9PAcN0DGTuOqE/q/NGmfKB++33wa2rkrLHPVkxEI66Hs9B8Z81Tb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246236164"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="246236164"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="520617471"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:45 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 07/19] soundwire: stream: add 'slave' prefix for port range checks
Date:   Wed, 26 Jan 2022 09:17:03 +0800
Message-Id: <20220126011715.28204-8-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
References: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We can only check for Slave port ranges, the ports are not defined at
the Master level. Also move the function to the 'slave port' block.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index e3cb55de0d12..c326298a0fe2 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1208,16 +1208,6 @@ static int sdw_config_stream(struct device *dev,
 	return 0;
 }
 
-static int sdw_is_valid_port_range(struct device *dev, int num)
-{
-	if (!SDW_VALID_PORT_RANGE(num)) {
-		dev_err(dev, "SoundWire: Invalid port number :%d\n", num);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int sdw_master_port_alloc(struct sdw_master_runtime *m_rt,
 				 unsigned int num_ports)
 {
@@ -1269,6 +1259,16 @@ static int sdw_slave_port_alloc(struct sdw_slave *slave,
 	return 0;
 }
 
+static int sdw_slave_port_is_valid_range(struct device *dev, int num)
+{
+	if (!SDW_VALID_PORT_RANGE(num)) {
+		dev_err(dev, "SoundWire: Invalid port number :%d\n", num);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int sdw_slave_port_config(struct sdw_slave *slave,
 				 struct sdw_slave_runtime *s_rt,
 				 struct sdw_port_config *port_config)
@@ -1283,7 +1283,7 @@ static int sdw_slave_port_config(struct sdw_slave *slave,
 		 * TODO: Check valid port range as defined by DisCo/
 		 * slave
 		 */
-		ret = sdw_is_valid_port_range(&slave->dev, port_config[i].num);
+		ret = sdw_slave_port_is_valid_range(&slave->dev, port_config[i].num);
 		if (ret < 0)
 			return ret;
 
-- 
2.17.1

