Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F19F54E0FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiFPMpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiFPMpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:45:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01BF50B1F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655383502; x=1686919502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Z5Da896Eo94KjFbVdgpWXCi2n2dzVGb+t3oq6zgE4Q=;
  b=lMt6+hBUGNS9EiP2QhXq4FzOCBOzOOqqWHm1edgA8QdgmqrUMuGf6D6p
   x2fO6jRMhB3UQI7SfGBZc74XiBbreivzMTGymgSnZOA0X4xr+3EywbnP6
   JAbuXzw/ut+CXvudOPhTzL29ZcWMKQsnhYWVPzv+kdeJnpxRgF9o5DCSf
   Hm7Xn1GQ+I5vcDTA60LmQtokgPkDiqvA1dNJuQjSRpXMxUOzG7mVCwN1K
   jBYi5Mcnti+zgjfVTrMLOKT5TNv0zM3j85t4gFQ6y/e+2+tEG/iw70Atk
   ClmElO6wvmTlbMBPVtv4dzGHIO+wRKxXha2WxvNsboOR0Ux3zPOWZy/pE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="280271870"
X-IronPort-AV: E=Sophos;i="5.91,305,1647327600"; 
   d="scan'208";a="280271870"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 05:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,305,1647327600"; 
   d="scan'208";a="641522693"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jun 2022 05:44:59 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1orr-000ONl-8r;
        Thu, 16 Jun 2022 12:44:59 +0000
Date:   Thu, 16 Jun 2022 20:44:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org, hch@infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 1/2] mm/mmap: Restrict generic protection_map[] array
 visibility
Message-ID: <202206162004.ak9KTfMD-lkp@intel.com>
References: <20220616040924.1022607-2-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616040924.1022607-2-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/mm-mmap-Drop-__SXXX-__PXXX-macros-from-across-platforms/20220616-121132
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220616/202206162004.ak9KTfMD-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/4eb89368b130fe235d5e587bcc2eec18bb688e2d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anshuman-Khandual/mm-mmap-Drop-__SXXX-__PXXX-macros-from-across-platforms/20220616-121132
        git checkout 4eb89368b130fe235d5e587bcc2eec18bb688e2d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:7,
                    from arch/x86/mm/mem_encrypt_amd.c:14:
   arch/x86/mm/mem_encrypt_amd.c: In function 'sme_early_init':
>> arch/x86/mm/mem_encrypt_amd.c:499:36: error: 'protection_map' undeclared (first use in this function)
     499 |         for (i = 0; i < ARRAY_SIZE(protection_map); i++)
         |                                    ^~~~~~~~~~~~~~
   include/linux/kernel.h:55:33: note: in definition of macro 'ARRAY_SIZE'
      55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                 ^~~
   arch/x86/mm/mem_encrypt_amd.c:499:36: note: each undeclared identifier is reported only once for each function it appears in
     499 |         for (i = 0; i < ARRAY_SIZE(protection_map); i++)
         |                                    ^~~~~~~~~~~~~~
   include/linux/kernel.h:55:33: note: in definition of macro 'ARRAY_SIZE'
      55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                 ^~~
   In file included from include/linux/bits.h:22,
                    from include/linux/ratelimit_types.h:5,
                    from include/linux/printk.h:9,
                    from include/asm-generic/bug.h:22,
                    from arch/x86/include/asm/bug.h:87,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6,
                    from arch/x86/mm/mem_encrypt_amd.c:14:
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:240:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     240 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:55:59: note: in expansion of macro '__must_be_array'
      55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   arch/x86/mm/mem_encrypt_amd.c:499:25: note: in expansion of macro 'ARRAY_SIZE'
     499 |         for (i = 0; i < ARRAY_SIZE(protection_map); i++)
         |                         ^~~~~~~~~~


vim +/protection_map +499 arch/x86/mm/mem_encrypt_amd.c

1e8c5971c24989 arch/x86/mm/mem_encrypt_amd.c Brijesh Singh 2022-02-22  486  
1e8c5971c24989 arch/x86/mm/mem_encrypt_amd.c Brijesh Singh 2022-02-22  487  void __init sme_early_init(void)
1e8c5971c24989 arch/x86/mm/mem_encrypt_amd.c Brijesh Singh 2022-02-22  488  {
1e8c5971c24989 arch/x86/mm/mem_encrypt_amd.c Brijesh Singh 2022-02-22  489  	unsigned int i;
1e8c5971c24989 arch/x86/mm/mem_encrypt_amd.c Brijesh Singh 2022-02-22  490  
1e8c5971c24989 arch/x86/mm/mem_encrypt_amd.c Brijesh Singh 2022-02-22  491  	if (!sme_me_mask)
1e8c5971c24989 arch/x86/mm/mem_encrypt_amd.c Brijesh Singh 2022-02-22  492  		return;
1e8c5971c24989 arch/x86/mm/mem_encrypt_amd.c Brijesh Singh 2022-02-22  493  
1e8c5971c24989 arch/x86/mm/mem_encrypt_amd.c Brijesh Singh 2022-02-22  494  	early_pmd_flags = __sme_set(early_pmd_flags);
1e8c5971c24989 arch/x86/mm/mem_encrypt_amd.c Brijesh Singh 2022-02-22  495  
1e8c5971c24989 arch/x86/mm/mem_encrypt_amd.c Brijesh Singh 2022-02-22  496  	__supported_pte_mask = __sme_set(__supported_pte_mask);
1e8c5971c24989 arch/x86/mm/mem_encrypt_amd.c Brijesh Singh 2022-02-22  497  
1e8c5971c24989 arch/x86/mm/mem_encrypt_amd.c Brijesh Singh 2022-02-22  498  	/* Update the protection map with memory encryption mask */
1e8c5971c24989 arch/x86/mm/mem_encrypt_amd.c Brijesh Singh 2022-02-22 @499  	for (i = 0; i < ARRAY_SIZE(protection_map); i++)
1e8c5971c24989 arch/x86/mm/mem_encrypt_amd.c Brijesh Singh 2022-02-22  500  		protection_map[i] = pgprot_encrypted(protection_map[i]);
1e8c5971c24989 arch/x86/mm/mem_encrypt_amd.c Brijesh Singh 2022-02-22  501  
1e8c5971c24989 arch/x86/mm/mem_encrypt_amd.c Brijesh Singh 2022-02-22  502  	x86_platform.guest.enc_status_change_prepare = amd_enc_status_change_prepare;
1e8c5971c24989 arch/x86/mm/mem_encrypt_amd.c Brijesh Singh 2022-02-22  503  	x86_platform.guest.enc_status_change_finish  = amd_enc_status_change_finish;
1e8c5971c24989 arch/x86/mm/mem_encrypt_amd.c Brijesh Singh 2022-02-22  504  	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
1e8c5971c24989 arch/x86/mm/mem_encrypt_amd.c Brijesh Singh 2022-02-22  505  	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
f4495615d76cfe arch/x86/mm/mem_encrypt.c     Ashish Kalra  2021-08-24  506  }
f4495615d76cfe arch/x86/mm/mem_encrypt.c     Ashish Kalra  2021-08-24  507  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
