Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A97649C092
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbiAZBSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:18:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:5209 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235765AbiAZBSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159892; x=1674695892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=L3Rs5jIAORH1Ru0BztTzuyiSSChTf9LFA+0AV67sWM4=;
  b=QJMI28nuWUyago36lz7/VcghAHz1mTG63gkR4wB+SHiCPX7HG5a0dCdn
   Nv27X3AhNASia9yY6y7dNrsKgfdC7WBqg0Zsz78CQ54Ovw570oIqYSs+L
   dovTTJvPsGLmtWjzXwplDkRyt0YQ8NL9UUY2Bt1yKRzHgOqYfjgHVhIbd
   z0AWz8ViF1vzT8hHC3c8Ioz7NozvpiVDhxq/ZgHtJ0nKJBT7wnAN/GdJD
   Be3sXVpJE4x5WakroEKmFUUjCqfU+laacgQ8GtdRaC+mu+nDyRLRHDcJ2
   JLJAOPBy+NV6EfSd4GPIRPZlrogGgyOcWh4qevEtLi9po1dC/i/acAHcU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246236225"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="246236225"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:18:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="520617637"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:18:06 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 15/19] soundwire: stream: move list addition to sdw_slave_alloc_rt()
Date:   Wed, 26 Jan 2022 09:17:11 +0800
Message-Id: <20220126011715.28204-16-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
References: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Simplify sdw_stream_add_slave() by moving the linked list management
inside of the sdw_slave_alloc_rt_free() helper, this also makes the
alloc/free helpers more symmetrical.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index e57920ee4c55..8a76d6605f93 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1019,11 +1019,13 @@ static int sdw_master_port_config(struct sdw_master_runtime *m_rt,
  * sdw_slave_rt_alloc() - Allocate a Slave runtime handle.
  *
  * @slave: Slave handle
+ * @m_rt: Master runtime handle
  *
  * This function is to be called with bus_lock held.
  */
 static struct sdw_slave_runtime
-*sdw_slave_rt_alloc(struct sdw_slave *slave)
+*sdw_slave_rt_alloc(struct sdw_slave *slave,
+		    struct sdw_master_runtime *m_rt)
 {
 	struct sdw_slave_runtime *s_rt;
 
@@ -1034,6 +1036,8 @@ static struct sdw_slave_runtime
 	INIT_LIST_HEAD(&s_rt->port_list);
 	s_rt->slave = slave;
 
+	list_add_tail(&s_rt->m_rt_node, &m_rt->slave_rt_list);
+
 	return s_rt;
 }
 
@@ -1949,13 +1953,12 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 		goto stream_error;
 
 skip_alloc_master_rt:
-	s_rt = sdw_slave_rt_alloc(slave);
+	s_rt = sdw_slave_rt_alloc(slave, m_rt);
 	if (!s_rt) {
 		dev_err(&slave->dev, "Slave runtime alloc failed for stream:%s\n", stream->name);
 		ret = -ENOMEM;
 		goto stream_error;
 	}
-	list_add_tail(&s_rt->m_rt_node, &m_rt->slave_rt_list);
 
 	ret = sdw_slave_rt_config(s_rt, stream_config);
 	if (ret)
-- 
2.17.1

