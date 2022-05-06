Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B35951D704
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391562AbiEFLuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391508AbiEFLt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:49:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE19694A1;
        Fri,  6 May 2022 04:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651837566; x=1683373566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t935uiHDr0FwSTZ51xfRHQyUrAV/YgeTPxzpxBGwWOI=;
  b=CeUm8kye1Y6vhGAg7+U6lyeh6e4WgWiVLoNK6lTCz1TmFd0hZY8af0qz
   jBzMZS8rLMpPQcatCqmEV6GQhwXz9CryoPMCKYpbjdVdLxJYKQNx33YvL
   tFcoXmJ32XByJtrEWitaliFQuTiV3gNKlhaBMLWtJn8oYFFD5bec+gX3v
   cDqSaHFOcb5hntykkBpwdVqbgpnfWyqRVGEE4rRudLM9v9zQabpkM1khc
   lIScsAnt6sZ/7z2yHz8h0YX5IcGDK4E0wqvc6r9VCwu654bhdkFVduz/l
   2so/LfzAJ65vs4oPAF5ujltrhXlddrx226KhWFOUTvruYBtUSag+fPbju
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="268341203"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="268341203"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 04:46:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="665448955"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 May 2022 04:46:00 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmwPI-000DQW-30;
        Fri, 06 May 2022 11:46:00 +0000
Date:   Fri, 6 May 2022 19:45:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paran Lee <p4ranlee@gmail.com>,
        Christoph Lameter <cl@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Austin Kim <austindh.kim@gmail.com>
