Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0097E57C14B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 02:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiGUAEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 20:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiGUAEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 20:04:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6772E747BC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 17:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658361853; x=1689897853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vwRr745hsHtS3o5kz19qtXZyc2oZLqSxhcXbyjxxfhI=;
  b=gmJA+x8e6twg80V1MGGmxvk/C+MitdG2gsca4riJUbDv3wcgDuTcjvZK
   rv0wG3+rhpFHLuck2joWc09SfluJ4HFljTbmPx82NZHPkpfzuNwDQ7A/E
   O3rbbSU0ZslppLA2UU78VbDxbJgLA46xkeNMO1nItztga35xJBiGejW1v
   kUrK3Q4Kv4o+eIGHFDMD4sbpomdbZ8FK9o5pINNfOM0ZOu6zUQ9ZRB8Pd
   mReWAyvMWo3EDb/plnpBD0zrM9Mf+yTu4dMo1YduM9rftIg1VMPcA4j6S
   6thvGBgHvRHw32knXSxXuBr3IV6Jouew3o8F8QmUWrlRINOuw73AD2uqe
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="273756034"
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="273756034"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 17:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="701066661"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jul 2022 17:03:11 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oEJeo-00014z-Mk;
        Thu, 21 Jul 2022 00:03:10 +0000
Date:   Thu, 21 Jul 2022 08:02:22 +0800
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
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v10 5/8] mm/demotion: Build demotion targets based on
 explicit memory tiers
Message-ID: <202207210723.HeaXhM1j-lkp@intel.com>
References: <20220720025920.1373558-6-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720025920.1373558-6-aneesh.kumar@linux.ibm.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Aneesh,

I love your patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Aneesh-Kumar-K-V/mm-demotion-Memory-tiers-and-demotion/20220720-110356
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: arm64-randconfig-r025-20220718 (https://download.01.org/0day-ci/archive/20220721/202207210723.HeaXhM1j-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b5fc1c467550e9f07b8f128b554a7d68e13628ff
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aneesh-Kumar-K-V/mm-demotion-Memory-tiers-and-demotion/20220720-110356
        git checkout b5fc1c467550e9f07b8f128b554a7d68e13628ff
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/memory-tiers.c: In function 'migrate_on_reclaim_init':
>> mm/memory-tiers.c:349:17: error: 'node_demotion' undeclared (first use in this function)
     349 |                 node_demotion = kcalloc(MAX_NUMNODES, sizeof(struct demotion_nodes),
         |                 ^~~~~~~~~~~~~
   mm/memory-tiers.c:349:17: note: each undeclared identifier is reported only once for each function it appears in


vim +/node_demotion +349 mm/memory-tiers.c

   345	
   346	static void __init migrate_on_reclaim_init(void)
   347	{
   348		if (IS_ENABLED(CONFIG_MIGRATION)) {
 > 349			node_demotion = kcalloc(MAX_NUMNODES, sizeof(struct demotion_nodes),
   350						GFP_KERNEL);
   351			WARN_ON(!node_demotion);
   352		}
   353		hotplug_memory_notifier(migrate_on_reclaim_callback, MEMTIER_HOTPLUG_PRIO);
   354	}
   355	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
