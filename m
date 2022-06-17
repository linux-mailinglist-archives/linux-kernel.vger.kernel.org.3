Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6DC54FC2A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383272AbiFQRXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382906AbiFQRXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:23:34 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBB918383;
        Fri, 17 Jun 2022 10:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655486613; x=1687022613;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5r0rapPYszeZBBEbJ/ZlpHIsTYM/ozOqcBVhPIANdrM=;
  b=eO+bj2hEeWAUudtg5CU9yl9fxz0asyamHWOeYHJ1EqkZMBoywm3DB07O
   aGX083DvfOXZPN2ZXOmJI1ZgcaGukg1qroBnoGQ44xP2o8WFM+BeCkroY
   rh4bWzzWk+OKKYO7SlwsYvamyMbMbntL3o0TRfPYlxn71wfwPsUjPs997
   VpHzLjF8EJp3GU56yeCLC9Cd98FD81sLzoTPTPSA04zuJncDwl5qnKvvp
   dDxBqAAkjRdtKVR1jj6BBg4lxGKmo83PxNNP67U5qSyrpa7eiLOlP28Ua
   zGd05SBQxpAtIZDuL2dJMWgkX3KRRT8yqKE2dqZYhJkiV9k/NWy6nmCbr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="259358208"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="259358208"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 10:06:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="560563793"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Jun 2022 10:06:50 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2FQn-000Pcp-M0;
        Fri, 17 Jun 2022 17:06:49 +0000
Date:   Sat, 18 Jun 2022 01:06:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     kbuild-all@lists.01.org, Muchun Song <songmuchun@bytedance.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        catalin.marinas@arm.com, will@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 1/4] hugetlb: skip to end of PT page mapping when pte not
 present
Message-ID: <202206180021.rcc4B1by-lkp@intel.com>
References: <20220616210518.125287-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616210518.125287-2-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

I love your patch! Yet something to improve:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v5.19-rc2 next-20220617]
[cannot apply to arm64/for-next/core arm/for-next kvmarm/next xilinx-xlnx/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Kravetz/hugetlb-speed-up-linear-address-scanning/20220617-050726
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20220618/202206180021.rcc4B1by-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/4c647687607f10fece04967b8180c0dadaf765e6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mike-Kravetz/hugetlb-speed-up-linear-address-scanning/20220617-050726
        git checkout 4c647687607f10fece04967b8180c0dadaf765e6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/hugetlb.c: In function 'hugetlb_mask_last_page':
>> mm/hugetlb.c:6901:9: error: duplicate case value
    6901 |         case PUD_SIZE:
         |         ^~~~
   mm/hugetlb.c:6899:9: note: previously used here
    6899 |         case P4D_SIZE:
         |         ^~~~


vim +6901 mm/hugetlb.c

  6886	
  6887	/*
  6888	 * Return a mask that can be used to update an address to the last huge
  6889	 * page in a page table page mapping size.  Used to skip non-present
  6890	 * page table entries when linearly scanning address ranges.  Architectures
  6891	 * with unique huge page to page table relationships can define their own
  6892	 * version of this routine.
  6893	 */
  6894	unsigned long hugetlb_mask_last_page(struct hstate *h)
  6895	{
  6896		unsigned long hp_size = huge_page_size(h);
  6897	
  6898		switch (hp_size) {
  6899		case P4D_SIZE:
  6900			return PGDIR_SIZE - P4D_SIZE;
> 6901		case PUD_SIZE:
  6902			return P4D_SIZE - PUD_SIZE;
  6903		case PMD_SIZE:
  6904			return PUD_SIZE - PMD_SIZE;
  6905		default:
  6906			break; /* Should never happen */
  6907		}
  6908	
  6909		return ~(0UL);
  6910	}
  6911	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