Subject: Re: [PATCH] slub: kunit catch kmem_cache_alloc failed
Message-ID: <202205061914.zGa4ozYg-lkp@intel.com>
References: <20220506045319.GA28237@DESKTOP-NK4TH6S.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506045319.GA28237@DESKTOP-NK4TH6S.localdomain>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paran,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.18-rc5 next-20220506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Paran-Lee/slub-kunit-catch-kmem_cache_alloc-failed/20220506-125540
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fe27d189e3f42e31d3c8223d5daed7285e334c5e
config: hexagon-randconfig-r014-20220505 (https://download.01.org/0day-ci/archive/20220506/202205061914.zGa4ozYg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e004fb787698440a387750db7f8028e7cb14cfc)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4827e156a14ba66c648125c98967c96178ca024d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Paran-Lee/slub-kunit-catch-kmem_cache_alloc-failed/20220506-125540
        git checkout 4827e156a14ba66c648125c98967c96178ca024d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash lib/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/slub_kunit.c:40:16: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
           unsigned long tmp;
                         ^
   1 warning generated.


vim +40 lib/slub_kunit.c

1f9f78b1b376f8 Oliver Glitta 2021-06-28  28  
1f9f78b1b376f8 Oliver Glitta 2021-06-28  29  #ifndef CONFIG_KASAN
1f9f78b1b376f8 Oliver Glitta 2021-06-28  30  static void test_next_pointer(struct kunit *test)
1f9f78b1b376f8 Oliver Glitta 2021-06-28  31  {
1f9f78b1b376f8 Oliver Glitta 2021-06-28  32  	struct kmem_cache *s = kmem_cache_create("TestSlub_next_ptr_free", 64, 0,
1f9f78b1b376f8 Oliver Glitta 2021-06-28  33  				SLAB_POISON, NULL);
1f9f78b1b376f8 Oliver Glitta 2021-06-28  34  	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
4827e156a14ba6 Paran Lee     2022-05-06  35  	if (!p) {
4827e156a14ba6 Paran Lee     2022-05-06  36  		kunit_err(test, "Allocation failed: %s\n", __func__);
4827e156a14ba6 Paran Lee     2022-05-06  37  		kmem_cache_destroy(s);
4827e156a14ba6 Paran Lee     2022-05-06  38  		return;
4827e156a14ba6 Paran Lee     2022-05-06  39  	}
1f9f78b1b376f8 Oliver Glitta 2021-06-28 @40  	unsigned long tmp;
1f9f78b1b376f8 Oliver Glitta 2021-06-28  41  	unsigned long *ptr_addr;
1f9f78b1b376f8 Oliver Glitta 2021-06-28  42  
1f9f78b1b376f8 Oliver Glitta 2021-06-28  43  	kmem_cache_free(s, p);
1f9f78b1b376f8 Oliver Glitta 2021-06-28  44  
1f9f78b1b376f8 Oliver Glitta 2021-06-28  45  	ptr_addr = (unsigned long *)(p + s->offset);
1f9f78b1b376f8 Oliver Glitta 2021-06-28  46  	tmp = *ptr_addr;
1f9f78b1b376f8 Oliver Glitta 2021-06-28  47  	p[s->offset] = 0x12;
1f9f78b1b376f8 Oliver Glitta 2021-06-28  48  
1f9f78b1b376f8 Oliver Glitta 2021-06-28  49  	/*
1f9f78b1b376f8 Oliver Glitta 2021-06-28  50  	 * Expecting three errors.
1f9f78b1b376f8 Oliver Glitta 2021-06-28  51  	 * One for the corrupted freechain and the other one for the wrong
1f9f78b1b376f8 Oliver Glitta 2021-06-28  52  	 * count of objects in use. The third error is fixing broken cache.
1f9f78b1b376f8 Oliver Glitta 2021-06-28  53  	 */
1f9f78b1b376f8 Oliver Glitta 2021-06-28  54  	validate_slab_cache(s);
1f9f78b1b376f8 Oliver Glitta 2021-06-28  55  	KUNIT_EXPECT_EQ(test, 3, slab_errors);
1f9f78b1b376f8 Oliver Glitta 2021-06-28  56  
1f9f78b1b376f8 Oliver Glitta 2021-06-28  57  	/*
1f9f78b1b376f8 Oliver Glitta 2021-06-28  58  	 * Try to repair corrupted freepointer.
1f9f78b1b376f8 Oliver Glitta 2021-06-28  59  	 * Still expecting two errors. The first for the wrong count
1f9f78b1b376f8 Oliver Glitta 2021-06-28  60  	 * of objects in use.
1f9f78b1b376f8 Oliver Glitta 2021-06-28  61  	 * The second error is for fixing broken cache.
1f9f78b1b376f8 Oliver Glitta 2021-06-28  62  	 */
1f9f78b1b376f8 Oliver Glitta 2021-06-28  63  	*ptr_addr = tmp;
1f9f78b1b376f8 Oliver Glitta 2021-06-28  64  	slab_errors = 0;
1f9f78b1b376f8 Oliver Glitta 2021-06-28  65  
1f9f78b1b376f8 Oliver Glitta 2021-06-28  66  	validate_slab_cache(s);
1f9f78b1b376f8 Oliver Glitta 2021-06-28  67  	KUNIT_EXPECT_EQ(test, 2, slab_errors);
1f9f78b1b376f8 Oliver Glitta 2021-06-28  68  
1f9f78b1b376f8 Oliver Glitta 2021-06-28  69  	/*
1f9f78b1b376f8 Oliver Glitta 2021-06-28  70  	 * Previous validation repaired the count of objects in use.
1f9f78b1b376f8 Oliver Glitta 2021-06-28  71  	 * Now expecting no error.
1f9f78b1b376f8 Oliver Glitta 2021-06-28  72  	 */
1f9f78b1b376f8 Oliver Glitta 2021-06-28  73  	slab_errors = 0;
1f9f78b1b376f8 Oliver Glitta 2021-06-28  74  	validate_slab_cache(s);
1f9f78b1b376f8 Oliver Glitta 2021-06-28  75  	KUNIT_EXPECT_EQ(test, 0, slab_errors);
1f9f78b1b376f8 Oliver Glitta 2021-06-28  76  
1f9f78b1b376f8 Oliver Glitta 2021-06-28  77  	kmem_cache_destroy(s);
1f9f78b1b376f8 Oliver Glitta 2021-06-28  78  }
1f9f78b1b376f8 Oliver Glitta 2021-06-28  79  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
