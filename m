Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D8849C08B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiAZBSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:18:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:5135 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235674AbiAZBRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159872; x=1674695872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=JOSj0p7UUWlQeCOb35AUBPW7MKDklglz0v2cDMR9q8s=;
  b=R5F3XgEuwYvrGoEmZibAmFVEPb/+106Y4kn0aYqjU17IMx63UilmKapS
   WI/RoStgCsbwef0M64psNU1hd4FHAGnnIx2Jhe8LANgmhL5l6D0W2GrIM
   I1d/65NNU74IuHNgy0+VgL2CJs9wavXp/aFsG9qNOW5P2rXrXUHEBrO4v
   hVLyKtOQg43rHJ6MAEztqHdgZJBXBu3vKSQ2zshwmkT2rE8gQnhf0KYrR
   uPAtLxJ78Sdvfq93PyLYZ/YSuf/+h7+0j1lAbWW3Pc/V9WTTkpDy9zGa6
   K+LIpe/Vf3e53lLjYvLZN9rRfsj0gy6AGChHuPlU1UFO2dbLuZJtW15fp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246236175"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="246236175"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="520617494"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:47 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 08/19] soundwire: stream: group sdw_port and sdw_master/slave_port functions
Date:   Wed, 26 Jan 2022 09:17:04 +0800
Message-Id: <20220126011715.28204-9-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
References: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

re-group all the helpers in one location with a code move. For
consistency the 'slave' helpers are placed before the 'master'
helpers.

Also remove unused arguments and rename the 'release' function to
'free' for consistency.

No functional change in this patch.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 242 ++++++++++++++++++-------------------
 1 file changed, 120 insertions(+), 122 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index c326298a0fe2..5e2d29448aaf 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -898,6 +898,123 @@ static void sdw_port_free(struct sdw_port_runtime *p_rt)
 	kfree(p_rt);
 }
 
