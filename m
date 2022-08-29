Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E0C5A4050
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 02:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiH2ASs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 20:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2ASp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 20:18:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9E1E0EF;
        Sun, 28 Aug 2022 17:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661732324; x=1693268324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VkVo2KDkqcPeWUpG5RCjP+0wRvccIebUsn6wx9dVc4g=;
  b=fYPejCHOcBHmdZOqvxWW0ritR7On9rQx32QpMVBKgBsRBXBW8e4is31B
   DUu8qZyJlKDvQDo+es4fgfAh9XxT7seRDX++hYOj6UvNPZAj6Fh0GKqnP
   MTFQSERwLGJsD4oJ5Klje09xxPVGKLeWrbtD44t+3NOLrGtfXW+725C8E
   9MQoC2H/x13lpsUIM92vK0GwlyanRyhKQoy+wDEOWbaBeVCCk+VbykrY+
   Ty+Mb/iuY+YkIhyHa5zpXOGpYgdORczJnnknIz5NpDno3h7cSeGs2C4U4
   KZTfOYUCaZb6q5zPamKAuTzoHlLOi/Ah/sgcLCiBxbIk+k7YoJs9XG+2Y
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="320897820"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="320897820"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 17:18:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="786912671"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Aug 2022 17:18:42 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSSUD-0001lk-1c;
        Mon, 29 Aug 2022 00:18:41 +0000
Date:   Mon, 29 Aug 2022 08:18:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li Zhong <floridsleeves@gmail.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        lily <floridsleeves@gmail.com>
Subject: Re: [PATCH v1] drivers/clk/clk: check return value of
 clk_pm_runtime_get()
Message-ID: <202208290820.mUMIcCS2-lkp@intel.com>
References: <20220828202025.1948848-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828202025.1948848-1-floridsleeves@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on linus/master v6.0-rc3 next-20220826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Zhong/drivers-clk-clk-check-return-value-of-clk_pm_runtime_get/20220829-042043
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-randconfig-r034-20220829 (https://download.01.org/0day-ci/archive/20220829/202208290820.mUMIcCS2-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project a2100daf12fb980a29fd1a9c85ccf8eaaaf79730)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/26ebbe49c7b40cb8465ed2bba4e4e62c3a55bb93
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Li-Zhong/drivers-clk-clk-check-return-value-of-clk_pm_runtime_get/20220829-042043
        git checkout 26ebbe49c7b40cb8465ed2bba4e4e62c3a55bb93
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/clk/clk.c:3016:2: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
           clk_summary_show_one(s, c, level);
           ^
   drivers/clk/clk.c:3014:5: note: previous statement is here
       if (ret)
       ^
   1 warning generated.


vim +/if +3016 drivers/clk/clk.c

89ac8d7ae1cde0 Mike Turquette 2013-08-21  3006  
4dff95dc9477a3 Stephen Boyd   2015-04-30  3007  static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
4dff95dc9477a3 Stephen Boyd   2015-04-30  3008  				     int level)
4dff95dc9477a3 Stephen Boyd   2015-04-30  3009  {
4dff95dc9477a3 Stephen Boyd   2015-04-30  3010  	struct clk_core *child;
26ebbe49c7b40c lily           2022-08-28  3011  	int ret;
b2476490ef1113 Mike Turquette 2012-03-15  3012  	
26ebbe49c7b40c lily           2022-08-28  3013  	ret = clk_pm_runtime_get(c);
26ebbe49c7b40c lily           2022-08-28  3014      if (ret)
26ebbe49c7b40c lily           2022-08-28  3015          return;
4dff95dc9477a3 Stephen Boyd   2015-04-30 @3016  	clk_summary_show_one(s, c, level);
1bb294a7981c73 Taniya Das     2021-12-20  3017  	clk_pm_runtime_put(c);
0e1c03017549a9 Viresh Kumar   2012-04-11  3018  
4dff95dc9477a3 Stephen Boyd   2015-04-30  3019  	hlist_for_each_entry(child, &c->children, child_node)
4dff95dc9477a3 Stephen Boyd   2015-04-30  3020  		clk_summary_show_subtree(s, child, level + 1);
b2476490ef1113 Mike Turquette 2012-03-15  3021  }
b2476490ef1113 Mike Turquette 2012-03-15  3022  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
