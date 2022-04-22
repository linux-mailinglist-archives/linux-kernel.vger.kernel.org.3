Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EA750B097
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444391AbiDVGaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239131AbiDVGan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:30:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600E850B17
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650608871; x=1682144871;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7FKlaBGgHn2LiVjGfAUlft1h9xE8gkk5PntmcCX/1as=;
  b=fryKipwJMtAt66EEM6DT8sLSBNIuNWcgIvfrjMg6VYC3gGx2gsgJdsPs
   baHLQyXG7nPQdunqwE8oW/OzL74DAcr61+/GgkL29iH/ddx2cM9ObFndJ
   1Z2Khpdf9xJzUsWysKpd/z+PtrUO5K7hsgDVnDp1qYsCiRDasSEueCFd1
   xM5t5H++G+cqCU64ojggYHTrxFk5Ks15oPiepWXWT7jWlGjAMhISC9U33
   rAOzab40cFMC9/nPV8MQBvZGM5S0UjcHpayOuQTuHsP4NRM86NPPAykU1
   d/yVNIiw5nUjoNdFKOgV4zZJ2zW2yVlYYG6UAQuX/1GzBuFueKRKAcouo
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264757411"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="264757411"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 23:27:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="530688715"
Received: from jiejingx-mobl1.ccr.corp.intel.com ([10.254.215.31])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 23:27:48 -0700
Message-ID: <4f1bc4dc65117a185833555ff8df30a944453499.camel@intel.com>
Subject: Re: [PATCH] mm: swap: determine swap device by using page nid
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 22 Apr 2022 14:27:45 +0800
In-Reply-To: <YmJKBaq1yj6/iBJ3@ziqianlu-desk1>
References: <20220407020953.475626-1-shy828301@gmail.com>
         <Yk6cutNf5sOuYbDl@ziqianlu-nuc9qn>
         <CAHbLzkq+eKcKCsxXDTiOcBxk8FjMdWBqOxwi4N_NG7PZWbAAkA@mail.gmail.com>
         <Yl/FS9enAD4V8jG3@ziqianlu-nuc9qn>
         <f27ec36beb3cf1dbbfc3b8835e586d5d6fe7f561.camel@intel.com>
         <YmETEHnK/FiNbLO7@ziqianlu-desk1>
         <6f7210be7353d1c01dc9f872b2692b83f87f5452.camel@intel.com>
         <YmJKBaq1yj6/iBJ3@ziqianlu-desk1>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-22 at 14:24 +0800, Aaron Lu wrote:
> On Thu, Apr 21, 2022 at 04:34:09PM +0800, ying.huang@intel.com wrote:
> > On Thu, 2022-04-21 at 16:17 +0800, Aaron Lu wrote:
> > > On Thu, Apr 21, 2022 at 03:49:21PM +0800, ying.huang@intel.com wrote:
> 
> ... ...
> 
> > > > For swap-in latency, we can use pmbench, which can output latency
> > > > information.
> > > > 
> > > 
> > > OK, I'll give pmbench a run, thanks for the suggestion.
> > 
> > Better to construct a senario with more swapin than swapout.  For
> > example, start a memory eater, then kill it later.
> 
> What about vm-scalability/case-swapin?
> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-swapin
> 
> I think you are pretty familiar with it but still:
> 1) it starts $nr_task processes and each mmaps $size/$nr_task area and
>    then consumes the memory, after this, it waits for a signal;
> 2) start another process to consume $size memory to push the memory in
>    step 1) to swap device;
> 3) kick processes in step 1) to start accessing their memory, thus
>    trigger swapins. The metric of this testcase is the swapin throughput.
> 
> I plan to restrict the cgroup's limit to $size.
> 
> Considering there is only one NVMe drive attached to node 0, I will run
> the test as described before:
> 1) bind processes to run on node 0, allocate on node 1 to test the
>    performance when reclaimer's node id is the same as swap device's.
> 2) bind processes to run on node 1, allocate on node 0 to test the
>    performance when page's node id is the same as swap device's.
> 
> Ying and Yang,
> 
> Let me know what you think about the case used and the way the test is
> conducted.

The test case looks good to me.  And, do you have a way to measure swap
in latency?  Better to compare between enabling and disabling per-node
swap device support too to make sure per-node support has performance
impact on this system.

Best Regards,
Huang, Ying


