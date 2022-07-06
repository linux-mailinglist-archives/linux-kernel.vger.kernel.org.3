Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E712568BD7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiGFOxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbiGFOx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:53:29 -0400
Received: from outbound-smtp30.blacknight.com (outbound-smtp30.blacknight.com [81.17.249.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7D4A1B0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:53:28 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id ABF94BAB38
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 15:53:26 +0100 (IST)
Received: (qmail 22138 invoked from network); 6 Jul 2022 14:53:26 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Jul 2022 14:53:26 -0000
Date:   Wed, 6 Jul 2022 15:53:24 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        lkp@lists.01.org, Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [mm/page_alloc]  2bd8eec68f:
 BUG:sleeping_function_called_from_invalid_context_at_mm/gup.c
Message-ID: <20220706145324.GH27531@techsingularity.net>
References: <20220613125622.18628-8-mgorman@techsingularity.net>
 <YsFk/qU+QtWun04h@xsang-OptiPlex-9020>
 <20220703132209.875b823d1cb7169a8d51d56d@linux-foundation.org>
 <YsRB3fZHAfik0M/q@xsang-OptiPlex-9020>
 <20220706095535.GD27531@techsingularity.net>
 <YsWbWsN2qPbWsNWZ@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YsWbWsN2qPbWsNWZ@xsang-OptiPlex-9020>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 10:25:30PM +0800, Oliver Sang wrote:
> hi, Mel Gorman,
> 
> On Wed, Jul 06, 2022 at 10:55:35AM +0100, Mel Gorman wrote:
> > On Tue, Jul 05, 2022 at 09:51:25PM +0800, Oliver Sang wrote:
> > > Hi Andrew Morton,
> > > 
> > > On Sun, Jul 03, 2022 at 01:22:09PM -0700, Andrew Morton wrote:
> > > > On Sun, 3 Jul 2022 17:44:30 +0800 kernel test robot <oliver.sang@intel.com> wrote:
> > > > 
> > > > > FYI, we noticed the following commit (built with gcc-11):
> > > > > 
> > > > > commit: 2bd8eec68f740608db5ea58ecff06965228764cb ("[PATCH 7/7] mm/page_alloc: Replace local_lock with normal spinlock")
> > > > > url: https://github.com/intel-lab-lkp/linux/commits/Mel-Gorman/Drain-remote-per-cpu-directly/20220613-230139
> > > > > base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
> > > > > patch link: https://lore.kernel.org/lkml/20220613125622.18628-8-mgorman@techsingularity.net
> > > > > 
> > > > 
> > > > Did this test include the followup patch
> > > > mm-page_alloc-replace-local_lock-with-normal-spinlock-fix.patch?
> > > 
> > > no, we just fetched original patch set and test upon it.
> > > 
> > > now we applied the patch you pointed to us upon 2bd8eec68f and found the issue
> > > still exist.
> > > (attached dmesg FYI)
> > > 
> > 
> > Thanks Oliver.
> > 
> > The trace is odd in that it hits in GUP when the page allocator is no
> > longer active and the context is a syscall. First, is this definitely
> > the first patch the problem occurs?
> > 
> > Second, it's possible for IRQs to be enabled and an IRQ delivered before
> > preemption is enabled. It's not clear why that would be a problem other
> > than lacking symmetry or how it could result in the reported BUG but
> > might as well rule it out. This is build tested only
> 
> do you want us test below patch?
> if so, should we apply it upon the patch
> "mm/page_alloc: Replace local_lock with normal spinlock"
> or
> "mm/page_alloc: replace local_lock with normal spinlock -fix"?
> 

On top of "mm/page_alloc: replace local_lock with normal spinlock -fix"
please. The -fix patch is cosmetic but it'd still be better to test on
top.

Thanks!

-- 
Mel Gorman
SUSE Labs
