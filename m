Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1605020B4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348897AbiDOCvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348876AbiDOCvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:51:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21182BAB85;
        Thu, 14 Apr 2022 19:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649990904; x=1681526904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fvKMTgYSbk6pJ8MqCyitz/wA3aCnBOZnivgruHxRgxI=;
  b=fMFflodfJVuurKHV8jyoeKr6sEz/Cn/ax5eoGJQTBfMCmxctdXn8tDZu
   g5kKgvV6fJBcWlEQPaX8eAIY7Rq+j0mml2VWfttK7oOt8/1Jx3SnfeMsm
   kFpG6f1yTIJJ7Yi/dvg+6CU4cvA/b1iIIBenbfWXJgBvdT6qC2vm3dGhy
   AY6vIqBP37EuUoMoi5C8pxkYXsLQRfeOYpJkircmm/quvx1kKR+Whmd/R
   F7oJF68hjp7T0HJzmdYnnyOyNj+Xf+Lb4QCpzakDCpPuZKy/HkNJSRYkw
   ucDCYr27+OCAUmPFNuJH7tQEamAL04/LJXOsO9I7fkag3uZixKRXDYqXB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="349515617"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="349515617"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 19:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="560421033"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 14 Apr 2022 19:48:16 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nfC0N-0001S9-M6;
        Fri, 15 Apr 2022 02:48:15 +0000
Date:   Fri, 15 Apr 2022 10:47:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 1/4] mm: hugetlb_vmemmap: introduce
 CONFIG_HUGETLB_PAGE_HAS_OPTIMIZE_VMEMMAP
Message-ID: <202204151043.JSdPGnod-lkp@intel.com>
References: <20220412111434.96498-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412111434.96498-2-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
[also build test ERROR on next-20220414]
[cannot apply to tip/x86/mm masahiroy-kbuild/for-next linus/master v5.18-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Muchun-Song/add-hugetlb_optimize_vmemmap-sysctl/20220412-191713
base:   https://github.com/hnaz/linux-mm master
config: s390-randconfig-r025-20220414 (https://download.01.org/0day-ci/archive/20220415/202204151043.JSdPGnod-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6ea489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/bb63a010442d551909f826b4c05bf707a6dff052
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muchun-Song/add-hugetlb_optimize_vmemmap-sysctl/20220412-191713
        git checkout bb63a010442d551909f826b4c05bf707a6dff052
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:2:
>> include/linux/kconfig.h:8:10: fatal error: 'generated/autoconf_ext.h' file not found
   #include <generated/autoconf_ext.h>
            ^~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
   make[2]: *** [scripts/Makefile.host:111: arch/s390/tools/gen_facilities] Error 1
   make[2]: Target 'kapi' not remade because of errors.
   make[1]: *** [arch/s390/Makefile:148: archprepare] Error 2
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
