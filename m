Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C235A757F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiHaFJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHaFJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:09:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC40B603F;
        Tue, 30 Aug 2022 22:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661922541; x=1693458541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CkyVV/AlV0V78gzE1iUFdsIQBCphGVca6cbMNx3k9DA=;
  b=SpdQ+F/v0tBz4V0a2pTQTxZ5oYEwI3TahcGvVb0CAGL3A/VoOb9vwvgR
   MwPj1cSjN6zwRR5odtyppDpi641sx1Q8lUYJPmywMZqmBHHJmS8dvKkHV
   G769Pv3Hr58yStn2DEdHRLdeaAHguZREPOjzx4PoLIpg+tNq815+zI1k1
   h2wLrLoSJBZyT7RJJVzeJegbzSa5l8LhwddkC/4YwrqXuZoMOJmXrv+RD
   6fm250BTFTRovLb9bIRRVyee1hf2mZoc6C6zvkKXhj79oA9IEq3dqkDXU
   G04c/ZcnWLYY4BBwRmiyxtkHeJvLDGA8Iqg5U9tjZ+NshcUSmkwrBS2tI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="381669760"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="381669760"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 22:08:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="611975974"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Aug 2022 22:08:55 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTFyB-00011P-04;
        Wed, 31 Aug 2022 05:08:55 +0000
Date:   Wed, 31 Aug 2022 13:08:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, inuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH] hugetlb: simplify hugetlb handling in follow_page_mask
Message-ID: <202208311341.ybNgt0Kz-lkp@intel.com>
References: <20220829234053.159158-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829234053.159158-1-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

I love your patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.0-rc3 next-20220830]
[cannot apply to powerpc/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Kravetz/hugetlb-simplify-hugetlb-handling-in-follow_page_mask/20220830-074147
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: powerpc-randconfig-r001-20220830 (https://download.01.org/0day-ci/archive/20220831/202208311341.ybNgt0Kz-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f7dc41c1552ecd1e483a100c8b0921df62980f38
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mike-Kravetz/hugetlb-simplify-hugetlb-handling-in-follow_page_mask/20220830-074147
        git checkout f7dc41c1552ecd1e483a100c8b0921df62980f38
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/setup-common.c:35:
>> include/linux/hugetlb.h:258:21: error: 'hugetlb_follow_page_mask' defined but not used [-Werror=unused-function]
     258 | static struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/hugetlb_follow_page_mask +258 include/linux/hugetlb.h

   257	
 > 258	static struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
   259					unsigned long address, unsigned int flags)
   260	{
   261		/* should never happen, but do not want to BUG */
   262		return ERR_PTR(-EINVAL);
   263	}
   264	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
