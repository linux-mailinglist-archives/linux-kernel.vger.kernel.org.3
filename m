Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30894711B2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 06:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhLKFZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 00:25:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:51756 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229452AbhLKFZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 00:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639200092; x=1670736092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4jeFRTkBneJ9Tg0hGd9/F1vN4Ck2h1BgrDoHalejcwQ=;
  b=YEmWBFpA3mdUZf8VdBU0KMlbDgPECC28MNNOAdoHzu50DUKSqGx+46TS
   0e4HabBAIkMAnQlSzc7woXNnSTaEjHKEulrFZM2tmS0wdEsCtD9jRhuNA
   2F5Sx6zlLam0j7OMtIq0tue+xOOeN3ZX1rmbpmxpg1LcfRItbsbv4mtWW
   IsnWPlfuNbLugt/Cl/PxmJJsnISFNXQDzswIOWp3ZJqdkUgl6iOsH4Rdt
   iHm3BDalj/btNaeJF3msU/fvWLxPJUU0xtmDW7RxWzn2/9MauulTjGEhx
   d0uT+auTZNCP7NBGoVaiqr18L2KCFLW4TwBe70/9/okhmkEntWbrB4eso
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="238314897"
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="238314897"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 21:21:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="480966268"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 10 Dec 2021 21:21:30 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvup7-000492-Ik; Sat, 11 Dec 2021 05:21:29 +0000
Date:   Sat, 11 Dec 2021 13:21:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wander Lairson Costa <wander@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        Wander Lairson Costa <wander@redhat.com>
Subject: Re: [PREEMPT_RT PATCH 1/2] block: Avoid sleeping function called
 from invalid context bug
Message-ID: <202112111300.2jYSEVK1-lkp@intel.com>
References: <20211210204156.96336-2-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210204156.96336-2-wander@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wander,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linux/master linus/master v5.16-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Wander-Lairson-Costa/Fix-warnings-in-blktrace/20211211-044405
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: i386-randconfig-a016-20211210 (https://download.01.org/0day-ci/archive/20211211/202112111300.2jYSEVK1-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/37b10b13961fb1af60139789717a018f788f714e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Wander-Lairson-Costa/Fix-warnings-in-blktrace/20211211-044405
        git checkout 37b10b13961fb1af60139789717a018f788f714e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> block/blk-cgroup.c:1915:8: error: implicit declaration of function 'get_cpu_light' [-Werror,-Wimplicit-function-declaration]
           cpu = get_cpu_light();
                 ^
>> block/blk-cgroup.c:1932:2: error: implicit declaration of function 'put_cpu_light' [-Werror,-Wimplicit-function-declaration]
           put_cpu_light();
           ^
   block/blk-cgroup.c:1932:2: note: did you mean 'get_cpu_light'?
   block/blk-cgroup.c:1915:8: note: 'get_cpu_light' declared here
           cpu = get_cpu_light();
                 ^
   2 errors generated.


vim +/get_cpu_light +1915 block/blk-cgroup.c

  1908	
  1909	void blk_cgroup_bio_start(struct bio *bio)
  1910	{
  1911		int rwd = blk_cgroup_io_type(bio), cpu;
  1912		struct blkg_iostat_set *bis;
  1913		unsigned long flags;
  1914	
> 1915		cpu = get_cpu_light();
  1916		bis = per_cpu_ptr(bio->bi_blkg->iostat_cpu, cpu);
  1917		flags = u64_stats_update_begin_irqsave(&bis->sync);
  1918	
  1919		/*
  1920		 * If the bio is flagged with BIO_CGROUP_ACCT it means this is a split
  1921		 * bio and we would have already accounted for the size of the bio.
  1922		 */
  1923		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
  1924			bio_set_flag(bio, BIO_CGROUP_ACCT);
  1925			bis->cur.bytes[rwd] += bio->bi_iter.bi_size;
  1926		}
  1927		bis->cur.ios[rwd]++;
  1928	
  1929		u64_stats_update_end_irqrestore(&bis->sync, flags);
  1930		if (cgroup_subsys_on_dfl(io_cgrp_subsys))
  1931			cgroup_rstat_updated(bio->bi_blkg->blkcg->css.cgroup, cpu);
> 1932		put_cpu_light();
  1933	}
  1934	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
