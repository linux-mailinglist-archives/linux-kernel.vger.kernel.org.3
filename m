Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9394C77B0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbiB1S1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240630AbiB1S11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:27:27 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AA15D5FA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646071720; x=1677607720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mjTrSdZLS0vkY/n3c3U4LIAjRcrou3vGsUs7LG9mP78=;
  b=GNlNRC4vJfEHeKJBy7DTzjWmaOdQOFzu5zPv8BgcEOeblTGz1q687OXO
   GuqLEtw8+cy4EIgZqhRiFNeD+vDZPa5QXImNFv4xTmCBJv7cDKjcwGHSp
   pK0rdc42D/qiNtM/j/t18aF58pvgsIcHfmQYLJyCXHpoF0eqhp8r58DDT
   jSLjS2H8IryGlta2V6b2Kj5MQWH6yhFSMsPn7G9NvQhZ40SFJu3waEmCQ
   BcjdbzLjvbqQY8B/XzUVfu3gLOSCNyqcNT1e90EYM1C/dX9m1kdXqEwS7
   Sww/tesECK8NcniG/XuZ2gK5nnc2jgKOSIbtTU9cYJSiqtSc19I/JsvPo
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="252874501"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="252874501"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 10:08:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="534549808"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Feb 2022 10:08:16 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOkRT-0007fC-KF; Mon, 28 Feb 2022 18:08:15 +0000
Date:   Tue, 1 Mar 2022 02:07:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>, mingo@redhat.com,
        peterz@infradead.org, frederic@kernel.org, rostedt@goodmis.org
Cc:     kbuild-all@lists.01.org, tglx@linutronix.de, mtosatti@redhat.com,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: Re: [RESEND PATCH 2/2] tracing: Avoid isolated CPUs when queueing
 fsnotify irqwork
Message-ID: <202203010138.m94KpMH3-lkp@intel.com>
References: <20220228141550.260119-2-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228141550.260119-2-nsaenzju@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on next-20220225]
[cannot apply to rostedt-trace/for-next linus/master v5.17-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Nicolas-Saenz-Julienne/sched-isolation-Use-raw_smp_processor_id-in-housekeeping_any_cpu/20220228-221742
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 6255b48aebfd4dff375e97fc8b075a235848db0b
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220301/202203010138.m94KpMH3-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e3ec0b4adfed05db0d559d2d5234d6d8f1034985
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nicolas-Saenz-Julienne/sched-isolation-Use-raw_smp_processor_id-in-housekeeping_any_cpu/20220228-221742
        git checkout e3ec0b4adfed05db0d559d2d5234d6d8f1034985
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/trace/trace.c: In function 'latency_fsnotify':
>> kernel/trace/trace.c:1728:71: error: 'HK_FLAG_MISC' undeclared (first use in this function); did you mean 'HK_TYPE_MISC'?
    1728 |         irq_work_queue_on(&tr->fsnotify_irqwork, housekeeping_any_cpu(HK_FLAG_MISC));
         |                                                                       ^~~~~~~~~~~~
         |                                                                       HK_TYPE_MISC
   kernel/trace/trace.c:1728:71: note: each undeclared identifier is reported only once for each function it appears in
   kernel/trace/trace.c: In function 'trace_check_vprintf':
   kernel/trace/trace.c:3827:17: warning: function 'trace_check_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    3827 |                 trace_seq_vprintf(&iter->seq, iter->fmt, ap);
         |                 ^~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:3894:17: warning: function 'trace_check_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    3894 |                 trace_seq_vprintf(&iter->seq, p, ap);
         |                 ^~~~~~~~~~~~~~~~~


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
