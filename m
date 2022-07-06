Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F72568B1D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiGFOVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiGFOVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:21:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060E523BFB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657117305; x=1688653305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rANpPC1k8ntNoM9UbPaxTmHG5k84FYQtX4k3gZlotro=;
  b=fyQ4xFgN/axPASZ5hJrxCrXFwKTbzjCIj2nCAMGyRkJm1QS1frSUa/By
   kIKWIBKdsScHB7Ex9jGkHtSV2yzzI+Fnf7PjPPyWZKTPQ8gqxzsrQLraF
   5UkDSc8n6Hfaz31/8F/6YZ8DntiYWDg91VjfD1g3sDwNVO+65MQKFnWs6
   3qgjh+5mArSvO0kyJ4jkv0BqdMOpo+nWmTpGMxrmtxwbl4VBXZXm8tsZj
   0XaybRIZvq7053AkLPj/jjseRbYU2+/XV9DZ3tAWBebOC6gxTqOetaLO4
   ajctck1tsp89Hj/54DAlBbDt16NE1Wr92nXGAHQzYMhGVg8QQCAvKv6mU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="283783802"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="283783802"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 07:21:45 -0700
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="650683204"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 07:21:42 -0700
Date:   Wed, 6 Jul 2022 22:21:36 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
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
Message-ID: <YsWacP1k8wMgGfXx@xsang-OptiPlex-9020>
References: <20220613125622.18628-8-mgorman@techsingularity.net>
 <YsFk/qU+QtWun04h@xsang-OptiPlex-9020>
 <20220703132209.875b823d1cb7169a8d51d56d@linux-foundation.org>
 <YsRB3fZHAfik0M/q@xsang-OptiPlex-9020>
 <20220706095535.GD27531@techsingularity.net>
 <20220706115328.GE27531@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706115328.GE27531@techsingularity.net>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Mel Gorman,

On Wed, Jul 06, 2022 at 12:53:29PM +0100, Mel Gorman wrote:
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
> 
> I tried reproducing this on a 2-socket machine with Xeon
> Gold Gold 5218R CPUs. It was necessary to set timeouts in both
> vm/settings and kselftest/runner.sh to avoid timeouts. Testing with
> a standard config on my original 5.19-rc3 baseline and the baseline
> b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3 both passed. I tried your kernel
> config with i915 disabled (would not build) and necessary storage drivers
> and network drivers enabled (for boot and access). The kernel log shows
> a bunch of warnings related to USBAN during boot and during some of the
> tests but otherwise compaction_test completed successfully as well as
> the other VM tests.
> 
> Is this always reproducible?

not always but high rate.
we actually also observed other dmesgs stats for both 2bd8eec68f74 and its
parent, but those dmesg.BUG:sleeping_function_called_from_invalid_context_at*
seem only happen on 2bd8eec68f74 as well as the '-fix' commit.

=========================================================================================
compiler/group/kconfig/rootfs/sc_nr_hugepages/tbox_group/testcase/ucode:
  gcc-11/vm/x86_64-rhel-8.3-kselftests/debian-11.1-x86_64-20220510.cgz/2/lkp-csl-2sp9/kernel-selftests/0x500320a

commit:
  eec0ff5df294 ("mm/page_alloc: Remotely drain per-cpu lists")
  2bd8eec68f74 ("mm/page_alloc: Replace local_lock with normal spinlock")
  292baeb4c714 ("mm/page_alloc: replace local_lock with normal spinlock -fix")

eec0ff5df2945d19 2bd8eec68f740608db5ea58ecff 292baeb4c7149ac2cb844137481
---------------- --------------------------- ---------------------------
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |
           :20          75%          15:20          70%          14:21    dmesg.BUG:scheduling_while_atomic
           :20           5%           1:20           0%            :21    dmesg.BUG:sleeping_function_called_from_invalid_context_at_fs/binfmt_elf.c
           :20           5%           1:20          10%           2:21    dmesg.BUG:sleeping_function_called_from_invalid_context_at_fs/dcache.c
           :20           5%           1:20           5%           1:21    dmesg.BUG:sleeping_function_called_from_invalid_context_at_include/linux/freezer.h
           :20          10%           2:20          25%           5:21    dmesg.BUG:sleeping_function_called_from_invalid_context_at_include/linux/mmu_notifier.h
           :20           5%           1:20           0%            :21    dmesg.BUG:sleeping_function_called_from_invalid_context_at_include/linux/percpu-rwsem.h
           :20          40%           8:20          40%           8:21    dmesg.BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h
           :20          10%           2:20           0%            :21    dmesg.BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c
           :20          10%           2:20          10%           2:21    dmesg.BUG:sleeping_function_called_from_invalid_context_at_lib/strncpy_from_user.c
           :20          55%          11:20          65%          13:21    dmesg.BUG:sleeping_function_called_from_invalid_context_at_mm/gup.c
           :20          15%           3:20           5%           1:21    dmesg.BUG:sleeping_function_called_from_invalid_context_at_mm/memory.c
           :20          60%          12:20          55%          11:21    dmesg.BUG:sleeping_function_called_from_invalid_context_at_mm/migrate.c
           :20           5%           1:20           5%           1:21    dmesg.BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c
           :20           0%            :20           5%           1:21    dmesg.BUG:sleeping_function_called_from_invalid_context_at_mm/rmap.c
           :20          15%           3:20           0%            :21    dmesg.BUG:sleeping_function_called_from_invalid_context_at_mm/vmalloc.c
           :20          45%           9:20          45%           9:21    dmesg.BUG:workqueue_leaked_lock_or_atomic
           :20          25%           5:20          15%           3:21    dmesg.Kernel_panic-not_syncing:Attempted_to_kill_init!exitcode=
           :20           5%           1:20           0%            :21    dmesg.RIP:__clear_user
         20:20           0%          20:20           5%          21:21    dmesg.RIP:rcu_eqs_exit
         20:20           0%          20:20           5%          21:21    dmesg.RIP:sched_clock_tick
           :20           5%           1:20           0%            :21    dmesg.RIP:smp_call_function_many_cond
         20:20           0%          20:20           5%          21:21    dmesg.WARNING:at_kernel/rcu/tree.c:#rcu_eqs_exit
         20:20           0%          20:20           5%          21:21    dmesg.WARNING:at_kernel/sched/clock.c:#sched_clock_tick
           :20           5%           1:20           0%            :21    dmesg.WARNING:at_kernel/smp.c:#smp_call_function_many_cond
         20:20           0%          20:20           5%          21:21    dmesg.WARNING:suspicious_RCU_usage
         20:20           0%          20:20           5%          21:21    dmesg.boot_failures
          9:20         -15%           6:20          -5%           8:21    dmesg.include/linux/rcupdate.h:#rcu_read_lock()used_illegally_while_idle
          9:20         -15%           6:20          -5%           8:21    dmesg.include/linux/rcupdate.h:#rcu_read_unlock()used_illegally_while_idle
         20:20           0%          20:20           5%          21:21    dmesg.include/trace/events/error_report.h:#suspicious_rcu_dereference_check()usage
         20:20           0%          20:20           5%          21:21    dmesg.include/trace/events/lock.h:#suspicious_rcu_dereference_check()usage


> 
> -- 
> Mel Gorman
> SUSE Labs
