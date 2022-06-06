Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6159453DFEB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 05:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349629AbiFFDLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 23:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiFFDLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 23:11:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31ED4F460
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 20:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654485091; x=1686021091;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I0QdHF0IW1vsI3ZsPfW1ZXjzy87HEMICXcGVm9Da8ds=;
  b=YcGrJvhWHxe7TLmXKZ53x8003e4CGbBg/6rAlCaN4ahRSwv07A91n3Ty
   KLcT9LsKRYZumz1csuAsyIHXamky2TlcYPKjTX5ENI5ZbM3xl09UAuhNF
   Cwc7xNHNAVFC/B/BHS0zSCJFZ6CAu+bldTxpOlKO4F9F7286cf5Yu00J6
   Dpx0Rttw8O6KTGHoj3XIT69vGycUayxGrYox5NZl0WwdsImkKREwweWzB
   8TN8CEMLvCufNRFQ6lkwmDhfY+9LHlDCgW7j/EWoPcORwqTeBNOW5ARA4
   9/rZ6Lp7gsapQ8NEAW+G8Bf1rwX2WIkEoZRbExWXgeTX+sgdsN6VlGvBn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="274153848"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="274153848"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 20:11:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635369779"
Received: from xingguom-mobl.ccr.corp.intel.com ([10.254.213.116])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 20:11:26 -0700
Message-ID: <6e94b7e2a6192e4cacba1db3676b5b5cf9b98eac.camel@intel.com>
Subject: Re: [PATCH v5 9/9] mm/demotion: Update node_is_toptier to work with
 memory tiers
From:   Ying Huang <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
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
Date:   Mon, 06 Jun 2022 11:11:23 +0800
In-Reply-To: <20220603134237.131362-10-aneesh.kumar@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
         <20220603134237.131362-10-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
> With memory tiers support we can have memory on NUMA nodes
> in the top tier from which we want to avoid promotion tracking NUMA
> faults. Update node_is_toptier to work with memory tiers. To
> avoid taking locks, a nodemask is maintained for all demotion
> targets. All NUMA nodes are by default top tier nodes and as
> we add new lower memory tiers NUMA nodes get added to the
> demotion targets thereby moving them out of the top tier.

Check the usage of node_is_toptier(),

- migrate_misplaced_page()
  node_is_toptier() is used to check whether migration is a promotion. 
We can avoid to use it.  Just compare the rank of the nodes.

- change_pte_range() and change_huge_pmd()
  node_is_toptier() is used to avoid scanning fast memory (DRAM) pages
for promotion.  So I think we should change the name to node_is_fast()
as follows,

static inline bool node_is_fast(int node)
{
	return NODE_DATA(node)->mt_rank >= MEMORY_RANK_DRAM;
}

And, as above, I suggest to add memory tier ID and rank to struct
pglist_data directly.

Best Regards,
Huang, Ying

