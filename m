Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F324C791F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiB1TwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiB1Tvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:51:46 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB320DF29
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646077823; x=1677613823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fyMzmzWob5BwLEcRZwKRCLnS0Nzkv/dRn06vcSYOlQM=;
  b=DUC1DxOZ9b9qtpoVAlOYQssJAZ6Z0Mnhemti5/ealu5BTCxe6nkMnggM
   12tvzd6mXjpkxZOGNTbMfaC9Z6rd0In2/XJhc43c3u9pv3RTkXDQyvIN7
   UgznB6G2/CIwfLjIP5HMsvqPhrq+Apag+0ZcfdX6HEUvQYhIWxsc7mKQH
   yssv/vKq7+J/fvedmcwVTcT0do94sN4MhgfdTul4FQh+kwJcYrRIVyXlJ
   ZtoIxMAQHPxbuAGWllPkXIhvhLgyrhLXia5kzLdz50TfLHDRjPZVxrUcn
   mHn3t02AqCJJb/7vPR8lVOBHNFhQsaYZg0Es08LKo/TGDkocnjtTqBXwT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="232942862"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="232942862"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 11:50:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="492838943"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Feb 2022 11:50:19 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOm2E-0007kJ-LB; Mon, 28 Feb 2022 19:50:18 +0000
Date:   Tue, 1 Mar 2022 03:49:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>, mingo@redhat.com,
        peterz@infradead.org, frederic@kernel.org, rostedt@goodmis.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, tglx@linutronix.de,
        mtosatti@redhat.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: Re: [RESEND PATCH 2/2] tracing: Avoid isolated CPUs when queueing
 fsnotify irqwork
Message-ID: <202203010318.S1y5cIXE-lkp@intel.com>
References: <20220228141550.260119-2-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228141550.260119-2-nsaenzju@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on next-20220228]
[cannot apply to rostedt-trace/for-next linus/master v5.17-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Nicolas-Saenz-Julienne/sched-isolation-Use-raw_smp_processor_id-in-housekeeping_any_cpu/20220228-221742
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 6255b48aebfd4dff375e97fc8b075a235848db0b
config: i386-randconfig-a002-20220228 (https://download.01.org/0day-ci/archive/20220301/202203010318.S1y5cIXE-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e3ec0b4adfed05db0d559d2d5234d6d8f1034985
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nicolas-Saenz-Julienne/sched-isolation-Use-raw_smp_processor_id-in-housekeeping_any_cpu/20220228-221742
        git checkout e3ec0b4adfed05db0d559d2d5234d6d8f1034985
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/trace/trace.c:1728:64: error: use of undeclared identifier 'HK_FLAG_MISC'; did you mean 'HK_TYPE_MISC'?
           irq_work_queue_on(&tr->fsnotify_irqwork, housekeeping_any_cpu(HK_FLAG_MISC));
                                                                         ^~~~~~~~~~~~
                                                                         HK_TYPE_MISC
   include/linux/sched/isolation.h:11:2: note: 'HK_TYPE_MISC' declared here
           HK_TYPE_MISC,
           ^
   1 error generated.


vim +1728 kernel/trace/trace.c

  1718	
  1719	void latency_fsnotify(struct trace_array *tr)
  1720	{
  1721		if (!fsnotify_wq)
  1722			return;
  1723		/*
  1724		 * We cannot call queue_work(&tr->fsnotify_work) from here because it's
  1725		 * possible that we are called from __schedule() or do_idle(), which
  1726		 * could cause a deadlock.
  1727		 */
> 1728		irq_work_queue_on(&tr->fsnotify_irqwork, housekeeping_any_cpu(HK_FLAG_MISC));
  1729	}
  1730	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
