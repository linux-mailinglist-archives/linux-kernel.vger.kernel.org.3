Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A8E50602B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 01:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbiDRXV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 19:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbiDRXVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 19:21:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08AA24084
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650323948; x=1681859948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=maYb/5Ezv8tvNfB+FhmofI1/kJ1xLqRda+v3VRNJtl8=;
  b=Z9VYjPpagrp5n1/gkkAw/SoCZGxAp87B6ZAwaH4uJ5SsVPGpgUseriAc
   wL5Bvc6MrniA94WvDAWS7AT6Ry34iFQiF0P8N7tvlj20D5yBw6Anvytlz
   9r2m1qvQS2gz5LYT2a/hqzYsCdbX+OBQ6HI2+96uj42QFbjcohhpKmFKM
   uxmeKucxA4ThOrVfhnbHpQAYmIEYdl0Y5nxYFgFvwU1wqUdVHPj7vAJMt
   KgsET8sVGb8jnWvrUbG5aYyjZ0u8JxRNSunHCldf6FlLRj4RGBdOwbKPK
   haRixyTxsga4aRX2oZxAA4ENpGq6C6xtYz5KVU5v5L6OnfmG+G2Lix9I9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="244216040"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="244216040"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 16:19:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="554441668"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 18 Apr 2022 16:19:05 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngae8-000554-S8;
        Mon, 18 Apr 2022 23:19:04 +0000
Date:   Tue, 19 Apr 2022 07:19:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom Rix <trix@redhat.com>, nsaenz@kernel.org,
        bcm-kernel-feedback-list@broadcom.com, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com, gascoar@gmail.com, ojaswin98@gmail.com
Cc:     kbuild-all@lists.01.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] staging: vchiq_arm: change vchiq_platform_init from
 global to static
Message-ID: <202204190737.qhFLAafo-lkp@intel.com>
References: <20220418164356.3532969-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418164356.3532969-1-trix@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

I love your patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Tom-Rix/staging-vchiq_arm-change-vchiq_platform_init-from-global-to-static/20220419-004611
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git bed6d200f8ca38e1ecbdd8fb7e0564884002abd1
config: parisc-buildonly-randconfig-r004-20220417 (https://download.01.org/0day-ci/archive/20220419/202204190737.qhFLAafo-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/192ca8cdfd692f17162557c64e8d533c816eccff
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tom-Rix/staging-vchiq_arm-change-vchiq_platform_init-from-global-to-static/20220419-004611
        git checkout 192ca8cdfd692f17162557c64e8d533c816eccff
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash drivers/staging/vc04_services/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:16:
   In function 'memcpy_to_page',
       inlined from 'free_pagelist' at drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:434:4:
>> include/linux/highmem.h:353:9: warning: argument 2 null where non-null expected [-Wnonnull]
     353 |         memcpy(to + offset, from, len);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/string.h:20,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:8:
   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c: In function 'free_pagelist':
   arch/parisc/include/asm/string.h:9:8: note: in a call to function 'memcpy' declared 'nonnull'
       9 | void * memcpy(void * dest,const void *src,size_t count);
         |        ^~~~~~
   In file included from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:16:
   In function 'memcpy_to_page',
       inlined from 'free_pagelist' at drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:441:4:
>> include/linux/highmem.h:353:9: warning: 'memcpy' offset 0 is out of the bounds [0, 0] [-Warray-bounds]
     353 |         memcpy(to + offset, from, len);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +353 include/linux/highmem.h

bb90d4bc7b6a53 Ira Weiny         2021-02-09  346  
bb90d4bc7b6a53 Ira Weiny         2021-02-09  347  static inline void memcpy_to_page(struct page *page, size_t offset,
bb90d4bc7b6a53 Ira Weiny         2021-02-09  348  				  const char *from, size_t len)
bb90d4bc7b6a53 Ira Weiny         2021-02-09  349  {
61b205f579911a Ira Weiny         2021-02-09  350  	char *to = kmap_local_page(page);
bb90d4bc7b6a53 Ira Weiny         2021-02-09  351  
ca18f6ea012bf3 Ira Weiny         2021-02-10  352  	VM_BUG_ON(offset + len > PAGE_SIZE);
bb90d4bc7b6a53 Ira Weiny         2021-02-09 @353  	memcpy(to + offset, from, len);
8dad53a11f8d94 Christoph Hellwig 2021-07-23  354  	flush_dcache_page(page);
61b205f579911a Ira Weiny         2021-02-09  355  	kunmap_local(to);
bb90d4bc7b6a53 Ira Weiny         2021-02-09  356  }
bb90d4bc7b6a53 Ira Weiny         2021-02-09  357  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
