Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ACB5915FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 21:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbiHLTa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 15:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbiHLTa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 15:30:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3058D9926A
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 12:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660332656; x=1691868656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GlbJXtp1pQ/j4T73SprLl7OSfQKxTVMN6a3ZI775+EA=;
  b=BdqGG+W0Cc+8lXYCnvIdTVg7M1Fi0+SuNhAEP6jsDJYPYOo9mH2bg01V
   IpErTKcfCzxvttMCxJiL9G5/TS6eqcBQQOA1HNV/AsxSf314RgPB9tlVX
   XV5nPHtgLTfPoexl7gChhc4ks6eerZBz/fvIAIXgNWWXr/RPa+eq3k5mG
   6Frv2RQySb3HY8KMixUv/V1JaMeKYP+0Tg0tcqS7wagh59zmqBt8840Rn
   Vx2d7s20fvBfobuCV48AB6GkFo3HJzcC6euAfyIrNq4pelOCYswEyKNpR
   KEA7bsAY3Bg2SnShB5GaZ5D26pQcSal9W0q8Pty4LQjW+w6jSVfL4yWA3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="355679513"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="355679513"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 12:30:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="695370860"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Aug 2022 12:30:53 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMaMu-0000rZ-2y;
        Fri, 12 Aug 2022 19:30:52 +0000
Date:   Sat, 13 Aug 2022 03:30:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     xiakaixu1987@gmail.com, sj@kernel.org, akpm@linux-foundation.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] mm/damon/core: simplify the parameter passing for region
 split operation
Message-ID: <202208130308.8rYWTL9U-lkp@intel.com>
References: <1660290073-26347-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660290073-26347-1-git-send-email-kaixuxia@tencent.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/xiakaixu1987-gmail-com/mm-damon-core-simplify-the-parameter-passing-for-region-split-operation/20220812-154316
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: hexagon-randconfig-r045-20220812 (https://download.01.org/0day-ci/archive/20220813/202208130308.8rYWTL9U-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/26b7d93b0f64c71d6d324a4a37d85641b55eaec2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review xiakaixu1987-gmail-com/mm-damon-core-simplify-the-parameter-passing-for-region-split-operation/20220812-154316
        git checkout 26b7d93b0f64c71d6d324a4a37d85641b55eaec2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from mm/damon/core.c:1218:
>> mm/damon/core-test.h:129:33: error: too many arguments to function call, expected 3, have 4
           damon_split_region_at(c, t, r, 25);
           ~~~~~~~~~~~~~~~~~~~~~          ^~
   mm/damon/core.c:930:13: note: 'damon_split_region_at' declared here
   static void damon_split_region_at(struct damon_target *t,
               ^
   In file included from mm/damon/core.c:1218:
   mm/damon/core-test.h:222:31: error: too many arguments to function call, expected 2, have 3
           damon_split_regions_of(c, t, 2);
           ~~~~~~~~~~~~~~~~~~~~~~       ^
   mm/damon/core.c:948:13: note: 'damon_split_regions_of' declared here
   static void damon_split_regions_of(struct damon_target *t, int nr_subs)
               ^
   In file included from mm/damon/core.c:1218:
   mm/damon/core-test.h:229:31: error: too many arguments to function call, expected 2, have 3
           damon_split_regions_of(c, t, 4);
           ~~~~~~~~~~~~~~~~~~~~~~       ^
   mm/damon/core.c:948:13: note: 'damon_split_regions_of' declared here
   static void damon_split_regions_of(struct damon_target *t, int nr_subs)
               ^
   3 errors generated.


vim +129 mm/damon/core-test.h

17ccae8bb5c928 SeongJae Park 2021-09-07  119  
17ccae8bb5c928 SeongJae Park 2021-09-07  120  static void damon_test_split_at(struct kunit *test)
17ccae8bb5c928 SeongJae Park 2021-09-07  121  {
17ccae8bb5c928 SeongJae Park 2021-09-07  122  	struct damon_ctx *c = damon_new_ctx();
17ccae8bb5c928 SeongJae Park 2021-09-07  123  	struct damon_target *t;
17ccae8bb5c928 SeongJae Park 2021-09-07  124  	struct damon_region *r;
17ccae8bb5c928 SeongJae Park 2021-09-07  125  
1971bd630452e9 SeongJae Park 2022-03-22  126  	t = damon_new_target();
17ccae8bb5c928 SeongJae Park 2021-09-07  127  	r = damon_new_region(0, 100);
17ccae8bb5c928 SeongJae Park 2021-09-07  128  	damon_add_region(r, t);
17ccae8bb5c928 SeongJae Park 2021-09-07 @129  	damon_split_region_at(c, t, r, 25);
17ccae8bb5c928 SeongJae Park 2021-09-07  130  	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
17ccae8bb5c928 SeongJae Park 2021-09-07  131  	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);
17ccae8bb5c928 SeongJae Park 2021-09-07  132  
17ccae8bb5c928 SeongJae Park 2021-09-07  133  	r = damon_next_region(r);
17ccae8bb5c928 SeongJae Park 2021-09-07  134  	KUNIT_EXPECT_EQ(test, r->ar.start, 25ul);
17ccae8bb5c928 SeongJae Park 2021-09-07  135  	KUNIT_EXPECT_EQ(test, r->ar.end, 100ul);
17ccae8bb5c928 SeongJae Park 2021-09-07  136  
17ccae8bb5c928 SeongJae Park 2021-09-07  137  	damon_free_target(t);
17ccae8bb5c928 SeongJae Park 2021-09-07  138  	damon_destroy_ctx(c);
17ccae8bb5c928 SeongJae Park 2021-09-07  139  }
17ccae8bb5c928 SeongJae Park 2021-09-07  140  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
