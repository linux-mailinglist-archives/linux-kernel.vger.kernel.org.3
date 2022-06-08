Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B0954400B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 01:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiFHXoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 19:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbiFHXnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 19:43:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE9BB82E5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 16:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654731916; x=1686267916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f905eM5bNst+aqOd4tSp5UMDRuBSJ2wsoWVFwPgHrC0=;
  b=n+Y/Lg7lI9toQvXjI+d45rf7yFtEB2v/U8a/UyQnxO/xrEut1ZhhQFlA
   JNBAUVgt0gkjQMDCpuxmvr1jdmyJHxTPqu6HdCAd5/OmV0ulR/zUzPK4m
   OIWbzNLZYwqbnsmBb3CB515Um6rTn0+yc8iqEdhf4OKLmFyKCBNNmoiT+
   UL+M/M/8U2zqGSk8gXkl53WcayknKPGre0WxFeTtYfGYrlKG0KUkZ3JGy
   P+gLdyauUxYAgcAZHrPmtsn8zzS4E/MezbKdDzQ6OqVv4ikn/q/4WGlyF
   hGzGxPWdVNZ7FejdX2/bx9kj25qyiHlyj0LjmTezmMJwxKhvReBABim5V
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="277910927"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="277910927"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 16:45:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="585174833"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2022 16:45:12 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nz5MJ-000FEv-23;
        Wed, 08 Jun 2022 23:45:07 +0000
Date:   Thu, 9 Jun 2022 07:44:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Hao Wang <haowang3@fb.com>,
        Abhishek Dhanotia <abhishekd@fb.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Hasan Al Maruf <hasanalmaruf@fb.com>
Subject: Re: [PATCH] mm: mempolicy: N:M interleave policy for tiered memory
 nodes
Message-ID: <202206090708.jaGUnz8e-lkp@intel.com>
References: <20220607171949.85796-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607171949.85796-1-hannes@cmpxchg.org>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Weiner/mm-mempolicy-N-M-interleave-policy-for-tiered-memory-nodes/20220608-012652
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20220609/202206090708.jaGUnz8e-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/876d8daa0642d35f71ff504eeb3be4b950339a45
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Johannes-Weiner/mm-mempolicy-N-M-interleave-policy-for-tiered-memory-nodes/20220608-012652
        git checkout 876d8daa0642d35f71ff504eeb3be4b950339a45
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/mempolicy.c:1890:11: warning: variable 'next' is used uninitialized whenever function 'next_node_tier' is called [-Wsometimes-uninitialized]
           unsigned next, start = nid;
           ~~~~~~~~~^~~~
   mm/mempolicy.c:1893:23: note: uninitialized use occurs here
                   next = next_node_in(next, policy->nodes);
                                       ^~~~
   include/linux/nodemask.h:278:46: note: expanded from macro 'next_node_in'
   #define next_node_in(n, src) __next_node_in((n), &(src))
                                                ^
   mm/mempolicy.c:1890:15: note: initialize the variable 'next' to silence this warning
           unsigned next, start = nid;
                        ^
                         = 0
   1 warning generated.


vim +1890 mm/mempolicy.c

  1887	
  1888	static unsigned next_node_tier(int nid, struct mempolicy *policy, bool toptier)
  1889	{
> 1890		unsigned next, start = nid;
  1891	
  1892		do {
  1893			next = next_node_in(next, policy->nodes);
  1894			if (next == MAX_NUMNODES)
  1895				break;
  1896			if (toptier == node_is_toptier(next))
  1897				break;
  1898		} while (next != start);
  1899		return next;
  1900	}
  1901	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
