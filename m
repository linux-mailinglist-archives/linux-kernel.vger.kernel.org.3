Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A73954C9C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349086AbiFON2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347478AbiFON2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:28:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1B82CCBB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655299701; x=1686835701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G5/lQUzNGrkTsaT8lmei7Sc623MPsT6oyM+mwSRQnwM=;
  b=F16S51Ytjx5JEpYqTpcvS2DGtyZDU+UHDBecSdMKhQq0Un/+j4lOpz1K
   TlTkAzN+unrFU0gulqKOvTUzYCkbpWFuxDxovA32FCgy9QuP9HoypGT9d
   9wdTUu0TuutmCmVQicd1RBG8s1YdS4u5zWutYK7WgOhqQQJZc1XRvjb7N
   agvbt+GC9Yjo6+tJh2yeQTuCQ25evNH+0/sDEPh/OWcJFKO2p4mh9TKdX
   DVCScYcXQges1Q82BvLRk1pi/beRKUhU/oI9PcfzHV6V6MqL3zPxnJXKp
   cvVLZfefe1biREr/a+D1Mx0SNXTiESNSmszDUJEHKNIBaDuGVJEyNQ7r7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="277752634"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="277752634"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 06:28:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="612739745"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 15 Jun 2022 06:28:17 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1T4C-000Mtf-RD;
        Wed, 15 Jun 2022 13:28:16 +0000
Date:   Wed, 15 Jun 2022 21:27:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     kbuild-all@lists.01.org, Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/32] kasan: move kasan_addr_to_slab to common.c
Message-ID: <202206152134.sadCRvGk-lkp@intel.com>
References: <5ea6f55fb645405bb52cb15b8d30544ba3f189b0.1655150842.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ea6f55fb645405bb52cb15b8d30544ba3f189b0.1655150842.git.andreyknvl@google.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v5.19-rc2 next-20220615]
[cannot apply to vbabka-slab/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/andrey-konovalov-linux-dev/kasan-switch-tag-based-modes-to-stack-ring-from-per-object-metadata/20220614-042239
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220615/202206152134.sadCRvGk-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b0b10a57b2d9a5e5ae5d7ca62046b9774df1a88f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review andrey-konovalov-linux-dev/kasan-switch-tag-based-modes-to-stack-ring-from-per-object-metadata/20220614-042239
        git checkout b0b10a57b2d9a5e5ae5d7ca62046b9774df1a88f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash mm/kasan/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/kasan/common.c: In function 'kasan_addr_to_slab':
>> mm/kasan/common.c:35:19: warning: ordered comparison of pointer with null pointer [-Wextra]
      35 |         if ((addr >= (void *)PAGE_OFFSET) && (addr < high_memory))
         |                   ^~
   mm/kasan/common.c: In function '____kasan_slab_free':
   mm/kasan/common.c:202:12: warning: variable 'tag' set but not used [-Wunused-but-set-variable]
     202 |         u8 tag;
         |            ^~~


vim +35 mm/kasan/common.c

    32	
    33	struct slab *kasan_addr_to_slab(const void *addr)
    34	{
  > 35		if ((addr >= (void *)PAGE_OFFSET) && (addr < high_memory))
    36			return virt_to_slab(addr);
    37		return NULL;
    38	}
    39	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
