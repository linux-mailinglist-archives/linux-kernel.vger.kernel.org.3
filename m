Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409F4591E7B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 07:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbiHNFbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 01:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiHNFbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 01:31:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19862F3B0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660455106; x=1691991106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CyYXgFPiTZBF4hllQ9D5bfoHKsevy0exwVXcfUVUP9U=;
  b=dAUqssxT5g958TndPPoXCcKA4oJctLrk8RbSI2D03eCCr50maZYwRZfr
   pnUH7HLKULww/kfVH0yuKVH92pl0Lnr1UK/P9k7+OhZxPoLg5pHsmFt7D
   lyg8v+GEZP0eERjYFK4Hzxc+K0zrSnPzEp8Jodwxzz7KocQDVDAAN1Oh2
   a3l/Knqs8+/6x+kRH7D147UFw/VH9HjqR6guH3tPFIpGtb8+OZgOGKBCh
   VB/GEI7tYexfBg5dInYfLgIAo61Qyhw6Zs0uiRXVeb6zCCii3/0xuYNLI
   0hlpNJAYpcSlvzLkqOdFV/Jh4j2yTgPfV3HZN+gdee+rel6enwBK2HUWZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="378088188"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="378088188"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 22:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="602876183"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Aug 2022 22:31:43 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN6Du-0002X1-2m;
        Sun, 14 Aug 2022 05:31:42 +0000
Date:   Sun, 14 Aug 2022 13:31:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     kbuild-all@lists.01.org, WANG Xuerui <kernel@xen0n.name>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn,
        zhangqing@loongson.cn
