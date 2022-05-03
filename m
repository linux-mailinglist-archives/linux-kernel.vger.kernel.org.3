Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245CB517C28
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 05:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiECDLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 23:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiECDLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 23:11:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905A4387AE
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 20:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651547298; x=1683083298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QhCZIg9TqfRkZJDSFzHBxZAoXeT7GzvUzfL6hRZHXoc=;
  b=bLvaBn6Epi9U+KZ/TAdpiDajqoQVjvffnnoaauBVl1joNIWhAF9aBRLe
   AlS3t5A6G/+xQ9kjQ3jnqWHVHaN+eH2v4D52VAyqkvdL+r4eS1cN2tjTF
   P3jsmwuZdRG5dTpaW4FLByR0VUQM2zUkpqfaKpz8wnG8vYsEAkLJ+/z14
   dP2EKj9zrmpOhc9BDrHG3CBieVAOMGNUeOa2Lrn2yjZslH2H99tJ18YJy
   T1kVuyGN2N8YY58y9qrF5ZkOr7iwgSqfJVjPt77LDV4DYl59L7L7ZK0cV
   xMMxzQ6xcqKFetlwkVhryhLnNcWiqNOgboROaeuf/j4yFsi1mX5kZGEAP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="264976244"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="264976244"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 20:08:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="733744061"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 May 2022 20:08:15 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlita-000A6W-Gk;
        Tue, 03 May 2022 03:08:14 +0000
Date:   Tue, 3 May 2022 11:07:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tom Rix <trix@redhat.com>, nsaenz@kernel.org,
        bcm-kernel-feedback-list@broadcom.com, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com, gascoar@gmail.com, ojaswin98@gmail.com
Cc:     kbuild-all@lists.01.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v2] staging: vchiq_arm: change vchiq_platform_init from
 global to static
Message-ID: <202205031150.FRdwOUbC-lkp@intel.com>
References: <20220419133616.544255-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419133616.544255-1-trix@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

url:    https://github.com/intel-lab-lkp/linux/commits/Tom-Rix/staging-vchiq_arm-change-vchiq_platform_init-from-global-to-static/20220419-213849
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git bed6d200f8ca38e1ecbdd8fb7e0564884002abd1
config: openrisc-buildonly-randconfig-r003-20220501 (https://download.01.org/0day-ci/archive/20220503/202205031150.FRdwOUbC-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/36525447e8cdf4a25d5217bffc548768c0f7cec1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tom-Rix/staging-vchiq_arm-change-vchiq_platform_init-from-global-to-static/20220419-213849
        git checkout 36525447e8cdf4a25d5217bffc548768c0f7cec1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/staging/vc04_services/

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
   arch/openrisc/include/asm/string.h:9:14: note: in a call to function 'memcpy' declared 'nonnull'
       9 | extern void *memcpy(void *dest, __const void *src, __kernel_size_t n);
         |              ^~~~~~
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
