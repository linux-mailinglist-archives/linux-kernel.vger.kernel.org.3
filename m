Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCE5557141
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 05:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiFWDC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 23:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiFWDBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:01:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D8B11E;
        Wed, 22 Jun 2022 20:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655953274; x=1687489274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jcv8I77tN1NvyruOZ4gDU9yRls547ADMhJwmdGl0qwA=;
  b=WsJh7NmX2iCY200Y4/80o4/cwV81EbmyJN6EIt644exCWqM7EsRI/Po3
   6G/06gJf5zPk2+gleg4g8LNCjI3wzQV1Xy2+zKgF/v+isIHbZv78sVX7i
   iUFrPOn/iC19bKdEYzH0fLcrrtAydfT/rSSgJxmLsnVc5TkQGTWc9LzRV
   NfSx3t7Vy5CryAm+fLzIbyZ04AoFA9W5BIM+mWxIJvCv0hwoEnYUIB1Rv
   8Bo3D3UmmpucibPCYbRxOgp5jaT6G9S0/SDQ3IJdg5UbVA2TyqrZGRT0V
   jC+06b9jK5rW7RQ2GCqapVQenOeDwz+MurXvue2QPN7taj47z/dev36f2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="366929260"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="366929260"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 20:01:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="563276486"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2022 20:01:11 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4D5i-0000cH-AR;
        Thu, 23 Jun 2022 03:01:10 +0000
Date:   Thu, 23 Jun 2022 11:00:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH v2 6/8] rcuscale: Add test for using call_rcu_lazy() to
 emulate kfree_rcu()
Message-ID: <202206231028.gVHd7wR5-lkp@intel.com>
References: <20220622225102.2112026-8-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622225102.2112026-8-joel@joelfernandes.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Joel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19-rc3 next-20220622]
[cannot apply to paulmck-rcu/dev]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Joel-Fernandes-Google/Implement-call_rcu_lazy-and-miscellaneous-fixes/20220623-065447
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git de5c208d533a46a074eb46ea17f672cc005a7269
config: s390-randconfig-r044-20220622 (https://download.01.org/0day-ci/archive/20220623/202206231028.gVHd7wR5-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 46be5faaf03466c3751f8a2882bef5a217e15926)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/6c59cb940f39b882c20e6858c41df7c1470b930a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Joel-Fernandes-Google/Implement-call_rcu_lazy-and-miscellaneous-fixes/20220623-065447
        git checkout 6c59cb940f39b882c20e6858c41df7c1470b930a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: kernel/rcu/rcuscale.o: in function `kfree_scale_init':
>> kernel/rcu/rcuscale.c:810: undefined reference to `rcu_scale_get_jiffies_till_flush'
>> /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: kernel/rcu/rcuscale.c:813: undefined reference to `rcu_scale_set_jiffies_till_flush'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: kernel/rcu/rcuscale.c:822: undefined reference to `rcu_scale_set_jiffies_till_flush'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: certs/system_keyring.o: in function `load_system_certificate_list':
   certs/system_keyring.c:207: undefined reference to `x509_load_certificate_list'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/dma/fsl-edma.o: in function `fsl_edma_probe':
   drivers/dma/fsl-edma.c:302: undefined reference to `devm_ioremap_resource'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/dma/fsl-edma.c:327: undefined reference to `devm_ioremap_resource'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/dma/idma64.o: in function `idma64_platform_probe':
   drivers/dma/idma64.c:644: undefined reference to `devm_ioremap_resource'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
   drivers/clocksource/timer-of.c:151: undefined reference to `iounmap'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_base_init':
   drivers/clocksource/timer-of.c:159: undefined reference to `of_iomap'
   /opt/cross/gcc-11.3.0-nolibc/s390x-linux/bin/s390x-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_cleanup':
   drivers/clocksource/timer-of.c:151: undefined reference to `iounmap'


vim +810 kernel/rcu/rcuscale.c

   794	
   795	static int __init
   796	kfree_scale_init(void)
   797	{
   798		long i;
   799		int firsterr = 0;
   800		unsigned long orig_jif, jif_start;
   801	
   802		// Force all call_rcu() to call_rcu_lazy() so that non-lazy CBs
   803		// do not remove laziness of the lazy ones (since the test tries
   804		// to stress call_rcu_lazy() for OOM).
   805		//
   806		// Also, do a quick self-test to ensure laziness is as much as
   807		// expected.
   808		if (kfree_rcu_by_lazy) {
   809			/* do a test to check the timeout. */
 > 810			orig_jif = rcu_scale_get_jiffies_till_flush();
   811	
   812			rcu_force_call_rcu_to_lazy(true);
 > 813			rcu_scale_set_jiffies_till_flush(2 * HZ);
   814			rcu_barrier();
   815	
   816			jif_start = jiffies;
   817			jiffies_at_lazy_cb = 0;
   818			call_rcu_lazy(&lazy_test1_rh, call_rcu_lazy_test1);
   819	
   820			smp_cond_load_relaxed(&rcu_lazy_test1_cb_called, VAL == 1);
   821	
   822			rcu_scale_set_jiffies_till_flush(orig_jif);
   823	
   824			if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
   825				pr_alert("Lazy CBs are not being lazy as expected!\n");
   826				return -1;
   827			}
   828	
   829			if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
   830				pr_alert("Lazy CBs are being too lazy!\n");
   831				return -1;
   832			}
   833		}
   834	
   835		kfree_nrealthreads = compute_real(kfree_nthreads);
   836		/* Start up the kthreads. */
   837		if (shutdown) {
   838			init_waitqueue_head(&shutdown_wq);
   839			firsterr = torture_create_kthread(kfree_scale_shutdown, NULL,
   840							  shutdown_task);
   841			if (torture_init_error(firsterr))
   842				goto unwind;
   843			schedule_timeout_uninterruptible(1);
   844		}
   845	
   846		pr_alert("kfree object size=%zu, kfree_rcu_by_lazy=%d\n",
   847				kfree_mult * sizeof(struct kfree_obj),
   848				kfree_rcu_by_lazy);
   849	
   850		kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
   851				       GFP_KERNEL);
   852		if (kfree_reader_tasks == NULL) {
   853			firsterr = -ENOMEM;
   854			goto unwind;
   855		}
   856	
   857		for (i = 0; i < kfree_nrealthreads; i++) {
   858			firsterr = torture_create_kthread(kfree_scale_thread, (void *)i,
   859							  kfree_reader_tasks[i]);
   860			if (torture_init_error(firsterr))
   861				goto unwind;
   862		}
   863	
   864		while (atomic_read(&n_kfree_scale_thread_started) < kfree_nrealthreads)
   865			schedule_timeout_uninterruptible(1);
   866	
   867		torture_init_end();
   868		return 0;
   869	
   870	unwind:
   871		torture_init_end();
   872		kfree_scale_cleanup();
   873		return firsterr;
   874	}
   875	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
