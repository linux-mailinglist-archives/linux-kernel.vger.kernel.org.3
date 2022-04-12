Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5864FE35D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351534AbiDLOG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346027AbiDLOGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:06:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8CDF2B;
        Tue, 12 Apr 2022 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649772246; x=1681308246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mpBkEIWIDmrR43RVF1sWg8x0t3HhAwOXKBLdLpHlNJs=;
  b=hQAwm5fYsOfjGny880sZvtCOO9L9kLYAJ/qGc+FfHRRTnyMDw6sajPJh
   VXjGQ90TdqN7jDAQ25Y7t+JSu1Qy4OtAPvK519ymcmvpahF8uzStbuk5Z
   DNUjl/hH1PY/Kfk3yWjn7DEVC4zwmJb/TRpfLO0s+N1ffi+lz8/rukAWb
   moRNPXAe+E1AlVyXcm4xRpo+XiuQcYZ9U9u8V8zSCOeiw0///lVuHWPjs
   bh2V1xBbGTV9Xhl/gxwY4xEWKW3XBHVC/IC2A8FT3T1JYuOqiQKBoQcCY
   8+yXxTe48MYTqnAV1Wh6yDuHm/hsA32aQhtuDWaMXOSExDlhC1X2SEbyS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="259976579"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="259976579"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 07:04:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="559337307"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 12 Apr 2022 07:04:02 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neH7h-0002tc-LI;
        Tue, 12 Apr 2022 14:04:01 +0000
Date:   Tue, 12 Apr 2022 22:03:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     kbuild-all@lists.01.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 1/4] mm: hugetlb_vmemmap: introduce
 CONFIG_HUGETLB_PAGE_HAS_OPTIMIZE_VMEMMAP
Message-ID: <202204122103.jCnIflyV-lkp@intel.com>
References: <20220412111434.96498-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412111434.96498-2-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muchun,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]
[also build test ERROR on next-20220412]
[cannot apply to tip/x86/mm masahiroy-kbuild/for-next linus/master v5.18-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Muchun-Song/add-hugetlb_optimize_vmemmap-sysctl/20220412-191713
base:   https://github.com/hnaz/linux-mm master
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220412/202204122103.jCnIflyV-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bb63a010442d551909f826b4c05bf707a6dff052
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muchun-Song/add-hugetlb_optimize_vmemmap-sysctl/20220412-191713
        git checkout bb63a010442d551909f826b4c05bf707a6dff052
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from scripts/selinux/mdp/mdp.c:22:
>> include/linux/kconfig.h:8:10: fatal error: generated/autoconf_ext.h: No such file or directory
       8 | #include <generated/autoconf_ext.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[4]: *** [scripts/Makefile.host:111: scripts/selinux/mdp/mdp] Error 1
   make[4]: Target '__build' not remade because of errors.
   make[3]: *** [scripts/Makefile.build:607: scripts/selinux/mdp] Error 2
   make[3]: Target '__build' not remade because of errors.
   make[2]: *** [scripts/Makefile.build:607: scripts/selinux] Error 2
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1267: scripts] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:226: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +8 include/linux/kconfig.h

     6	
     7	#ifndef __EXCLUDE_AUTOCONF_EXT_H
   > 8	#include <generated/autoconf_ext.h>
     9	#endif
    10	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
