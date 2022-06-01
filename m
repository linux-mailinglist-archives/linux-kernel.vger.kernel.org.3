Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7AC539D0E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 08:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243740AbiFAGMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 02:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbiFAGMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 02:12:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4140F554AA
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 23:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654063950; x=1685599950;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ejk+xQ9b0k0wC9j8WfBHQoNfMzyyS5YZ0KCtVf4OBQw=;
  b=GH5EMaLPQFiM8BNsSkrnQdfqfrjAS76V8CwkAGFg7p1TpMAd9KXeVYsh
   jKhyCpCrl8yebMrb3RJG+D8GUAGcr0B/AiQYaAuz2mnW+9H6EJBN96JO7
   DO+32BYeJDd1cR8L+epRnS7IMa1pfyztk4Mwa02sFbk5P05WvQe9AtW4D
   Bbi5aRb/vTCraLYdlDxB72xNZ5ol7b3Y8Lqx5Yr1aOZdtRuHJSk9BbY4+
   9NCYC5FmyW+RBzjX8MQWLOhqV5/IVHMXhuI3lSPyHdnqQWQAhA6+rpDa6
   JUyc1V10uv3UEfb2RZQ7r9wta9zl/xAY3g+HfP9l3+F8l7i9X7j1jWbvo
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="255962236"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="255962236"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 23:12:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="606087592"
Received: from liangqiz-mobl.ccr.corp.intel.com ([10.254.214.157])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 23:12:25 -0700
Message-ID: <61c47f98b4c0be1d5da5e097779412f9edd70753.camel@intel.com>
Subject: Re: [PATCH 2/6] mm/vmscan: use node_is_toptier helper in
 node_reclaim
From:   Ying Huang <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-mm@kvack.org,
        Wei Xu <weixugc@google.com>
Cc:     mhocko@kernel.org, akpm@linux-foundation.org, rientjes@google.com,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        dave.hansen@linux.intel.com, tim.c.chen@linux.intel.com,
        roman.gushchin@linux.dev, gthelen@google.com,
        a.manzanares@samsung.com, heekwon.p@samsung.com,
        gim.jongmin@samsung.com, linux-kernel@vger.kernel.org
Date:   Wed, 01 Jun 2022 14:12:22 +0800
In-Reply-To: <87h755dip9.fsf@linux.ibm.com>
References: <20220416053902.68517-1-dave@stgolabs.net>
         <20220416053902.68517-3-dave@stgolabs.net> <87h755dip9.fsf@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-31 at 17:20 +0530, Aneesh Kumar K.V wrote:
> Davidlohr Bueso <dave@stgolabs.net> writes:
> 
> > We have helpers for a reason.
> > 
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > ---
> >  mm/vmscan.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 1678802e03e7..cb583fcbf5bf 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -4750,7 +4750,7 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
> >  	 * over remote processors and spread off node memory allocations
> >  	 * as wide as possible.
> >  	 */
> > -	if (node_state(pgdat->node_id, N_CPU) && pgdat->node_id != numa_node_id())
> > +	if (node_is_toptier(pgdat->node_id) && pgdat->node_id != numa_node_id())
> >  		return NODE_RECLAIM_NOSCAN;
> >  
> > 
> >  	if (test_and_set_bit(PGDAT_RECLAIM_LOCKED, &pgdat->flags))
> 
> 
> Are we really looking at the top tier in a tiered memory hierarchy here?
> The comment seems to suggest we are looking at local NUMA node?

The code change itself is correct.  But it is an implementation details
that node_is_toptier() == node_state(, N_CPU).  And after we supporting
more memory tiers (like GPU, HBM), we will change the implementation of
node_is_toptier() soon.   So I think that it's better to keep the
original code.

Best Regards,
Huang, Ying


