Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FFB5570EB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 04:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377504AbiFWCKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 22:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377471AbiFWCKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 22:10:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EF1240A9;
        Wed, 22 Jun 2022 19:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655950206; x=1687486206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Hgyl64lTRzl577pdJLwsDI8ZU7ElY/jYelrfOvZLuM=;
  b=JtAUvOp1UxuWGQWEcm21yl6Qk+VU4XewSVTNw3cgXk6yRP9muHkNY/tP
   4kPXizsWViBdU+b4yswKQWLmI/mjnN32O44x7yHmXfhsxLAxCxgBfQ1JW
   sFdEE6Pm20A3KhJVl49uAMy5Znx+NIRigRPWYmsWw6R2QROFzV8jFZ4Sp
   64oywnmZhxKied4CBuOkIIMdeXteyo10NSblx5Ri9o04jr/VY1+EErgjH
   w0Zm12S39EMfuOboe87dl530TjHda8g64Ud30nBB//7Os1kOVyy4TklXN
   fgwm4AIHitkq+mHR208QXOs/h2rFEXKihGNwbyAKZiJzBWPBEpooSGA3z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281676188"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="281676188"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 19:10:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="588441192"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2022 19:10:02 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4CID-0000ML-N5;
        Thu, 23 Jun 2022 02:10:01 +0000
