Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801194690DF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 08:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbhLFHlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 02:41:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:50248 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhLFHlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 02:41:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="298063540"
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="298063540"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 23:38:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; 
   d="scan'208";a="611156814"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 05 Dec 2021 23:37:59 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mu8ZS-000Kxe-Q0; Mon, 06 Dec 2021 07:37:58 +0000
Date:   Mon, 6 Dec 2021 15:37:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yajun Deng <yajun.deng@linux.dev>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc:     kbuild-all@lists.01.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] completion: introduce complete_put() helper function
Message-ID: <202112061552.NaaSG9xz-lkp@intel.com>
References: <20211206040319.7063-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206040319.7063-1-yajun.deng@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yajun,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on v5.16-rc4 next-20211203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Yajun-Deng/completion-introduce-complete_put-helper-function/20211206-120632
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 8c92606ab81086db00cbb73347d124b4eb169b7e
config: arm-randconfig-r033-20211206 (https://download.01.org/0day-ci/archive/20211206/202112061552.NaaSG9xz-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/6d181628873250fd66a8f2da19182fec95973b6e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Yajun-Deng/completion-introduce-complete_put-helper-function/20211206-120632
        git checkout 6d181628873250fd66a8f2da19182fec95973b6e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/sched/completion.c:41:6: warning: no previous prototype for 'complete_put' [-Wmissing-prototypes]
      41 | void complete_put(refcount_t *r, struct completion *x)
         |      ^~~~~~~~~~~~


vim +/complete_put +41 kernel/sched/completion.c

    40	
  > 41	void complete_put(refcount_t *r, struct completion *x)
    42	{
    43		if (refcount_dec_and_test(r))
    44			complete(x);
    45	}
    46	EXPORT_SYMBOL(complete_put);
    47	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
