Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A2658B0DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 22:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiHEUck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 16:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiHEUcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 16:32:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB495A9
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 13:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659731555; x=1691267555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wuW24Cu2umCId52VIuddWDHuf31qum3IMq03iCe1SAk=;
  b=h4xpdhg9acUpx09WQ1RrpBiH1IJX+20IyuUTo5g63U7wJ7GvGMrukX3A
   WDeUyNAMP2b1TTsHF5vQ0sslh7v0ir8ZzHRNVAJXga61EqpQmisdUzSJe
   FHB4AGAsKNKJwLd+OpQYnS5bZ85rTMk1stvytrFTmHtgiHquAxkG/P4Ih
   JXpkNNEDxGrJFMKCcCUbOe32l+QTXjwQJL11EtixfWo+QX3v4xpHDAxn6
   Aq8q38GmiWukahIUVFWGjAvSid0565nlX4ELLCeBbMQ5cWrn1NAkKtp35
   UA0XS5yBk6rNuo5kEHNrUl++BPEUVd4hoqj6MpcTC0kD7MrUhpq/QIT/z
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="376577687"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="376577687"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 13:32:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="554230392"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Aug 2022 13:32:32 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oK3zj-000Jht-1V;
        Fri, 05 Aug 2022 20:32:31 +0000
