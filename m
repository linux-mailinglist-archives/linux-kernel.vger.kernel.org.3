Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74C059110D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbiHLMuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238860AbiHLMuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:50:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6933CFC
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660308645; x=1691844645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P/fAt24DxFqvPoyPLU5c9Y/VeDiAMJeVyGR8ot4zoAA=;
  b=e5tKovhy2d3LHOUXRKK0YOLSWXISMfxfDTkWpk5R/pyFZPA7IxKrK01z
   KyAearuS6KyEIxswY+Gwr4yPuPQd6bkXAD7lHY/xtHH4+i+YDhtSNVQee
   LcnEOE/Jp6Qf2o/5oS5nTLxzMmXMcsD2dRcwD27lJm3GgPnnF/nQa2N3T
   9HRvGC5eyJhjYPyjC4w3h5h28zs89wLCsVZIF7DZ3HZj1s3OdNgAWYpdD
   eNPO+il7NIg/Q4SDTDjmJal1FIUgYkzVbwDEP7/RSwYC9q0eTOssp/TBz
   FcZZKScp5TkVOiwqX8ezo/OQmuY4On5Ck6XNY6m7Ew15fQBKTswKWg9gf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="291586666"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="291586666"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 05:50:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="605905926"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 12 Aug 2022 05:50:42 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMU7d-0000Wk-1z;
        Fri, 12 Aug 2022 12:50:41 +0000
Date:   Fri, 12 Aug 2022 20:50:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     xiakaixu1987@gmail.com, sj@kernel.org, akpm@linux-foundation.org
Cc:     kbuild-all@lists.01.org, damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] mm/damon/core: simplify the parameter passing for region
 split operation
Message-ID: <202208122001.69lQAxjD-lkp@intel.com>
References: <1660290073-26347-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660290073-26347-1-git-send-email-kaixuxia@tencent.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220812/202208122001.69lQAxjD-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/26b7d93b0f64c71d6d324a4a37d85641b55eaec2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review xiakaixu1987-gmail-com/mm-damon-core-simplify-the-parameter-passing-for-region-split-operation/20220812-154316
        git checkout 26b7d93b0f64c71d6d324a4a37d85641b55eaec2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from mm/damon/core.c:1218:
   mm/damon/core-test.h: In function 'damon_test_split_at':
>> mm/damon/core-test.h:129:31: error: passing argument 1 of 'damon_split_region_at' from incompatible pointer type [-Werror=incompatible-pointer-types]
     129 |         damon_split_region_at(c, t, r, 25);
         |                               ^
         |                               |
         |                               struct damon_ctx *
   mm/damon/core.c:930:56: note: expected 'struct damon_target *' but argument is of type 'struct damon_ctx *'
     930 | static void damon_split_region_at(struct damon_target *t,
         |                                   ~~~~~~~~~~~~~~~~~~~~~^
   In file included from mm/damon/core.c:1218:
   mm/damon/core-test.h:129:34: error: passing argument 2 of 'damon_split_region_at' from incompatible pointer type [-Werror=incompatible-pointer-types]
     129 |         damon_split_region_at(c, t, r, 25);
         |                                  ^
         |                                  |
         |                                  struct damon_target *
   mm/damon/core.c:931:56: note: expected 'struct damon_region *' but argument is of type 'struct damon_target *'
     931 |                                   struct damon_region *r, unsigned long sz_r)
         |                                   ~~~~~~~~~~~~~~~~~~~~~^
   In file included from mm/damon/core.c:1218:
   mm/damon/core-test.h:129:37: warning: passing argument 3 of 'damon_split_region_at' makes integer from pointer without a cast [-Wint-conversion]
     129 |         damon_split_region_at(c, t, r, 25);
         |                                     ^
         |                                     |
         |                                     struct damon_region *
   mm/damon/core.c:931:73: note: expected 'long unsigned int' but argument is of type 'struct damon_region *'
     931 |                                   struct damon_region *r, unsigned long sz_r)
         |                                                           ~~~~~~~~~~~~~~^~~~
   In file included from mm/damon/core.c:1218:
