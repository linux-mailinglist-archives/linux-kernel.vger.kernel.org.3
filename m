Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F0C59AB1B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 06:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiHTEEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 00:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiHTEEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 00:04:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0126E2D5;
        Fri, 19 Aug 2022 21:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660968269; x=1692504269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cBvMddEtt4UQqHMg0rq14ho6Xv1Ko3mJzB2RdT3ptPQ=;
  b=dLiArMA2G5dWN3EfEWIXqGuqwlGJMg4VCkGSBhWeIMWxR9YmY/b7ESlo
   3JLejxtsNWDu/vLMPk7RAtube28xPa9gItcAnFD4i+zaYJqDXGJlW6vp+
   vUPHpZpFQNfZXi2BqLWV8k1RLt8DMOosz1KkrByBR8xpNH1R1ozx1iaAA
   ne6T4ja39rMJe6EcRz+LDliDpgbr65BxL0tj1RxL55qGTzJZWN1ji+B2/
   zUdp2qohDEQXPZxcrgEdOAZp/n4VD6Ecy/7POEnx+Pq15xLjq5nrT8e6H
   bTic5gDuh4jT9W0DDBs9BjKQYaazyQ/MYsAyBxgtkfFw9vMCneR4j4F6/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="272907718"
X-IronPort-AV: E=Sophos;i="5.93,250,1654585200"; 
   d="scan'208";a="272907718"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 21:04:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,250,1654585200"; 
   d="scan'208";a="641468410"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 19 Aug 2022 21:04:24 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPFih-00027Q-16;
        Sat, 20 Aug 2022 04:04:23 +0000
Date:   Sat, 20 Aug 2022 12:03:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: Re: [PATCH v2 08/11] parisc: mm: Convert to GENERIC_IOREMAP
Message-ID: <202208201135.YyN9CXsu-lkp@intel.com>
References: <20220820003125.353570-9-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820003125.353570-9-bhe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

I love your patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/mm-ioremap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20220820-083435
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: parisc-randconfig-r005-20220820 (https://download.01.org/0day-ci/archive/20220820/202208201135.YyN9CXsu-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/570f2a3347cc83c9ea71d3dbbebfad8ea085ecc6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Baoquan-He/mm-ioremap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20220820-083435
        git checkout 570f2a3347cc83c9ea71d3dbbebfad8ea085ecc6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/parisc/include/asm/io.h:315,
                    from include/linux/io.h:13,
                    from include/linux/irq.h:20,
                    from arch/parisc/include/asm/hardirq.h:13,
                    from include/linux/hardirq.h:11,
                    from arch/parisc/kernel/asm-offsets.c:21:
>> include/asm-generic/iomap.h:97: warning: "ioremap_wc" redefined
      97 | #define ioremap_wc ioremap
         | 
   arch/parisc/include/asm/io.h:135: note: this is the location of the previous definition
     135 | #define ioremap_wc(addr, size)  \
         | 
   include/linux/io.h: In function 'pci_remap_cfgspace':
>> include/linux/io.h:89:44: error: implicit declaration of function 'ioremap'; did you mean 'ioremap_np'? [-Werror=implicit-function-declaration]
      89 |         return ioremap_np(offset, size) ?: ioremap(offset, size);
         |                                            ^~~~~~~
         |                                            ioremap_np
>> include/linux/io.h:89:42: warning: pointer/integer type mismatch in conditional expression
      89 |         return ioremap_np(offset, size) ?: ioremap(offset, size);
         |                                          ^
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/parisc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1207: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:222: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +89 include/linux/io.h

7d3dcf26a6559f Christoph Hellwig 2015-08-10  72  
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  73  #ifdef CONFIG_PCI
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  74  /*
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  75   * The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
b10eb2d50911f9 Hector Martin     2021-03-25  76   * Posting") mandate non-posted configuration transactions. This default
b10eb2d50911f9 Hector Martin     2021-03-25  77   * implementation attempts to use the ioremap_np() API to provide this
b10eb2d50911f9 Hector Martin     2021-03-25  78   * on arches that support it, and falls back to ioremap() on those that
b10eb2d50911f9 Hector Martin     2021-03-25  79   * don't. Overriding this function is deprecated; arches that properly
b10eb2d50911f9 Hector Martin     2021-03-25  80   * support non-posted accesses should implement ioremap_np() instead, which
b10eb2d50911f9 Hector Martin     2021-03-25  81   * this default implementation can then use to return mappings compliant with
b10eb2d50911f9 Hector Martin     2021-03-25  82   * the PCI specification.
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  83   */
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  84  #ifndef pci_remap_cfgspace
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  85  #define pci_remap_cfgspace pci_remap_cfgspace
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  86  static inline void __iomem *pci_remap_cfgspace(phys_addr_t offset,
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  87  					       size_t size)
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  88  {
b10eb2d50911f9 Hector Martin     2021-03-25 @89  	return ioremap_np(offset, size) ?: ioremap(offset, size);
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  90  }
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  91  #endif
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  92  #endif
cf9ea8ca4a0bea Lorenzo Pieralisi 2017-04-19  93  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
