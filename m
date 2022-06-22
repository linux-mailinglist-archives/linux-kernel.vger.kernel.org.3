Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49046556EB1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 00:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242981AbiFVWy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 18:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376789AbiFVWxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 18:53:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793FD4162A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655938421; x=1687474421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XlQvUoHIyljwFR5TR2Yyoy6OdtmMrypdx8HArayAsyQ=;
  b=VNlzB3j+Ko97HqFxrP0ZLgAP6fIHjD7hsIMAlh07eaOUci2/dVLdIgxq
   8pALYWw5XgO1XaJ3C5ShySdaJoBHnTZXHcgFpzI5700BpGZGvE407tneY
   UJXtA6qYnrW8/xdsEzvW/NrXowxjO/s9TRLLTKUov8+i8uoE7DPek1Ck5
   z1ivTkyQoY6hwEfxSaeSaRVijt3PiRhVZJctABfnYHY9YEcVTvKwCZUte
   41d68Ddxzp53z38GNfbzI1U0MRWzgKtYb1nJajbnwfBkIRBn9jLYqz6nW
   jzETCKbB6GC0vf7gb13oeMITCuR0vp/C2tnjQ2B4rS5zXeD1k6oRuUMqn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="260999773"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="260999773"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 15:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="765073492"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2022 15:53:37 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o49E9-0001mj-1c;
        Wed, 22 Jun 2022 22:53:37 +0000
Date:   Thu, 23 Jun 2022 06:52:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     kbuild-all@lists.01.org, Wei Xu <weixugc@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v7 08/12] mm/demotion: Add pg_data_t member to track node
 memory tier details
Message-ID: <202206230603.yUtYS0xk-lkp@intel.com>
References: <20220622082513.467538-9-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622082513.467538-9-aneesh.kumar@linux.ibm.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Aneesh,

I love your patch! Perhaps something to improve:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Aneesh-Kumar-K-V/mm-demotion-Memory-tiers-and-demotion/20220622-163031
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220623/202206230603.yUtYS0xk-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-31-g4880bd19-dirty
        # https://github.com/intel-lab-lkp/linux/commit/97a1874c652abe1500768e5cab39b2d3dcdfb046
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aneesh-Kumar-K-V/mm-demotion-Memory-tiers-and-demotion/20220622-163031
        git checkout 97a1874c652abe1500768e5cab39b2d3dcdfb046
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> mm/memory-tiers.c:182:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> mm/memory-tiers.c:182:16: sparse:    struct memory_tier [noderef] __rcu *
>> mm/memory-tiers.c:182:16: sparse:    struct memory_tier *
   mm/memory-tiers.c:214:27: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memory-tiers.c:214:27: sparse:    struct memory_tier [noderef] __rcu *
   mm/memory-tiers.c:214:27: sparse:    struct memory_tier *
   mm/memory-tiers.c:216:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memory-tiers.c:216:9: sparse:    struct memory_tier [noderef] __rcu *
   mm/memory-tiers.c:216:9: sparse:    struct memory_tier *
   mm/memory-tiers.c:221:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memory-tiers.c:221:9: sparse:    struct memory_tier [noderef] __rcu *
   mm/memory-tiers.c:221:9: sparse:    struct memory_tier *
   mm/memory-tiers.c:361:19: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memory-tiers.c:361:19: sparse:    struct memory_tier [noderef] __rcu *
   mm/memory-tiers.c:361:19: sparse:    struct memory_tier *
   mm/memory-tiers.c:614:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memory-tiers.c:614:17: sparse:    struct memory_tier [noderef] __rcu *
   mm/memory-tiers.c:614:17: sparse:    struct memory_tier *

vim +182 mm/memory-tiers.c

   169	
   170	static struct memory_tier *__node_get_memory_tier(int node)
   171	{
   172		pg_data_t *pgdat;
   173	
   174		pgdat = NODE_DATA(node);
   175		if (!pgdat)
   176			return NULL;
   177		/*
   178		 * Since we hold memory_tier_lock, we can avoid
   179		 * RCU read locks when accessing the details. No
   180		 * parallel updates are possible here.
   181		 */
 > 182		return rcu_dereference_check(pgdat->memtier,
   183					     lockdep_is_held(&memory_tier_lock));
   184	}
   185	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
