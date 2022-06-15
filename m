Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0B654D012
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349864AbiFOReC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357877AbiFORdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:33:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7814F455
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655314409; x=1686850409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+MKeBdQz1ajkRhqL3VBuYBCksZz92U5jphtv50ui+cU=;
  b=ZI4aDJxM1wubyNnxLla1bpPOLrP2R0nHUIo6EOot/iz/fNPgtVm4WixX
   1LLMj9NmhoSCLTNkPITKYeJ5d5H2ofGKHZl+mnKp/DyLcjE1jWMf+lIHq
   02txjxqRejW90f1MG98Cq5UAxb/6rG4aW+IPwgqrgo0UDWHfIZpmpZl6L
   zzvHuAuAmLi7A9RcM4pY9RTzD2otry7+GDfq6n1y4g8Xi6XEmBK/Zi1Bt
   SyyS1EG+cafmz34evSiXnw4c40q4QKurX1G5YImKX/avXQsDPdIcFZQrL
   WcrFGyCt/AHAzxhC1gJFPe4Od2EI1rRZSInxhgDJBEVoqC0BVCLhjKgV1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="258902412"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="258902412"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 10:33:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="572430235"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Jun 2022 10:33:24 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1WtQ-000N3J-36;
        Wed, 15 Jun 2022 17:33:24 +0000
Date:   Thu, 16 Jun 2022 01:32:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] highmem: Make __kunmap_{local,atomic}() take "const void
 *"
Message-ID: <202206160154.0Asirpka-lkp@intel.com>
References: <20220614142531.16478-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614142531.16478-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Fabio,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v5.19-rc2 next-20220615]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Francesco/highmem-Make-__kunmap_-local-atomic-take-const-void/20220614-222749
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220616/202206160154.0Asirpka-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/558ba1aeb12cc7940165f07160e51afb0bc1a64b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Fabio-M-De-Francesco/highmem-Make-__kunmap_-local-atomic-take-const-void/20220614-222749
        git checkout 558ba1aeb12cc7940165f07160e51afb0bc1a64b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/highmem.h:13,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from drivers/net/wwan/t7xx/t7xx_hif_cldma.h:25,
                    from drivers/net/wwan/t7xx/t7xx_modem_ops.h:25,
                    from drivers/net/wwan/t7xx/t7xx_pci.c:39:
   include/linux/highmem-internal.h: In function '__kunmap_local':
>> include/linux/highmem-internal.h:203:31: error: passing argument 1 of 'kunmap_flush_on_unmap' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
     203 |         kunmap_flush_on_unmap(addr);
         |                               ^~~~
   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from drivers/net/wwan/t7xx/t7xx_hif_cldma.h:25,
                    from drivers/net/wwan/t7xx/t7xx_modem_ops.h:25,
                    from drivers/net/wwan/t7xx/t7xx_pci.c:39:
   arch/parisc/include/asm/cacheflush.h:78:48: note: expected 'void *' but argument is of type 'const void *'
      78 | static inline void kunmap_flush_on_unmap(void *addr)
         |                                          ~~~~~~^~~~
   In file included from include/linux/highmem.h:13,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from drivers/net/wwan/t7xx/t7xx_hif_cldma.h:25,
                    from drivers/net/wwan/t7xx/t7xx_modem_ops.h:25,
                    from drivers/net/wwan/t7xx/t7xx_pci.c:39:
   include/linux/highmem-internal.h: In function '__kunmap_atomic':
   include/linux/highmem-internal.h:230:31: error: passing argument 1 of 'kunmap_flush_on_unmap' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
     230 |         kunmap_flush_on_unmap(addr);
         |                               ^~~~
   In file included from include/linux/cacheflush.h:5,
                    from include/linux/highmem.h:8,
                    from include/linux/bvec.h:10,
                    from include/linux/skbuff.h:17,
                    from drivers/net/wwan/t7xx/t7xx_hif_cldma.h:25,
                    from drivers/net/wwan/t7xx/t7xx_modem_ops.h:25,
                    from drivers/net/wwan/t7xx/t7xx_pci.c:39:
   arch/parisc/include/asm/cacheflush.h:78:48: note: expected 'void *' but argument is of type 'const void *'
      78 | static inline void kunmap_flush_on_unmap(void *addr)
         |                                          ~~~~~~^~~~
   cc1: all warnings being treated as errors


vim +203 include/linux/highmem-internal.h

f3ba3c710ac5a3 Thomas Gleixner       2020-11-18  199  
558ba1aeb12cc7 Fabio M. De Francesco 2022-06-14  200  static inline void __kunmap_local(const void *addr)
f3ba3c710ac5a3 Thomas Gleixner       2020-11-18  201  {
f3ba3c710ac5a3 Thomas Gleixner       2020-11-18  202  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
f3ba3c710ac5a3 Thomas Gleixner       2020-11-18 @203  	kunmap_flush_on_unmap(addr);
f3ba3c710ac5a3 Thomas Gleixner       2020-11-18  204  #endif
f3ba3c710ac5a3 Thomas Gleixner       2020-11-18  205  }
f3ba3c710ac5a3 Thomas Gleixner       2020-11-18  206  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
