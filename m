Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728A05423E7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbiFHGDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 02:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347127AbiFHF5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:57:45 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A331476BF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 21:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654662019; x=1686198019;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oxqzxeK1ewo+4Ulb0MeKVIGm1F9MiXZOy7Gc3aAjZXc=;
  b=As1jG0MZEyE/yzxRWO+9F3bkaTBk4BZOwaySfvTTS44zIJ/SOUbds9JS
   jua4mZhoxnHM2Xfm2u8wTRc9FhA7/9mVq5wiAXq5rad03Th+psqVEThEQ
   oR727DelpiixJ5Zfa17ZPTiwm+qkVAvmxhJFa213CCh7UDZEjXjMlNZtl
   DaA+Jajhd4AUCwchYMBn3+2RjavunKv7d4ZYxd2a75Xx4rDIGmCm1a/eq
   gDk/wCdgI6ouu386LDBQEa1KIBMkotcSplnEPXKJ1iXlmZJGmE8bNzcsw
   vqai1s8OW4rmT3NUa/ctMb1uxxlMumX26gD2mymLA2NLAMqzg6EWKPLPk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="338518835"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="338518835"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 21:20:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="636540115"
Received: from wantingz-mobl.ccr.corp.intel.com ([10.254.214.193])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 21:19:55 -0700
Message-ID: <dece66a05bb63a04706d25ca86f75bfc875c27fd.camel@intel.com>
Subject: Re: [PATCH] mm: mempolicy: N:M interleave policy for tiered memory
 nodes
From:   Ying Huang <ying.huang@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
Cc:     Hao Wang <haowang3@fb.com>, Abhishek Dhanotia <abhishekd@fb.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Hasan Al Maruf <hasanalmaruf@fb.com>,
        Wei Xu <weixugc@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>
Date:   Wed, 08 Jun 2022 12:19:52 +0800
In-Reply-To: <20220607171949.85796-1-hannes@cmpxchg.org>
References: <20220607171949.85796-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-07 at 13:19 -0400, Johannes Weiner wrote:
> From: Hasan Al Maruf <hasanalmaruf@fb.com>
> 
> Existing interleave policy spreads out pages evenly across a set of
> specified nodes, i.e. 1:1 interleave. Upcoming tiered memory systems
> have CPU-less memory nodes with different peak bandwidth and
> latency-bandwidth characteristics. In such systems, we will want to
> use the additional bandwidth provided by lowtier memory for
> bandwidth-intensive applications. However, the default 1:1 interleave
> can lead to suboptimal bandwidth distribution.
> 
> Introduce an N:M interleave policy, where N pages allocated to the
> top-tier nodes are followed by M pages allocated to lowtier nodes.
> This provides the capability to steer the fraction of memory traffic
> that goes to toptier vs. lowtier nodes. For example, 4:1 interleave
> leads to an 80%/20% traffic breakdown between toptier and lowtier.
> 
> The ratios are configured through a new sysctl:
> 
> 	vm.numa_tier_interleave = toptier lowtier
> 
> We have run experiments on bandwidth-intensive production services on
> CXL-based tiered memory systems, where lowtier CXL memory has, when
> compared to the toptier memory directly connected to the CPU:
> 
> 	- ~half of the peak bandwidth
> 	- ~80ns higher idle latency
> 	- steeper latency vs. bandwidth curve
> 
> Results show that regular interleaving leads to a ~40% performance
> regression over baseline; 5:1 interleaving shows an ~8% improvement
> over baseline. We have found the optimal distribution changes based on
> hardware characteristics: slower CXL memory will shift the optimal
> breakdown from 5:1 to (e.g.) 8:1.
> 
> The sysctl only applies to processes and vmas with an "interleave"
> policy and has no bearing on contexts using prefer or bind policies.
> 
> It defaults to a setting of "1 1", which represents even interleaving,
> and so is backward compatible with existing setups.
> 
> Signed-off-by: Hasan Al Maruf <hasanalmaruf@fb.com>
> Signed-off-by: Hao Wang <haowang3@fb.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

In general, I think the use case is valid.  But we are changing memory
tiering now, including

- make memory tiering explict

- support more than 2 tiers

- expose memory tiering via sysfs

Details can be found int the following threads,

https://lore.kernel.org/lkml/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com/
https://lore.kernel.org/lkml/20220603134237.131362-1-aneesh.kumar@linux.ibm.com/

With these changes, we may need to revise your implementation.  For
example, put interleave knobs in memory tier sysfs interface, support
more than 2 tiers, etc.

Best Regards,
Huang, Ying


[snip]

