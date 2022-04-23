Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C1750C801
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 09:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbiDWHd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 03:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiDWHdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 03:33:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1257CE04
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 00:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650699052; x=1682235052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=byW5e7HMBEMlxs4zsMVsZvJMl2G0TfZXEMbM7J374Ck=;
  b=dn8jAUIzRR8dlRzNNKOpq8kVrurvsf08yyiWFHiyR1KHhVP8fPOuYb7W
   Lfpzk9L62WoV4+pU2qfHSPonclsdzp91Wixmym19B7EIvek6BfxcxStg6
   7SrSEjLDeg3JDpI3tU3nf0LYJZnOanZQlq/eMp043LiydVST//k0Yw2/j
   csd4IXIq+2kA8xRfyDyr4G1ArVZZyFVBT5HE683ULa/lvefY5gbgTnp7o
   EE1KoHIb0pVf4lzR4JczOpYnDJsD85+iBKpiHuDMF2Rx0Ad3dvpoWGGzu
   o/EbVuAD7DVjfGblK6nsSF6dYPldjx7EP3aNvL+AJG4yVdR7HKtkPRq0Z
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="252196309"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="252196309"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 00:30:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="728858848"
Received: from lkp-server01.sh.intel.com (HELO dd58949a6e39) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Apr 2022 00:30:48 -0700
Received: from kbuild by dd58949a6e39 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niAEB-00001S-HQ;
        Sat, 23 Apr 2022 07:30:47 +0000
Date:   Sat, 23 Apr 2022 15:30:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Donghai Qiao <dqiao@redhat.com>, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, arnd@arndb.de, peterz@infradead.org,
        heying24@huawei.com, andriy.shevchenko@linux.intel.com,
        axboe@kernel.dk, rdunlap@infradead.org, tglx@linutronix.de,
        gor@linux.ibm.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: Re: [PATCH v2 05/11] smp: replace smp_call_function_single_async()
 with  smp_call_private()
Message-ID: <202204231532.nXbSK9Tk-lkp@intel.com>
References: <20220422200040.93813-6-dqiao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422200040.93813-6-dqiao@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Donghai,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on powerpc/next]
[also build test WARNING on rafael-pm/linux-next linus/master v5.18-rc3 next-20220422]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Donghai-Qiao/smp-cross-CPU-call-interface/20220423-060436
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220423/202204231532.nXbSK9Tk-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3b8a90029bebdb77e2d5c0cd16f371e83d8ed2e8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Donghai-Qiao/smp-cross-CPU-call-interface/20220423-060436
        git checkout 3b8a90029bebdb77e2d5c0cd16f371e83d8ed2e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> block/blk-mq.c:1065:39: warning: passing 4-byte aligned argument to 16-byte aligned parameter 2 of 'smp_call_private' may result in an unaligned pointer access [-Walign-mismatch]
                   smp_call_function_single_async(cpu, &rq->csd);
                                                       ^
   1 warning generated.


vim +/smp_call_private +1065 block/blk-mq.c

963395269c7586 Christoph Hellwig         2020-06-11  1055  
f9ab49184af093 Sebastian Andrzej Siewior 2021-01-23  1056  static void blk_mq_complete_send_ipi(struct request *rq)
f9ab49184af093 Sebastian Andrzej Siewior 2021-01-23  1057  {
f9ab49184af093 Sebastian Andrzej Siewior 2021-01-23  1058  	struct llist_head *list;
f9ab49184af093 Sebastian Andrzej Siewior 2021-01-23  1059  	unsigned int cpu;
f9ab49184af093 Sebastian Andrzej Siewior 2021-01-23  1060  
f9ab49184af093 Sebastian Andrzej Siewior 2021-01-23  1061  	cpu = rq->mq_ctx->cpu;
f9ab49184af093 Sebastian Andrzej Siewior 2021-01-23  1062  	list = &per_cpu(blk_cpu_done, cpu);
f9ab49184af093 Sebastian Andrzej Siewior 2021-01-23  1063  	if (llist_add(&rq->ipi_list, list)) {
f9ab49184af093 Sebastian Andrzej Siewior 2021-01-23  1064  		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
f9ab49184af093 Sebastian Andrzej Siewior 2021-01-23 @1065  		smp_call_function_single_async(cpu, &rq->csd);
f9ab49184af093 Sebastian Andrzej Siewior 2021-01-23  1066  	}
f9ab49184af093 Sebastian Andrzej Siewior 2021-01-23  1067  }
f9ab49184af093 Sebastian Andrzej Siewior 2021-01-23  1068  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
