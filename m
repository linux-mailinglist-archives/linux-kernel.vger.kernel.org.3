Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1B250F164
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343508AbiDZGrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiDZGrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:47:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8361811A07
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650955434; x=1682491434;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yRyl3S9crOjdQbOExXeqmkPegF+G+uJ5wBkFap/4wW4=;
  b=nB2kvjHhFpso7h7NOQ7XGAixC5rGAf8BHjpt/xYPqv8imBjxlrqlDaCE
   LdG1Wjea9ovp89ctZ7RYs75EESRq0QcSTqHzPJS5m7gv4XYipPynUQsfK
   VY9QMVlSU/Ieo0vdvCtA/8wCTh07ZP+irsR+0MDcoShHx5nAinzh5gy9q
   e7j3xK907bFb3sUTxaB8LEMsPxSrDcpvn7D8pOCA/BvANT4Fr9RXY2nZi
   fL1NwLRLqYLztqMLNJZRXBWn6zA+YFg2cP5ch5/KFJSZiUXY9BNGj7az1
   vDLL1lR+D2s98dmB5ssY6N3ytNo0U7S4nNxKZkYykaq0XHA0igYAR95ns
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="264995774"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="264995774"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 23:43:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="532506571"
Received: from yyu16-mobl.ccr.corp.intel.com ([10.254.212.128])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 23:43:50 -0700
Message-ID: <b63553254c1cea0571582521c72324388636c24e.camel@intel.com>
Subject: Re: [PATCH -V2] sched,topology: Update sched topology atomically
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Valentin Schneider <vschneid@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Date:   Tue, 26 Apr 2022 14:43:45 +0800
In-Reply-To: <xhsmh7d7d9n3y.mognet@vschneid.remote.csb>
References: <20220421003125.195470-1-ying.huang@intel.com>
         <xhsmh7d7d9n3y.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Valentin,

On Mon, 2022-04-25 at 16:52 +0100, Valentin Schneider wrote:
> On 21/04/22 08:31, Huang Ying wrote:
> > When Peter Zijlstra reviewed commit 0fb3978b0aac ("sched/numa: Fix
> > NUMA topology for systems with CPU-less nodes") [1], he pointed out
> > that sched_domains_numa_distance and sched_domains_numa_masks are made
> > separate RCU variables.  That could go side-ways if there were a
> > function using both, although there isn't for now.
> > 
> > So we update sched_domains_numa_distance and sched_domains_numa_masks
> > and some other related sched topology parameters atomically to address
> > the potential issues.
> > 
> > [1] https://lkml.kernel.org/r/20220214121553.582248-1-ying.huang@intel.com
> > 
> > Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Rik van Riel <riel@surriel.com>
> > Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > 
> > Changelog:
> > 
> > v2:
> > 
> > - Addressed comments from Valentin Schneider, Thanks!
> 
> One small bug and a whitespace nit below, with those fixed:
> 
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>

Thanks!  Your review comments help me a lot!

> FWIW I briefly tested this vs hotplug on QEMU.
> 
> > @@ -1806,8 +1873,7 @@ void sched_init_numa(int offline_node)
> > 
> >                       if (distance < LOCAL_DISTANCE || distance >= NR_DISTANCE_VALUES) {
> >                               sched_numa_warn("Invalid distance value range");
> > -				bitmap_free(distance_map);
> > -				return;
> > +                                goto free_bitmap;
> 
> The indentation here is wrong (spaces vs tabs).

Yes.  Will fix in the next version.

> >                       }
> > 
> >                       bitmap_set(distance_map, distance, 1);
> 
> >       /* Compute default topology size */
> >       for (i = 0; sched_domain_topology[i].mask; i++);
> 
> After the original boot this will now be the default topology with the NUMA
> bits on top, so we'll just keep growing the array every time we hotplug a
> node. This should use sched_domain_topology_default instead (ditto for the
> copy loop further down).
> 

Yes.  You are right!  Thanks for pointing this out.  Will fix this in
the next version.

Best Regards,
Huang, Ying

