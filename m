Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E26249C096
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbiAZBSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:18:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:5209 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235637AbiAZBSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159912; x=1674695912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=tEU3JXFvTcLnvhlyRCwxkBFoGoHR5/y8RfltTRrDs3Q=;
  b=HEZZH0+LfgArjavSBXTCRQwg/7WyV6xIbrovAACY7ZQKvP84bCfM0TQI
   0pZ1AkfIInUwvgLDXEWypBEkZuUF5wqQvwivA7WYnqJP4ZZeSu2gQ7Sry
   wWg34jSquk9rs4ntzKhv/WUBJ42EV0/Ky/0w6W47Xh794Ku850OR8PpJx
   YG3ylZwYdoYGdRMM2npUuDMHB8KlkuEXKikuz09xi7v2tCXGRgRJiTzfS
   9F8beNkXjaqH0Qyw1ttMAKypXcjgRtERB6ea8hNK33mgBGTEZHLWw7QYf
   3WilNvb5GNlimKEKiYJd0FGVGH02gtya0s0nxEiOtBy3bb15Wmlb0kh1k
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246236250"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="246236250"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:18:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="520617661"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:18:14 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 18/19] soundwire: stream: sdw_stream_add_ functions can be called multiple times
Date:   Wed, 26 Jan 2022 09:17:14 +0800
Message-Id: <20220126011715.28204-19-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
References: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The sdw_stream_add_slave/master() functions are called from the
.hw_params stage. We need to make sure the functions can be called
multiple times.

In this version, we assume that only 'audio' parameters provide in the
hw_params() can change. If the number of ports could change
dynamically depending on the stream configuration (number of channels,
etc), we would need to free-up all the stream resources and reallocate
them.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index a52a9ab0eea1..ccf3c99dd579 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -898,6 +898,11 @@ static void sdw_port_free(struct sdw_port_runtime *p_rt)
 	kfree(p_rt);
 }
 
+static bool sdw_slave_port_allocated(struct sdw_slave_runtime *s_rt)
+{
+	return !list_empty(&s_rt->port_list);
+}
+
 static void sdw_slave_port_free(struct sdw_slave *slave,
 				struct sdw_stream_runtime *stream)
 {
@@ -972,6 +977,11 @@ static int sdw_slave_port_config(struct sdw_slave *slave,
 	return 0;
 }
 
+static bool sdw_master_port_allocated(struct sdw_master_runtime *m_rt)
+{
+	return !list_empty(&m_rt->port_list);
+}
+
 static void sdw_master_port_free(struct sdw_master_runtime *m_rt)
 {
 	struct sdw_port_runtime *p_rt, *_p_rt;
@@ -1856,12 +1866,17 @@ int sdw_stream_add_master(struct sdw_bus *bus,
 	}
 skip_alloc_master_rt:
 
+	if (sdw_master_port_allocated(m_rt))
+		goto skip_alloc_master_port;
+
 	ret = sdw_master_port_alloc(m_rt, num_ports);
 	if (ret)
 		goto alloc_error;
 
 	stream->m_rt_count++;
 
+skip_alloc_master_port:
+
 	ret = sdw_master_rt_config(m_rt, stream_config);
 	if (ret < 0)
 		goto unlock;
@@ -1970,6 +1985,10 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 	}
 
 skip_alloc_master_rt:
+	s_rt = sdw_slave_rt_find(slave, stream);
+	if (s_rt)
+		goto skip_alloc_slave_rt;
+
 	s_rt = sdw_slave_rt_alloc(slave, m_rt);
 	if (!s_rt) {
 		dev_err(&slave->dev, "Slave runtime alloc failed for stream:%s\n", stream->name);
@@ -1978,10 +1997,15 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
 		goto alloc_error;
 	}
 
+skip_alloc_slave_rt:
+	if (sdw_slave_port_allocated(s_rt))
+		goto skip_port_alloc;
+
 	ret = sdw_slave_port_alloc(slave, s_rt, num_ports);
 	if (ret)
 		goto alloc_error;
 
+skip_port_alloc:
 	ret =  sdw_master_rt_config(m_rt, stream_config);
 	if (ret)
 		goto unlock;
-- 
2.17.1

