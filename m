Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A75649FEB3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350471AbiA1RKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:10:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:45625 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245716AbiA1RKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:10:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643389835; x=1674925835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kgXvkvGlDf1JVTYkFL7dYdiuifP4CeQljPpc6IyMVvA=;
  b=lkE8sOiCpd6XsO4+ra6Otx5s2W7PFeLkj3a9q7l7Ke3TGuYmezd/qJg4
   dLQySUy9tHAQj/lZamklZkT5vWuKU+G9rzd9l/5pW2Uuozu5/5Qz3QRZb
   yuQ+nn4oqF8qQBRV2sFtBHNYT3ONZbWc+Xk4QofWQVRAIS/RCLsGsRKFu
   llXBLfonq9ZiukJ/tw+6171Y+JInM1fPSmB61prhz4kOZ16EAxI1imbgO
   Pa+1tGL8b4qdUY7EvahWBAQrvuiYWyHASdeHMqeLirH3TcPQZ8RYmdHvk
   cIhJQ9oPMYqJOkdCiB0iPhgW2X0v0zNsYsODHi9IrnHkWhQygmN1iGgyc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="234543267"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="234543267"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 09:06:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="533563875"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jan 2022 09:06:38 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDUhq-000O76-4k; Fri, 28 Jan 2022 17:06:38 +0000
Date:   Sat, 29 Jan 2022 01:06:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhanglianjie <zhanglianjie@uniontech.com>, keescook@chromium.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, yzaikin@google.com,
        mcgrof@kernel.org, akpm@linux-foundation.org,
        zhanglianjie <zhanglianjie@uniontech.com>
Subject: Re: [PATCH] mm: move page-writeback sysctls to is own file
Message-ID: <202201290141.GDKdUC72-lkp@intel.com>
References: <20220128091901.18074-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128091901.18074-1-zhanglianjie@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhanglianjie,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.17-rc1 next-20220128]
[cannot apply to hnaz-mm/master linux/master kees/for-next/pstore]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/zhanglianjie/mm-move-page-writeback-sysctls-to-is-own-file/20220128-172052
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 23a46422c56144939c091c76cf389aa863ce9c18
config: arm64-buildonly-randconfig-r005-20220127 (https://download.01.org/0day-ci/archive/20220129/202201290141.GDKdUC72-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/d24502aa729978894feb2de10481cd139ae5bb42
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review zhanglianjie/mm-move-page-writeback-sysctls-to-is-own-file/20220128-172052
        git checkout d24502aa729978894feb2de10481cd139ae5bb42
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/page-writeback.c:509:5: warning: no previous prototype for function 'dirty_background_ratio_handler' [-Wmissing-prototypes]
   int dirty_background_ratio_handler(struct ctl_table *table, int write,
       ^
   mm/page-writeback.c:509:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int dirty_background_ratio_handler(struct ctl_table *table, int write,
   ^
   static 
   mm/page-writeback.c:520:5: warning: no previous prototype for function 'dirty_background_bytes_handler' [-Wmissing-prototypes]
   int dirty_background_bytes_handler(struct ctl_table *table, int write,
       ^
   mm/page-writeback.c:520:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int dirty_background_bytes_handler(struct ctl_table *table, int write,
   ^
   static 
   mm/page-writeback.c:531:5: warning: no previous prototype for function 'dirty_ratio_handler' [-Wmissing-prototypes]
   int dirty_ratio_handler(struct ctl_table *table, int write, void *buffer,
       ^
   mm/page-writeback.c:531:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int dirty_ratio_handler(struct ctl_table *table, int write, void *buffer,
   ^
   static 
   mm/page-writeback.c:545:5: warning: no previous prototype for function 'dirty_bytes_handler' [-Wmissing-prototypes]
   int dirty_bytes_handler(struct ctl_table *table, int write,
       ^
   mm/page-writeback.c:545:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int dirty_bytes_handler(struct ctl_table *table, int write,
   ^
   static 
   mm/page-writeback.c:2002:5: warning: no previous prototype for function 'dirty_writeback_centisecs_handler' [-Wmissing-prototypes]
   int dirty_writeback_centisecs_handler(struct ctl_table *table, int write,
       ^
   mm/page-writeback.c:2002:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int dirty_writeback_centisecs_handler(struct ctl_table *table, int write,
   ^
   static 
>> mm/page-writeback.c:93:28: warning: unused variable 'dirty_bytes_min' [-Wunused-const-variable]
   static const unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
                              ^
   6 warnings generated.


vim +/dirty_bytes_min +93 mm/page-writeback.c

    91	
    92	/* this is needed for the proc_doulongvec_minmax of vm_dirty_bytes */
  > 93	static const unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
    94	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
