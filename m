Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC7C49C07B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 02:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiAZBPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 20:15:41 -0500
Received: from mga11.intel.com ([192.55.52.93]:8046 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235581AbiAZBPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 20:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159739; x=1674695739;
  h=from:to:cc:subject:date:message-id;
  bh=4ie7NmQiHe1ezeLtR9C2w+62rfFvkBb3pIYs6EglC0g=;
  b=hxzm8hxnHvZ9+VnU9qZkzoRT/OI5HAcne6mp5LDvnk/OUz4PZAcmZsVv
   9oyZ9gCIWyB65Ff5QX6TxKMTZyFG9SKR7lVR8Keno0K5wHX2dIAMmOUQ/
   PragjPhd+nVPqVfnzJEIHLKIPjUC9mZSSr/gzGkTM05q7PrxeycpOn3q5
   5QWdUUipZ65KmnK0X27vZvc7tKckh1iaIIeE72IZCUa1CeGm7kDp/8lm0
   GdFmfZIlT0GiNCoLAfcH2oE/wTIHleG/5zdPd4cIWdSzhTBEZrhZlneDu
   ZRtcpTsGjMks6exqNSAuNCzyF3tc7naoV7P1x4ckJPlxYKmARZ7t9OvXF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="244054443"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="244054443"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:15:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="520616673"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:15:35 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH] soundwire: bus: add dev_warn() messages to track UNATTACHED devices
Date:   Wed, 26 Jan 2022 09:15:27 +0800
Message-Id: <20220126011527.27930-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

In rare cases, some devices seem to lose sync and never re-attach on
the bus. This seems to happen only when there are more than one device
per link, which suggests either an electrical issue, a race condition
or a state machine issue.

Add two dev_warn() messages to identify the sequence by which the
devices become UNATTACHED.

BugLink: https://github.com/thesofproject/linux/issues/3063
BugLink: https://github.com/thesofproject/linux/issues/3325
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 67369e941d0d..354d3f89366f 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1749,8 +1749,11 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 			continue;
 
 		if (status[i] == SDW_SLAVE_UNATTACHED &&
-		    slave->status != SDW_SLAVE_UNATTACHED)
+		    slave->status != SDW_SLAVE_UNATTACHED) {
+			dev_warn(&slave->dev, "Slave %d state check1: UNATTACHED, status was %d\n",
+				 i, slave->status);
 			sdw_modify_slave_status(slave, SDW_SLAVE_UNATTACHED);
+		}
 	}
 
 	if (status[0] == SDW_SLAVE_ATTACHED) {
@@ -1785,6 +1788,9 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 			if (slave->status == SDW_SLAVE_UNATTACHED)
 				break;
 
+			dev_warn(&slave->dev, "Slave %d state check2: UNATTACHED, status was %d\n",
+				 i, slave->status);
+
 			sdw_modify_slave_status(slave, SDW_SLAVE_UNATTACHED);
 			break;
 
-- 
2.17.1