Date:   Thu, 23 Jun 2022 10:09:22 +0800
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
Message-ID: <202206230936.goRWmVwu-lkp@intel.com>
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
config: hexagon-randconfig-r045-20220622 (https://download.01.org/0day-ci/archive/20220623/202206230936.goRWmVwu-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 46be5faaf03466c3751f8a2882bef5a217e15926)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6c59cb940f39b882c20e6858c41df7c1470b930a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Joel-Fernandes-Google/Implement-call_rcu_lazy-and-miscellaneous-fixes/20220623-065447
        git checkout 6c59cb940f39b882c20e6858c41df7c1470b930a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/rcu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> kernel/rcu/rcuscale.c:663:6: warning: no previous prototype for function 'kfree_rcu_lazy' [-Wmissing-prototypes]
   void kfree_rcu_lazy(struct rcu_head *rh)
        ^
   kernel/rcu/rcuscale.c:663:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void kfree_rcu_lazy(struct rcu_head *rh)
   ^
   static 
>> kernel/rcu/rcuscale.c:789:6: warning: no previous prototype for function 'call_rcu_lazy_test1' [-Wmissing-prototypes]
   void call_rcu_lazy_test1(struct rcu_head *rh)
        ^
   kernel/rcu/rcuscale.c:789:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void call_rcu_lazy_test1(struct rcu_head *rh)
   ^
   static 
>> kernel/rcu/rcuscale.c:810:14: error: call to undeclared function 'rcu_scale_get_jiffies_till_flush'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   orig_jif = rcu_scale_get_jiffies_till_flush();
                              ^
>> kernel/rcu/rcuscale.c:813:3: error: call to undeclared function 'rcu_scale_set_jiffies_till_flush'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   rcu_scale_set_jiffies_till_flush(2 * HZ);
                   ^
   2 warnings and 2 errors generated.


vim +/rcu_scale_get_jiffies_till_flush +810 kernel/rcu/rcuscale.c

   661	
   662	/* Used if doing RCU-kfree'ing via call_rcu_lazy(). */
 > 663	void kfree_rcu_lazy(struct rcu_head *rh)
   664	{
   665		struct kfree_obj *obj = container_of(rh, struct kfree_obj, rh);
   666		kfree(obj);
   667	}
   668	
   669	static int
   670	kfree_scale_thread(void *arg)
   671	{
   672		int i, loop = 0;
   673		long me = (long)arg;
   674		struct kfree_obj *alloc_ptr;
   675		u64 start_time, end_time;
   676		long long mem_begin, mem_during = 0;
   677		bool kfree_rcu_test_both;
   678		DEFINE_TORTURE_RANDOM(tr);
   679	
   680		VERBOSE_SCALEOUT_STRING("kfree_scale_thread task started");
   681		set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
   682		set_user_nice(current, MAX_NICE);
   683		kfree_rcu_test_both = (kfree_rcu_test_single == kfree_rcu_test_double);
   684	
   685		start_time = ktime_get_mono_fast_ns();
   686	
   687		if (atomic_inc_return(&n_kfree_scale_thread_started) >= kfree_nrealthreads) {
   688			if (gp_exp)
   689				b_rcu_gp_test_started = cur_ops->exp_completed() / 2;
   690			else
   691				b_rcu_gp_test_started = cur_ops->get_gp_seq();
   692		}
   693	
   694		do {
   695			if (!mem_during) {
   696				mem_during = mem_begin = si_mem_available();
   697			} else if (loop % (kfree_loops / 4) == 0) {
   698				mem_during = (mem_during + si_mem_available()) / 2;
   699			}
   700	
   701			for (i = 0; i < kfree_alloc_num; i++) {
   702				alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
   703				if (!alloc_ptr)
   704					return -ENOMEM;
   705	
   706				if (kfree_rcu_by_lazy) {
   707					call_rcu_lazy(&(alloc_ptr->rh), kfree_rcu_lazy);
   708					continue;
   709				}
   710	
   711				// By default kfree_rcu_test_single and kfree_rcu_test_double are
   712				// initialized to false. If both have the same value (false or true)
   713				// both are randomly tested, otherwise only the one with value true
   714				// is tested.
   715				if ((kfree_rcu_test_single && !kfree_rcu_test_double) ||
   716						(kfree_rcu_test_both && torture_random(&tr) & 0x800))
   717					kfree_rcu(alloc_ptr);
   718				else
   719					kfree_rcu(alloc_ptr, rh);
   720			}
   721	
   722			cond_resched();
   723		} while (!torture_must_stop() && ++loop < kfree_loops);
   724	
   725		if (atomic_inc_return(&n_kfree_scale_thread_ended) >= kfree_nrealthreads) {
   726			end_time = ktime_get_mono_fast_ns();
   727	
   728			if (gp_exp)
   729				b_rcu_gp_test_finished = cur_ops->exp_completed() / 2;
   730			else
   731				b_rcu_gp_test_finished = cur_ops->get_gp_seq();
   732	
   733			pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld, memory footprint: %lldMB\n",
   734			       (unsigned long long)(end_time - start_time), kfree_loops,
   735			       rcuscale_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started),
   736			       (mem_begin - mem_during) >> (20 - PAGE_SHIFT));
   737	
   738			if (shutdown) {
   739				smp_mb(); /* Assign before wake. */
   740				wake_up(&shutdown_wq);
   741			}
   742		}
   743	
   744		torture_kthread_stopping("kfree_scale_thread");
   745		return 0;
   746	}
   747	
   748	static void
   749	kfree_scale_cleanup(void)
   750	{
   751		int i;
   752	
   753		if (kfree_rcu_by_lazy)
   754			rcu_force_call_rcu_to_lazy(false);
   755	
   756		if (torture_cleanup_begin())
   757			return;
   758	
   759		if (kfree_reader_tasks) {
   760			for (i = 0; i < kfree_nrealthreads; i++)
   761				torture_stop_kthread(kfree_scale_thread,
   762						     kfree_reader_tasks[i]);
   763			kfree(kfree_reader_tasks);
   764		}
   765	
   766		torture_cleanup_end();
   767	}
   768	
   769	/*
   770	 * shutdown kthread.  Just waits to be awakened, then shuts down system.
   771	 */
   772	static int
   773	kfree_scale_shutdown(void *arg)
   774	{
   775		wait_event(shutdown_wq,
   776			   atomic_read(&n_kfree_scale_thread_ended) >= kfree_nrealthreads);
   777	
   778		smp_mb(); /* Wake before output. */
   779	
   780		kfree_scale_cleanup();
   781		kernel_power_off();
   782		return -EINVAL;
   783	}
   784	
   785	// Used if doing RCU-kfree'ing via call_rcu_lazy().
   786	unsigned long jiffies_at_lazy_cb;
   787	struct rcu_head lazy_test1_rh;
   788	int rcu_lazy_test1_cb_called;
 > 789	void call_rcu_lazy_test1(struct rcu_head *rh)
   790	{
   791		jiffies_at_lazy_cb = jiffies;
   792		WRITE_ONCE(rcu_lazy_test1_cb_called, 1);
   793	}
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
