Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD58F577DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbiGRIrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiGRIrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:47:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2BA6403;
        Mon, 18 Jul 2022 01:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658134021; x=1689670021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OBECoidjbs/b4gjb4vh7yiE3zSs/3k3t1WbIVAmKqjU=;
  b=KJi/6pG2faldsW2HbVlS/IX4kBma40OhtItBSDFJ0SgCK3AWCaoA/0QO
   qAhj16cku18y5DNGEmGsDfVOzE0+X2F7EA7waNPx/ueMdCb5cyNoXab8d
   lsMZH/YHiBTrseR/GGv66ecNjI9ewQ/PIXmA00TwpZlG+SQhOGIw3sAEE
   0GNAoE0z+A+O8dTNBAxpXKx8rsh6VOut2vypnZoJCBxHe0mw7jml3O71p
   Tgoqi+mR+6x7NoVYmsgogWtYMWSdJCXRj+Cgbdoofn9kr2E4wLGGvdtwe
   mMaG5wmhPATMpevkbw7lXeVZqytontrlhvWo6Vm1TINCusUw87/oYmp/K
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="265952373"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="265952373"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 01:47:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="723785806"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 18 Jul 2022 01:46:56 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDMP1-0004Cw-KJ;
        Mon, 18 Jul 2022 08:46:55 +0000
Date:   Mon, 18 Jul 2022 16:45:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Tao Zhou <tao.zhou@linux.dev>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V5 15/16] rv/reactor: Add the printk reactor
Message-ID: <202207181646.sRRbkyru-lkp@intel.com>
References: <5fcf3d21b51bc4c1a6d2968cfd0c60fdbc1d471b.1657745645.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fcf3d21b51bc4c1a6d2968cfd0c60fdbc1d471b.1657745645.git.bristot@kernel.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rostedt-trace/for-next]
[also build test WARNING on tip/sched/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Bristot-de-Oliveira/The-Runtime-Verification-RV-interface/20220714-052220
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220718/202207181646.sRRbkyru-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 07022e6cf9b5b3baa642be53d0b3c3f1c403dbfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d1746223447deb1d1646f968512a065a1cd63a9c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Bristot-de-Oliveira/The-Runtime-Verification-RV-interface/20220714-052220
        git checkout d1746223447deb1d1646f968512a065a1cd63a9c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/net/pcs/ kernel/trace/rv/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/trace/rv/reactor_printk.c:26:5: warning: no previous prototype for function 'register_react_printk' [-Wmissing-prototypes]
   int register_react_printk(void)
       ^
   kernel/trace/rv/reactor_printk.c:26:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int register_react_printk(void)
   ^
   static 
>> kernel/trace/rv/reactor_printk.c:32:6: warning: no previous prototype for function 'unregister_react_printk' [-Wmissing-prototypes]
   void unregister_react_printk(void)
        ^
   kernel/trace/rv/reactor_printk.c:32:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void unregister_react_printk(void)
   ^
   static 
   2 warnings generated.


vim +/register_react_printk +26 kernel/trace/rv/reactor_printk.c

    25	
  > 26	int register_react_printk(void)
    27	{
    28		rv_register_reactor(&rv_printk);
    29		return 0;
    30	}
    31	
  > 32	void unregister_react_printk(void)
    33	{
    34		rv_unregister_reactor(&rv_printk);
    35	}
    36	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
