Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2726C53B35C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 08:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiFBGIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 02:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiFBGII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 02:08:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9C9147828
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 23:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654150087; x=1685686087;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FGpXmAX/PMi+Jou3AXg4JhK9EmyKVV1NzWJ2qKBKYJc=;
  b=OuRXo0ZZrKS1vHDxs/GMxjkCwBCwzFaBHOb7nzFs/fnkuzgyQqRnBKE5
   vEcCv8n1bC7yXmmOjW/RH8Zi3ITbUObrX6rZS8U1jfLtgU8NspWLkLbVX
   h+GHLN4SKfCW0rQTO+2AurzsE/ThAl8d8QajeLyPRLRxnoU/YNGMduaZu
   50/PDhrzzE82enEjhqSf3XS3KFcp9r3beyF9ixJHzR1y3v5VnDcNVKyg2
   eNION1SxFAHH3pqXTyHJIqnf/Tu4EvoVqj3VEVt+8UQtaVrEAzvWVmSPP
   pCLc5pFNhPfMFJF0SyAV8FEBOx5c0/mj7SC9XegoQlTnLQvuN7gyj3ytx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275562310"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="275562310"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 23:08:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="606670183"
Received: from yanqingl-mobl1.ccr.corp.intel.com ([10.254.212.10])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 23:08:02 -0700
Message-ID: <352ae5f408b6d7d4d3d820d68e2f2c6b494e95e1.camel@intel.com>
Subject: Re: [RFC PATCH v4 1/7] mm/demotion: Add support for explicit memory
 tiers
From:   Ying Huang <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Greg Thelen <gthelen@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
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
        David Rientjes <rientjes@google.com>
Date:   Thu, 02 Jun 2022 14:07:59 +0800
In-Reply-To: <20220527122528.129445-2-aneesh.kumar@linux.ibm.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
         <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
         <20220527122528.129445-2-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-27 at 17:55 +0530, Aneesh Kumar K.V wrote:
> From: Jagdish Gediya <jvgediya@linux.ibm.com>
> 
> In the current kernel, memory tiers are defined implicitly via a
> demotion path relationship between NUMA nodes, which is created
> during the kernel initialization and updated when a NUMA node is
> hot-added or hot-removed.  The current implementation puts all
> nodes with CPU into the top tier, and builds the tier hierarchy
> tier-by-tier by establishing the per-node demotion targets based
> on the distances between nodes.
> 
> This current memory tier kernel interface needs to be improved for
> several important use cases,
> 
> The current tier initialization code always initializes
> each memory-only NUMA node into a lower tier.  But a memory-only
> NUMA node may have a high performance memory device (e.g. a DRAM
> device attached via CXL.mem or a DRAM-backed memory-only node on
> a virtual machine) and should be put into a higher tier.
> 
> The current tier hierarchy always puts CPU nodes into the top
> tier. But on a system with HBM or GPU devices, the
> memory-only NUMA nodes mapping these devices should be in the
> top tier, and DRAM nodes with CPUs are better to be placed into the
> next lower tier.
> 
> With current kernel higher tier node can only be demoted to selected nodes on the
> next lower tier as defined by the demotion path, not any other
> node from any lower tier.  This strict, hard-coded demotion order
> does not work in all use cases (e.g. some use cases may want to
> allow cross-socket demotion to another node in the same demotion
> tier as a fallback when the preferred demotion node is out of
> space), This demotion order is also inconsistent with the page
> allocation fallback order when all the nodes in a higher tier are
> out of space: The page allocation can fall back to any node from
> any lower tier, whereas the demotion order doesn't allow that.
> 
> The current kernel also don't provide any interfaces for the
> userspace to learn about the memory tier hierarchy in order to
> optimize its memory allocations.
> 
> This patch series address the above by defining memory tiers explicitly.
> 
> This patch adds below sysfs interface which is read-only and
> can be used to read nodes available in specific tier.
> 
> /sys/devices/system/memtier/memtierN/nodelist
> 
> Tier 0 is the highest tier, while tier MAX_MEMORY_TIERS - 1 is the
> lowest tier. The absolute value of a tier id number has no specific
> meaning. what matters is the relative order of the tier id numbers.
> 
> All the tiered memory code is guarded by CONFIG_TIERED_MEMORY.
> Default number of memory tiers are MAX_MEMORY_TIERS(3). All the
> nodes are by default assigned to DEFAULT_MEMORY_TIER(1).
> 
> Default memory tier can be read from,
> /sys/devices/system/memtier/default_tier
> 
> Max memory tier can be read from,
> /sys/devices/system/memtier/max_tiers
> 
> This patch implements the RFC spec sent by Wei Xu <weixugc@google.com> at [1].
> 
> [1] https://lore.kernel.org/linux-mm/CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com/
> 
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

IMHO, we should change the kernel internal implementation firstly, then
implement the kerne/user space interface.  That is, make memory tier
explicit inside kernel, then expose it to user space.

Best Regards,
Huang, Ying


[snip]

