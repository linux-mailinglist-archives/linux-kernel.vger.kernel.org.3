Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908784C8481
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiCAHCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiCAHCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:02:18 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5C9654B0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 23:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646118098; x=1677654098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=35HJmXKfxBi/prrSB2I1QkaptGFdsXRKRkwKG2qraxI=;
  b=SnKzdPSY4o1EODWUrnhdltreRFep9lhD1y+P//qy0IZsjtozmpM6WJBQ
   cKlWO/DSmFYgJrLWujLJHeDvwm6xtzL7ze1H4jWEsC3jdIctFOJS5NAHN
   pfrPqDWXPL7kZn5bOFad89qJt91JX3UJxy2iteD2xI1lOftCRpvsWqaUu
   cpEi6AsMlpcch1UZn/pBvGTWFbw90kcUongpgVtIyjbx8MfRedJ+1fvC9
   qJYU7ARY3QBSVPSSJL8Tf0IO+MUrl/OgLueytj0UxCDSZyNN/iUpP5X9E
   yuwph8jDOJwuPZWZarcrJLUTvlG4o1sGbRFPxvWGafyFoYq83BNhrAhX5
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="252805911"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="252805911"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 23:01:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="708950428"
Received: from lkp-server01.sh.intel.com (HELO 2146afe809fb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2022 23:01:30 -0800
Received: from kbuild by 2146afe809fb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOwVm-00005R-0Y; Tue, 01 Mar 2022 07:01:30 +0000
Date:   Tue, 1 Mar 2022 15:00:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     kbuild-all@lists.01.org, David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Zqiang <qiang.zhang@windriver.com>
Subject: Re: [PATCH v2] mm/slub: initialize stack depot in boot process
Message-ID: <202203011429.a87fKdU7-lkp@intel.com>
References: <Yh2Uxh9DMndwjGcb@ip-172-31-19-208.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh2Uxh9DMndwjGcb@ip-172-31-19-208.ap-northeast-1.compute.internal>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hyeonggon,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on vbabka/slub-stackdepot-v1]
[also build test ERROR on linus/master v5.17-rc6 next-20220228]
[cannot apply to hnaz-mm/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Hyeonggon-Yoo/mm-slub-initialize-stack-depot-in-boot-process/20220301-113825
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git slub-stackdepot-v1
config: m68k-randconfig-r014-20220301 (https://download.01.org/0day-ci/archive/20220301/202203011429.a87fKdU7-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/dd9dbeec7444b13b510dc4a863e9593d1799f965
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Hyeonggon-Yoo/mm-slub-initialize-stack-depot-in-boot-process/20220301-113825
        git checkout dd9dbeec7444b13b510dc4a863e9593d1799f965
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash arch/m68k/coldfire/ mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/irq.h:21,
                    from include/asm-generic/hardirq.h:17,
                    from ./arch/m68k/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from arch/m68k/kernel/asm-offsets.c:16:
>> include/linux/slab.h:769:5: warning: no previous prototype for 'slab_stack_depot_init' [-Wmissing-prototypes]
     769 | int slab_stack_depot_init(void) { return 0; }
         |     ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/irq.h:21,
                    from arch/m68k/coldfire/vectors.c:14:
>> include/linux/slab.h:769:5: warning: no previous prototype for 'slab_stack_depot_init' [-Wmissing-prototypes]
     769 | int slab_stack_depot_init(void) { return 0; }
         |     ^~~~~~~~~~~~~~~~~~~~~
   arch/m68k/coldfire/vectors.c:43:13: warning: no previous prototype for 'trap_init' [-Wmissing-prototypes]
      43 | void __init trap_init(void)
         |             ^~~~~~~~~
--
   In file included from include/linux/irq.h:21,
                    from include/asm-generic/hardirq.h:17,
                    from ./arch/m68k/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from arch/m68k/coldfire/intc-simr.c:16:
>> include/linux/slab.h:769:5: warning: no previous prototype for 'slab_stack_depot_init' [-Wmissing-prototypes]
     769 | int slab_stack_depot_init(void) { return 0; }
         |     ^~~~~~~~~~~~~~~~~~~~~
   arch/m68k/coldfire/intc-simr.c:177:13: warning: no previous prototype for 'init_IRQ' [-Wmissing-prototypes]
     177 | void __init init_IRQ(void)
         |             ^~~~~~~~
--
   In file included from include/linux/irq.h:21,
                    from include/linux/gpio/driver.h:7,
                    from arch/m68k/coldfire/gpio.c:12:
>> include/linux/slab.h:769:5: warning: no previous prototype for 'slab_stack_depot_init' [-Wmissing-prototypes]
     769 | int slab_stack_depot_init(void) { return 0; }
         |     ^~~~~~~~~~~~~~~~~~~~~
   arch/m68k/coldfire/gpio.c:19:5: warning: no previous prototype for '__mcfgpio_get_value' [-Wmissing-prototypes]
      19 | int __mcfgpio_get_value(unsigned gpio)
         |     ^~~~~~~~~~~~~~~~~~~
   arch/m68k/coldfire/gpio.c:25:6: warning: no previous prototype for '__mcfgpio_set_value' [-Wmissing-prototypes]
      25 | void __mcfgpio_set_value(unsigned gpio, int value)
         |      ^~~~~~~~~~~~~~~~~~~
   arch/m68k/coldfire/gpio.c:50:5: warning: no previous prototype for '__mcfgpio_direction_input' [-Wmissing-prototypes]
      50 | int __mcfgpio_direction_input(unsigned gpio)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/m68k/coldfire/gpio.c:65:5: warning: no previous prototype for '__mcfgpio_direction_output' [-Wmissing-prototypes]
      65 | int __mcfgpio_direction_output(unsigned gpio, int value)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/m68k/coldfire/gpio.c:96:5: warning: no previous prototype for '__mcfgpio_request' [-Wmissing-prototypes]
      96 | int __mcfgpio_request(unsigned gpio)
         |     ^~~~~~~~~~~~~~~~~
   arch/m68k/coldfire/gpio.c:102:6: warning: no previous prototype for '__mcfgpio_free' [-Wmissing-prototypes]
     102 | void __mcfgpio_free(unsigned gpio)
         |      ^~~~~~~~~~~~~~
--
   In file included from include/linux/stackdepot.h:15,
                    from include/linux/page_ext.h:7,
                    from include/linux/mm.h:25,
                    from mm/page_alloc.c:19:
>> include/linux/slab.h:769:5: warning: no previous prototype for 'slab_stack_depot_init' [-Wmissing-prototypes]
     769 | int slab_stack_depot_init(void) { return 0; }
         |     ^~~~~~~~~~~~~~~~~~~~~
   mm/page_alloc.c:3820:15: warning: no previous prototype for 'should_fail_alloc_page' [-Wmissing-prototypes]
    3820 | noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
         |               ^~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/stackdepot.h:15,
                    from include/linux/page_ext.h:7,
                    from include/linux/mm.h:25,
                    from mm/page_poison.c:4:
>> include/linux/slab.h:769:5: warning: no previous prototype for 'slab_stack_depot_init' [-Wmissing-prototypes]
     769 | int slab_stack_depot_init(void) { return 0; }
         |     ^~~~~~~~~~~~~~~~~~~~~
   mm/page_poison.c:102:6: warning: no previous prototype for '__kernel_map_pages' [-Wmissing-prototypes]
     102 | void __kernel_map_pages(struct page *page, int numpages, int enable)
         |      ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/stackdepot.h:15,
                    from include/linux/page_ext.h:7,
                    from include/linux/mm.h:25,
                    from mm/slub.c:13:
>> include/linux/slab.h:769:5: warning: no previous prototype for 'slab_stack_depot_init' [-Wmissing-prototypes]
     769 | int slab_stack_depot_init(void) { return 0; }
         |     ^~~~~~~~~~~~~~~~~~~~~
>> mm/slub.c:651:5: error: redefinition of 'slab_stack_depot_init'
     651 | int slab_stack_depot_init(void)
         |     ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/stackdepot.h:15,
                    from include/linux/page_ext.h:7,
                    from include/linux/mm.h:25,
                    from mm/slub.c:13:
   include/linux/slab.h:769:5: note: previous definition of 'slab_stack_depot_init' with type 'int(void)'
     769 | int slab_stack_depot_init(void) { return 0; }
         |     ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/irq.h:21,
                    from include/asm-generic/hardirq.h:17,
                    from ./arch/m68k/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from arch/m68k/kernel/asm-offsets.c:16:
>> include/linux/slab.h:769:5: warning: no previous prototype for 'slab_stack_depot_init' [-Wmissing-prototypes]
     769 | int slab_stack_depot_init(void) { return 0; }
         |     ^~~~~~~~~~~~~~~~~~~~~


vim +/slab_stack_depot_init +651 mm/slub.c

   650	
 > 651	int slab_stack_depot_init(void)
   652	{
   653		if (init_stack_depot)
   654			stack_depot_init();
   655		return 0;
   656	}
   657	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
