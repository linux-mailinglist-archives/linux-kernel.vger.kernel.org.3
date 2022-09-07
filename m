Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2F45AFAEF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 06:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIGECH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiIGECF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:02:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7617D1F4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 21:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662523324; x=1694059324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ln+JO6/zBHVt1PCyuUuoSHz5m1pbbht0yVef688wCVI=;
  b=WNzftsd0v3UTTjOK+GbtFmUT8fIMhCddNGeRPXbnIwyV9OSSD8ynSuPJ
   bJ9X2IfZZ9/2yYH+iw4a+CBKikrA5+KvK4WXicv2QS2gv7xZQrT16DSLa
   fvI2xXMTUiFOs4++v5lExq7gmq4UmTqzvfyuA4OCS/AKfccPOd1Bylmlu
   HX5CHN/a+QmhvIQBdpNB3b3d904+VzHqlvqjW0GUJc0PaCsZ5jjXQBLAq
   NGZxEtZaiwayuq9csnZyfvR7+unYkOoSg0opE8YwXskyV/Mf73K7O/KzN
   L0urgFB2219L6JD79xPqquMpgGLM59wxiWRt8hdrT+kdwWDlCLv8s5tiW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="296771693"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="296771693"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 21:02:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="682655588"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 06 Sep 2022 21:02:01 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVmGG-000653-1f;
        Wed, 07 Sep 2022 04:02:00 +0000
Date:   Wed, 7 Sep 2022 12:01:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org, akpm@linux-foundation.org,
        songmuchun@bytedance.com, mike.kravetz@oracle.com,
        willy@infradead.org, vbabka@suse.cz, william.kucharski@oracle.com,
        dhowells@redhat.com, peterx@redhat.com, arnd@arndb.de,
        ccross@google.com, hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [PATCH v2 6/6] mm/hugetlb add folio_hstate()
Message-ID: <202209071158.3gw6CkuN-lkp@intel.com>
References: <20220906165445.146913-7-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906165445.146913-7-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sidhartha,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on next-20220906]
[cannot apply to soc/for-next linus/master v6.0-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sidhartha-Kumar/begin-converting-hugetlb-code-to-folios/20220907-005803
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: openrisc-randconfig-r033-20220906 (https://download.01.org/0day-ci/archive/20220907/202209071158.3gw6CkuN-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4f02eaa12cd159c40269d80d357809de3be5518a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sidhartha-Kumar/begin-converting-hugetlb-code-to-folios/20220907-005803
        git checkout 4f02eaa12cd159c40269d80d357809de3be5518a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   mm/migrate.c: In function 'alloc_migration_target':
>> mm/migrate.c:1610:36: error: implicit declaration of function 'folio_hstate'; did you mean 'folio_activate'? [-Werror=implicit-function-declaration]
    1610 |                 struct hstate *h = folio_hstate(folio);
         |                                    ^~~~~~~~~~~~
         |                                    folio_activate
>> mm/migrate.c:1610:36: warning: initialization of 'struct hstate *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   cc1: some warnings being treated as errors


vim +1610 mm/migrate.c

  1592	
  1593	struct page *alloc_migration_target(struct page *page, unsigned long private)
  1594	{
  1595		struct folio *folio = page_folio(page);
  1596		struct migration_target_control *mtc;
  1597		gfp_t gfp_mask;
  1598		unsigned int order = 0;
  1599		struct folio *new_folio = NULL;
  1600		int nid;
  1601		int zidx;
  1602	
  1603		mtc = (struct migration_target_control *)private;
  1604		gfp_mask = mtc->gfp_mask;
  1605		nid = mtc->nid;
  1606		if (nid == NUMA_NO_NODE)
  1607			nid = folio_nid(folio);
  1608	
  1609		if (folio_test_hugetlb(folio)) {
> 1610			struct hstate *h = folio_hstate(folio);
  1611	
  1612			gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
  1613			return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
  1614		}
  1615	
  1616		if (folio_test_large(folio)) {
  1617			/*
  1618			 * clear __GFP_RECLAIM to make the migration callback
  1619			 * consistent with regular THP allocations.
  1620			 */
  1621			gfp_mask &= ~__GFP_RECLAIM;
  1622			gfp_mask |= GFP_TRANSHUGE;
  1623			order = folio_order(folio);
  1624		}
  1625		zidx = zone_idx(folio_zone(folio));
  1626		if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
  1627			gfp_mask |= __GFP_HIGHMEM;
  1628	
  1629		new_folio = __folio_alloc(gfp_mask, order, nid, mtc->nmask);
  1630	
  1631		return &new_folio->page;
  1632	}
  1633	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
