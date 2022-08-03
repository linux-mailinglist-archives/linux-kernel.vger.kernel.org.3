Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E32588BEC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbiHCMWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiHCMWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:22:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB3C13E07
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 05:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659529330; x=1691065330;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q5oMqDUOf5jPtkD4LDnaNhTX3jxTVkViK2zCA1vHBOs=;
  b=lpbKz8VqhN/ADLcbLb0J5OFwmmotenmG8idkvDHWwHjFd5RNb2KmIQIb
   +2yIOzg5LUNTKreW8Qnl/n+AFzCN/kMqqEq0g2ZDD/0HSIpsstgxAQvIA
   U/PuFC+4/qyVhLivLqb7PwE5vBjqgr5ued7sf35kIF4gJSWIP6cWGAAdP
   AfUGMSg0PRY0NymM8Nl/+ec7mZhkHPPIcgiw6ihcSGklSqNPfhJNQtSeb
   pi42V7PspmMOWE77HH1AYPJbh9KfAPHNtLmvym0o7wuHha/gx2AFkJHyK
   HI0kskCzIqIzC4R/iUEGPgMgiLQvigtlt5ImVSwHdgtURK2JzVoQuz8kj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="269427574"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="269427574"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 05:22:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="848562356"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2022 05:22:05 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJDO1-000HFf-0U;
        Wed, 03 Aug 2022 12:22:05 +0000
Date:   Wed, 3 Aug 2022 20:21:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org, Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Huang Ying <ying.huang@intel.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 2/2] mm: Remember young bit for page migrations
Message-ID: <202208032031.PVcMB0Hr-lkp@intel.com>
References: <20220803012159.36551-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803012159.36551-3-peterx@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Xu/mm-Remember-young-bit-for-migration-entries/20220803-092311
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: openrisc-randconfig-r016-20220803 (https://download.01.org/0day-ci/archive/20220803/202208032031.PVcMB0Hr-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2fca6cb25745d1404fc34e0ec2ea89b6195a8c27
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peter-Xu/mm-Remember-young-bit-for-migration-entries/20220803-092311
        git checkout 2fca6cb25745d1404fc34e0ec2ea89b6195a8c27
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   or1k-linux-ld: mm/rmap.o: in function `migration_entry_supports_young':
>> include/linux/swapops.h:288: undefined reference to `max_swapfile_size'
   include/linux/swapops.h:288:(.text+0x31a0): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `max_swapfile_size'
   or1k-linux-ld: mm/migrate.o: in function `migration_entry_supports_young':
>> include/linux/swapops.h:288: undefined reference to `max_swapfile_size'
   include/linux/swapops.h:288:(.text+0x158): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `max_swapfile_size'


vim +288 include/linux/swapops.h

   279	
   280	static inline bool migration_entry_supports_young(void)
   281	{
   282		/*
   283		 * max_swapfile_size() returns the max supported swp-offset plus 1.
   284		 * We can support the migration young bit only if the pfn swap
   285		 * entry has the offset larger than storing the PFN value, then it
   286		 * means there's extra bit(s) where we can store the young bit.
   287		 */
 > 288		return max_swapfile_size() > SWP_MIG_YOUNG_BIT;
   289	}
   290	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