Date:   Sat, 6 Aug 2022 04:31:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     kbuild-all@lists.01.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn
Subject: Re: [PATCH 3/3] LoongArch: Add stacktrace support
Message-ID: <202208060426.hJL19duk-lkp@intel.com>
References: <20220728140519.5420-3-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728140519.5420-3-zhangqing@loongson.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qing,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.19 next-20220805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qing-Zhang/LoongArch-Add-guess-unwinder-support/20220728-220739
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 6e7765cb477a9753670d4351d14de93f1e9dbbd4
config: loongarch-randconfig-s033-20220805 (https://download.01.org/0day-ci/archive/20220806/202208060426.hJL19duk-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/32ef6acf6f5ecfadda21be77cbebb07b1c69e56a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qing-Zhang/LoongArch-Add-guess-unwinder-support/20220728-220739
        git checkout 32ef6acf6f5ecfadda21be77cbebb07b1c69e56a
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=loongarch 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> kernel/irq_work.c:278:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/irq_work.c:278:9: sparse:     expected void *ptr
   kernel/irq_work.c:278:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/irq_work.c:278:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/irq_work.c:278:9: sparse:     expected void *ptr
   kernel/irq_work.c:278:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/irq_work.c:278:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/irq_work.c:278:9: sparse:     expected void *ptr
   kernel/irq_work.c:278:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/irq_work.c:278:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/irq_work.c:278:9: sparse:     expected void *ptr
   kernel/irq_work.c:278:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/irq_work.c:278:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/irq_work.c:278:9: sparse:     expected void *ptr
   kernel/irq_work.c:278:9: sparse:     got int [noderef] __percpu *
>> kernel/irq_work.c:278:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/irq_work.c:278:9: sparse:     expected void *ptr
   kernel/irq_work.c:278:9: sparse:     got int [noderef] __percpu *
>> kernel/irq_work.c:278:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/irq_work.c:278:9: sparse:     expected void *ptr
   kernel/irq_work.c:278:9: sparse:     got int [noderef] __percpu *
>> kernel/irq_work.c:278:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/irq_work.c:278:9: sparse:     expected void *ptr
   kernel/irq_work.c:278:9: sparse:     got int [noderef] __percpu *
--
   kernel/fork.c:1307:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *[assigned] old_exe_file @@     got struct file [noderef] __rcu *[assigned] __res @@
   kernel/fork.c:1307:22: sparse:     expected struct file *[assigned] old_exe_file
   kernel/fork.c:1307:22: sparse:     got struct file [noderef] __rcu *[assigned] __res
   kernel/fork.c:1638:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:1638:38: sparse:     expected struct refcount_struct [usertype] *r
   kernel/fork.c:1638:38: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:1647:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1647:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1647:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:1648:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1648:36: sparse:     expected void const *
   kernel/fork.c:1648:36: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1649:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1649:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1649:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2061:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2061:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2061:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2065:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2065:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2065:33: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/fork.c:2096:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/fork.c:2096:9: sparse:     expected void *ptr
   kernel/fork.c:2096:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/fork.c:2096:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/fork.c:2096:9: sparse:     expected void *ptr
   kernel/fork.c:2096:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/fork.c:2096:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/fork.c:2096:9: sparse:     expected void *ptr
   kernel/fork.c:2096:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/fork.c:2096:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/fork.c:2096:9: sparse:     expected void *ptr
   kernel/fork.c:2096:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/fork.c:2096:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/fork.c:2096:9: sparse:     expected void *ptr
   kernel/fork.c:2096:9: sparse:     got int [noderef] __percpu *
>> kernel/fork.c:2096:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/fork.c:2096:9: sparse:     expected void *ptr
   kernel/fork.c:2096:9: sparse:     got int [noderef] __percpu *
>> kernel/fork.c:2096:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/fork.c:2096:9: sparse:     expected void *ptr
   kernel/fork.c:2096:9: sparse:     got int [noderef] __percpu *
>> kernel/fork.c:2096:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/fork.c:2096:9: sparse:     expected void *ptr
   kernel/fork.c:2096:9: sparse:     got int [noderef] __percpu *
   kernel/fork.c:2385:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct *task @@
   kernel/fork.c:2385:32: sparse:     expected struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:2385:32: sparse:     got struct task_struct *task
   kernel/fork.c:2394:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2394:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2394:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2439:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
   kernel/fork.c:2439:54: sparse:     expected struct list_head *head
   kernel/fork.c:2439:54: sparse:     got struct list_head [noderef] __rcu *
   kernel/fork.c:2460:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2460:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2460:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2481:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2481:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2481:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2508:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/fork.c:2508:28: sparse:     expected struct sighand_struct *sighand
   kernel/fork.c:2508:28: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/fork.c:2537:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2537:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2537:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2539:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2539:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2539:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2975:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/fork.c:2975:24: sparse:     expected struct task_struct *[assigned] parent
   kernel/fork.c:2975:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:3056:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct const [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:3056:43: sparse:     expected struct refcount_struct const [usertype] *r
   kernel/fork.c:3056:43: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:2106:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c: note: in included file (through include/uapi/asm-generic/bpf_perf_event.h, arch/loongarch/include/generated/uapi/asm/bpf_perf_event.h, ...):
   include/linux/ptrace.h:210:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:210:45: sparse:     expected struct task_struct *new_parent
   include/linux/ptrace.h:210:45: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:210:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   include/linux/ptrace.h:210:62: sparse:     expected struct cred const *ptracer_cred
   include/linux/ptrace.h:210:62: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/fork.c:2437:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2438:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h):
   arch/loongarch/include/asm/uaccess.h:232:32: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/loongarch/include/asm/uaccess.h:232:32: sparse:     expected void const *from
   arch/loongarch/include/asm/uaccess.h:232:32: sparse:     got void const [noderef] __user *from
   arch/loongarch/include/asm/uaccess.h:232:32: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/loongarch/include/asm/uaccess.h:232:32: sparse:     expected void const *from
   arch/loongarch/include/asm/uaccess.h:232:32: sparse:     got void const [noderef] __user *from
--
>> kernel/softirq.c:351:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:351:9: sparse:     expected void *ptr
   kernel/softirq.c:351:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/softirq.c:351:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:351:9: sparse:     expected void *ptr
   kernel/softirq.c:351:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/softirq.c:351:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:351:9: sparse:     expected void *ptr
   kernel/softirq.c:351:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/softirq.c:351:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:351:9: sparse:     expected void *ptr
   kernel/softirq.c:351:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/softirq.c:351:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:351:9: sparse:     expected void *ptr
   kernel/softirq.c:351:9: sparse:     got int [noderef] __percpu *
>> kernel/softirq.c:351:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:351:9: sparse:     expected void *ptr
   kernel/softirq.c:351:9: sparse:     got int [noderef] __percpu *
>> kernel/softirq.c:351:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:351:9: sparse:     expected void *ptr
   kernel/softirq.c:351:9: sparse:     got int [noderef] __percpu *
>> kernel/softirq.c:351:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:351:9: sparse:     expected void *ptr
   kernel/softirq.c:351:9: sparse:     got int [noderef] __percpu *
   kernel/softirq.c:376:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:376:9: sparse:     expected void *ptr
   kernel/softirq.c:376:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/softirq.c:376:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:376:9: sparse:     expected void *ptr
   kernel/softirq.c:376:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/softirq.c:376:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:376:9: sparse:     expected void *ptr
   kernel/softirq.c:376:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/softirq.c:376:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:376:9: sparse:     expected void *ptr
   kernel/softirq.c:376:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/softirq.c:376:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:376:9: sparse:     expected void *ptr
   kernel/softirq.c:376:9: sparse:     got int [noderef] __percpu *
   kernel/softirq.c:376:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:376:9: sparse:     expected void *ptr
   kernel/softirq.c:376:9: sparse:     got int [noderef] __percpu *
   kernel/softirq.c:376:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:376:9: sparse:     expected void *ptr
   kernel/softirq.c:376:9: sparse:     got int [noderef] __percpu *
   kernel/softirq.c:376:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:376:9: sparse:     expected void *ptr
   kernel/softirq.c:376:9: sparse:     got int [noderef] __percpu *
   kernel/softirq.c:711:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:711:9: sparse:     expected void *ptr
   kernel/softirq.c:711:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/softirq.c:711:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:711:9: sparse:     expected void *ptr
   kernel/softirq.c:711:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/softirq.c:711:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:711:9: sparse:     expected void *ptr
   kernel/softirq.c:711:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/softirq.c:711:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/softirq.c:711:9: sparse:     expected void *ptr
   kernel/softirq.c:711:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/softirq.c:711:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:711:9: sparse:     expected void *ptr
   kernel/softirq.c:711:9: sparse:     got int [noderef] __percpu *
   kernel/softirq.c:711:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:711:9: sparse:     expected void *ptr
   kernel/softirq.c:711:9: sparse:     got int [noderef] __percpu *
   kernel/softirq.c:711:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:711:9: sparse:     expected void *ptr
   kernel/softirq.c:711:9: sparse:     got int [noderef] __percpu *
   kernel/softirq.c:711:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/softirq.c:711:9: sparse:     expected void *ptr
   kernel/softirq.c:711:9: sparse:     got int [noderef] __percpu *
--
>> kernel/workqueue.c:1433:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/workqueue.c:1433:9: sparse:     expected void *ptr
   kernel/workqueue.c:1433:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/workqueue.c:1433:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/workqueue.c:1433:9: sparse:     expected void *ptr
   kernel/workqueue.c:1433:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/workqueue.c:1433:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/workqueue.c:1433:9: sparse:     expected void *ptr
   kernel/workqueue.c:1433:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/workqueue.c:1433:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/workqueue.c:1433:9: sparse:     expected void *ptr
   kernel/workqueue.c:1433:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/workqueue.c:1433:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/workqueue.c:1433:9: sparse:     expected void *ptr
   kernel/workqueue.c:1433:9: sparse:     got int [noderef] __percpu *
>> kernel/workqueue.c:1433:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/workqueue.c:1433:9: sparse:     expected void *ptr
   kernel/workqueue.c:1433:9: sparse:     got int [noderef] __percpu *
>> kernel/workqueue.c:1433:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/workqueue.c:1433:9: sparse:     expected void *ptr
   kernel/workqueue.c:1433:9: sparse:     got int [noderef] __percpu *
>> kernel/workqueue.c:1433:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/workqueue.c:1433:9: sparse:     expected void *ptr
   kernel/workqueue.c:1433:9: sparse:     got int [noderef] __percpu *
   kernel/workqueue.c:3537:13: sparse: sparse: context imbalance in 'wq_manager_inactive' - different lock contexts for basic block
   kernel/workqueue.c:3592:9: sparse: sparse: context imbalance in 'put_unbound_pool' - unexpected unlock
--
>> kernel/locking/lockdep.c:2562:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:2562:9: sparse:     expected void *ptr
   kernel/locking/lockdep.c:2562:9: sparse:     got int [noderef] __percpu *
>> kernel/locking/lockdep.c:2562:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:2562:9: sparse:     expected void *ptr
   kernel/locking/lockdep.c:2562:9: sparse:     got int [noderef] __percpu *
>> kernel/locking/lockdep.c:2562:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:2562:9: sparse:     expected void *ptr
   kernel/locking/lockdep.c:2562:9: sparse:     got int [noderef] __percpu *
>> kernel/locking/lockdep.c:2562:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:2562:9: sparse:     expected void *ptr
   kernel/locking/lockdep.c:2562:9: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:3943:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:3943:9: sparse:     expected void *ptr
   kernel/locking/lockdep.c:3943:9: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:3943:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:3943:9: sparse:     expected void *ptr
   kernel/locking/lockdep.c:3943:9: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:3943:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:3943:9: sparse:     expected void *ptr
   kernel/locking/lockdep.c:3943:9: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:3943:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:3943:9: sparse:     expected void *ptr
   kernel/locking/lockdep.c:3943:9: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4282:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4282:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4282:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:4282:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4282:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4282:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:4282:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4282:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4282:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:4282:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4282:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4282:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:4285:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4285:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4285:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4285:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4285:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4285:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4285:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4285:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4285:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4285:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4285:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4285:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4351:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4351:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4351:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:4351:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4351:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4351:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:4351:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4351:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4351:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:4351:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4351:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4351:13: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/lockdep.c:4354:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4354:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4354:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4354:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4354:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4354:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4354:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4354:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4354:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4354:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4354:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4354:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4414:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4414:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4414:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4414:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4414:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4414:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4414:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4414:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4414:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4414:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4414:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4414:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4465:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4465:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4465:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4465:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4465:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4465:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4465:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4465:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4465:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:4465:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:4465:13: sparse:     expected void *ptr
   kernel/locking/lockdep.c:4465:13: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:5505:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:5505:21: sparse:     expected void *ptr
   kernel/locking/lockdep.c:5505:21: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:5505:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:5505:21: sparse:     expected void *ptr
   kernel/locking/lockdep.c:5505:21: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:5505:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:5505:21: sparse:     expected void *ptr
   kernel/locking/lockdep.c:5505:21: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:5505:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:5505:21: sparse:     expected void *ptr
   kernel/locking/lockdep.c:5505:21: sparse:     got int [noderef] __percpu *
   kernel/locking/lockdep.c:5509:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/lockdep.c:5509:21: sparse:     expected void *ptr
--
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got unsigned int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got unsigned int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got unsigned int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got unsigned int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/loongarch/include/asm/uaccess.h:232:32: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
--
   kernel/rcu/update.c: note: in included file:
>> kernel/rcu/tasks.h:256:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:256:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:256:17: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tasks.h:256:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:256:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:256:17: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tasks.h:256:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:256:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:256:17: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tasks.h:256:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:256:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:256:17: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tasks.h:256:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:256:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:256:17: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tasks.h:256:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:256:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:256:17: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tasks.h:256:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:256:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:256:17: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tasks.h:256:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:256:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:256:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:303:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:303:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:303:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:303:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:303:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:303:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:303:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:303:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:303:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:303:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:303:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:303:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:303:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:303:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:303:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:303:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:303:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:303:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:303:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:303:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:303:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:303:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:303:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:303:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:309:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:309:9: sparse:     expected void *ptr
   kernel/rcu/tasks.h:309:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:309:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:309:9: sparse:     expected void *ptr
   kernel/rcu/tasks.h:309:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:309:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:309:9: sparse:     expected void *ptr
   kernel/rcu/tasks.h:309:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:309:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:309:9: sparse:     expected void *ptr
   kernel/rcu/tasks.h:309:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:309:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:309:9: sparse:     expected void *ptr
   kernel/rcu/tasks.h:309:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:309:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:309:9: sparse:     expected void *ptr
   kernel/rcu/tasks.h:309:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:309:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:309:9: sparse:     expected void *ptr
   kernel/rcu/tasks.h:309:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:309:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:309:9: sparse:     expected void *ptr
   kernel/rcu/tasks.h:309:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:375:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:375:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:375:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:375:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:375:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:375:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:375:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:375:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:375:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:375:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:375:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:375:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:375:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:375:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:375:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:375:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:375:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:375:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:375:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:375:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:375:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:375:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:375:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:375:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:415:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:415:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:415:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:415:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:415:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:415:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:415:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:415:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:415:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:415:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:415:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:415:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tasks.h:415:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:415:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:415:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:415:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:415:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:415:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:415:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:415:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:415:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:415:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tasks.h:415:17: sparse:     expected void *ptr
   kernel/rcu/tasks.h:415:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tasks.h:476:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tasks.h:476:9: sparse:     expected void *ptr
--
>> kernel/entry/common.c:195:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:195:9: sparse:     expected void *ptr
   kernel/entry/common.c:195:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/entry/common.c:195:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:195:9: sparse:     expected void *ptr
   kernel/entry/common.c:195:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/entry/common.c:195:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:195:9: sparse:     expected void *ptr
   kernel/entry/common.c:195:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/entry/common.c:195:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:195:9: sparse:     expected void *ptr
   kernel/entry/common.c:195:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/entry/common.c:195:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:195:9: sparse:     expected void *ptr
   kernel/entry/common.c:195:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:195:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:195:9: sparse:     expected void *ptr
   kernel/entry/common.c:195:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:195:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:195:9: sparse:     expected void *ptr
   kernel/entry/common.c:195:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:195:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:195:9: sparse:     expected void *ptr
   kernel/entry/common.c:195:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:208:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:208:9: sparse:     expected void *ptr
   kernel/entry/common.c:208:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/entry/common.c:208:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:208:9: sparse:     expected void *ptr
   kernel/entry/common.c:208:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/entry/common.c:208:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:208:9: sparse:     expected void *ptr
   kernel/entry/common.c:208:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/entry/common.c:208:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:208:9: sparse:     expected void *ptr
   kernel/entry/common.c:208:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/entry/common.c:208:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:208:9: sparse:     expected void *ptr
   kernel/entry/common.c:208:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:208:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:208:9: sparse:     expected void *ptr
   kernel/entry/common.c:208:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:208:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:208:9: sparse:     expected void *ptr
   kernel/entry/common.c:208:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:208:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:208:9: sparse:     expected void *ptr
   kernel/entry/common.c:208:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:404:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:404:9: sparse:     expected void *ptr
   kernel/entry/common.c:404:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/entry/common.c:404:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:404:9: sparse:     expected void *ptr
   kernel/entry/common.c:404:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/entry/common.c:404:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:404:9: sparse:     expected void *ptr
   kernel/entry/common.c:404:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/entry/common.c:404:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/entry/common.c:404:9: sparse:     expected void *ptr
   kernel/entry/common.c:404:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/entry/common.c:404:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:404:9: sparse:     expected void *ptr
   kernel/entry/common.c:404:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:404:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:404:9: sparse:     expected void *ptr
   kernel/entry/common.c:404:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:404:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:404:9: sparse:     expected void *ptr
   kernel/entry/common.c:404:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:404:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:404:9: sparse:     expected void *ptr
   kernel/entry/common.c:404:9: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:447:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:447:29: sparse:     expected void *ptr
   kernel/entry/common.c:447:29: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:447:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:447:29: sparse:     expected void *ptr
   kernel/entry/common.c:447:29: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:447:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:447:29: sparse:     expected void *ptr
   kernel/entry/common.c:447:29: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c:447:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:447:29: sparse:     expected void *ptr
   kernel/entry/common.c:447:29: sparse:     got int [noderef] __percpu *
--
>> kernel/time/hrtimer.c:1006:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/hrtimer.c:1006:9: sparse:     expected void *ptr
   kernel/time/hrtimer.c:1006:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/hrtimer.c:1006:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/hrtimer.c:1006:9: sparse:     expected void *ptr
   kernel/time/hrtimer.c:1006:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/hrtimer.c:1006:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/hrtimer.c:1006:9: sparse:     expected void *ptr
   kernel/time/hrtimer.c:1006:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/hrtimer.c:1006:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/hrtimer.c:1006:9: sparse:     expected void *ptr
   kernel/time/hrtimer.c:1006:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/hrtimer.c:1006:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/hrtimer.c:1006:9: sparse:     expected void *ptr
   kernel/time/hrtimer.c:1006:9: sparse:     got int [noderef] __percpu *
>> kernel/time/hrtimer.c:1006:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/hrtimer.c:1006:9: sparse:     expected void *ptr
   kernel/time/hrtimer.c:1006:9: sparse:     got int [noderef] __percpu *
>> kernel/time/hrtimer.c:1006:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/hrtimer.c:1006:9: sparse:     expected void *ptr
   kernel/time/hrtimer.c:1006:9: sparse:     got int [noderef] __percpu *
>> kernel/time/hrtimer.c:1006:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/hrtimer.c:1006:9: sparse:     expected void *ptr
   kernel/time/hrtimer.c:1006:9: sparse:     got int [noderef] __percpu *
--
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got int [noderef] __percpu *
>> kernel/time/posix-cpu-timers.c:1380:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     expected void *ptr
   kernel/time/posix-cpu-timers.c:1380:9: sparse:     got int [noderef] __percpu *
   kernel/time/posix-cpu-timers.c: note: in included file:
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/time/posix-cpu-timers.c:42:5: sparse: sparse: context imbalance in 'update_rlimit_cpu' - different lock contexts for basic block
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:752:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:752:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:752:37: sparse:     got struct spinlock [noderef] __rcu *
--
   lib/flex_proportions.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/percpu_counter.h, ...):
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
>> include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *

