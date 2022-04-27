Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31373510F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 05:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348370AbiD0D3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 23:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350721AbiD0D2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:28:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0D8B7C1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651029927; x=1682565927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I/D36ogdcL9qPxkkh7uSsit5MMJEkaxqwKjEaM3XMoA=;
  b=OO2K4r9dc/bugEMuXEQ7Oxun28aXnAwkA4ILQtwRidPW8amgR/l8TTkv
   9vrtGOogX8TS6Vik2RRy8gdvnArK5BQBOw9MZI23tfgR6JraUjKDAGzt+
   gOBBLcQzMC9P2q2kG2bvfoV3xJ9gcvvvwpXiBH7G/XH3LPOFczaLouI9n
   Hk6hvuhujss/UFZYFSMUwC+cvmv5XXeoFeuFZ30vtqPz89O/mHjqRPmNE
   4qcFlwx6N5mlQqGnDomH7Hem1ZRoygvWmtKt5WBtMu4Mq2s7kjxmgC3fX
   /lMYcGoDFPPBVfY53mHGssz2MqZLaN9TJVVLrtPqbmw0gu1y3l3SOPvGB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="328741194"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="328741194"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 20:25:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="661015977"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 26 Apr 2022 20:25:21 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njYIr-0004Gi-5Y;
        Wed, 27 Apr 2022 03:25:21 +0000
Date:   Wed, 27 Apr 2022 11:25:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
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
Message-ID: <202204271135.P05x34Pe-lkp@intel.com>
References: <20220426203231.2107365-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426203231.2107365-1-pcc@google.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on vbabka-slab/for-next]
[also build test ERROR on arm64/for-next/core linus/master v5.18-rc4 next-20220426]
[cannot apply to dennis-percpu/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Collingbourne/printk-stop-including-cache-h-from-printk-h/20220427-043357
base:   git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git for-next
config: arm-randconfig-r025-20220425 (https://download.01.org/0day-ci/archive/20220427/202204271135.P05x34Pe-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/edcb0f592304f7849a39586f9e3fe0d8f6e6c6b9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peter-Collingbourne/printk-stop-including-cache-h-from-printk-h/20220427-043357
        git checkout edcb0f592304f7849a39586f9e3fe0d8f6e6c6b9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/bpf/bpf_lru_list.c:8:
>> kernel/bpf/bpf_lru_list.h:36:21: error: expected ';' at end of declaration list
           raw_spinlock_t lock ____cacheline_aligned_in_smp;
                              ^
                              ;
   1 error generated.


vim +36 kernel/bpf/bpf_lru_list.h

3a08c2fd763450a Martin KaFai Lau 2016-11-11  29  
3a08c2fd763450a Martin KaFai Lau 2016-11-11  30  struct bpf_lru_list {
3a08c2fd763450a Martin KaFai Lau 2016-11-11  31  	struct list_head lists[NR_BPF_LRU_LIST_T];
3a08c2fd763450a Martin KaFai Lau 2016-11-11  32  	unsigned int counts[NR_BPF_LRU_LIST_COUNT];
0ac16296ffc638f Qiujun Huang     2020-04-03  33  	/* The next inactive list rotation starts from here */
3a08c2fd763450a Martin KaFai Lau 2016-11-11  34  	struct list_head *next_inactive_rotation;
3a08c2fd763450a Martin KaFai Lau 2016-11-11  35  
3a08c2fd763450a Martin KaFai Lau 2016-11-11 @36  	raw_spinlock_t lock ____cacheline_aligned_in_smp;
3a08c2fd763450a Martin KaFai Lau 2016-11-11  37  };
3a08c2fd763450a Martin KaFai Lau 2016-11-11  38  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