+static void sdw_slave_port_free(struct sdw_slave *slave,
+				struct sdw_stream_runtime *stream)
+{
+	struct sdw_port_runtime *p_rt, *_p_rt;
+	struct sdw_master_runtime *m_rt;
+	struct sdw_slave_runtime *s_rt;
+
+	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
+		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
+			if (s_rt->slave != slave)
+				continue;
+
+			list_for_each_entry_safe(p_rt, _p_rt,
+						 &s_rt->port_list, port_node) {
+				sdw_port_free(p_rt);
+			}
+		}
+	}
+}
+
+static int sdw_slave_port_alloc(struct sdw_slave *slave,
+				struct sdw_slave_runtime *s_rt,
+				unsigned int num_config)
+{
+	struct sdw_port_runtime *p_rt;
+	int i;
+
+	/* Iterate for number of ports to perform initialization */
+	for (i = 0; i < num_config; i++) {
+		p_rt = sdw_port_alloc(&s_rt->port_list);
+		if (!p_rt)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
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
+static int sdw_slave_port_config(struct sdw_slave *slave,
+				 struct sdw_slave_runtime *s_rt,
+				 struct sdw_port_config *port_config)
+{
+	struct sdw_port_runtime *p_rt;
+	int ret;
+	int i;
+
+	i = 0;
+	list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
+		/*
+		 * TODO: Check valid port range as defined by DisCo/
+		 * slave
+		 */
+		ret = sdw_slave_port_is_valid_range(&slave->dev, port_config[i].num);
+		if (ret < 0)
+			return ret;
+
+		ret = sdw_port_config(p_rt, port_config, i);
+		if (ret < 0)
+			return ret;
+		i++;
+	}
+
+	return 0;
+}
+
+static void sdw_master_port_free(struct sdw_master_runtime *m_rt)
+{
+	struct sdw_port_runtime *p_rt, *_p_rt;
+
+	list_for_each_entry_safe(p_rt, _p_rt, &m_rt->port_list, port_node) {
+		sdw_port_free(p_rt);
+	}
+}
+
+static int sdw_master_port_alloc(struct sdw_master_runtime *m_rt,
+				 unsigned int num_ports)
+{
+	struct sdw_port_runtime *p_rt;
+	int i;
+
+	/* Iterate for number of ports to perform initialization */
+	for (i = 0; i < num_ports; i++) {
+		p_rt = sdw_port_alloc(&m_rt->port_list);
+		if (!p_rt)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int sdw_master_port_config(struct sdw_master_runtime *m_rt,
+				  struct sdw_port_config *port_config)
+{
+	struct sdw_port_runtime *p_rt;
+	int ret;
+	int i;
+
+	i = 0;
+	list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
+		ret = sdw_port_config(p_rt, port_config, i);
+		if (ret < 0)
+			return ret;
+		i++;
+	}
+
+	return 0;
+}
+
 /**
  * sdw_release_stream() - Free the assigned stream runtime
  *
@@ -1022,37 +1139,6 @@ static struct sdw_slave_runtime
 	return s_rt;
 }
 
-static void sdw_master_port_release(struct sdw_bus *bus,
-				    struct sdw_master_runtime *m_rt)
-{
-	struct sdw_port_runtime *p_rt, *_p_rt;
-
-	list_for_each_entry_safe(p_rt, _p_rt, &m_rt->port_list, port_node) {
-		sdw_port_free(p_rt);
-	}
-}
-
-static void sdw_slave_port_release(struct sdw_bus *bus,
-				   struct sdw_slave *slave,
-				   struct sdw_stream_runtime *stream)
-{
-	struct sdw_port_runtime *p_rt, *_p_rt;
-	struct sdw_master_runtime *m_rt;
-	struct sdw_slave_runtime *s_rt;
-
-	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
-		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
-			if (s_rt->slave != slave)
-				continue;
-
-			list_for_each_entry_safe(p_rt, _p_rt,
-						 &s_rt->port_list, port_node) {
-				sdw_port_free(p_rt);
-			}
-		}
-	}
-}
-
 /**
  * sdw_release_slave_stream() - Free Slave(s) runtime handle
  *
@@ -1097,7 +1183,7 @@ static void sdw_release_master_stream(struct sdw_master_runtime *m_rt,
 	struct sdw_slave_runtime *s_rt, *_s_rt;
 
 	list_for_each_entry_safe(s_rt, _s_rt, &m_rt->slave_rt_list, m_rt_node) {
-		sdw_slave_port_release(s_rt->slave->bus, s_rt->slave, stream);
+		sdw_slave_port_free(s_rt->slave, stream);
 		sdw_release_slave_stream(s_rt->slave, stream);
 	}
 
@@ -1126,7 +1212,7 @@ int sdw_stream_remove_master(struct sdw_bus *bus,
 		if (m_rt->bus != bus)
 			continue;
 
-		sdw_master_port_release(bus, m_rt);
+		sdw_master_port_free(m_rt);
 		sdw_release_master_stream(m_rt, stream);
 		stream->m_rt_count--;
 	}
@@ -1153,7 +1239,7 @@ int sdw_stream_remove_slave(struct sdw_slave *slave,
 {
 	mutex_lock(&slave->bus->bus_lock);
 
-	sdw_slave_port_release(slave->bus, slave, stream);
+	sdw_slave_port_free(slave, stream);
 	sdw_release_slave_stream(slave, stream);
 
 	mutex_unlock(&slave->bus->bus_lock);
@@ -1208,94 +1294,6 @@ static int sdw_config_stream(struct device *dev,
 	return 0;
 }
 
-static int sdw_master_port_alloc(struct sdw_master_runtime *m_rt,
-				 unsigned int num_ports)
-{
-	struct sdw_port_runtime *p_rt;
-	int i;
-
-	/* Iterate for number of ports to perform initialization */
-	for (i = 0; i < num_ports; i++) {
-		p_rt = sdw_port_alloc(&m_rt->port_list);
-		if (!p_rt)
-			return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static int sdw_master_port_config(struct sdw_master_runtime *m_rt,
-				  struct sdw_port_config *port_config)
-{
-	struct sdw_port_runtime *p_rt;
-	int ret;
-	int i;
-
-	i = 0;
-	list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
-		ret = sdw_port_config(p_rt, port_config, i);
-		if (ret < 0)
-			return ret;
-		i++;
-	}
-
-	return 0;
-}
-
-static int sdw_slave_port_alloc(struct sdw_slave *slave,
-				struct sdw_slave_runtime *s_rt,
-				unsigned int num_config)
-{
-	struct sdw_port_runtime *p_rt;
-	int i;
-
-	/* Iterate for number of ports to perform initialization */
-	for (i = 0; i < num_config; i++) {
-		p_rt = sdw_port_alloc(&s_rt->port_list);
-		if (!p_rt)
-			return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static int sdw_slave_port_is_valid_range(struct device *dev, int num)
-{
-	if (!SDW_VALID_PORT_RANGE(num)) {
-		dev_err(dev, "SoundWire: Invalid port number :%d\n", num);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int sdw_slave_port_config(struct sdw_slave *slave,
-				 struct sdw_slave_runtime *s_rt,
-				 struct sdw_port_config *port_config)
-{
-	struct sdw_port_runtime *p_rt;
-	int ret;
-	int i;
-
-	i = 0;
-	list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
-		/*
-		 * TODO: Check valid port range as defined by DisCo/
-		 * slave
-		 */
-		ret = sdw_slave_port_is_valid_range(&slave->dev, port_config[i].num);
-		if (ret < 0)
-			return ret;
-
-		ret = sdw_port_config(p_rt, port_config, i);
-		if (ret < 0)
-			return ret;
-		i++;
-	}
-
-	return 0;
-}
-
 /**
  * sdw_stream_add_master() - Allocate and add master runtime to a stream
  *
-- 
2.17.1

