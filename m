Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63617585ED1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 14:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbiGaMSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 08:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbiGaMSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 08:18:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A6D1056F
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 05:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659269893; x=1690805893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rL7pSsRpSxy1xNctCfIeaAMR+N04fzaBts8U6GlJ+SY=;
  b=KlJ+kSzMSQF+u1i5gfMOzcOFrSlm2ins1kqqRu7AnNC7VtoJh29/iQCK
   MCeUSoBJhb7qVVNZbjEtKpjz/05WFRq+sAqXORqoxOqHAP6rcXwQJvDgj
   FXte86TX0sb8qKA5FU6NuONk2slXV8wtCJHF8mhqMjr68vSGaMZj1BgeA
   PJFdRFiCpoU453f9hISQWi3BL0Op+k6HHiOQs4D6pfOF0MEqlZw/rwsAO
   9hzHenUO3roYF60tgmCvWFG/6Ai9sdw2BSw9/cmRldDu90YyzXklDetsI
   f1PCBcMOiU285nvgw/++fiGAsqrTfzsdNIewN4IoQwqTd4D6qg84vX0ah
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="375294631"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="375294631"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 05:18:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="577474282"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Jul 2022 05:18:10 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oI7tZ-000E79-21;
        Sun, 31 Jul 2022 12:18:09 +0000
