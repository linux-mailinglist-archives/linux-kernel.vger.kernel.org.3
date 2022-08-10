Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CF358ECE7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiHJNRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiHJNQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:16:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E4722298
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660137412; x=1691673412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9TSgA33SDJln0XORUaheqflFWGe3kUB9qcYCl8X3XM0=;
  b=gE1zlbtZ1Hnvb+/DjAwAVOBvBrKU6JHE6gkSL8CABuLmWJ4raCMm5Xst
   H8fmLgytm4a4vR88nn6Hnm9nIc7tfHgc2JrxSvhKrnIJfvgmhT+87zULw
   jZ+vK3RoLY6/MrqkXf2LAYEB124uHVrJs6mU+SaR8J8AdDYtGzQQR/Tvp
   6QC17LuRS6Salz8kDWbWeExixOX5JoyL7XEJp6FTigNTQTmQ8E7KNUtwN
   4KQL3fu1OVDCueqbhtELMQUuRww4s+F6tWgAhteX2vejX/tsf+3vdCeYl
   OSoI7Q+7l0oCfGdWTPHr2mq5yjg+ctzb0qNChQBIEiFQKoUup2ilThVJE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="271462332"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="271462332"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 06:16:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="555729564"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Aug 2022 06:16:49 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLlZo-0000IF-1l;
        Wed, 10 Aug 2022 13:16:48 +0000
