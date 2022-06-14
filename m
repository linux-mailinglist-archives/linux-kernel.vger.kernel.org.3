Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E9C54BD9F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345212AbiFNW0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344400AbiFNW0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:26:16 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9200550E21
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655245574; x=1686781574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1DtxFR7jESUt0Tg8UteAbb/krwgxdAsTgRC8kfkXIEY=;
  b=acxCcwLoL1PZQU88P6J2MFdxse+tTVFE2kNcSyvoZBqsjVnZdyUBh9eX
   G/pQM5d7Ah3BaXXHM316mXlwVQhgLNmxFyNAZI4HENRkbfd2eDzm/ujMb
   j0Xd3HbYH15t6dnvEizbBh6hzefEl9SpC2qb5/cr8BNKfUbxPhay20U5D
   G5Yl17mYO6eclhadne95usyJHjvURTNu2QfpCgFJwuRAvC1ABQugywN6X
   Y53oIRPYCOXjwuV2+GU9OOhGINqVe4E/IgpqsXVUTkNzVSfbLzQX2qI3y
   jab2D/FU5znRSkMhYeyGCHmDiXUPPziiTTfPsBNuy6hsTOqEh3ZB3JNx9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="340422024"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="340422024"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 15:26:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="588724739"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2022 15:26:13 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Tim Chen <tim.c.chen@linux.intel.com>, Wei Xu <weixugc@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: [RFC PATCH 3/3] mm/memory-tiers: Show toptier memory usage for cgroup
Date:   Tue, 14 Jun 2022 15:25:35 -0700
Message-Id: <766f5858d5427c0345a7bd55a16733b39022095c.1655242024.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1655242024.git.tim.c.chen@linux.intel.com>
References: <cover.1655242024.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show toptier memory usage for a cgroup via sysfs:

/sys/fs/cgroup/<group>/memory.toptier
---
 mm/memcontrol.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2f20ec2712b8..5fd1e3b686cd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6205,6 +6205,14 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
 	return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
 }
 
+static u64 memory_toptier_read(struct cgroup_subsys_state *css,
+			       struct cftype *cft)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	return (u64)mem_cgroup_toptier_usage(memcg) * PAGE_SIZE;
+}
+
 static u64 memory_peak_read(struct cgroup_subsys_state *css,
 			    struct cftype *cft)
 {
@@ -6516,6 +6524,11 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = memory_current_read,
 	},
+	{
+		.name = "toptier",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = memory_toptier_read,
+	},
 	{
 		.name = "peak",
 		.flags = CFTYPE_NOT_ON_ROOT,
-- 
2.35.1

