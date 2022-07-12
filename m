Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EAD5711AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 07:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiGLFEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 01:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGLFEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 01:04:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F211183B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657602268; x=1689138268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=74peq7EUXo2TFcTffXqHvB5ZkF60WM+edxb+BhUXwQY=;
  b=eCm1jIRIOox831MIlCCUAezlmXaJoiK/gNP3mZqJITjjOnxxgzjxS//+
   DDXzk1U0Uq5CoM92FCP3kIuHypCiKqIvKwVvMy4CNxWUKMHUCsS3uXO18
   +gw9dSY5ELWgw2TB0fFMTTAlz5rkhZtZsvTJqy1lhj40JJQ0/5ccr3JJP
   2lRaHguDvkQcTxbGXaBgxsv51AkdEyx3KiPowZ1fhtZ+Qse4UIkBoYcrE
   dwfkY9xKoNI+EqCpvtmA81T3DTXORp7NYrodUYlx/2Mz6CdIe7DND1wOi
   /zxZMt3i3Wwk67d6je0F+qh/Ro1GP9vtBeKIDrKyAYIhWgMqogGEEKE+Q
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="346522539"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="346522539"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 22:04:27 -0700
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="922059873"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 22:04:24 -0700
Date:   Tue, 12 Jul 2022 13:04:21 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        lkp@lists.01.org, Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [mm/page_alloc] 2bd8eec68f:
 BUG:sleeping_function_called_from_invalid_context_at_mm/gup.c
Message-ID: <Ys0A1VPFpOnUSBqu@xsang-OptiPlex-9020>
References: <20220613125622.18628-8-mgorman@techsingularity.net>
 <YsFk/qU+QtWun04h@xsang-OptiPlex-9020>
 <20220703132209.875b823d1cb7169a8d51d56d@linux-foundation.org>
 <YsRB3fZHAfik0M/q@xsang-OptiPlex-9020>
 <1d3a26ac-89b3-0211-f8f2-5165ffa732fd@suse.cz>
 <20220708105603.GI27531@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708105603.GI27531@techsingularity.net>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel Gorman, Hi Vlastimil Babka,

thanks a lot for information!
normally we would discard a report if we found there is a new version for a
patch set. however, for this one, we failed to fetch v5 from mailing list.

sorry if any inconvenience.

On Fri, Jul 08, 2022 at 11:56:03AM +0100, Mel Gorman wrote:
> On Thu, Jul 07, 2022 at 11:55:35PM +0200, Vlastimil Babka wrote:
> > On 7/5/22 15:51, Oliver Sang wrote:
> > > Hi Andrew Morton,
> > > 
> > > On Sun, Jul 03, 2022 at 01:22:09PM -0700, Andrew Morton wrote:
> > >> On Sun, 3 Jul 2022 17:44:30 +0800 kernel test robot <oliver.sang@intel.com> wrote:
> > >> 
> > >> > FYI, we noticed the following commit (built with gcc-11):
> > >> > 
> > >> > commit: 2bd8eec68f740608db5ea58ecff06965228764cb ("[PATCH 7/7] mm/page_alloc: Replace local_lock with normal spinlock")
> > >> > url: https://github.com/intel-lab-lkp/linux/commits/Mel-Gorman/Drain-remote-per-cpu-directly/20220613-230139
> > >> > base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
> > >> > patch link: https://lore.kernel.org/lkml/20220613125622.18628-8-mgorman@techsingularity.net
> > >> > 
> > >> 
> > >> Did this test include the followup patch
> > >> mm-page_alloc-replace-local_lock-with-normal-spinlock-fix.patch?
> > > 
> > > no, we just fetched original patch set and test upon it.
> > 
> > It appears you fetched v4, not v5. I noticed it from the threading of your
> > report that was threaded in the v4 thread, and also the github url: above.
> > In v4, pcpu_spin_trylock_irqsave() was missing an unpin, and indeed it's
> > missing in the github branch you were testing:
> > 
> 
> Thanks Vlastimil! This is my fault, I failed to verify that the code in
> my tree, Andrew's tree and what Oliver tested were the same so no wonder I
> could not find where the missing unpin was. I've gone through mm-unstable
> commits be42c869b8e..4143c9b5266 and can confirm that they are now identical
> to my own tree which includes Andrew's fix for the smatch warning that
> Dan reported.
> 
> # git diff HEAD^..mm-pcpspinnoirq-v6r1-mmunstable | wc -l
> 0
> 
> The only difference between my tree and Andrew's is that there is a head
> commit for "mm/page_alloc: Do not disable IRQs for per-cpu allocations"
> which has been put on hold for now.
> 
> -- 
> Mel Gorman
> SUSE Labs