Date:   Wed, 10 Aug 2022 21:16:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     kbuild-all@lists.01.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn
Subject: Re: [PATCH 3/3] LoongArch: Add stacktrace support
Message-ID: <202208102109.mnxcQi3g-lkp@intel.com>
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
[also build test WARNING on v5.19]
[cannot apply to next-20220810]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qing-Zhang/LoongArch-Add-guess-unwinder-support/20220728-220739
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 6e7765cb477a9753670d4351d14de93f1e9dbbd4
config: loongarch-randconfig-s042-20220810 (https://download.01.org/0day-ci/archive/20220810/202208102109.mnxcQi3g-lkp@intel.com/config)
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
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> kernel/events/core.c:223:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:223:9: sparse:     expected void *ptr
   kernel/events/core.c:223:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/events/core.c:223:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:223:9: sparse:     expected void *ptr
   kernel/events/core.c:223:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/events/core.c:223:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:223:9: sparse:     expected void *ptr
   kernel/events/core.c:223:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/events/core.c:223:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:223:9: sparse:     expected void *ptr
   kernel/events/core.c:223:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/events/core.c:223:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:223:9: sparse:     expected void *ptr
   kernel/events/core.c:223:9: sparse:     got int [noderef] __percpu *
>> kernel/events/core.c:223:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:223:9: sparse:     expected void *ptr
   kernel/events/core.c:223:9: sparse:     got int [noderef] __percpu *
>> kernel/events/core.c:223:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:223:9: sparse:     expected void *ptr
   kernel/events/core.c:223:9: sparse:     got int [noderef] __percpu *
>> kernel/events/core.c:223:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:223:9: sparse:     expected void *ptr
   kernel/events/core.c:223:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:320:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:320:9: sparse:     expected void *ptr
   kernel/events/core.c:320:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:320:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:320:9: sparse:     expected void *ptr
   kernel/events/core.c:320:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:320:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:320:9: sparse:     expected void *ptr
   kernel/events/core.c:320:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:320:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:320:9: sparse:     expected void *ptr
   kernel/events/core.c:320:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:320:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:320:9: sparse:     expected void *ptr
   kernel/events/core.c:320:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:320:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:320:9: sparse:     expected void *ptr
   kernel/events/core.c:320:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:320:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:320:9: sparse:     expected void *ptr
   kernel/events/core.c:320:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:320:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:320:9: sparse:     expected void *ptr
   kernel/events/core.c:320:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1074:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1074:9: sparse:     expected void *ptr
   kernel/events/core.c:1074:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1074:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1074:9: sparse:     expected void *ptr
   kernel/events/core.c:1074:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1074:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1074:9: sparse:     expected void *ptr
   kernel/events/core.c:1074:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1074:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1074:9: sparse:     expected void *ptr
   kernel/events/core.c:1074:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1074:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1074:9: sparse:     expected void *ptr
   kernel/events/core.c:1074:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1074:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1074:9: sparse:     expected void *ptr
   kernel/events/core.c:1074:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1074:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1074:9: sparse:     expected void *ptr
   kernel/events/core.c:1074:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1074:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1074:9: sparse:     expected void *ptr
   kernel/events/core.c:1074:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1161:9: sparse:     expected void *ptr
   kernel/events/core.c:1161:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1161:9: sparse:     expected void *ptr
   kernel/events/core.c:1161:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1161:9: sparse:     expected void *ptr
   kernel/events/core.c:1161:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1161:9: sparse:     expected void *ptr
   kernel/events/core.c:1161:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1161:9: sparse:     expected void *ptr
   kernel/events/core.c:1161:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1161:9: sparse:     expected void *ptr
   kernel/events/core.c:1161:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1161:9: sparse:     expected void *ptr
   kernel/events/core.c:1161:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1161:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1161:9: sparse:     expected void *ptr
   kernel/events/core.c:1161:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1170:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1170:9: sparse:     expected void *ptr
   kernel/events/core.c:1170:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1170:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1170:9: sparse:     expected void *ptr
   kernel/events/core.c:1170:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1170:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1170:9: sparse:     expected void *ptr
   kernel/events/core.c:1170:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1170:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/events/core.c:1170:9: sparse:     expected void *ptr
   kernel/events/core.c:1170:9: sparse:     got unsigned int [noderef] __percpu *
   kernel/events/core.c:1170:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1170:9: sparse:     expected void *ptr
   kernel/events/core.c:1170:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1170:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1170:9: sparse:     expected void *ptr
   kernel/events/core.c:1170:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1170:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1170:9: sparse:     expected void *ptr
   kernel/events/core.c:1170:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1170:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/events/core.c:1170:9: sparse:     expected void *ptr
   kernel/events/core.c:1170:9: sparse:     got int [noderef] __percpu *
   kernel/events/core.c:1402:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/events/core.c:1402:15: sparse:    struct perf_event_context [noderef] __rcu *
--
>> crypto/crypto_engine.c:56:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   crypto/crypto_engine.c:56:9: sparse:     expected void *ptr
   crypto/crypto_engine.c:56:9: sparse:     got unsigned int [noderef] __percpu *
>> crypto/crypto_engine.c:56:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   crypto/crypto_engine.c:56:9: sparse:     expected void *ptr
   crypto/crypto_engine.c:56:9: sparse:     got unsigned int [noderef] __percpu *
>> crypto/crypto_engine.c:56:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   crypto/crypto_engine.c:56:9: sparse:     expected void *ptr
   crypto/crypto_engine.c:56:9: sparse:     got unsigned int [noderef] __percpu *
>> crypto/crypto_engine.c:56:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   crypto/crypto_engine.c:56:9: sparse:     expected void *ptr
   crypto/crypto_engine.c:56:9: sparse:     got unsigned int [noderef] __percpu *

vim +223 kernel/events/core.c

fae3fde65138b60 Peter Zijlstra      2016-01-11  213  
fae3fde65138b60 Peter Zijlstra      2016-01-11  214  static int event_function(void *info)
fae3fde65138b60 Peter Zijlstra      2016-01-11  215  {
fae3fde65138b60 Peter Zijlstra      2016-01-11  216  	struct event_function_struct *efs = info;
fae3fde65138b60 Peter Zijlstra      2016-01-11  217  	struct perf_event *event = efs->event;
fae3fde65138b60 Peter Zijlstra      2016-01-11  218  	struct perf_event_context *ctx = event->ctx;
fae3fde65138b60 Peter Zijlstra      2016-01-11  219  	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
fae3fde65138b60 Peter Zijlstra      2016-01-11  220  	struct perf_event_context *task_ctx = cpuctx->task_ctx;
63b6da39bb38e8f Peter Zijlstra      2016-01-14  221  	int ret = 0;
fae3fde65138b60 Peter Zijlstra      2016-01-11  222  
164446455a5d3f1 Frederic Weisbecker 2017-11-06 @223  	lockdep_assert_irqs_disabled();
fae3fde65138b60 Peter Zijlstra      2016-01-11  224  
63b6da39bb38e8f Peter Zijlstra      2016-01-14  225  	perf_ctx_lock(cpuctx, task_ctx);
fae3fde65138b60 Peter Zijlstra      2016-01-11  226  	/*
fae3fde65138b60 Peter Zijlstra      2016-01-11  227  	 * Since we do the IPI call without holding ctx->lock things can have
fae3fde65138b60 Peter Zijlstra      2016-01-11  228  	 * changed, double check we hit the task we set out to hit.
fae3fde65138b60 Peter Zijlstra      2016-01-11  229  	 */
fae3fde65138b60 Peter Zijlstra      2016-01-11  230  	if (ctx->task) {
63b6da39bb38e8f Peter Zijlstra      2016-01-14  231  		if (ctx->task != current) {
0da4cf3e0a68c97 Peter Zijlstra      2016-02-24  232  			ret = -ESRCH;
63b6da39bb38e8f Peter Zijlstra      2016-01-14  233  			goto unlock;
fae3fde65138b60 Peter Zijlstra      2016-01-11  234  		}
fae3fde65138b60 Peter Zijlstra      2016-01-11  235  
fae3fde65138b60 Peter Zijlstra      2016-01-11  236  		/*
fae3fde65138b60 Peter Zijlstra      2016-01-11  237  		 * We only use event_function_call() on established contexts,
fae3fde65138b60 Peter Zijlstra      2016-01-11  238  		 * and event_function() is only ever called when active (or
fae3fde65138b60 Peter Zijlstra      2016-01-11  239  		 * rather, we'll have bailed in task_function_call() or the
fae3fde65138b60 Peter Zijlstra      2016-01-11  240  		 * above ctx->task != current test), therefore we must have
fae3fde65138b60 Peter Zijlstra      2016-01-11  241  		 * ctx->is_active here.
fae3fde65138b60 Peter Zijlstra      2016-01-11  242  		 */
fae3fde65138b60 Peter Zijlstra      2016-01-11  243  		WARN_ON_ONCE(!ctx->is_active);
fae3fde65138b60 Peter Zijlstra      2016-01-11  244  		/*
fae3fde65138b60 Peter Zijlstra      2016-01-11  245  		 * And since we have ctx->is_active, cpuctx->task_ctx must
fae3fde65138b60 Peter Zijlstra      2016-01-11  246  		 * match.
fae3fde65138b60 Peter Zijlstra      2016-01-11  247  		 */
63b6da39bb38e8f Peter Zijlstra      2016-01-14  248  		WARN_ON_ONCE(task_ctx != ctx);
63b6da39bb38e8f Peter Zijlstra      2016-01-14  249  	} else {
63b6da39bb38e8f Peter Zijlstra      2016-01-14  250  		WARN_ON_ONCE(&cpuctx->ctx != ctx);
fae3fde65138b60 Peter Zijlstra      2016-01-11  251  	}
63b6da39bb38e8f Peter Zijlstra      2016-01-14  252  
fae3fde65138b60 Peter Zijlstra      2016-01-11  253  	efs->func(event, cpuctx, ctx, efs->data);
63b6da39bb38e8f Peter Zijlstra      2016-01-14  254  unlock:
fae3fde65138b60 Peter Zijlstra      2016-01-11  255  	perf_ctx_unlock(cpuctx, task_ctx);
fae3fde65138b60 Peter Zijlstra      2016-01-11  256  
63b6da39bb38e8f Peter Zijlstra      2016-01-14  257  	return ret;
fae3fde65138b60 Peter Zijlstra      2016-01-11  258  }
fae3fde65138b60 Peter Zijlstra      2016-01-11  259  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
