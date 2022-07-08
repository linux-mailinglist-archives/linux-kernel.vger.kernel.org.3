Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A61056B7CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbiGHK4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbiGHK4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:56:09 -0400
Received: from outbound-smtp12.blacknight.com (outbound-smtp12.blacknight.com [46.22.139.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769B48737F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 03:56:07 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id 091421C3A87
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 11:56:06 +0100 (IST)
Received: (qmail 27842 invoked from network); 8 Jul 2022 10:56:05 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Jul 2022 10:56:05 -0000
Date:   Fri, 8 Jul 2022 11:56:03 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Oliver Sang <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        lkp@lists.01.org, Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [mm/page_alloc] 2bd8eec68f:
 BUG:sleeping_function_called_from_invalid_context_at_mm/gup.c
Message-ID: <20220708105603.GI27531@techsingularity.net>
References: <20220613125622.18628-8-mgorman@techsingularity.net>
 <YsFk/qU+QtWun04h@xsang-OptiPlex-9020>
 <20220703132209.875b823d1cb7169a8d51d56d@linux-foundation.org>
 <YsRB3fZHAfik0M/q@xsang-OptiPlex-9020>
 <1d3a26ac-89b3-0211-f8f2-5165ffa732fd@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1d3a26ac-89b3-0211-f8f2-5165ffa732fd@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 11:55:35PM +0200, Vlastimil Babka wrote:
> On 7/5/22 15:51, Oliver Sang wrote:
> > Hi Andrew Morton,
> > 
> > On Sun, Jul 03, 2022 at 01:22:09PM -0700, Andrew Morton wrote:
> >> On Sun, 3 Jul 2022 17:44:30 +0800 kernel test robot <oliver.sang@intel.com> wrote:
> >> 
> >> > FYI, we noticed the following commit (built with gcc-11):
> >> > 
> >> > commit: 2bd8eec68f740608db5ea58ecff06965228764cb ("[PATCH 7/7] mm/page_alloc: Replace local_lock with normal spinlock")
> >> > url: https://github.com/intel-lab-lkp/linux/commits/Mel-Gorman/Drain-remote-per-cpu-directly/20220613-230139
> >> > base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
> >> > patch link: https://lore.kernel.org/lkml/20220613125622.18628-8-mgorman@techsingularity.net
> >> > 
> >> 
> >> Did this test include the followup patch
> >> mm-page_alloc-replace-local_lock-with-normal-spinlock-fix.patch?
> > 
> > no, we just fetched original patch set and test upon it.
> 
> It appears you fetched v4, not v5. I noticed it from the threading of your
> report that was threaded in the v4 thread, and also the github url: above.
> In v4, pcpu_spin_trylock_irqsave() was missing an unpin, and indeed it's
> missing in the github branch you were testing:
> 

Thanks Vlastimil! This is my fault, I failed to verify that the code in
my tree, Andrew's tree and what Oliver tested were the same so no wonder I
could not find where the missing unpin was. I've gone through mm-unstable
commits be42c869b8e..4143c9b5266 and can confirm that they are now identical
to my own tree which includes Andrew's fix for the smatch warning that
Dan reported.

# git diff HEAD^..mm-pcpspinnoirq-v6r1-mmunstable | wc -l
0

The only difference between my tree and Andrew's is that there is a head
commit for "mm/page_alloc: Do not disable IRQs for per-cpu allocations"
which has been put on hold for now.

-- 
Mel Gorman
SUSE Labs