>> mm/damon/core-test.h:129:9: error: too many arguments to function 'damon_split_region_at'
     129 |         damon_split_region_at(c, t, r, 25);
         |         ^~~~~~~~~~~~~~~~~~~~~
   mm/damon/core.c:930:13: note: declared here
     930 | static void damon_split_region_at(struct damon_target *t,
         |             ^~~~~~~~~~~~~~~~~~~~~
   In file included from mm/damon/core.c:1218:
   mm/damon/core-test.h: In function 'damon_test_split_regions_of':
>> mm/damon/core-test.h:222:32: error: passing argument 1 of 'damon_split_regions_of' from incompatible pointer type [-Werror=incompatible-pointer-types]
     222 |         damon_split_regions_of(c, t, 2);
         |                                ^
         |                                |
         |                                struct damon_ctx *
   mm/damon/core.c:948:57: note: expected 'struct damon_target *' but argument is of type 'struct damon_ctx *'
     948 | static void damon_split_regions_of(struct damon_target *t, int nr_subs)
         |                                    ~~~~~~~~~~~~~~~~~~~~~^
   In file included from mm/damon/core.c:1218:
   mm/damon/core-test.h:222:35: warning: passing argument 2 of 'damon_split_regions_of' makes integer from pointer without a cast [-Wint-conversion]
     222 |         damon_split_regions_of(c, t, 2);
         |                                   ^
         |                                   |
         |                                   struct damon_target *
   mm/damon/core.c:948:64: note: expected 'int' but argument is of type 'struct damon_target *'
     948 | static void damon_split_regions_of(struct damon_target *t, int nr_subs)
         |                                                            ~~~~^~~~~~~
   In file included from mm/damon/core.c:1218:
>> mm/damon/core-test.h:222:9: error: too many arguments to function 'damon_split_regions_of'
     222 |         damon_split_regions_of(c, t, 2);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   mm/damon/core.c:948:13: note: declared here
     948 | static void damon_split_regions_of(struct damon_target *t, int nr_subs)
         |             ^~~~~~~~~~~~~~~~~~~~~~
   In file included from mm/damon/core.c:1218:
   mm/damon/core-test.h:229:32: error: passing argument 1 of 'damon_split_regions_of' from incompatible pointer type [-Werror=incompatible-pointer-types]
     229 |         damon_split_regions_of(c, t, 4);
         |                                ^
         |                                |
         |                                struct damon_ctx *
   mm/damon/core.c:948:57: note: expected 'struct damon_target *' but argument is of type 'struct damon_ctx *'
     948 | static void damon_split_regions_of(struct damon_target *t, int nr_subs)
         |                                    ~~~~~~~~~~~~~~~~~~~~~^
   In file included from mm/damon/core.c:1218:
   mm/damon/core-test.h:229:35: warning: passing argument 2 of 'damon_split_regions_of' makes integer from pointer without a cast [-Wint-conversion]
     229 |         damon_split_regions_of(c, t, 4);
         |                                   ^
         |                                   |
         |                                   struct damon_target *
   mm/damon/core.c:948:64: note: expected 'int' but argument is of type 'struct damon_target *'
     948 | static void damon_split_regions_of(struct damon_target *t, int nr_subs)
         |                                                            ~~~~^~~~~~~
   In file included from mm/damon/core.c:1218:
   mm/damon/core-test.h:229:9: error: too many arguments to function 'damon_split_regions_of'
     229 |         damon_split_regions_of(c, t, 4);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   mm/damon/core.c:948:13: note: declared here
     948 | static void damon_split_regions_of(struct damon_target *t, int nr_subs)
         |             ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/damon_split_region_at +129 mm/damon/core-test.h

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
17ccae8bb5c928 SeongJae Park 2021-09-07  141  static void damon_test_merge_two(struct kunit *test)
17ccae8bb5c928 SeongJae Park 2021-09-07  142  {
17ccae8bb5c928 SeongJae Park 2021-09-07  143  	struct damon_target *t;
17ccae8bb5c928 SeongJae Park 2021-09-07  144  	struct damon_region *r, *r2, *r3;
17ccae8bb5c928 SeongJae Park 2021-09-07  145  	int i;
17ccae8bb5c928 SeongJae Park 2021-09-07  146  
1971bd630452e9 SeongJae Park 2022-03-22  147  	t = damon_new_target();
17ccae8bb5c928 SeongJae Park 2021-09-07  148  	r = damon_new_region(0, 100);
17ccae8bb5c928 SeongJae Park 2021-09-07  149  	r->nr_accesses = 10;
17ccae8bb5c928 SeongJae Park 2021-09-07  150  	damon_add_region(r, t);
17ccae8bb5c928 SeongJae Park 2021-09-07  151  	r2 = damon_new_region(100, 300);
17ccae8bb5c928 SeongJae Park 2021-09-07  152  	r2->nr_accesses = 20;
17ccae8bb5c928 SeongJae Park 2021-09-07  153  	damon_add_region(r2, t);
17ccae8bb5c928 SeongJae Park 2021-09-07  154  
17ccae8bb5c928 SeongJae Park 2021-09-07  155  	damon_merge_two_regions(t, r, r2);
17ccae8bb5c928 SeongJae Park 2021-09-07  156  	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
17ccae8bb5c928 SeongJae Park 2021-09-07  157  	KUNIT_EXPECT_EQ(test, r->ar.end, 300ul);
17ccae8bb5c928 SeongJae Park 2021-09-07  158  	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
17ccae8bb5c928 SeongJae Park 2021-09-07  159  
17ccae8bb5c928 SeongJae Park 2021-09-07  160  	i = 0;
17ccae8bb5c928 SeongJae Park 2021-09-07  161  	damon_for_each_region(r3, t) {
17ccae8bb5c928 SeongJae Park 2021-09-07  162  		KUNIT_EXPECT_PTR_EQ(test, r, r3);
17ccae8bb5c928 SeongJae Park 2021-09-07  163  		i++;
17ccae8bb5c928 SeongJae Park 2021-09-07  164  	}
17ccae8bb5c928 SeongJae Park 2021-09-07  165  	KUNIT_EXPECT_EQ(test, i, 1);
17ccae8bb5c928 SeongJae Park 2021-09-07  166  
17ccae8bb5c928 SeongJae Park 2021-09-07  167  	damon_free_target(t);
17ccae8bb5c928 SeongJae Park 2021-09-07  168  }
17ccae8bb5c928 SeongJae Park 2021-09-07  169  
17ccae8bb5c928 SeongJae Park 2021-09-07  170  static struct damon_region *__nth_region_of(struct damon_target *t, int idx)
17ccae8bb5c928 SeongJae Park 2021-09-07  171  {
17ccae8bb5c928 SeongJae Park 2021-09-07  172  	struct damon_region *r;
17ccae8bb5c928 SeongJae Park 2021-09-07  173  	unsigned int i = 0;
17ccae8bb5c928 SeongJae Park 2021-09-07  174  
17ccae8bb5c928 SeongJae Park 2021-09-07  175  	damon_for_each_region(r, t) {
17ccae8bb5c928 SeongJae Park 2021-09-07  176  		if (i++ == idx)
17ccae8bb5c928 SeongJae Park 2021-09-07  177  			return r;
17ccae8bb5c928 SeongJae Park 2021-09-07  178  	}
17ccae8bb5c928 SeongJae Park 2021-09-07  179  
17ccae8bb5c928 SeongJae Park 2021-09-07  180  	return NULL;
17ccae8bb5c928 SeongJae Park 2021-09-07  181  }
17ccae8bb5c928 SeongJae Park 2021-09-07  182  
17ccae8bb5c928 SeongJae Park 2021-09-07  183  static void damon_test_merge_regions_of(struct kunit *test)
17ccae8bb5c928 SeongJae Park 2021-09-07  184  {
17ccae8bb5c928 SeongJae Park 2021-09-07  185  	struct damon_target *t;
17ccae8bb5c928 SeongJae Park 2021-09-07  186  	struct damon_region *r;
17ccae8bb5c928 SeongJae Park 2021-09-07  187  	unsigned long sa[] = {0, 100, 114, 122, 130, 156, 170, 184};
17ccae8bb5c928 SeongJae Park 2021-09-07  188  	unsigned long ea[] = {100, 112, 122, 130, 156, 170, 184, 230};
17ccae8bb5c928 SeongJae Park 2021-09-07  189  	unsigned int nrs[] = {0, 0, 10, 10, 20, 30, 1, 2};
17ccae8bb5c928 SeongJae Park 2021-09-07  190  
17ccae8bb5c928 SeongJae Park 2021-09-07  191  	unsigned long saddrs[] = {0, 114, 130, 156, 170};
17ccae8bb5c928 SeongJae Park 2021-09-07  192  	unsigned long eaddrs[] = {112, 130, 156, 170, 230};
17ccae8bb5c928 SeongJae Park 2021-09-07  193  	int i;
17ccae8bb5c928 SeongJae Park 2021-09-07  194  
1971bd630452e9 SeongJae Park 2022-03-22  195  	t = damon_new_target();
17ccae8bb5c928 SeongJae Park 2021-09-07  196  	for (i = 0; i < ARRAY_SIZE(sa); i++) {
17ccae8bb5c928 SeongJae Park 2021-09-07  197  		r = damon_new_region(sa[i], ea[i]);
17ccae8bb5c928 SeongJae Park 2021-09-07  198  		r->nr_accesses = nrs[i];
17ccae8bb5c928 SeongJae Park 2021-09-07  199  		damon_add_region(r, t);
17ccae8bb5c928 SeongJae Park 2021-09-07  200  	}
17ccae8bb5c928 SeongJae Park 2021-09-07  201  
17ccae8bb5c928 SeongJae Park 2021-09-07  202  	damon_merge_regions_of(t, 9, 9999);
17ccae8bb5c928 SeongJae Park 2021-09-07  203  	/* 0-112, 114-130, 130-156, 156-170 */
17ccae8bb5c928 SeongJae Park 2021-09-07  204  	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
17ccae8bb5c928 SeongJae Park 2021-09-07  205  	for (i = 0; i < 5; i++) {
17ccae8bb5c928 SeongJae Park 2021-09-07  206  		r = __nth_region_of(t, i);
17ccae8bb5c928 SeongJae Park 2021-09-07  207  		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
17ccae8bb5c928 SeongJae Park 2021-09-07  208  		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
17ccae8bb5c928 SeongJae Park 2021-09-07  209  	}
17ccae8bb5c928 SeongJae Park 2021-09-07  210  	damon_free_target(t);
17ccae8bb5c928 SeongJae Park 2021-09-07  211  }
17ccae8bb5c928 SeongJae Park 2021-09-07  212  
17ccae8bb5c928 SeongJae Park 2021-09-07  213  static void damon_test_split_regions_of(struct kunit *test)
17ccae8bb5c928 SeongJae Park 2021-09-07  214  {
17ccae8bb5c928 SeongJae Park 2021-09-07  215  	struct damon_ctx *c = damon_new_ctx();
17ccae8bb5c928 SeongJae Park 2021-09-07  216  	struct damon_target *t;
17ccae8bb5c928 SeongJae Park 2021-09-07  217  	struct damon_region *r;
17ccae8bb5c928 SeongJae Park 2021-09-07  218  
1971bd630452e9 SeongJae Park 2022-03-22  219  	t = damon_new_target();
17ccae8bb5c928 SeongJae Park 2021-09-07  220  	r = damon_new_region(0, 22);
17ccae8bb5c928 SeongJae Park 2021-09-07  221  	damon_add_region(r, t);
17ccae8bb5c928 SeongJae Park 2021-09-07 @222  	damon_split_regions_of(c, t, 2);
2e014660b3e4b7 SeongJae Park 2021-10-28  223  	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 2u);
17ccae8bb5c928 SeongJae Park 2021-09-07  224  	damon_free_target(t);
17ccae8bb5c928 SeongJae Park 2021-09-07  225  
1971bd630452e9 SeongJae Park 2022-03-22  226  	t = damon_new_target();
17ccae8bb5c928 SeongJae Park 2021-09-07  227  	r = damon_new_region(0, 220);
17ccae8bb5c928 SeongJae Park 2021-09-07  228  	damon_add_region(r, t);
17ccae8bb5c928 SeongJae Park 2021-09-07  229  	damon_split_regions_of(c, t, 4);
2e014660b3e4b7 SeongJae Park 2021-10-28  230  	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 4u);
17ccae8bb5c928 SeongJae Park 2021-09-07  231  	damon_free_target(t);
17ccae8bb5c928 SeongJae Park 2021-09-07  232  	damon_destroy_ctx(c);
17ccae8bb5c928 SeongJae Park 2021-09-07  233  }
17ccae8bb5c928 SeongJae Park 2021-09-07  234  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
