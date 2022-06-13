Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B28549A77
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242366AbiFMRxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242016AbiFMRwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:52:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC3874DC3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655127529; x=1686663529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bbuir7+M76SzGly2yS37ZmAUAl9BctEhBOZRYhVfaFI=;
  b=BIf8iJlu5dDBX8GUnA9Dvjq+Y8GatrUAwGEO/1TrAKAEdY2+yYZDcrS8
   0qrARb+De8ppk71e3UW3byaakFbq8+vruuAAagM4TkY9bcmZ8EkwbavcD
   hOhuBr4cZQPs+LPRdhU/+gxR3gq6Fr64SWsi9Z+uHSCZpvRv6Q5bbgJv7
   jUvR6AfH7XqQYC8AggZHZHcQ9PtPU9pCZc35myKj6mURyNLJOreI/zzE3
   EN31ts4rnxbWa2K0EzEXNchti5CljeoY4WMTQQoTmCcJT3tbcFy/oc3ta
   CZlNzqtJqiJLAPuO7cgPBVE/maDVsr6t+Ees9Gk7gjWbBxMymckK78KzU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="258118177"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="258118177"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 06:38:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="726273252"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jun 2022 06:38:46 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0kHF-000KqF-B7;
        Mon, 13 Jun 2022 13:38:45 +0000
Date:   Mon, 13 Jun 2022 21:37:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ren Yu <renyu@nfschina.com>, cl@linux.com
Cc:     kbuild-all@lists.01.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        qixu@nfschina.com, hukun@nfschina.com, yuzhe@nfschina.com,
        Ren Yu <renyu@nfschina.com>
Subject: Re: [PATCH] mm: check the function kmalloc_slab return value
Message-ID: <202206132134.VtqdhH9v-lkp@intel.com>
References: <20220613102438.27723-1-renyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613102438.27723-1-renyu@nfschina.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ren,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Ren-Yu/mm-check-the-function-kmalloc_slab-return-value/20220613-182849
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220613/202206132134.VtqdhH9v-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/5ba2024be9e85177c986e9078e903798cac72f74
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ren-Yu/mm-check-the-function-kmalloc_slab-return-value/20220613-182849
        git checkout 5ba2024be9e85177c986e9078e903798cac72f74
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/slab.c: In function '__kmem_cache_create':
>> mm/slab.c:2068:38: warning: returning 'struct kmem_cache *' from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
    2068 |                         return cachep->freelist_cache;
         |                                ~~~~~~^~~~~~~~~~~~~~~~


vim +2068 mm/slab.c

  2063	
  2064		if (OFF_SLAB(cachep)) {
  2065			cachep->freelist_cache =
  2066				kmalloc_slab(cachep->freelist_size, 0u);
  2067			if (unlikely(ZERO_OR_NULL_PTR(cachep->freelist_cache)))
> 2068				return cachep->freelist_cache;
  2069		}
  2070	
  2071		err = setup_cpu_cache(cachep, gfp);
  2072		if (err) {
  2073			__kmem_cache_release(cachep);
  2074			return err;
  2075		}
  2076	
  2077		return 0;
  2078	}
  2079	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
