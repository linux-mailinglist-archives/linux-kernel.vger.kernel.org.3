Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EA34C5951
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 06:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiB0FHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 00:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiB0FHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 00:07:03 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CA27F6C0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 21:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645938387; x=1677474387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ma45tRABv3DOm24yibSpjnBT7pc4eQkuslcTGBgE5vo=;
  b=KmGim15PxsX0oDs3MUgmEroPgyZbgJMlS8bjh2LI/2FEsWzKi88my78d
   Z0227T58F/6kYx1XDS/MnpRlwNNlvy3e3V2cIld8NHd3UaMd6uwq9wS3G
   E/2awF/svTL7zIdHy5AqNMC7QUUfjvlDpaWwIteUG1LQxJ8/bhmK/+hS5
   IZOvwXKY3mYe8AGxfIq6FXqV/Q9QwlVF816L4w7NH9b5sjp3ugiFUO2lq
   cdDJ8acVI8xZyU2LLUWeu0Eni0uM2qrRVYuysA9eLAgNNd+yXFrzTWmFG
   /UaqQWzmEWy3mb8g/1IOxSGKmaFFExGVw9DymeQuf+XYtTLW310KtLKAz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="232678706"
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="232678706"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 21:06:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="777775434"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 26 Feb 2022 21:06:21 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOBlE-0006ED-Pg; Sun, 27 Feb 2022 05:06:20 +0000
Date:   Sun, 27 Feb 2022 13:06:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        David Rientjes <rientjes@google.com>,
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
        Zqiang <qiang.zhang@windriver.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH] lib/stackdepot: Use page allocator if both slab and
 memblock is unavailable
Message-ID: <202202271324.VLaJlMYW-lkp@intel.com>
References: <YhrrM7NTYXG5JluY@ip-172-31-19-208.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhrrM7NTYXG5JluY@ip-172-31-19-208.ap-northeast-1.compute.internal>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hyeonggon,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.17-rc5 next-20220225]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Hyeonggon-Yoo/lib-stackdepot-Use-page-allocator-if-both-slab-and-memblock-is-unavailable/20220227-111029
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2293be58d6a18cab800e25e42081bacb75c05752
config: hexagon-randconfig-r005-20220227 (https://download.01.org/0day-ci/archive/20220227/202202271324.VLaJlMYW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/fd37f88eccc357002cc03a6a5fac60fb42552bc7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Hyeonggon-Yoo/lib-stackdepot-Use-page-allocator-if-both-slab-and-memblock-is-unavailable/20220227-111029
        git checkout fd37f88eccc357002cc03a6a5fac60fb42552bc7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/stackdepot.c:187:11: warning: comparison of distinct pointer types ('typeof (size) *' (aka 'unsigned int *') and 'typeof ((1UL << 14) << (11 - 1)) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
                           size = min(size, PAGE_SIZE << (MAX_ORDER - 1));
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   1 warning generated.


vim +187 lib/stackdepot.c

   168	
   169	/*
   170	 * __ref because of memblock_alloc(), which will not be actually called after
   171	 * the __init code is gone, because at that point slab_is_available() is true
   172	 */
   173	__ref int stack_depot_init(void)
   174	{
   175		static DEFINE_MUTEX(stack_depot_init_mutex);
   176	
   177		mutex_lock(&stack_depot_init_mutex);
   178		if (!stack_depot_disable && !stack_table) {
   179			size_t size = (stack_hash_size * sizeof(struct stack_record *));
   180			int i;
   181	
   182			if (slab_is_available()) {
   183				pr_info("Stack Depot allocating hash table with kvmalloc\n");
   184				stack_table = kvmalloc(size, GFP_KERNEL);
   185			} else if (totalram_pages() > 0) {
   186				/* Reduce size because vmalloc may be unavailable */
 > 187				size = min(size, PAGE_SIZE << (MAX_ORDER - 1));
   188				stack_hash_size = size / sizeof(struct stack_record *);
   189	
   190				pr_info("Stack Depot allocating hash table with __get_free_pages\n");
   191				stack_table = (struct stack_record **)
   192					      __get_free_pages(GFP_KERNEL, get_order(size));
   193			} else {
   194				pr_info("Stack Depot allocating hash table with memblock_alloc\n");
   195				stack_table = memblock_alloc(size, SMP_CACHE_BYTES);
   196			}
   197	
   198			if (stack_table) {
   199				pr_info("Stack Depot hash table size=%u\n", stack_hash_size);
   200				for (i = 0; i < stack_hash_size;  i++)
   201					stack_table[i] = NULL;
   202			} else {
   203				pr_err("Stack Depot hash table allocation failed, disabling\n");
   204				stack_depot_disable = true;
   205				mutex_unlock(&stack_depot_init_mutex);
   206				return -ENOMEM;
   207			}
   208		}
   209		mutex_unlock(&stack_depot_init_mutex);
   210		return 0;
   211	}
   212	EXPORT_SYMBOL_GPL(stack_depot_init);
   213	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
