Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC9052C419
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242361AbiERUKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242525AbiERUKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:10:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C452C244F1C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652904628; x=1684440628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vk2PHlYvv5Cus4Lj94Clz+Z1voayxRVicOxsYTDXq8o=;
  b=QZin+pTDsE96rQSSRWkMpJbXREvIwuR9zdKvSfh/zFF0nK+rSoBK3uem
   fOLiy0FsrlpLOk/yR3m2P/+FD7g1KOEZp9hoFzTLID/BfDSW5lusOOdP9
   9LLz7Ug8WWNm34xxS3YiL3rJTA5Dc7lm6FSEy2lYhgSQ64VX9Mk9OmSxm
   Fx2mNTFZir/swi25O2S7OhQH+V9fj8xL1OCEV/u8xMgwqxymTvfsoD6P3
   KrZKDx1/0wpZmydTc5783wuGk5na7j85o8QzzLNRu25XMt0X3rGF6uzER
   NPXFRc6I7RaWCl9VH5r//he1V0qxMLviFGVvz19ekNLcxK4Og/5QH+btI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="259440157"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="259440157"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 13:10:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="575258209"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 18 May 2022 13:10:24 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrPzz-0002ae-VR;
        Wed, 18 May 2022 20:10:23 +0000
Date:   Thu, 19 May 2022 04:09:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Donghai Qiao <dqiao@redhat.com>, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, arnd@arndb.de, peterz@infradead.org,
        heying24@huawei.com, andriy.shevchenko@linux.intel.com,
        axboe@kernel.dk, rdunlap@infradead.org, tglx@linutronix.de,
        gor@linux.ibm.com
Cc:     kbuild-all@lists.01.org, donghai.w.qiao@gmail.com,
        linux-kernel@vger.kernel.org, Donghai Qiao <dqiao@redhat.com>
Subject: Re: [PATCH v3 08/11] smp: replace smp_call_function_many_cond() with
 __smp_call_mask_cond()
Message-ID: <202205190420.dnidcWc5-lkp@intel.com>
References: <20220517180326.997129-9-dqiao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517180326.997129-9-dqiao@redhat.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Donghai,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linus/master v5.18-rc7]
[cannot apply to tip/x86/core powerpc/next next-20220518]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Donghai-Qiao/smp-cross-CPU-call-interface/20220518-020728
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20220519/202205190420.dnidcWc5-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/84d80dd2d0311a0de7a50290032cb79c13151af1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Donghai-Qiao/smp-cross-CPU-call-interface/20220518-020728
        git checkout 84d80dd2d0311a0de7a50290032cb79c13151af1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/parisc/mm/init.c: In function 'pagetable_init':
   arch/parisc/mm/init.c:623:31: warning: variable 'end_paddr' set but not used [-Wunused-but-set-variable]
     623 |                 unsigned long end_paddr;
         |                               ^~~~~~~~~
   arch/parisc/mm/init.c: In function 'flush_tlb_all':
>> arch/parisc/mm/init.c:850:32: error: 'lush_tlb_all_local' undeclared (first use in this function); did you mean 'flush_tlb_all_local'?
     850 |         smp_call(SMP_CALL_ALL, lush_tlb_all_local, NULL, SMP_CALL_TYPE_SYNC);
         |                                ^~~~~~~~~~~~~~~~~~
         |                                flush_tlb_all_local
   arch/parisc/mm/init.c:850:32: note: each undeclared identifier is reported only once for each function it appears in


vim +850 arch/parisc/mm/init.c

   835	
   836	void flush_tlb_all(void)
   837	{
   838		int do_recycle;
   839	
   840		do_recycle = 0;
   841		spin_lock(&sid_lock);
   842		__inc_irq_stat(irq_tlb_count);
   843		if (dirty_space_ids > RECYCLE_THRESHOLD) {
   844		    BUG_ON(recycle_inuse);  /* FIXME: Use a semaphore/wait queue here */
   845		    get_dirty_sids(&recycle_ndirty,recycle_dirty_array);
   846		    recycle_inuse++;
   847		    do_recycle++;
   848		}
   849		spin_unlock(&sid_lock);
 > 850		smp_call(SMP_CALL_ALL, lush_tlb_all_local, NULL, SMP_CALL_TYPE_SYNC);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
