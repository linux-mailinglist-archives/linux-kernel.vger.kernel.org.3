Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3595A4028
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 01:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiH1X1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 19:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiH1X1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 19:27:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBE42ED63;
        Sun, 28 Aug 2022 16:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661729260; x=1693265260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s6M+tz/8Vcsx8DVrjSwhv6Ow+s3cbQupGX0BGWGmVdM=;
  b=lXMlVYKOX/XOahFcBBaD8djsmSdDMkLv9xtW2PozHDgA7bofbwdeocJc
   e2t0dGTCJhI5KHhLQOmBETy6A4rtT536RQAZmHOjHYbpeYyjErc4SNHr9
   Kv+ooM9wh5iqtJFgHPhXLiCG7ZjGDH6XrdXdwLvoSgcV+e62H0DNGhqhD
   7frieJomiHdDzUh6dyDZri9lqJZRaWUObqctldSSYFaWdBHNg9ePEdbi6
   yJDiTGL8kQccX2ZhBG4vrS8fpS43hIZ+VwI3KyjZpFf/v38FQhHizm6Mp
   BzWSGgvmjA1tW/v0RKvbDxVpBowamjISgwCBEp6g6/2ErRNxlQ+NU9kMp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="293519261"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="293519261"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 16:27:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="587953874"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Aug 2022 16:27:38 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSRgn-0001ih-1R;
        Sun, 28 Aug 2022 23:27:37 +0000
Date:   Mon, 29 Aug 2022 07:26:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li Zhong <floridsleeves@gmail.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, mturquette@baylibre.com, sboyd@kernel.org,
        lily <floridsleeves@gmail.com>
Subject: Re: [PATCH v1] drivers/clk/clk: check return value of
 clk_pm_runtime_get()
Message-ID: <202208290728.M8AblulP-lkp@intel.com>
References: <20220828202025.1948848-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828202025.1948848-1-floridsleeves@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: riscv-randconfig-r042-20220828 (https://download.01.org/0day-ci/archive/20220829/202208290728.M8AblulP-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/26ebbe49c7b40cb8465ed2bba4e4e62c3a55bb93
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Li-Zhong/drivers-clk-clk-check-return-value-of-clk_pm_runtime_get/20220829-042043
        git checkout 26ebbe49c7b40cb8465ed2bba4e4e62c3a55bb93
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/clk/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/clk/clk.c: In function 'clk_summary_show_subtree':
>> drivers/clk/clk.c:3014:5: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    3014 |     if (ret)
         |     ^~
   drivers/clk/clk.c:3016:9: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    3016 |         clk_summary_show_one(s, c, level);
         |         ^~~~~~~~~~~~~~~~~~~~


vim +/if +3014 drivers/clk/clk.c

  3006	
  3007	static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
  3008					     int level)
  3009	{
  3010		struct clk_core *child;
  3011		int ret;
  3012		
  3013		ret = clk_pm_runtime_get(c);
> 3014	    if (ret)
  3015	        return;
  3016		clk_summary_show_one(s, c, level);
  3017		clk_pm_runtime_put(c);
  3018	
  3019		hlist_for_each_entry(child, &c->children, child_node)
  3020			clk_summary_show_subtree(s, child, level + 1);
  3021	}
  3022	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