vim +278 kernel/irq_work.c

76a33061b9323b Frederic Weisbecker       2014-08-16  271  
e360adbe29241a Peter Zijlstra            2010-10-14  272  /*
e360adbe29241a Peter Zijlstra            2010-10-14  273   * Synchronize against the irq_work @entry, ensures the entry is not
e360adbe29241a Peter Zijlstra            2010-10-14  274   * currently in use.
e360adbe29241a Peter Zijlstra            2010-10-14  275   */
38aaf8090d34b6 Huang Ying                2011-09-08  276  void irq_work_sync(struct irq_work *work)
e360adbe29241a Peter Zijlstra            2010-10-14  277  {
3c7169a3bf8216 Frederic Weisbecker       2017-11-06 @278  	lockdep_assert_irqs_enabled();
810979682ccc98 Sebastian Andrzej Siewior 2021-10-06  279  	might_sleep();
810979682ccc98 Sebastian Andrzej Siewior 2021-10-06  280  
09089db79859cb Sebastian Andrzej Siewior 2021-10-06  281  	if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
09089db79859cb Sebastian Andrzej Siewior 2021-10-06  282  	    !arch_irq_work_has_interrupt()) {
810979682ccc98 Sebastian Andrzej Siewior 2021-10-06  283  		rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work),
810979682ccc98 Sebastian Andrzej Siewior 2021-10-06  284  				   TASK_UNINTERRUPTIBLE);
810979682ccc98 Sebastian Andrzej Siewior 2021-10-06  285  		return;
810979682ccc98 Sebastian Andrzej Siewior 2021-10-06  286  	}
e360adbe29241a Peter Zijlstra            2010-10-14  287  
7a9f50a05843fe Peter Zijlstra            2020-06-15  288  	while (irq_work_is_busy(work))
e360adbe29241a Peter Zijlstra            2010-10-14  289  		cpu_relax();
e360adbe29241a Peter Zijlstra            2010-10-14  290  }
e360adbe29241a Peter Zijlstra            2010-10-14  291  EXPORT_SYMBOL_GPL(irq_work_sync);
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  292  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
