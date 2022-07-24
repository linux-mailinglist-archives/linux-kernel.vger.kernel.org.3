Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A322457F2C0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 05:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbiGXD1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 23:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGXD12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 23:27:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F1513EA4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 20:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658633245; x=1690169245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c3sj+GBlD1xGWctY+aVdrsm9qyZu8Zx1zr5837o8X24=;
  b=Pvu4mKaCtXRX2NKVqf8eC+JvBXjYEMcTuOtHgIGprKZf/bS0qNRJtgNo
   rCi6WgdbI8JimdrUa8xl0OxLzkQ2R/Vo9uWVcuuHAgJM5okPRTBgd9Dp7
   d/aVVWjIqDJ2Bn3DJ//sugeQgnhNZAuw9IopXL+R+t4E/TT/LXcAmlv4s
   TVtw/s0ClSxEFwgHUhSbKLE31FfE9MlYZl5QysM/9V7obUztLVq09fFWk
   XMrYqXcXtcbPzXiDYy4a0i7/V8L6dDgzh02beDQSWjBO2a9U8nmdVYxes
   o9f6a43h1MOh16cYbYHYD1aCORXxmagJbsvXzh6r0qjP7U7hSp/N3zaJ/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="267903402"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="267903402"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 20:27:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="627019409"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Jul 2022 20:27:23 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFSH5-0003U1-0R;
        Sun, 24 Jul 2022 03:27:23 +0000
Date:   Sun, 24 Jul 2022 11:26:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 1/1] drivers/clk/keystone: avoid a memory leak
Message-ID: <202207241139.rWZLXU81-lkp@intel.com>
References: <20220722041343.39492-1-ruc_gongyuanjun@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722041343.39492-1-ruc_gongyuanjun@163.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuanjun,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on keystone/next linus/master v5.19-rc7 next-20220722]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuanjun-Gong/drivers-clk-keystone-avoid-a-memory-leak/20220722-121453
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-randconfig-r024-20220721 (https://download.01.org/0day-ci/archive/20220724/202207241139.rWZLXU81-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c8db4a192822cdb1e77a32238a893d7a81081f80
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yuanjun-Gong/drivers-clk-keystone-avoid-a-memory-leak/20220722-121453
        git checkout c8db4a192822cdb1e77a32238a893d7a81081f80
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/keystone/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/build_bug.h:5,
                    from include/linux/bits.h:22,
                    from include/linux/bitops.h:6,
                    from include/linux/of.h:15,
                    from include/linux/clk-provider.h:9,
                    from drivers/clk/keystone/syscon-clk.c:6:
   drivers/clk/keystone/syscon-clk.c: In function 'ti_syscon_gate_clk_register':
>> include/linux/compiler.h:56:23: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^~
   drivers/clk/keystone/syscon-clk.c:86:9: note: in expansion of macro 'if'
      86 |         if (ret)
         |         ^~
   drivers/clk/keystone/syscon-clk.c:88:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
      88 |                 return ERR_PTR(ret);
         |                 ^~~~~~


vim +/if +56 include/linux/compiler.h

2bcd521a684cc94 Steven Rostedt 2008-11-21  50  
2bcd521a684cc94 Steven Rostedt 2008-11-21  51  #ifdef CONFIG_PROFILE_ALL_BRANCHES
2bcd521a684cc94 Steven Rostedt 2008-11-21  52  /*
2bcd521a684cc94 Steven Rostedt 2008-11-21  53   * "Define 'is'", Bill Clinton
2bcd521a684cc94 Steven Rostedt 2008-11-21  54   * "Define 'if'", Steven Rostedt
2bcd521a684cc94 Steven Rostedt 2008-11-21  55   */
a15fd609ad53a63 Linus Torvalds 2019-03-20 @56  #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
a15fd609ad53a63 Linus Torvalds 2019-03-20  57  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
