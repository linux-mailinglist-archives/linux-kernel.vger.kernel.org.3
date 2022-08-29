Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044DB5A4058
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 02:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiH2A2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 20:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2A2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 20:28:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077872F384;
        Sun, 28 Aug 2022 17:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661732925; x=1693268925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kDX69736XpDMgOUcSTK4ZbYLBegfexKrW1fk+/B1fPs=;
  b=mK0gLOy/WvaIpK8zLh7S1pVZREFRokN0f2f2BXRC3Azc1ZVldjYAztOL
   Zx+JOsKQYaclRPdmsaVEAAqcHTFE+rfC2cFr9TTlLP/xn8ivnar+hmxz1
   wKz1AUT3EGfkURUyqy5AOFBEc/ujsVwz7e3IRMF440huki3CY8KYLvXZl
   aa9cyg7efBWL4FHVbn+ywBl8jw40IBAnhFvUqRQL7sBIfjytoa4j+uga+
   51kTMxxdgJWZErGykyYpEf1sP28nOGwECQFP1TEFl5e8vUxlMbm2kKhFz
   5Oc2FWh5mvZTaqDuL98474TeVysajEch+XFL7vu/daPS4rZG+H0x5H0HD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="292361557"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="292361557"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 17:28:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="753446763"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2022 17:28:43 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSSdu-0001nU-1S;
        Mon, 29 Aug 2022 00:28:42 +0000
Date:   Mon, 29 Aug 2022 08:28:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li Zhong <floridsleeves@gmail.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, mturquette@baylibre.com, sboyd@kernel.org,
        lily <floridsleeves@gmail.com>
Subject: Re: [PATCH v1] drivers/clk/clk: check return value of
 clk_pm_runtime_get()
Message-ID: <202208290801.8grjrhjQ-lkp@intel.com>
References: <20220828202025.1948848-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828202025.1948848-1-floridsleeves@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on linus/master v6.0-rc2 next-20220826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Zhong/drivers-clk-clk-check-return-value-of-clk_pm_runtime_get/20220829-042043
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arc-randconfig-r043-20220829 (https://download.01.org/0day-ci/archive/20220829/202208290801.8grjrhjQ-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/26ebbe49c7b40cb8465ed2bba4e4e62c3a55bb93
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Li-Zhong/drivers-clk-clk-check-return-value-of-clk_pm_runtime_get/20220829-042043
        git checkout 26ebbe49c7b40cb8465ed2bba4e4e62c3a55bb93
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/clk/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/err.h:5,
                    from include/linux/clk.h:12,
                    from drivers/clk/clk.c:9:
   drivers/clk/clk.c: In function 'clk_summary_show_subtree':
>> include/linux/compiler.h:56:23: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
      56 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                       ^~
   drivers/clk/clk.c:3014:5: note: in expansion of macro 'if'
    3014 |     if (ret)
         |     ^~
   drivers/clk/clk.c:3016:9: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    3016 |         clk_summary_show_one(s, c, level);
         |         ^~~~~~~~~~~~~~~~~~~~


vim +/if +56 include/linux/compiler.h

2bcd521a684cc9 Steven Rostedt 2008-11-21  50  
2bcd521a684cc9 Steven Rostedt 2008-11-21  51  #ifdef CONFIG_PROFILE_ALL_BRANCHES
2bcd521a684cc9 Steven Rostedt 2008-11-21  52  /*
2bcd521a684cc9 Steven Rostedt 2008-11-21  53   * "Define 'is'", Bill Clinton
2bcd521a684cc9 Steven Rostedt 2008-11-21  54   * "Define 'if'", Steven Rostedt
2bcd521a684cc9 Steven Rostedt 2008-11-21  55   */
a15fd609ad53a6 Linus Torvalds 2019-03-20 @56  #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
a15fd609ad53a6 Linus Torvalds 2019-03-20  57  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
