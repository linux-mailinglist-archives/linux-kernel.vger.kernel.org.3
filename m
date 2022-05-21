Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8104E52F7F3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 05:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354439AbiEUDTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 23:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354431AbiEUDTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 23:19:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607A2185421
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 20:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653103171; x=1684639171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g8rxXkviU1sahuXd0DZNQpe1jtECbU3vBsD0Kr4uZ4U=;
  b=KKANtUqe1ZCaapWWUinCYPoIzmtYmkNAchdfxfABFUGfn+6cyf1QJniI
   f7nkxCaIVzcJqc/HVvDY02z9AC7HcBvvic5E4vi1IzSvQ38vJQo3iTOWK
   VX1vQA5TgKNslGhmoCLj2EP2rjLWQoSENK6/dtm+yiQR9zk0sV0OKmBjG
   XYSej18pStD3jV+Ye5OODvEZl4dmnkcg0l57TKKM7Kkm3l7HDKlb4CLpo
   tHY4vjZYpxrfjDmkTk/j7dyhOnsVNDUDVKy5v5tzfdBSEtThxJ3nIRy6Q
   4liYXS8xbtlZA83rDDCCowjaNZqFOL0fnkWUlR9Zen8aFUc3vjopihP2X
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="253313078"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="253313078"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 20:19:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="640594118"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2022 20:19:27 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsFeJ-0005rS-2T;
        Sat, 21 May 2022 03:19:27 +0000
Date:   Sat, 21 May 2022 11:19:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tejun Heo <tj@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Cruz Zhao <CruzZhao@linux.alibaba.com>,
        Josh Don <joshdon@google.com>
Subject: Re: [PATCH v2] sched/core: add forced idle accounting for cgroups
Message-ID: <202205211108.a5tqwV7v-lkp@intel.com>
References: <20220520235138.3140590-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520235138.3140590-1-joshdon@google.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tj-cgroup/for-next]
[also build test WARNING on tip/sched/core tip/master v5.18-rc7 next-20220520]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Josh-Don/sched-core-add-forced-idle-accounting-for-cgroups/20220521-075311
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220521/202205211108.a5tqwV7v-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/0575a42c9f10cda618b09b949cc42fe97abea479
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Josh-Don/sched-core-add-forced-idle-accounting-for-cgroups/20220521-075311
        git checkout 0575a42c9f10cda618b09b949cc42fe97abea479
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash kernel/cgroup/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time64.h:5,
                    from include/linux/restart_block.h:10,
                    from include/linux/thread_info.h:14,
                    from include/asm-generic/current.h:5,
                    from ./arch/um/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/cgroup.h:12,
                    from kernel/cgroup/cgroup-internal.h:5,
                    from kernel/cgroup/rstat.c:2:
   kernel/cgroup/rstat.c: In function 'cgroup_base_stat_cputime_show':
>> arch/x86/include/asm/div64.h:30:17: warning: 'forceidle_time' is used uninitialized [-Wuninitialized]
      30 |                 asm("" : "=a" (__low), "=d" (__high) : "A" (n));\
         |                 ^~~
   kernel/cgroup/rstat.c:465:28: note: 'forceidle_time' was declared here
     465 |         u64 __maybe_unused forceidle_time;
         |                            ^~~~~~~~~~~~~~


vim +/forceidle_time +30 arch/x86/include/asm/div64.h

428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20   9  
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  10  /*
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  11   * do_div() is NOT a C function. It wants to return
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  12   * two values (the quotient and the remainder), but
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  13   * since that doesn't work very well in C, what it
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  14   * does is:
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  15   *
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  16   * - modifies the 64-bit dividend _in_place_
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  17   * - returns the 32-bit remainder
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  18   *
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  19   * This ends up being the most efficient "calling
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  20   * convention" on x86.
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  21   */
925a09b27fc735 include/asm-x86/div64.h      Joe Perches               2008-03-23  22  #define do_div(n, base)						\
925a09b27fc735 include/asm-x86/div64.h      Joe Perches               2008-03-23  23  ({								\
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  24  	unsigned long __upper, __low, __high, __mod, __base;	\
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  25  	__base = (base);					\
668b4484660618 arch/x86/include/asm/div64.h Sebastian Andrzej Siewior 2011-11-30  26  	if (__builtin_constant_p(__base) && is_power_of_2(__base)) { \
668b4484660618 arch/x86/include/asm/div64.h Sebastian Andrzej Siewior 2011-11-30  27  		__mod = n & (__base - 1);			\
668b4484660618 arch/x86/include/asm/div64.h Sebastian Andrzej Siewior 2011-11-30  28  		n >>= ilog2(__base);				\
668b4484660618 arch/x86/include/asm/div64.h Sebastian Andrzej Siewior 2011-11-30  29  	} else {						\
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20 @30  		asm("" : "=a" (__low), "=d" (__high) : "A" (n));\
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  31  		__upper = __high;				\
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  32  		if (__high) {					\
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  33  			__upper = __high % (__base);		\
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  34  			__high = __high / (__base);		\
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  35  		}						\
925a09b27fc735 include/asm-x86/div64.h      Joe Perches               2008-03-23  36  		asm("divl %2" : "=a" (__low), "=d" (__mod)	\
925a09b27fc735 include/asm-x86/div64.h      Joe Perches               2008-03-23  37  			: "rm" (__base), "0" (__low), "1" (__upper));	\
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  38  		asm("" : "=A" (n) : "a" (__low), "d" (__high));	\
668b4484660618 arch/x86/include/asm/div64.h Sebastian Andrzej Siewior 2011-11-30  39  	}							\
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  40  	__mod;							\
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  41  })
428c5a2339f6d5 include/asm-x86/div64.h      Chris Snook               2007-10-20  42  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
