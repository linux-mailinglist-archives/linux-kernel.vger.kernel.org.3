Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07904EDE0B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 17:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239387AbiCaP4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 11:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239394AbiCaP4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:56:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4937C91566
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 08:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648742094; x=1680278094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7T7GLlriaF2A5bwKoW5oZoyB9UoM65n6FmNK69DBzGs=;
  b=lNdigNF0+NKc49B4OeNrWz8yElEKeCKVuDvATi0eA3Vqg13mg170YZGn
   R+KMBnIwX+mljJc2/DJV3KUvqiQZjfIV1Fl0ImZfm2UJ18l7w0Z1Eumme
   UVxc5vON+HJmEINkpLLNQMkcAZv2IBCRzuD0YGWmBr9GAlAaPUZZK2hmP
   JhxROQFX465DZpXB1LNS8RsNKC5d666xUltQys6B4gsbq/uAhYAoo5nwi
   4iSMMeSgQPV+n54cQdY5gWS6wLHB6J8ACNf08NHUmVs/ad2zeoo6kPSZ/
   aXqOnCpYkvLhGEzZXRRJp6lGwcfuZ7gcrXBYTs5Q6W4bL+JWgikA47kgP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259585744"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="259585744"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 08:54:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="586480733"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 31 Mar 2022 08:54:51 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZx8M-0000P4-CT;
        Thu, 31 Mar 2022 15:54:50 +0000
Date:   Thu, 31 Mar 2022 23:54:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3] mm/sparsemem: Fix 'mem_section' will never be NULL
 gcc 12 warning
Message-ID: <202203312327.XGeCiD5T-lkp@intel.com>
References: <20220330205919.2713275-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330205919.2713275-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

I love your patch! Perhaps something to improve:

[auto build test WARNING on hnaz-mm/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/mm-sparsemem-Fix-mem_section-will-never-be-NULL-gcc-12-warning/20220331-050049
base:   https://github.com/hnaz/linux-mm master
config: arm-randconfig-c024-20220330 (https://download.01.org/0day-ci/archive/20220331/202203312327.XGeCiD5T-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2098f1d78cde338e81b3ba596ea39f37824e496e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Waiman-Long/mm-sparsemem-Fix-mem_section-will-never-be-NULL-gcc-12-warning/20220331-050049
        git checkout 2098f1d78cde338e81b3ba596ea39f37824e496e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash security/keys/encrypted-keys/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/gfp.h:6,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from security/keys/encrypted-keys/encrypted.c:15:
   security/keys/encrypted-keys/encrypted.c: In function 'derived_key_encrypt.constprop':
>> include/linux/mmzone.h:1432:23: warning: array subscript 32 is outside array bounds of 'struct mem_section[32][1]' [-Warray-bounds]
    1432 |         unsigned long map = section->section_mem_map;
         |                       ^~~
   include/linux/mmzone.h:1390:27: note: while referencing 'mem_section'
    1390 | extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
         |                           ^~~~~~~~~~~


vim +1432 include/linux/mmzone.h

29751f6991e845 Andy Whitcroft 2005-06-23  1429  
29751f6991e845 Andy Whitcroft 2005-06-23  1430  static inline struct page *__section_mem_map_addr(struct mem_section *section)
29751f6991e845 Andy Whitcroft 2005-06-23  1431  {
29751f6991e845 Andy Whitcroft 2005-06-23 @1432  	unsigned long map = section->section_mem_map;
29751f6991e845 Andy Whitcroft 2005-06-23  1433  	map &= SECTION_MAP_MASK;
29751f6991e845 Andy Whitcroft 2005-06-23  1434  	return (struct page *)map;
29751f6991e845 Andy Whitcroft 2005-06-23  1435  }
29751f6991e845 Andy Whitcroft 2005-06-23  1436  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
