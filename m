Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830C357813F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiGRLuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiGRLur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:50:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA4122BCC;
        Mon, 18 Jul 2022 04:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658145043; x=1689681043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5FOrLIjTNrMgP5wev/cI/BFIYR4iejo/Cv0ax9sgFdE=;
  b=Y+KBikxyTciaPX+ntgQZt4a6fHPhyGjO6ICkAEt2tIUW0S3uwHAHIcKg
   pyr6vQgO+OdvbyxFBKZv5yKN0zj+lyH93Ym99+kK8RRzOqwoHWAK4oBMR
   7Bp2To2A7kbxOf4izPx/g7DejWLhuJIWxiYI6HQmr1XV73FoZ3iauSVZO
   YVZ9WXZ3LzNteHHZkxgZixlkQA3enk3ZSKLMX+04+WNMukPQ86HZs2/o+
   1z7GCbuMRKnFLIk3GMrYWlgO7lqc5dN4wy8EAuH/K2UsVl2wAnEVs1wNx
   BKGI2mBuE/oFtl/wTqcqlKb07Ejx7CC2lzr0aKEu+7+Zpqr6Ja8p0A1EH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="287347962"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="287347962"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 04:50:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="843246864"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jul 2022 04:50:38 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDPGn-0004JW-W6;
        Mon, 18 Jul 2022 11:50:37 +0000
Date:   Mon, 18 Jul 2022 19:50:04 +0800
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
Subject: Re: [PATCH V5 16/16] rv/reactor: Add the panic reactor
Message-ID: <202207181929.M7O6FDon-lkp@intel.com>
References: <5b3233ed8c7bd06895cc177da8a4299d764d6f9a.1657745645.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b3233ed8c7bd06895cc177da8a4299d764d6f9a.1657745645.git.bristot@kernel.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220718/202207181929.M7O6FDon-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 07022e6cf9b5b3baa642be53d0b3c3f1c403dbfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f83faf07d0dad6cfd8fb22ff38b752dd7619bfc0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Bristot-de-Oliveira/The-Runtime-Verification-RV-interface/20220714-052220
        git checkout f83faf07d0dad6cfd8fb22ff38b752dd7619bfc0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/net/pcs/ kernel/trace/rv/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/trace/rv/reactor_panic.c:27:5: warning: no previous prototype for function 'register_react_panic' [-Wmissing-prototypes]
   int register_react_panic(void)
       ^
   kernel/trace/rv/reactor_panic.c:27:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int register_react_panic(void)
   ^
   static 
>> kernel/trace/rv/reactor_panic.c:33:6: warning: no previous prototype for function 'unregister_react_panic' [-Wmissing-prototypes]
   void unregister_react_panic(void)
        ^
   kernel/trace/rv/reactor_panic.c:33:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void unregister_react_panic(void)
   ^
   static 
   2 warnings generated.


vim +/register_react_panic +27 kernel/trace/rv/reactor_panic.c

    26	
  > 27	int register_react_panic(void)
    28	{
    29		rv_register_reactor(&rv_panic);
    30		return 0;
    31	}
    32	
  > 33	void unregister_react_panic(void)
    34	{
    35		rv_unregister_reactor(&rv_panic);
    36	}
    37	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