Subject: Re: [PATCH 3/4] LoongArch: Add stacktrace support
Message-ID: <202208141339.jCYoEcIL-lkp@intel.com>
References: <20220801121726.9681-4-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801121726.9681-4-zhangqing@loongson.cn>
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
[also build test WARNING on v5.19]
[cannot apply to next-20220812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qing-Zhang/LoongArch-Add-unwinder-support/20220801-204020
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3d7cb6b04c3f3115719235cc6866b10326de34cd
config: loongarch-randconfig-s033-20220814 (https://download.01.org/0day-ci/archive/20220814/202208141339.jCYoEcIL-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/102a43b57dafc9c0058a458a62d4133eb8020cbc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qing-Zhang/LoongArch-Add-unwinder-support/20220801-204020
        git checkout 102a43b57dafc9c0058a458a62d4133eb8020cbc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> kernel/smp.c:571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:571:9: sparse:     expected void *ptr
   kernel/smp.c:571:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/smp.c:571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:571:9: sparse:     expected void *ptr
   kernel/smp.c:571:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/smp.c:571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:571:9: sparse:     expected void *ptr
   kernel/smp.c:571:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/smp.c:571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:571:9: sparse:     expected void *ptr
   kernel/smp.c:571:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/smp.c:571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:571:9: sparse:     expected void *ptr
   kernel/smp.c:571:9: sparse:     got int [noderef] __percpu *
>> kernel/smp.c:571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:571:9: sparse:     expected void *ptr
   kernel/smp.c:571:9: sparse:     got int [noderef] __percpu *
>> kernel/smp.c:571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:571:9: sparse:     expected void *ptr
   kernel/smp.c:571:9: sparse:     got int [noderef] __percpu *
>> kernel/smp.c:571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:571:9: sparse:     expected void *ptr
   kernel/smp.c:571:9: sparse:     got int [noderef] __percpu *
   kernel/smp.c:895:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:895:9: sparse:     expected void *ptr
   kernel/smp.c:895:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/smp.c:895:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:895:9: sparse:     expected void *ptr
   kernel/smp.c:895:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/smp.c:895:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:895:9: sparse:     expected void *ptr
   kernel/smp.c:895:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/smp.c:895:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:895:9: sparse:     expected void *ptr
   kernel/smp.c:895:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/smp.c:895:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:895:9: sparse:     expected void *ptr
   kernel/smp.c:895:9: sparse:     got int [noderef] __percpu *
   kernel/smp.c:895:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:895:9: sparse:     expected void *ptr
   kernel/smp.c:895:9: sparse:     got int [noderef] __percpu *
   kernel/smp.c:895:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:895:9: sparse:     expected void *ptr
   kernel/smp.c:895:9: sparse:     got int [noderef] __percpu *
   kernel/smp.c:895:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:895:9: sparse:     expected void *ptr
   kernel/smp.c:895:9: sparse:     got int [noderef] __percpu *
   kernel/smp.c:905:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:905:17: sparse:     expected void *ptr
   kernel/smp.c:905:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/smp.c:905:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:905:17: sparse:     expected void *ptr
   kernel/smp.c:905:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/smp.c:905:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:905:17: sparse:     expected void *ptr
   kernel/smp.c:905:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/smp.c:905:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/smp.c:905:17: sparse:     expected void *ptr
   kernel/smp.c:905:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/smp.c:905:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:905:17: sparse:     expected void *ptr
   kernel/smp.c:905:17: sparse:     got int [noderef] __percpu *
   kernel/smp.c:905:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:905:17: sparse:     expected void *ptr
   kernel/smp.c:905:17: sparse:     got int [noderef] __percpu *
   kernel/smp.c:905:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:905:17: sparse:     expected void *ptr
   kernel/smp.c:905:17: sparse:     got int [noderef] __percpu *
   kernel/smp.c:905:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/smp.c:905:17: sparse:     expected void *ptr
   kernel/smp.c:905:17: sparse:     got int [noderef] __percpu *
--
>> kernel/sched/fair.c:6475:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/sched/fair.c:6475:9: sparse:     expected void *ptr
   kernel/sched/fair.c:6475:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/sched/fair.c:6475:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/sched/fair.c:6475:9: sparse:     expected void *ptr
   kernel/sched/fair.c:6475:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/sched/fair.c:6475:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/sched/fair.c:6475:9: sparse:     expected void *ptr
   kernel/sched/fair.c:6475:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/sched/fair.c:6475:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/sched/fair.c:6475:9: sparse:     expected void *ptr
   kernel/sched/fair.c:6475:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/sched/fair.c:6475:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/fair.c:6475:9: sparse:     expected void *ptr
   kernel/sched/fair.c:6475:9: sparse:     got int [noderef] __percpu *
>> kernel/sched/fair.c:6475:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/fair.c:6475:9: sparse:     expected void *ptr
   kernel/sched/fair.c:6475:9: sparse:     got int [noderef] __percpu *
>> kernel/sched/fair.c:6475:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/fair.c:6475:9: sparse:     expected void *ptr
   kernel/sched/fair.c:6475:9: sparse:     got int [noderef] __percpu *
>> kernel/sched/fair.c:6475:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/fair.c:6475:9: sparse:     expected void *ptr
   kernel/sched/fair.c:6475:9: sparse:     got int [noderef] __percpu *
   kernel/sched/fair.c:930:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_entity *se @@     got struct sched_entity [noderef] __rcu * @@
   kernel/sched/fair.c:930:34: sparse:     expected struct sched_entity *se
   kernel/sched/fair.c:930:34: sparse:     got struct sched_entity [noderef] __rcu *
   kernel/sched/fair.c:10928:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:10928:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:10928:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:5591:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:5591:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:5591:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:5846:1: sparse: sparse: symbol '__pcpu_scope_load_balance_mask' was not declared. Should it be static?
   kernel/sched/fair.c:5847:1: sparse: sparse: symbol '__pcpu_scope_select_idle_mask' was not declared. Should it be static?
   kernel/sched/fair.c:6774:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:6774:20: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:6774:20: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:6908:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:6908:9: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/fair.c:6908:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:7106:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:7106:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:7106:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:7404:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:7404:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:7404:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:8389:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/fair.c:8389:40: sparse:     expected struct sched_domain *child
   kernel/sched/fair.c:8389:40: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/fair.c:8933:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:8933:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:8933:22: sparse:    struct task_struct *
   kernel/sched/fair.c:10203:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:10203:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:10203:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:9863:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *sd_parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:9863:44: sparse:     expected struct sched_domain *sd_parent
   kernel/sched/fair.c:9863:44: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:10299:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:10299:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:10299:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:5520:35: sparse: sparse: marked inline, but without a definition
   kernel/sched/fair.c: note: in included file:
   kernel/sched/sched.h:2018:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2176:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2018:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2018:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct *
--
>> kernel/sched/core.c:597:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/sched/core.c:597:9: sparse:     expected void *ptr
   kernel/sched/core.c:597:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/sched/core.c:597:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/sched/core.c:597:9: sparse:     expected void *ptr
   kernel/sched/core.c:597:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/sched/core.c:597:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/sched/core.c:597:9: sparse:     expected void *ptr
   kernel/sched/core.c:597:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/sched/core.c:597:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/sched/core.c:597:9: sparse:     expected void *ptr
   kernel/sched/core.c:597:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/sched/core.c:597:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/core.c:597:9: sparse:     expected void *ptr
   kernel/sched/core.c:597:9: sparse:     got int [noderef] __percpu *
>> kernel/sched/core.c:597:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/core.c:597:9: sparse:     expected void *ptr
   kernel/sched/core.c:597:9: sparse:     got int [noderef] __percpu *
>> kernel/sched/core.c:597:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/core.c:597:9: sparse:     expected void *ptr
   kernel/sched/core.c:597:9: sparse:     got int [noderef] __percpu *
>> kernel/sched/core.c:597:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/sched/core.c:597:9: sparse:     expected void *ptr
   kernel/sched/core.c:597:9: sparse:     got int [noderef] __percpu *
   kernel/sched/core.c:780:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:780:48: sparse:     expected struct task_struct *p
   kernel/sched/core.c:780:48: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1033:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:1033:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:1033:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:1091:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/core.c:1091:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/core.c:1091:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/core.c:2197:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2197:33: sparse:     expected struct task_struct *p
   kernel/sched/core.c:2197:33: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:2197:68: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:2197:68: sparse:     expected struct task_struct *tsk
   kernel/sched/core.c:2197:68: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:3597:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/core.c:3597:17: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/core.c:3597:17: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/core.c:3794:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct const *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:3794:28: sparse:     expected struct task_struct const *p
   kernel/sched/core.c:3794:28: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:9084:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *push_task @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:9084:43: sparse:     expected struct task_struct *push_task
   kernel/sched/core.c:9084:43: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:5404:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:5404:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:5404:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:5495:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:5495:14: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:5495:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:6350:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *prev @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:6350:14: sparse:     expected struct task_struct *prev
   kernel/sched/core.c:6350:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:6872:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:6872:17: sparse:    struct task_struct *
   kernel/sched/core.c:6872:17: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7076:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7076:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7076:22: sparse:    struct task_struct *
   kernel/sched/core.c:11116:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:11116:25: sparse:     expected struct task_struct *p
   kernel/sched/core.c:11116:25: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:537:6: sparse: sparse: context imbalance in 'raw_spin_rq_lock_nested' - wrong count at exit
   kernel/sched/core.c:562:6: sparse: sparse: context imbalance in 'raw_spin_rq_trylock' - wrong count at exit
   kernel/sched/core.c:586:6: sparse: sparse: context imbalance in 'raw_spin_rq_unlock' - unexpected unlock
   kernel/sched/core.c:624:36: sparse: sparse: context imbalance in '__task_rq_lock' - wrong count at exit
   kernel/sched/core.c:665:36: sparse: sparse: context imbalance in 'task_rq_lock' - wrong count at exit
   kernel/sched/core.c: note: in included file:
   kernel/sched/pelt.h:78:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct const *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/pelt.h:78:13: sparse:     expected struct task_struct const *p
   kernel/sched/pelt.h:78:13: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:780:11: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2188:33: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2189:19: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2190:18: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:2018:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2176:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct *
   kernel/sched/core.c:2163:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:2163:38: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:2163:38: sparse:    struct task_struct const *
   kernel/sched/sched.h:2018:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2176:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2176:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct *
   kernel/sched/core.c: note: in included file (through arch/loongarch/include/asm/cpu-info.h, arch/loongarch/include/asm/processor.h, ...):
   arch/loongarch/include/asm/loongarch.h:242:9: sparse: sparse: undefined identifier '__builtin_loongarch_csrwr_w'
   arch/loongarch/include/asm/loongarch.h:242:9: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:247:9: sparse: sparse: undefined identifier '__builtin_loongarch_csrwr_d'
   arch/loongarch/include/asm/loongarch.h:247:9: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:247:9: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:232:16: sparse: sparse: undefined identifier '__builtin_loongarch_csrrd_w'
   arch/loongarch/include/asm/loongarch.h:232:16: sparse: sparse: cast from unknown type
   arch/loongarch/include/asm/loongarch.h:242:9: sparse: sparse: cast from unknown type
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:2018:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2176:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2018:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2176:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2176:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2018:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2018:25: sparse:    struct task_struct [noderef] __rcu *
--
>> kernel/locking/mutex.c:357:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:357:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:357:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/locking/mutex.c:357:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:357:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:357:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/locking/mutex.c:357:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:357:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:357:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/locking/mutex.c:357:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:357:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:357:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/locking/mutex.c:357:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:357:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:357:9: sparse:     got int [noderef] __percpu *
>> kernel/locking/mutex.c:357:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:357:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:357:9: sparse:     got int [noderef] __percpu *
>> kernel/locking/mutex.c:357:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:357:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:357:9: sparse:     got int [noderef] __percpu *
>> kernel/locking/mutex.c:357:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:357:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:357:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
   kernel/locking/mutex.c:397:9: sparse:     got int [noderef] __percpu *
   kernel/locking/mutex.c:397:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/mutex.c:397:9: sparse:     expected void *ptr
--
>> kernel/locking/rwsem.c:751:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/rwsem.c:751:9: sparse:     expected void *ptr
   kernel/locking/rwsem.c:751:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/locking/rwsem.c:751:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/rwsem.c:751:9: sparse:     expected void *ptr
   kernel/locking/rwsem.c:751:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/locking/rwsem.c:751:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/rwsem.c:751:9: sparse:     expected void *ptr
   kernel/locking/rwsem.c:751:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/locking/rwsem.c:751:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/locking/rwsem.c:751:9: sparse:     expected void *ptr
   kernel/locking/rwsem.c:751:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/locking/rwsem.c:751:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/rwsem.c:751:9: sparse:     expected void *ptr
   kernel/locking/rwsem.c:751:9: sparse:     got int [noderef] __percpu *
>> kernel/locking/rwsem.c:751:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/rwsem.c:751:9: sparse:     expected void *ptr
   kernel/locking/rwsem.c:751:9: sparse:     got int [noderef] __percpu *
>> kernel/locking/rwsem.c:751:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/rwsem.c:751:9: sparse:     expected void *ptr
   kernel/locking/rwsem.c:751:9: sparse:     got int [noderef] __percpu *
>> kernel/locking/rwsem.c:751:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/locking/rwsem.c:751:9: sparse:     expected void *ptr
   kernel/locking/rwsem.c:751:9: sparse:     got int [noderef] __percpu *
--
   kernel/rcu/tree.c: note: in included file:
>> kernel/rcu/tree_exp.h:807:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_exp.h:807:9: sparse:     expected void *ptr
   kernel/rcu/tree_exp.h:807:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_exp.h:807:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_exp.h:807:9: sparse:     expected void *ptr
   kernel/rcu/tree_exp.h:807:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_exp.h:807:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_exp.h:807:9: sparse:     expected void *ptr
   kernel/rcu/tree_exp.h:807:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_exp.h:807:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_exp.h:807:9: sparse:     expected void *ptr
   kernel/rcu/tree_exp.h:807:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_exp.h:807:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_exp.h:807:9: sparse:     expected void *ptr
   kernel/rcu/tree_exp.h:807:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_exp.h:807:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_exp.h:807:9: sparse:     expected void *ptr
   kernel/rcu/tree_exp.h:807:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_exp.h:807:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_exp.h:807:9: sparse:     expected void *ptr
   kernel/rcu/tree_exp.h:807:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_exp.h:807:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_exp.h:807:9: sparse:     expected void *ptr
   kernel/rcu/tree_exp.h:807:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree.c: note: in included file:
>> kernel/rcu/tree_plugin.h:720:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:720:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:720:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_plugin.h:720:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:720:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:720:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_plugin.h:720:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:720:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:720:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_plugin.h:720:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:720:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:720:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_plugin.h:720:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:720:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:720:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_plugin.h:720:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:720:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:720:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_plugin.h:720:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:720:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:720:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_plugin.h:720:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:720:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:720:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_plugin.h:1242:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:1242:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:1242:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_plugin.h:1242:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:1242:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:1242:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_plugin.h:1242:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:1242:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:1242:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_plugin.h:1242:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:1242:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:1242:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_plugin.h:1242:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:1242:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:1242:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_plugin.h:1242:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:1242:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:1242:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_plugin.h:1242:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:1242:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:1242:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_plugin.h:1242:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_plugin.h:1242:9: sparse:     expected void *ptr
   kernel/rcu/tree_plugin.h:1242:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree.c: note: in included file:
>> kernel/rcu/tree_nocb.h:377:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:377:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:377:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_nocb.h:377:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:377:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:377:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_nocb.h:377:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:377:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:377:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_nocb.h:377:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:377:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:377:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_nocb.h:377:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:377:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:377:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_nocb.h:377:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:377:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:377:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_nocb.h:377:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:377:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:377:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_nocb.h:377:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:377:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:377:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:154:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:154:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:154:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:154:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:154:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:154:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:154:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:154:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:154:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:154:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:154:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:154:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:154:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:154:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:154:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:154:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:154:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:154:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:154:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:154:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:154:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:154:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:154:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:154:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:167:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:167:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:167:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:167:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:167:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:167:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:167:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:167:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:167:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:167:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:167:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:167:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:167:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:167:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:167:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:167:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:167:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:167:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:167:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:167:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:167:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:167:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:167:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:167:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:180:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:180:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:180:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:180:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:180:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:180:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:180:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:180:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:180:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:180:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:180:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:180:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:180:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:180:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:180:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:180:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:180:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:180:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:180:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:180:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:180:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:180:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:180:17: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:180:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:190:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:190:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:190:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:190:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:190:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:190:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:190:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:190:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:190:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:190:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:190:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:190:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:190:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:190:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:190:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:190:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:190:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:190:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:190:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:190:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:190:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_nocb.h:190:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_nocb.h:190:9: sparse:     expected void *ptr
   kernel/rcu/tree_nocb.h:190:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree.c: note: in included file:
>> kernel/rcu/tree_stall.h:224:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:224:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:224:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_stall.h:224:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:224:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:224:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_stall.h:224:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:224:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:224:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_stall.h:224:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:224:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:224:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/rcu/tree_stall.h:224:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:224:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:224:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_stall.h:224:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:224:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:224:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_stall.h:224:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:224:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:224:9: sparse:     got int [noderef] __percpu *
>> kernel/rcu/tree_stall.h:224:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:224:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:224:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:700:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:700:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:700:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:700:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:700:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:700:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:700:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:700:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:700:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:700:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:700:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:700:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:700:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:700:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:700:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:700:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:700:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:700:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:700:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:700:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:700:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:700:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:700:9: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:700:9: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:941:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:941:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:941:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:941:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:941:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:941:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:941:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:941:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:941:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:941:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:941:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:941:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:941:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:941:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:941:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:941:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:941:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:941:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:941:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:941:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:941:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:941:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:941:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:941:17: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:957:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:957:25: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:957:25: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:957:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:957:25: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:957:25: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:957:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:957:25: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:957:25: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:957:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:957:25: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:957:25: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:957:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:957:25: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:957:25: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:957:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:957:25: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:957:25: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:957:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:957:25: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:957:25: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:957:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:957:25: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:957:25: sparse:     got int [noderef] __percpu *
   kernel/rcu/tree_stall.h:958:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:958:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:958:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:958:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:958:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:958:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:958:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/rcu/tree_stall.h:958:17: sparse:     expected void *ptr
   kernel/rcu/tree_stall.h:958:17: sparse:     got unsigned int [noderef] __percpu *
   kernel/rcu/tree_stall.h:958:17: sparse: sparse: too many warnings
--
>> kernel/time/timer.c:1432:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/timer.c:1432:17: sparse:     expected void *ptr
   kernel/time/timer.c:1432:17: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/timer.c:1432:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/timer.c:1432:17: sparse:     expected void *ptr
   kernel/time/timer.c:1432:17: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/timer.c:1432:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/timer.c:1432:17: sparse:     expected void *ptr
   kernel/time/timer.c:1432:17: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/timer.c:1432:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/timer.c:1432:17: sparse:     expected void *ptr
   kernel/time/timer.c:1432:17: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/timer.c:1432:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/timer.c:1432:17: sparse:     expected void *ptr
   kernel/time/timer.c:1432:17: sparse:     got int [noderef] __percpu *
>> kernel/time/timer.c:1432:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/timer.c:1432:17: sparse:     expected void *ptr
   kernel/time/timer.c:1432:17: sparse:     got int [noderef] __percpu *
>> kernel/time/timer.c:1432:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/timer.c:1432:17: sparse:     expected void *ptr
   kernel/time/timer.c:1432:17: sparse:     got int [noderef] __percpu *
>> kernel/time/timer.c:1432:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/timer.c:1432:17: sparse:     expected void *ptr
   kernel/time/timer.c:1432:17: sparse:     got int [noderef] __percpu *

vim +571 kernel/smp.c

8d056c48e48624 Srivatsa S. Bhat    2014-06-23  549  
8d056c48e48624 Srivatsa S. Bhat    2014-06-23  550  /**
16bf5a5e1ec564 Thomas Gleixner     2022-04-13  551   * __flush_smp_call_function_queue - Flush pending smp-call-function callbacks
8d056c48e48624 Srivatsa S. Bhat    2014-06-23  552   *
8d056c48e48624 Srivatsa S. Bhat    2014-06-23  553   * @warn_cpu_offline: If set to 'true', warn if callbacks were queued on an
8d056c48e48624 Srivatsa S. Bhat    2014-06-23  554   *		      offline CPU. Skip this check if set to 'false'.
8d056c48e48624 Srivatsa S. Bhat    2014-06-23  555   *
8d056c48e48624 Srivatsa S. Bhat    2014-06-23  556   * Flush any pending smp-call-function callbacks queued on this CPU. This is
8d056c48e48624 Srivatsa S. Bhat    2014-06-23  557   * invoked by the generic IPI handler, as well as by a CPU about to go offline,
8d056c48e48624 Srivatsa S. Bhat    2014-06-23  558   * to ensure that all pending IPI callbacks are run before it goes completely
8d056c48e48624 Srivatsa S. Bhat    2014-06-23  559   * offline.
8d056c48e48624 Srivatsa S. Bhat    2014-06-23  560   *
8d056c48e48624 Srivatsa S. Bhat    2014-06-23  561   * Loop through the call_single_queue and run all the queued callbacks.
8d056c48e48624 Srivatsa S. Bhat    2014-06-23  562   * Must be called with interrupts disabled.
8d056c48e48624 Srivatsa S. Bhat    2014-06-23  563   */
16bf5a5e1ec564 Thomas Gleixner     2022-04-13  564  static void __flush_smp_call_function_queue(bool warn_cpu_offline)
8d056c48e48624 Srivatsa S. Bhat    2014-06-23  565  {
966a967116e699 Ying Huang          2017-08-08  566  	call_single_data_t *csd, *csd_next;
52103be07d8b08 Peter Zijlstra      2020-05-26  567  	struct llist_node *entry, *prev;
52103be07d8b08 Peter Zijlstra      2020-05-26  568  	struct llist_head *head;
a219ccf4637396 Srivatsa S. Bhat    2014-06-06  569  	static bool warned;
a219ccf4637396 Srivatsa S. Bhat    2014-06-06  570  
83efcbd028ad3a Frederic Weisbecker 2017-11-06 @571  	lockdep_assert_irqs_disabled();
8d056c48e48624 Srivatsa S. Bhat    2014-06-23  572  
bb964a92ce70ac Christoph Lameter   2014-08-17  573  	head = this_cpu_ptr(&call_single_queue);
a5aabace5fb8ab Juergen Gross       2021-03-01  574  	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->handle, CFD_SEQ_NOCPU,
a5aabace5fb8ab Juergen Gross       2021-03-01  575  		      smp_processor_id(), CFD_SEQ_HANDLE);
8d056c48e48624 Srivatsa S. Bhat    2014-06-23  576  	entry = llist_del_all(head);
a5aabace5fb8ab Juergen Gross       2021-03-01  577  	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->dequeue,
a5aabace5fb8ab Juergen Gross       2021-03-01  578  		      /* Special meaning of source cpu: 0 == queue empty */
a5aabace5fb8ab Juergen Gross       2021-03-01  579  		      entry ? CFD_SEQ_NOCPU : 0,
a5aabace5fb8ab Juergen Gross       2021-03-01  580  		      smp_processor_id(), CFD_SEQ_DEQUEUE);
a219ccf4637396 Srivatsa S. Bhat    2014-06-06  581  	entry = llist_reverse_order(entry);
3d4422332711ef Jens Axboe          2008-06-26  582  
8d056c48e48624 Srivatsa S. Bhat    2014-06-23  583  	/* There shouldn't be any pending callbacks on an offline CPU. */
8d056c48e48624 Srivatsa S. Bhat    2014-06-23  584  	if (unlikely(warn_cpu_offline && !cpu_online(smp_processor_id()) &&
9e949a3886356f Nadav Amit          2022-03-19  585  		     !warned && entry != NULL)) {
a219ccf4637396 Srivatsa S. Bhat    2014-06-06  586  		warned = true;
a219ccf4637396 Srivatsa S. Bhat    2014-06-06  587  		WARN(1, "IPI on offline CPU %d\n", smp_processor_id());
269c861baa2fe7 Suresh Siddha       2009-08-19  588  
a219ccf4637396 Srivatsa S. Bhat    2014-06-06  589  		/*
a219ccf4637396 Srivatsa S. Bhat    2014-06-06  590  		 * We don't have to use the _safe() variant here
a219ccf4637396 Srivatsa S. Bhat    2014-06-06  591  		 * because we are not invoking the IPI handlers yet.
a219ccf4637396 Srivatsa S. Bhat    2014-06-06  592  		 */
545b8c8df41f9e Peter Zijlstra      2020-06-15  593  		llist_for_each_entry(csd, entry, node.llist) {
4b44a21dd640b6 Peter Zijlstra      2020-05-26  594  			switch (CSD_TYPE(csd)) {
4b44a21dd640b6 Peter Zijlstra      2020-05-26  595  			case CSD_TYPE_ASYNC:
4b44a21dd640b6 Peter Zijlstra      2020-05-26  596  			case CSD_TYPE_SYNC:
4b44a21dd640b6 Peter Zijlstra      2020-05-26  597  			case CSD_TYPE_IRQ_WORK:
a219ccf4637396 Srivatsa S. Bhat    2014-06-06  598  				pr_warn("IPI callback %pS sent to offline CPU\n",
a219ccf4637396 Srivatsa S. Bhat    2014-06-06  599  					csd->func);
4b44a21dd640b6 Peter Zijlstra      2020-05-26  600  				break;
4b44a21dd640b6 Peter Zijlstra      2020-05-26  601  
a148866489fbe2 Peter Zijlstra      2020-05-26  602  			case CSD_TYPE_TTWU:
a148866489fbe2 Peter Zijlstra      2020-05-26  603  				pr_warn("IPI task-wakeup sent to offline CPU\n");
a148866489fbe2 Peter Zijlstra      2020-05-26  604  				break;
a148866489fbe2 Peter Zijlstra      2020-05-26  605  
4b44a21dd640b6 Peter Zijlstra      2020-05-26  606  			default:
4b44a21dd640b6 Peter Zijlstra      2020-05-26  607  				pr_warn("IPI callback, unknown type %d, sent to offline CPU\n",
4b44a21dd640b6 Peter Zijlstra      2020-05-26  608  					CSD_TYPE(csd));
4b44a21dd640b6 Peter Zijlstra      2020-05-26  609  				break;
4b44a21dd640b6 Peter Zijlstra      2020-05-26  610  			}
4b44a21dd640b6 Peter Zijlstra      2020-05-26  611  		}
a219ccf4637396 Srivatsa S. Bhat    2014-06-06  612  	}
3d4422332711ef Jens Axboe          2008-06-26  613  
52103be07d8b08 Peter Zijlstra      2020-05-26  614  	/*
52103be07d8b08 Peter Zijlstra      2020-05-26  615  	 * First; run all SYNC callbacks, people are waiting for us.
52103be07d8b08 Peter Zijlstra      2020-05-26  616  	 */
52103be07d8b08 Peter Zijlstra      2020-05-26  617  	prev = NULL;
545b8c8df41f9e Peter Zijlstra      2020-06-15  618  	llist_for_each_entry_safe(csd, csd_next, entry, node.llist) {
4b44a21dd640b6 Peter Zijlstra      2020-05-26  619  		/* Do we wait until *after* callback? */
4b44a21dd640b6 Peter Zijlstra      2020-05-26  620  		if (CSD_TYPE(csd) == CSD_TYPE_SYNC) {
8053871d0f7f67 Linus Torvalds      2015-02-11  621  			smp_call_func_t func = csd->func;
8053871d0f7f67 Linus Torvalds      2015-02-11  622  			void *info = csd->info;
8053871d0f7f67 Linus Torvalds      2015-02-11  623  
52103be07d8b08 Peter Zijlstra      2020-05-26  624  			if (prev) {
545b8c8df41f9e Peter Zijlstra      2020-06-15  625  				prev->next = &csd_next->node.llist;
52103be07d8b08 Peter Zijlstra      2020-05-26  626  			} else {
545b8c8df41f9e Peter Zijlstra      2020-06-15  627  				entry = &csd_next->node.llist;
52103be07d8b08 Peter Zijlstra      2020-05-26  628  			}
4b44a21dd640b6 Peter Zijlstra      2020-05-26  629  
35feb60474bf4f Paul E. McKenney    2020-06-30  630  			csd_lock_record(csd);
8053871d0f7f67 Linus Torvalds      2015-02-11  631  			func(info);
8053871d0f7f67 Linus Torvalds      2015-02-11  632  			csd_unlock(csd);
35feb60474bf4f Paul E. McKenney    2020-06-30  633  			csd_lock_record(NULL);
8053871d0f7f67 Linus Torvalds      2015-02-11  634  		} else {
545b8c8df41f9e Peter Zijlstra      2020-06-15  635  			prev = &csd->node.llist;
52103be07d8b08 Peter Zijlstra      2020-05-26  636  		}
52103be07d8b08 Peter Zijlstra      2020-05-26  637  	}
52103be07d8b08 Peter Zijlstra      2020-05-26  638  
a5aabace5fb8ab Juergen Gross       2021-03-01  639  	if (!entry) {
a5aabace5fb8ab Juergen Gross       2021-03-01  640  		cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->hdlend,
a5aabace5fb8ab Juergen Gross       2021-03-01  641  			      0, smp_processor_id(),
a5aabace5fb8ab Juergen Gross       2021-03-01  642  			      CFD_SEQ_HDLEND);
a148866489fbe2 Peter Zijlstra      2020-05-26  643  		return;
a5aabace5fb8ab Juergen Gross       2021-03-01  644  	}
a148866489fbe2 Peter Zijlstra      2020-05-26  645  
52103be07d8b08 Peter Zijlstra      2020-05-26  646  	/*
52103be07d8b08 Peter Zijlstra      2020-05-26  647  	 * Second; run all !SYNC callbacks.
52103be07d8b08 Peter Zijlstra      2020-05-26  648  	 */
a148866489fbe2 Peter Zijlstra      2020-05-26  649  	prev = NULL;
545b8c8df41f9e Peter Zijlstra      2020-06-15  650  	llist_for_each_entry_safe(csd, csd_next, entry, node.llist) {
4b44a21dd640b6 Peter Zijlstra      2020-05-26  651  		int type = CSD_TYPE(csd);
4b44a21dd640b6 Peter Zijlstra      2020-05-26  652  
a148866489fbe2 Peter Zijlstra      2020-05-26  653  		if (type != CSD_TYPE_TTWU) {
a148866489fbe2 Peter Zijlstra      2020-05-26  654  			if (prev) {
545b8c8df41f9e Peter Zijlstra      2020-06-15  655  				prev->next = &csd_next->node.llist;
a148866489fbe2 Peter Zijlstra      2020-05-26  656  			} else {
545b8c8df41f9e Peter Zijlstra      2020-06-15  657  				entry = &csd_next->node.llist;
a148866489fbe2 Peter Zijlstra      2020-05-26  658  			}
a148866489fbe2 Peter Zijlstra      2020-05-26  659  
4b44a21dd640b6 Peter Zijlstra      2020-05-26  660  			if (type == CSD_TYPE_ASYNC) {
52103be07d8b08 Peter Zijlstra      2020-05-26  661  				smp_call_func_t func = csd->func;
52103be07d8b08 Peter Zijlstra      2020-05-26  662  				void *info = csd->info;
52103be07d8b08 Peter Zijlstra      2020-05-26  663  
35feb60474bf4f Paul E. McKenney    2020-06-30  664  				csd_lock_record(csd);
e1d12f327037a5 Andrew Morton       2013-04-30  665  				csd_unlock(csd);
8053871d0f7f67 Linus Torvalds      2015-02-11  666  				func(info);
35feb60474bf4f Paul E. McKenney    2020-06-30  667  				csd_lock_record(NULL);
4b44a21dd640b6 Peter Zijlstra      2020-05-26  668  			} else if (type == CSD_TYPE_IRQ_WORK) {
4b44a21dd640b6 Peter Zijlstra      2020-05-26  669  				irq_work_single(csd);
4b44a21dd640b6 Peter Zijlstra      2020-05-26  670  			}
a148866489fbe2 Peter Zijlstra      2020-05-26  671  
a148866489fbe2 Peter Zijlstra      2020-05-26  672  		} else {
545b8c8df41f9e Peter Zijlstra      2020-06-15  673  			prev = &csd->node.llist;
8053871d0f7f67 Linus Torvalds      2015-02-11  674  		}
3d4422332711ef Jens Axboe          2008-06-26  675  	}
478850160636c4 Frederic Weisbecker 2014-05-08  676  
478850160636c4 Frederic Weisbecker 2014-05-08  677  	/*
a148866489fbe2 Peter Zijlstra      2020-05-26  678  	 * Third; only CSD_TYPE_TTWU is left, issue those.
478850160636c4 Frederic Weisbecker 2014-05-08  679  	 */
a148866489fbe2 Peter Zijlstra      2020-05-26  680  	if (entry)
a148866489fbe2 Peter Zijlstra      2020-05-26  681  		sched_ttwu_pending(entry);
a5aabace5fb8ab Juergen Gross       2021-03-01  682  
a5aabace5fb8ab Juergen Gross       2021-03-01  683  	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->hdlend, CFD_SEQ_NOCPU,
a5aabace5fb8ab Juergen Gross       2021-03-01  684  		      smp_processor_id(), CFD_SEQ_HDLEND);
a148866489fbe2 Peter Zijlstra      2020-05-26  685  }
a148866489fbe2 Peter Zijlstra      2020-05-26  686  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
