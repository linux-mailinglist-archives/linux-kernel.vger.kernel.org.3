Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323A3467F5A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383280AbhLCVey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:34:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:15701 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353990AbhLCVen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:34:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="237000628"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="237000628"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 13:31:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="598116279"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Dec 2021 13:31:16 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Song Bao Hua <song.bao.hua@hisilicon.com>,
        yangyicong <yangyicong@huawei.com>,
        Michael Larabel <Michael@MichaelLarabel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] scheduler: Add boot time enabling/disabling of cluster scheduling
Date:   Fri,  3 Dec 2021 12:32:41 -0800
Message-Id: <41bf195de9d387ea58c030aec4eaaa8686c9cbb1.1638563225.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1638563225.git.tim.c.chen@linux.intel.com>
References: <cover.1638563225.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add boot time parameter sched_cluster to enable or disable cluster
scheduling.  Set boot parameter as follow:

	sched_cluster=0 disables cluster scheduling
	sched_cluster=1 enables cluster scheduling

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 kernel/sched/topology.c                         | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9725c546a0d4..40ad997430e1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5023,6 +5023,10 @@
 
 	sched_verbose	[KNL] Enables verbose scheduler debug messages.
 
+	sched_cluster=  Enable or disable cluster scheduling.
+			0 -- disable.
+			1 -- enable.
+
 	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
 			Allowed values are enable and disable. This feature
 			incurs a small amount of overhead in the scheduler
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index e362bba29f95..087854d505f7 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1697,6 +1697,22 @@ int sched_cluster_handler(struct ctl_table *table, int write,
 
 	return ret;
 }
+
+static int __init sched_cluster_option(char *str)
+{
+	int enable;
+
+	if (get_option(&str, &enable)) {
+		if (enable != 0 && enable != 1)
+			return -EINVAL;
+
+		sysctl_sched_cluster = enable;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+early_param("sched_cluster", sched_cluster_option);
 #endif
 
 static struct sched_domain_topology_level *next_tl(struct sched_domain_topology_level *tl)
-- 
2.20.1