Date:   Sun, 31 Jul 2022 20:17:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     kbuild-all@lists.01.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn
Subject: Re: [PATCH 3/3] LoongArch: Add stacktrace support
Message-ID: <202207312058.P3VcvB4t-lkp@intel.com>
References: <20220728140519.5420-3-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728140519.5420-3-zhangqing@loongson.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qing,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.19-rc8 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qing-Zhang/LoongArch-Add-guess-unwinder-support/20220728-220739
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 6e7765cb477a9753670d4351d14de93f1e9dbbd4
config: loongarch-randconfig-s041-20220731 (https://download.01.org/0day-ci/archive/20220731/202207312058.P3VcvB4t-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash kernel/entry/ kernel/trace/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> kernel/entry/common.c:447:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:447:29: sparse:     expected void *ptr
   kernel/entry/common.c:447:29: sparse:     got int [noderef] __percpu *
>> kernel/entry/common.c:447:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:447:29: sparse:     expected void *ptr
   kernel/entry/common.c:447:29: sparse:     got int [noderef] __percpu *
>> kernel/entry/common.c:447:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:447:29: sparse:     expected void *ptr
   kernel/entry/common.c:447:29: sparse:     got int [noderef] __percpu *
>> kernel/entry/common.c:447:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/entry/common.c:447:29: sparse:     expected void *ptr
   kernel/entry/common.c:447:29: sparse:     got int [noderef] __percpu *
   kernel/entry/common.c: note: in included file:
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
   include/linux/context_tracking.h:98:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int enum ctx_state [noderef] __percpu * @@
   include/linux/context_tracking.h:98:17: sparse:     expected void *ptr
   include/linux/context_tracking.h:98:17: sparse:     got int enum ctx_state [noderef] __percpu *
--
>> kernel/trace/trace_preemptirq.c:30:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:30:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:30:13: sparse:     got int [noderef] __percpu *
>> kernel/trace/trace_preemptirq.c:30:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:30:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:30:13: sparse:     got int [noderef] __percpu *
>> kernel/trace/trace_preemptirq.c:30:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:30:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:30:13: sparse:     got int [noderef] __percpu *
>> kernel/trace/trace_preemptirq.c:30:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:30:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:30:13: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:34:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:34:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:34:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:34:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:34:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:34:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:34:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:34:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:34:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:34:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:34:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:34:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:42:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:42:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:42:13: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:42:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:42:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:42:13: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:42:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:42:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:42:13: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:42:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:42:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:42:13: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:46:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:46:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:46:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:46:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:46:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:46:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:46:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:46:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:46:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:46:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:46:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:46:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:63:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:63:14: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:63:14: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:63:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:63:14: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:63:14: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:63:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:63:14: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:63:14: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:63:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:63:14: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:63:14: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:64:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:64:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:64:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:64:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:64:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:64:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:64:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:64:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:64:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:64:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:64:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:64:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:78:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:78:14: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:78:14: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:78:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:78:14: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:78:14: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:78:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:78:14: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:78:14: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:78:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:78:14: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:78:14: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:79:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:79:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:79:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:79:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:79:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:79:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:79:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:79:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:79:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:79:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:79:17: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:79:17: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:90:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:90:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:90:13: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:90:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:90:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:90:13: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:90:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:90:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:90:13: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:90:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:90:13: sparse:     expected void *ptr
   kernel/trace/trace_preemptirq.c:90:13: sparse:     got int [noderef] __percpu *
   kernel/trace/trace_preemptirq.c:94:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/trace/trace_preemptirq.c:94:17: sparse:     expected void *ptr
--
   kernel/trace/trace_events_user.c:280:37: sparse: sparse: Using plain integer as NULL pointer
   kernel/trace/trace_events_user.c:461:38: sparse: sparse: Using plain integer as NULL pointer
   kernel/trace/trace_events_user.c:482:40: sparse: sparse: Using plain integer as NULL pointer
   kernel/trace/trace_events_user.c:1181:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:1181:16: sparse:    void [noderef] __rcu *
   kernel/trace/trace_events_user.c:1181:16: sparse:    void *
   kernel/trace/trace_events_user.c:1248:13: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/trace_events_user.c:1248:13: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *buf @@     got char * @@
   kernel/trace/trace_events_user.c:1248:13: sparse:     expected void [noderef] __user *buf
   kernel/trace/trace_events_user.c:1248:13: sparse:     got char *
   kernel/trace/trace_events_user.c:1264:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:1264:16: sparse:    void [noderef] __rcu *
   kernel/trace/trace_events_user.c:1264:16: sparse:    void *
   kernel/trace/trace_events_user.c:1291:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:1291:9: sparse:    void [noderef] __rcu *
   kernel/trace/trace_events_user.c:1291:9: sparse:    void *
   kernel/trace/trace_events_user.c: note: in included file:
>> kernel/trace/trace.h:1338:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
   kernel/trace/trace.h:1338:13: sparse:     expected void *ptr
   kernel/trace/trace.h:1338:13: sparse:     got struct ring_buffer_event *[noderef] __percpu *
>> kernel/trace/trace.h:1338:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
   kernel/trace/trace.h:1338:13: sparse:     expected void *ptr
   kernel/trace/trace.h:1338:13: sparse:     got struct ring_buffer_event *[noderef] __percpu *
>> kernel/trace/trace.h:1338:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
   kernel/trace/trace.h:1338:13: sparse:     expected void *ptr
   kernel/trace/trace.h:1338:13: sparse:     got struct ring_buffer_event *[noderef] __percpu *
>> kernel/trace/trace.h:1338:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
   kernel/trace/trace.h:1338:13: sparse:     expected void *ptr
   kernel/trace/trace.h:1338:13: sparse:     got struct ring_buffer_event *[noderef] __percpu *
   kernel/trace/trace_events_user.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/loongarch/include/asm/uaccess.h:232:32: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/loongarch/include/asm/uaccess.h:232:32: sparse:     expected void const *from
   arch/loongarch/include/asm/uaccess.h:232:32: sparse:     got void const [noderef] __user *from
--
>> kernel/trace/trace_events.c:796:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:796:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:796:9: sparse:     got bool [noderef] __percpu *
>> kernel/trace/trace_events.c:796:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:796:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:796:9: sparse:     got bool [noderef] __percpu *
>> kernel/trace/trace_events.c:796:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:796:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:796:9: sparse:     got bool [noderef] __percpu *
>> kernel/trace/trace_events.c:796:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:796:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:796:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:814:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:814:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:814:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:814:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:814:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:814:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:814:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:814:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:814:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:814:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:814:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:814:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:826:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:826:14: sparse:     expected void *ptr
   kernel/trace/trace_events.c:826:14: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:826:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:826:14: sparse:     expected void *ptr
   kernel/trace/trace_events.c:826:14: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:826:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:826:14: sparse:     expected void *ptr
   kernel/trace/trace_events.c:826:14: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:826:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:826:14: sparse:     expected void *ptr
   kernel/trace/trace_events.c:826:14: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:832:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:832:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:832:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:832:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:832:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:832:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:832:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:832:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:832:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:832:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:832:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:832:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:844:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:844:13: sparse:     expected void *ptr
   kernel/trace/trace_events.c:844:13: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:844:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:844:13: sparse:     expected void *ptr
   kernel/trace/trace_events.c:844:13: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:844:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:844:13: sparse:     expected void *ptr
   kernel/trace/trace_events.c:844:13: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:844:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:844:13: sparse:     expected void *ptr
   kernel/trace/trace_events.c:844:13: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:851:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:851:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:851:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:851:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:851:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:851:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:851:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:851:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:851:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:851:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:851:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:851:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:999:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct event_filter *filter @@     got struct event_filter [noderef] __rcu *filter @@
   kernel/trace/trace_events.c:999:31: sparse:     expected struct event_filter *filter
   kernel/trace/trace_events.c:999:31: sparse:     got struct event_filter [noderef] __rcu *filter
   kernel/trace/trace_events.c:1907:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:1907:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:1907:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:1907:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:1907:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:1907:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:1907:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:1907:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:1907:9: sparse:     got bool [noderef] __percpu *
   kernel/trace/trace_events.c:1907:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got bool [noderef] __percpu * @@
   kernel/trace/trace_events.c:1907:9: sparse:     expected void *ptr
   kernel/trace/trace_events.c:1907:9: sparse:     got bool [noderef] __percpu *
--
   kernel/trace/trace.c:406:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
   kernel/trace/trace.c:406:28: sparse:     expected struct trace_export **list
   kernel/trace/trace.c:406:28: sparse:     got struct trace_export [noderef] __rcu **
   kernel/trace/trace.c:420:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
   kernel/trace/trace.c:420:33: sparse:     expected struct trace_export **list
   kernel/trace/trace.c:420:33: sparse:     got struct trace_export [noderef] __rcu **
   kernel/trace/trace.c:2864:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct event_filter *filter @@     got struct event_filter [noderef] __rcu *filter @@
   kernel/trace/trace.c:2864:38: sparse:     expected struct event_filter *filter
   kernel/trace/trace.c:2864:38: sparse:     got struct event_filter [noderef] __rcu *filter
>> kernel/trace/trace.c:7333:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
   kernel/trace/trace.c:7333:20: sparse:     expected void *ptr
   kernel/trace/trace.c:7333:20: sparse:     got struct ring_buffer_event *[noderef] __percpu *
>> kernel/trace/trace.c:7333:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
   kernel/trace/trace.c:7333:20: sparse:     expected void *ptr
   kernel/trace/trace.c:7333:20: sparse:     got struct ring_buffer_event *[noderef] __percpu *
>> kernel/trace/trace.c:7333:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
   kernel/trace/trace.c:7333:20: sparse:     expected void *ptr
   kernel/trace/trace.c:7333:20: sparse:     got struct ring_buffer_event *[noderef] __percpu *
>> kernel/trace/trace.c:7333:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
   kernel/trace/trace.c:7333:20: sparse:     expected void *ptr
   kernel/trace/trace.c:7333:20: sparse:     got struct ring_buffer_event *[noderef] __percpu *
   kernel/trace/trace.c:360:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:360:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:360:9: sparse:    struct trace_export *
   kernel/trace/trace.c:375:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace.c:375:9: sparse:    struct trace_export [noderef] __rcu *
   kernel/trace/trace.c:375:9: sparse:    struct trace_export *

vim +447 kernel/entry/common.c

b6be002bcd1dd1 Thomas Gleixner 2020-11-02  442  
b6be002bcd1dd1 Thomas Gleixner 2020-11-02  443  irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
b6be002bcd1dd1 Thomas Gleixner 2020-11-02  444  {
b6be002bcd1dd1 Thomas Gleixner 2020-11-02  445  	irqentry_state_t irq_state;
b6be002bcd1dd1 Thomas Gleixner 2020-11-02  446  
b6be002bcd1dd1 Thomas Gleixner 2020-11-02 @447  	irq_state.lockdep = lockdep_hardirqs_enabled();
b6be002bcd1dd1 Thomas Gleixner 2020-11-02  448  
b6be002bcd1dd1 Thomas Gleixner 2020-11-02  449  	__nmi_enter();
b6be002bcd1dd1 Thomas Gleixner 2020-11-02  450  	lockdep_hardirqs_off(CALLER_ADDR0);
b6be002bcd1dd1 Thomas Gleixner 2020-11-02  451  	lockdep_hardirq_enter();
b6be002bcd1dd1 Thomas Gleixner 2020-11-02  452  	rcu_nmi_enter();
b6be002bcd1dd1 Thomas Gleixner 2020-11-02  453  
b6be002bcd1dd1 Thomas Gleixner 2020-11-02  454  	instrumentation_begin();
b6be002bcd1dd1 Thomas Gleixner 2020-11-02  455  	trace_hardirqs_off_finish();
b6be002bcd1dd1 Thomas Gleixner 2020-11-02  456  	ftrace_nmi_enter();
b6be002bcd1dd1 Thomas Gleixner 2020-11-02  457  	instrumentation_end();
b6be002bcd1dd1 Thomas Gleixner 2020-11-02  458  
b6be002bcd1dd1 Thomas Gleixner 2020-11-02  459  	return irq_state;
b6be002bcd1dd1 Thomas Gleixner 2020-11-02  460  }
b6be002bcd1dd1 Thomas Gleixner 2020-11-02  461  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
