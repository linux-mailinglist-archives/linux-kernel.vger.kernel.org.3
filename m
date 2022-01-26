Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45FD49C089
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiAZBR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:17:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:5135 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235644AbiAZBRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159865; x=1674695865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=jHgJPNa8SPiX6zp1DNPAMTWl+vgD5iiQX0Bg4hGORN0=;
  b=ZJMrHB0vQ4PIc/PB+K/8wRD0/FwCKYqkC4T/bt/xA1sA2Xcx+TIaHGwg
   WW/LwnjnjxT5bTY6Bjq4P9vCqM8YJPMik5W9qSP51HGfToB/ekuRScg7r
   6kqzezOUAnlM8hL8Lfzx4HmM1j6OYhVvl5As/sTImbT9AQ2mc1IPpmtRp
   b2m9RAyECOsE/+qg6eDSBgtdr/nlPSGaiXBRZIRvMfrX3e5n+bRl2Fnpo
   KR0+nmLx+smUjiCFm7XOwnIXgsCc3mcJ6GM/GpmBFlTT7iA1ZGaz7eB9p
   x49OL2cjYx9M0BPf8MoLeLgMFKrpQHLZ50tVPxx5u3ny4AwtV8TLumpH6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246236154"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="246236154"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="520617449"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:42 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 06/19] soundwire: stream: split alloc and config in two functions
Date:   Wed, 26 Jan 2022 09:17:02 +0800
Message-Id: <20220126011715.28204-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
References: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Continue the split with two functions for master and slave, and remove
unused arguments.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 49 ++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index b97c59e71bdb..e3cb55de0d12 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1218,13 +1218,10 @@ static int sdw_is_valid_port_range(struct device *dev, int num)
 	return 0;
 }
 
-static int sdw_master_port_config(struct sdw_bus *bus,
-				  struct sdw_master_runtime *m_rt,
-				  struct sdw_port_config *port_config,
-				  unsigned int num_ports)
+static int sdw_master_port_alloc(struct sdw_master_runtime *m_rt,
+				 unsigned int num_ports)
 {
 	struct sdw_port_runtime *p_rt;
-	int ret;
 	int i;
 
 	/* Iterate for number of ports to perform initialization */
@@ -1234,6 +1231,16 @@ static int sdw_master_port_config(struct sdw_bus *bus,
 			return -ENOMEM;
 	}
 
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
 	i = 0;
 	list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
 		ret = sdw_port_config(p_rt, port_config, i);
@@ -1245,13 +1252,12 @@ static int sdw_master_port_config(struct sdw_bus *bus,
 	return 0;
 }
 
-static int sdw_slave_port_config(struct sdw_slave *slave,
-				 struct sdw_slave_runtime *s_rt,
-				 struct sdw_port_config *port_config,
-				 unsigned int num_config)
+static int sdw_slave_port_alloc(struct sdw_slave *slave,
+				struct sdw_slave_runtime *s_rt,
+				unsigned int num_config)
 {
 	struct sdw_port_runtime *p_rt;
-	int i, ret;
+	int i;
 
 	/* Iterate for number of ports to perform initialization */
 	for (i = 0; i < num_config; i++) {
@@ -1260,6 +1266,17 @@ static int sdw_slave_port_config(struct sdw_slave *slave,
 			return -ENOMEM;
 	}
 
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
 	i = 0;
 	list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
 		/*
@@ -1324,7 +1341,11 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 	if (ret)
 		goto stream_error;
 
-	ret = sdw_master_port_config(bus, m_rt, port_config, num_ports);
+	ret = sdw_master_port_alloc(m_rt, num_ports);
+	if (ret)
+		goto stream_error;
+
+	ret = sdw_master_port_config(m_rt, port_config);
 	if (ret)
 		goto stream_error;
 
@@ -1392,7 +1413,11 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	if (ret)
 		goto stream_error;
 
-	ret = sdw_slave_port_config(slave, s_rt, port_config, num_ports);
+	ret = sdw_slave_port_alloc(slave, s_rt, num_ports);
+	if (ret)
+		goto stream_error;
+
+	ret = sdw_slave_port_config(slave, s_rt, port_config);
 	if (ret)
 		goto stream_error;
 
-- 
2.17.1

