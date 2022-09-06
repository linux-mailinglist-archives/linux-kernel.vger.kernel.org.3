Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94A15AE89D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240018AbiIFMn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiIFMn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:43:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9088B2CDF7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662468205; x=1694004205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SKVSACxEGKvzhV1mjnOCMkraBJm5utM2asRpqotl1lc=;
  b=aR7XQ/HFPeNA7ci8o8n5ntxswJN7JTG4q+7gV8T2W0KNbSPe6+mLkY8r
   SIQ45x0xJ/TPQBHObQDSKjROYvh+EpzHS/10AYlNt6tfxYMWZi3WXLt0J
   rZASqPd7ClKhURR0Wc8nMNbTQP3eiSNoqEZIR+8V3c8YodMSeDlhY3SV7
   EhoiHMFXCmWgTD3RQ271JD51xiPe6iiqZKEjLovp8HZaurFulxHXN9Qq2
   HZeiItVephRQXwhY3btTIEUt5NiphstYMKNveB8u+fhwiBTDMb4MFwaDq
   rEi190ivPakwRXgBMZxEKo+yxgWFmoLg2wYbNSORdYqGZka+LHLDo31Po
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="382876508"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="382876508"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:43:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="647216326"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 06 Sep 2022 05:43:21 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVXvF-00056f-03;
        Tue, 06 Sep 2022 12:43:21 +0000
Date:   Tue, 6 Sep 2022 20:43:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muchun Song <songmuchun@bytedance.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, osalvador@suse.de, david@redhat.com,
        ying.huang@intel.com, aneesh.kumar@linux.ibm.com,
        rientjes@google.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev
Subject: Re: [PATCH v2] mm: hugetlb: eliminate memory-less nodes handling
Message-ID: <202209062036.1eQ3lYsX-lkp@intel.com>
References: <20220906034239.69436-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906034239.69436-1-songmuchun@bytedance.com>
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

I love your patch! Perhaps something to improve:

[auto build test WARNING on next-20220901]
[cannot apply to akpm-mm/mm-everything driver-core/driver-core-testing linus/master v6.0-rc4 v6.0-rc3 v6.0-rc2 v6.0-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Muchun-Song/mm-hugetlb-eliminate-memory-less-nodes-handling/20220906-114538
base:    e47eb90a0a9ae20b82635b9b99a8d0979b757ad8
config: arm-randconfig-r023-20220906 (https://download.01.org/0day-ci/archive/20220906/202209062036.1eQ3lYsX-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/ec1575c86ce4904a7134d2fef8e231ecd50ffc75
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muchun-Song/mm-hugetlb-eliminate-memory-less-nodes-handling/20220906-114538
        git checkout ec1575c86ce4904a7134d2fef8e231ecd50ffc75
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from mm/folio-compat.c:7:
   In file included from include/linux/migrate.h:8:
>> include/linux/hugetlb.h:1150:49: warning: declaration of 'struct node' will not be visible outside of this function [-Wvisibility]
   static inline void hugetlb_register_node(struct node *node)
                                                   ^
   include/linux/hugetlb.h:1154:51: warning: declaration of 'struct node' will not be visible outside of this function [-Wvisibility]
   static inline void hugetlb_unregister_node(struct node *node)
                                                     ^
   2 warnings generated.


vim +1150 include/linux/hugetlb.h

  1149	
> 1150	static inline void hugetlb_register_node(struct node *node)
  1151	{
  1152	}
  1153	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
