Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317F154BD9C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245277AbiFNW0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 18:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbiFNW0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 18:26:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE8F4D616
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 15:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655245566; x=1686781566;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V/U0UGWsGGGf1nHKbOmX9I1mE/XGx/BcO0xINFHGrNA=;
  b=JtL8Am0bLdcxGyd+w9a11/2AXAXUm8e4r6YOGSpKUWJow69pRv86kfke
   H8P5dAF6cOkAg5hOvxieWVjAgb3qp6W95yO8FNtZEGuUTzdZN3EZN31f5
   2vV+nDLw6xqSjiN7JMEDfAZGSR8+qSGxg/OsHn6Gz8Drg8djzVydFsk9W
   dyd1uA3y8UywmEA6a0QQNpwX1FzUJCaZejfXeYYxnbVpvA4EyBdSQdeIU
   Z1lhfcpXnvQ+jIu7PdFcttAdHseuZ/EBQJl8F3qofFRkNilLMmnvZBY4T
   YJV4NUnA3C1Yv/2NJ2WTvnkJs5hXCwRYStxHjf/15LOlTdcEqYHnDrlC+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="259217320"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="259217320"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 15:26:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="588724624"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2022 15:26:05 -0700
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
Subject: [RFC PATCH 0/3] Cgroup accounting of memory tier usage 
Date:   Tue, 14 Jun 2022 15:25:32 -0700
Message-Id: <cover.1655242024.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
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

For controlling usage of a top tiered memory by a cgroup, accounting
of top tier memory usage is needed.  This patch set implements the
following:

Patch 1 introduces interface and simple implementation to retrieve
	cgroup tiered memory usage
Patch 2 introduces more efficient accounting with top tier memory page counter 
Patch 3 provides a sysfs interface to repot the the top tiered memory
	usage.

The patchset works with Aneesh's v6 memory-tiering implementation [1].
It is a preparatory patch set before introducing features to
control top tiered memory in cgroups.

I'll like to first get feedback to see if 
(1) Controllng the topmost tiered memory is enough 
or
(2) Multiple tiers at the top levels need to be grouped into "toptier"
or
(3) There are use cases not covered by (1) and (2). 

Thanks.

Tim

[1] https://lore.kernel.org/linux-mm/20220610135229.182859-1-aneesh.kumar@linux.ibm.com/ 

Tim Chen (3):
  mm/memory-tiers Add functions for tier memory usage in a cgroup
  mm/memory-tiers: Use page counter to track toptier memory usage
  mm/memory-tiers: Show toptier memory usage for cgroup

 include/linux/memcontrol.h   |  1 +
 include/linux/memory-tiers.h |  2 +
 mm/memcontrol.c              | 86 +++++++++++++++++++++++++++++++++++-
 mm/memory-tiers.c            |  3 +-
 4 files changed, 89 insertions(+), 3 deletions(-)

-- 
2.35.1

