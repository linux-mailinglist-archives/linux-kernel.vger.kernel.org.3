Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BB5473D75
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhLNHNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:13:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:49269 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229752AbhLNHNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639466033; x=1671002033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jdfb5fVu5E7xPCWOdi0WEdnnVTTuMGI/SwiH4gh3/nk=;
  b=UKuByHmhVDuk0A1k/fsFdhlvU8rfhNC59zJ0RDbpwZEkmD/72F6VOH4X
   znHHbOfVkSbLq0UjVErvFvFbOS203kI09tVe+KRmXF/sGLrlxw/EzBw8e
   NHKFT0gpbbwwr0bwI3iWxLpgiL74TKrlyAvvUC0u/Y2t87q2Up8v+3eDA
   x/dVWN3t1HxRy+HpDbT1SYzQ16Oact5AVcUrIHKp7vumUfNZsQ2mARHyR
   0+NrBNhJej3Q9NuTfFpVeAfhx+d+NCt6RGsRhISkzOO+bYiamd2ry+PMV
   FjHVa29md96e1bcEzqSSTq121YLsuF1iW9r4MEHPwtSkk3ctBFHjzdw/V
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="237653013"
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="237653013"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 23:13:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="583275986"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Dec 2021 23:13:51 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mx20U-00001s-Bx; Tue, 14 Dec 2021 07:13:50 +0000
Date:   Tue, 14 Dec 2021 15:13:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wander Lairson Costa <wander@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        Wander Lairson Costa <wander@redhat.com>
Subject: Re: [PATCH v2 1/2] block: Avoid sleeping function called from
 invalid context bug
Message-ID: <202112141554.2175ujH7-lkp@intel.com>
References: <20211213123737.9147-2-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213123737.9147-2-wander@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wander,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linux/master linus/master v5.16-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Wander-Lairson-Costa/Fix-warnings-in-blktrace/20211213-204207
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20211214/202112141554.2175ujH7-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/e53f7f8c1ce0b19fef6164247fea08d17d5f771d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Wander-Lairson-Costa/Fix-warnings-in-blktrace/20211213-204207
        git checkout e53f7f8c1ce0b19fef6164247fea08d17d5f771d
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   block/blk-cgroup.c: In function 'blk_cgroup_bio_start':
>> block/blk-cgroup.c:1915:8: error: implicit declaration of function 'get_cpu_light'; did you mean 'em_cpu_get'? [-Werror=implicit-function-declaration]
    1915 |  cpu = get_cpu_light();
         |        ^~~~~~~~~~~~~
         |        em_cpu_get
>> block/blk-cgroup.c:1932:2: error: implicit declaration of function 'put_cpu_light'; did you mean 'fput_light'? [-Werror=implicit-function-declaration]
    1932 |  put_cpu_light();
         |  ^~~~~~~~~~~~~
         |  fput_light
   cc1: some warnings being treated as errors


vim +1915 block/blk-cgroup.c

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
