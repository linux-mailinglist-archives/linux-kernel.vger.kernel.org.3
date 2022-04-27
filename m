Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B384511619
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiD0LA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiD0LAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:00:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242C52359F8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651055882; x=1682591882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UbxzDhSBMwjU6x3l9iraRrYmZ24AOc0ElO25NvVEnPM=;
  b=ZGqrcQxXOjB1EiKUGMcHYhMAKzCuQ85XNlyi83gd+5KX0dSwHOxJV5xP
   AhXEZMB4EMZfBDAEdnSeZf6RW3PvyKeG+m/n7M63IkK37KnpdB8ki1FyO
   6eTX8q6bb9f9p5IebIxFqRtcX/DEB6oDUaXQt3Xrf557qpgOxk2OCqoSJ
   YYpcfc9yBts8N6B7YRa9SOexhDuXF0qukSIhn/71fKxeWLbdllW2wZIZF
   k3xHX8GYMIHLceLmrcRuzPG7VR+etZ9pCd3qGDUiQl1IFU+JTCRouxfuO
   hK2wXXBM3gDQuJGH7Rkk3osxwMfSk180KQq9icyOVYOV9uOvPap/zh5M3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="326363848"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="326363848"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 02:26:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="539773405"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 Apr 2022 02:26:35 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njdwR-0004YO-1A;
        Wed, 27 Apr 2022 09:26:35 +0000
Date:   Wed, 27 Apr 2022 17:25:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Peter Collingbourne <pcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        vbabka@suse.cz, penberg@kernel.org, roman.gushchin@linux.dev,
        iamjoonsoo.kim@lge.com, rientjes@google.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 1/2] printk: stop including cache.h from printk.h
Message-ID: <202204271721.kgeFN450-lkp@intel.com>
References: <20220426203231.2107365-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426203231.2107365-1-pcc@google.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on vbabka-slab/for-next]
[also build test ERROR on arm64/for-next/core linus/master v5.18-rc4 next-20220427]
[cannot apply to dennis-percpu/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Collingbourne/printk-stop-including-cache-h-from-printk-h/20220427-043357
base:   git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git for-next
config: csky-randconfig-r031-20220425 (https://download.01.org/0day-ci/archive/20220427/202204271721.kgeFN450-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/edcb0f592304f7849a39586f9e3fe0d8f6e6c6b9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peter-Collingbourne/printk-stop-including-cache-h-from-printk-h/20220427-043357
        git checkout edcb0f592304f7849a39586f9e3fe0d8f6e6c6b9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=csky prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/compiler_types.h:73,
                    from <command-line>:
>> arch/csky/include/asm/processor.h:19:13: error: 'SMP_CACHE_BYTES' undeclared here (not in a function); did you mean 'L1_CACHE_BYTES'?
      19 | } __aligned(SMP_CACHE_BYTES);
         |             ^~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:33:68: note: in definition of macro '__aligned'
      33 | #define __aligned(x)                    __attribute__((__aligned__(x)))
         |                                                                    ^
   make[2]: *** [scripts/Makefile.build:120: arch/csky/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +19 arch/csky/include/asm/processor.h

e9564df753fd547 Guo Ren 2018-09-05  16  
e9564df753fd547 Guo Ren 2018-09-05  17  struct cpuinfo_csky {
e9564df753fd547 Guo Ren 2018-09-05  18  	unsigned long asid_cache;
e9564df753fd547 Guo Ren 2018-09-05 @19  } __aligned(SMP_CACHE_BYTES);
e9564df753fd547 Guo Ren 2018-09-05  20  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
