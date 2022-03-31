Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CE04ED9C4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbiCaMmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbiCaMmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:42:00 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D8B144B6D;
        Thu, 31 Mar 2022 05:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648730413; x=1680266413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CJqdXwNo9v6/Qr4UTWxir9h956p2ApzEQvHPOUPXUPE=;
  b=hWEzodKAlB9VT8StNQVTdF55thwdxJ1fPjsG/YTLXgPqL1vfGkunAeWU
   0Zdc0OF0jJCIO81n5nfyxUzE941rjK24kbnEIb4WRLj2Ozglr2coEYfx7
   2X8djIBi9QjC2xDv1zLrQI0xf2XiSmCo7jJtsQzc5iH2VlJfjL8nF9FBK
   8C9b8HSHy4AgLjPFaXZ4kEmDk6kA+REpQwtWGk1WZ/d7uFce5ghjbU3Y0
   0Gg+QAAX9m9my4sctf638zibqdYBKmRIkIFv1UW4zzrnNoocdpFRLd/Sn
   T/XOUa6CVDo7oaTFJP9Wv4YQEbfA5j93nX1EghjA0besme3e0Tpof8tgv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259535728"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="259535728"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 05:40:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="840157894"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 31 Mar 2022 05:40:09 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZu5w-0000G4-Cy;
        Thu, 31 Mar 2022 12:40:08 +0000
Date:   Thu, 31 Mar 2022 20:39:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     kbuild-all@lists.01.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v6 1/4] mm: hugetlb_vmemmap: introduce
 STRUCT_PAGE_SIZE_IS_POWER_OF_2
Message-ID: <202203312010.ct30oFE6-lkp@intel.com>
References: <20220330153745.20465-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330153745.20465-2-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muchun,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]
[also build test ERROR on mcgrof/sysctl-next linus/master next-20220331]
[cannot apply to v5.17]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Muchun-Song/add-hugetlb_free_vmemmap-sysctl/20220330-234018
base:   https://github.com/hnaz/linux-mm master
config: ia64-randconfig-s031-20220331 (https://download.01.org/0day-ci/archive/20220331/202203312010.ct30oFE6-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/5164c566d4fbdb808689ee4552ed95eab421522e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muchun-Song/add-hugetlb_free_vmemmap-sysctl/20220330-234018
        git checkout 5164c566d4fbdb808689ee4552ed95eab421522e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/ia64/include/asm/thread_info.h:10,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/ia64/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/kref.h:16,
                    from include/linux/mm_types.h:8,
                    from mm/struct_page_size.c:10:
>> arch/ia64/include/asm/asm-offsets.h:1:10: fatal error: generated/asm-offsets.h: No such file or directory
       1 | #include <generated/asm-offsets.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
   make[2]: *** [scripts/Makefile.build:127: mm/struct_page_size.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1261: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:226: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +1 arch/ia64/include/asm/asm-offsets.h

559df2e0210352f Sam Ravnborg 2009-04-19 @1  #include <generated/asm-offsets.h>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
