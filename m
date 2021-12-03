Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003D1467F57
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354065AbhLCVer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:34:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:15695 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344223AbhLCVel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:34:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="237000624"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="237000624"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 13:31:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="598116251"
Received: from skl-02.jf.intel.com ([10.54.74.28])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Dec 2021 13:31:12 -0800
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
Subject: [PATCH 1/5] scheduler: Create SDTL_SKIP flag to skip topology level
Date:   Fri,  3 Dec 2021 12:32:38 -0800
Message-Id: <d6fe1f8972520f64c7e23d7e72fa298823813c6d.1638563225.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1638563225.git.tim.c.chen@linux.intel.com>
References: <cover.1638563225.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A system admin may not want to use cluster scheduling.  Make changes to
allow cluster topology level to be skipped when building sched domains.

Create SDTL_SKIP bit on the sched_domain_topology_level flag so we can
check if the cluster topology level should be skipped when building
sched domains.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/sched/topology.h |  1 +
 kernel/sched/topology.c        | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index c07bfa2d80f2..a6ad1e02e57a 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -182,6 +182,7 @@ typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
 typedef int (*sched_domain_flags_f)(void);
 
 #define SDTL_OVERLAP	0x01
+#define SDTL_SKIP	0x02
 
 struct sd_data {
 	struct sched_domain *__percpu *sd;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d201a7052a29..ee6b14ad3324 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1652,8 +1652,16 @@ static struct sched_domain_topology_level default_topology[] = {
 static struct sched_domain_topology_level *sched_domain_topology =
 	default_topology;
 
+static struct sched_domain_topology_level *next_tl(struct sched_domain_topology_level *tl)
+{
+	++tl;
+	while (tl->mask && tl->flags & SDTL_SKIP)
+		++tl;
+	return tl;
+}
+
 #define for_each_sd_topology(tl)			\
-	for (tl = sched_domain_topology; tl->mask; tl++)
+	for (tl = sched_domain_topology; tl->mask; tl = next_tl(tl))
 
 void set_sched_topology(struct sched_domain_topology_level *tl)
 {
-- 
2.20.1

