Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96B64F9863
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbiDHOnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237120AbiDHOnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:43:41 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203A5ED9F6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649428897; x=1680964897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gKPuDMxPwwImVaSWhf/GrWbTRZ/GhJoq+Oz10aC1ezE=;
  b=IEBaeNDD4Xcd9x3UM2UOYZGjNtkWZUsvqRdDtMl8UOLlHiaGPorf9G+C
   /vYMChWd3JhL2oYypBXD3r7Xxrubk/IsvwRUTmjlgAgL/qr94SdMM0FKu
   TwfdsfxPqiSBvRZxpDiiHIAuD+SsGHyVOQQb9yQQ10MoJT7lFyzMvX0A3
   V1VxjQkW6mpBNaH1FbJIEtWauwfMnPe3ahyne40+/jPFi8otMofSwaMjr
   APcFEgaX0SIIyw9w2/Sgdm0tCjQkiw2fI53vXEPbCBBXYkgR1ajE7FI9D
   /mH7xI3RCu02zkCiM++OM4dfg5NmS9DQyTYvWt4U4qLADmxkq0M/iAV4C
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="322295527"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="322295527"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 07:41:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="653285516"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 08 Apr 2022 07:41:32 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncpnn-0000MI-Eq;
        Fri, 08 Apr 2022 14:41:31 +0000
Date:   Fri, 8 Apr 2022 22:41:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
Message-ID: <202204082258.E7EPbAYz-lkp@intel.com>
References: <20220408032809.3696798-1-npache@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408032809.3696798-1-npache@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nico,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hnaz-mm/master]
[also build test WARNING on linus/master v5.18-rc1 next-20220408]
[cannot apply to linux/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Nico-Pache/oom_kill-c-futex-Don-t-OOM-reap-the-VMA-containing-the-robust_list_head/20220408-112952
base:   https://github.com/hnaz/linux-mm master
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220408/202204082258.E7EPbAYz-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/70c1e2a404ac47b7c9b8bd1e9c4d3e72f19e6c62
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nico-Pache/oom_kill-c-futex-Don-t-OOM-reap-the-VMA-containing-the-robust_list_head/20220408-112952
        git checkout 70c1e2a404ac47b7c9b8bd1e9c4d3e72f19e6c62
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> mm/oom_kill.c:606:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *robust_list @@     got struct robust_list_head [noderef] __user *robust_list @@
   mm/oom_kill.c:606:21: sparse:     expected void *robust_list
   mm/oom_kill.c:606:21: sparse:     got struct robust_list_head [noderef] __user *robust_list
   mm/oom_kill.c: note: in included file (through include/linux/rculist.h, include/linux/sched/signal.h, include/linux/oom.h):
   include/linux/rcupdate.h:726:9: sparse: sparse: context imbalance in 'find_lock_task_mm' - wrong count at exit
   mm/oom_kill.c:222:28: sparse: sparse: context imbalance in 'oom_badness' - unexpected unlock
   include/linux/rcupdate.h:726:9: sparse: sparse: context imbalance in 'dump_task' - unexpected unlock
   include/linux/rcupdate.h:726:9: sparse: sparse: context imbalance in '__oom_kill_process' - unexpected unlock
   mm/oom_kill.c:1243:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *robust_list @@     got struct robust_list_head [noderef] __user *robust_list @@
   mm/oom_kill.c:1243:21: sparse:     expected void *robust_list
   mm/oom_kill.c:1243:21: sparse:     got struct robust_list_head [noderef] __user *robust_list
   mm/oom_kill.c:1232:20: sparse: sparse: context imbalance in '__se_sys_process_mrelease' - unexpected unlock
--
>> mm/mmap.c:3138:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *robust_list @@     got struct robust_list_head [noderef] __user *robust_list @@
   mm/mmap.c:3138:21: sparse:     expected void *robust_list
   mm/mmap.c:3138:21: sparse:     got struct robust_list_head [noderef] __user *robust_list

vim +606 mm/oom_kill.c

   575	
   576	/*
   577	 * Reaps the address space of the give task.
   578	 *
   579	 * Returns true on success and false if none or part of the address space
   580	 * has been reclaimed and the caller should retry later.
   581	 */
   582	static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
   583	{
   584		bool ret = true;
   585		void *robust_list = NULL;
   586	
   587		if (!mmap_read_trylock(mm)) {
   588			trace_skip_task_reaping(tsk->pid);
   589			return false;
   590		}
   591	
   592		/*
   593		 * MMF_OOM_SKIP is set by exit_mmap when the OOM reaper can't
   594		 * work on the mm anymore. The check for MMF_OOM_SKIP must run
   595		 * under mmap_lock for reading because it serializes against the
   596		 * mmap_write_lock();mmap_write_unlock() cycle in exit_mmap().
   597		 */
   598		if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
   599			trace_skip_task_reaping(tsk->pid);
   600			goto out_unlock;
   601		}
   602	
   603		trace_start_task_reaping(tsk->pid);
   604	
   605	#ifdef CONFIG_FUTEX
 > 606		robust_list = tsk->robust_list;
   607	#endif
   608		/* failed to reap part of the address space. Try again later */
   609		ret = __oom_reap_task_mm(mm, robust_list);
   610		if (!ret)
   611			goto out_finish;
   612	
   613		pr_info("oom_reaper: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
   614				task_pid_nr(tsk), tsk->comm,
   615				K(get_mm_counter(mm, MM_ANONPAGES)),
   616				K(get_mm_counter(mm, MM_FILEPAGES)),
   617				K(get_mm_counter(mm, MM_SHMEMPAGES)));
   618	out_finish:
   619		trace_finish_task_reaping(tsk->pid);
   620	out_unlock:
   621		mmap_read_unlock(mm);
   622	
   623		return ret;
   624	}
   625	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
