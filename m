Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF2549C088
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiAZBR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:17:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:5135 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235694AbiAZBRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159862; x=1674695862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=hRyebvpUmOlSx2YqWY7Ev21ywUBSfmUTYJfGzoRDvXo=;
  b=HDzqGu54oNgbeUooTJUOT0W4wf21Bd2LoEBTsuhKHEmbcaJaeuSNuj0Y
   8z9CRJxOFUxs03a/fXBQn4JkJe7IUi5uejAPbbCp5970JRvcB5tEYUMOc
   kCiVeq9IZPQ0uC3TlK30xag4T4UcTl39hDf0ydCF+rnZ412be9PItNrOI
   ahOQ+xs9rDP42pd9kQ2OlH75l6cpsGxXsNpf2QyzTcsemGQakvlWS+w4l
   KcVL8zOab2TLGu1Nn6QQ5MS8uBZrd/NHZQuEwK/jx4i3EGoIaxlfukRys
   MYwuLAHTop/iTlLFSzQpw2Z35AKBRWUsL74Ps040ODYByfqMspaNRj/fd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246236142"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="246236142"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="520617427"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:17:40 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 05/19] soundwire: stream: split port allocation and configuration loops
Date:   Wed, 26 Jan 2022 09:17:01 +0800
Message-Id: <20220126011715.28204-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
References: <20220126011715.28204-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Split loops before moving the allocation and configuration to separate
functions.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 49d3a8d2fa31..b97c59e71bdb 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1232,10 +1232,14 @@ static int sdw_master_port_config(struct sdw_bus *bus,
 		p_rt = sdw_port_alloc(&m_rt->port_list);
 		if (!p_rt)
 			return -ENOMEM;
+	}
 
+	i = 0;
+	list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
 		ret = sdw_port_config(p_rt, port_config, i);
 		if (ret < 0)
 			return ret;
+		i++;
 	}
 
 	return 0;
@@ -1254,7 +1258,10 @@ static int sdw_slave_port_config(struct sdw_slave *slave,
 		p_rt = sdw_port_alloc(&s_rt->port_list);
 		if (!p_rt)
 			return -ENOMEM;
+	}
 
+	i = 0;
+	list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
 		/*
 		 * TODO: Check valid port range as defined by DisCo/
 		 * slave
@@ -1266,6 +1273,7 @@ static int sdw_slave_port_config(struct sdw_slave *slave,
 		ret = sdw_port_config(p_rt, port_config, i);
 		if (ret < 0)
 			return ret;
+		i++;
 	}
 
 	return 0;
-- 
2.17.1

