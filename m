Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C5B50D8B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 07:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241204AbiDYFQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 01:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237644AbiDYFQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 01:16:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D07ADA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650863615; x=1682399615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kI+Eb3HXZmO8tMdYWAtqwTvLTzUUWhx8e2ynN6/5zlc=;
  b=dT0cUK+nAa8SQP5FQWOcE4wBTVI7FG/5DZT7pbce6seNUzRRGZmYqCBI
   TermwmVldgaNTb0keuBthEWJlhk2EmHgcXqI8DK/Q8bkMeti0TNUSHkc1
   oCLy/MCT/Rcj/IEjGjUCdKAyzPG/JK45ibxnpCvLl0Kf8MT54rTfszSHq
   HUCOCzEG7aSwxARj9+i8fAAwNew2LsM1B4Aui5G5R5h7rYVvD0r2rggR5
   4bJBYt7wYewBBlhx1EKhtNQuBNnGZQnZFQddLPi/P0qTsS9QdyqIkKlSD
   qUISIEVNtXAgsvGuGA5+bkOk4/GilFFNTlhNy2tZ0nWCYp8uQJd0mSwCb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="290276389"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="290276389"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 22:13:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="704401579"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Apr 2022 22:13:29 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nir2P-0002AF-3Q;
        Mon, 25 Apr 2022 05:13:29 +0000
Date:   Mon, 25 Apr 2022 13:12:47 +0800
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
Subject: Re: [PATCH v3] mm: make minimum slab alignment a runtime property
Message-ID: <202204251346.WbwgrNZw-lkp@intel.com>
References: <20220422201830.288018-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422201830.288018-1-pcc@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Collingbourne/mm-make-minimum-slab-alignment-a-runtime-property/20220423-042024
base:   https://github.com/hnaz/linux-mm master
config: arm64-buildonly-randconfig-r002-20220425 (https://download.01.org/0day-ci/archive/20220425/202204251346.WbwgrNZw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/3aef97055dd4a480e05dff758164f153aaddbb49
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peter-Collingbourne/mm-make-minimum-slab-alignment-a-runtime-property/20220423-042024
        git checkout 3aef97055dd4a480e05dff758164f153aaddbb49
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/bounds.c:10:
   In file included from include/linux/page-flags.h:10:
   In file included from include/linux/bug.h:5:
   In file included from arch/arm64/include/asm/bug.h:26:
   In file included from include/asm-generic/bug.h:22:
   In file included from include/linux/printk.h:9:
   In file included from include/linux/cache.h:6:
   In file included from arch/arm64/include/asm/cache.h:56:
   In file included from include/linux/kasan-enabled.h:5:
   In file included from include/linux/static_key.h:1:
>> include/linux/jump_label.h:285:2: error: call to undeclared function 'WARN'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           STATIC_KEY_CHECK_USE(key);
           ^
   include/linux/jump_label.h:81:35: note: expanded from macro 'STATIC_KEY_CHECK_USE'
   #define STATIC_KEY_CHECK_USE(key) WARN(!static_key_initialized,               \
                                     ^
   include/linux/jump_label.h:291:2: error: call to undeclared function 'WARN'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           STATIC_KEY_CHECK_USE(key);
           ^
   include/linux/jump_label.h:81:35: note: expanded from macro 'STATIC_KEY_CHECK_USE'
   #define STATIC_KEY_CHECK_USE(key) WARN(!static_key_initialized,               \
                                     ^
   include/linux/jump_label.h:313:2: error: call to undeclared function 'WARN'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           STATIC_KEY_CHECK_USE(key);
           ^
   include/linux/jump_label.h:81:35: note: expanded from macro 'STATIC_KEY_CHECK_USE'
   #define STATIC_KEY_CHECK_USE(key) WARN(!static_key_initialized,               \
                                     ^
>> include/linux/jump_label.h:316:3: error: call to undeclared function 'WARN_ON_ONCE'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
                   ^
   include/linux/jump_label.h:324:2: error: call to undeclared function 'WARN'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           STATIC_KEY_CHECK_USE(key);
           ^
   include/linux/jump_label.h:81:35: note: expanded from macro 'STATIC_KEY_CHECK_USE'
   #define STATIC_KEY_CHECK_USE(key) WARN(!static_key_initialized,               \
                                     ^
   include/linux/jump_label.h:327:3: error: call to undeclared function 'WARN_ON_ONCE'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   WARN_ON_ONCE(atomic_read(&key->enabled) != 0);
                   ^
   6 errors generated.
   make[2]: *** [scripts/Makefile.build:122: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1283: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:226: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/WARN +285 include/linux/jump_label.h

bf5438fca2950b Jason Baron     2010-09-17  282  
c5905afb0ee655 Ingo Molnar     2012-02-24  283  static inline void static_key_slow_inc(struct static_key *key)
d430d3d7e646eb Jason Baron     2011-03-16  284  {
5cdda5117e125e Borislav Petkov 2017-10-18 @285  	STATIC_KEY_CHECK_USE(key);
d430d3d7e646eb Jason Baron     2011-03-16  286  	atomic_inc(&key->enabled);
d430d3d7e646eb Jason Baron     2011-03-16  287  }
bf5438fca2950b Jason Baron     2010-09-17  288  
c5905afb0ee655 Ingo Molnar     2012-02-24  289  static inline void static_key_slow_dec(struct static_key *key)
bf5438fca2950b Jason Baron     2010-09-17  290  {
5cdda5117e125e Borislav Petkov 2017-10-18  291  	STATIC_KEY_CHECK_USE(key);
d430d3d7e646eb Jason Baron     2011-03-16  292  	atomic_dec(&key->enabled);
bf5438fca2950b Jason Baron     2010-09-17  293  }
bf5438fca2950b Jason Baron     2010-09-17  294  
ce48c146495a1a Peter Zijlstra  2018-01-22  295  #define static_key_slow_inc_cpuslocked(key) static_key_slow_inc(key)
ce48c146495a1a Peter Zijlstra  2018-01-22  296  #define static_key_slow_dec_cpuslocked(key) static_key_slow_dec(key)
ce48c146495a1a Peter Zijlstra  2018-01-22  297  
4c3ef6d79328c0 Jason Baron     2010-09-17  298  static inline int jump_label_text_reserved(void *start, void *end)
4c3ef6d79328c0 Jason Baron     2010-09-17  299  {
4c3ef6d79328c0 Jason Baron     2010-09-17  300  	return 0;
4c3ef6d79328c0 Jason Baron     2010-09-17  301  }
4c3ef6d79328c0 Jason Baron     2010-09-17  302  
91bad2f8d30574 Jason Baron     2010-10-01  303  static inline void jump_label_lock(void) {}
91bad2f8d30574 Jason Baron     2010-10-01  304  static inline void jump_label_unlock(void) {}
91bad2f8d30574 Jason Baron     2010-10-01  305  
d430d3d7e646eb Jason Baron     2011-03-16  306  static inline int jump_label_apply_nops(struct module *mod)
d430d3d7e646eb Jason Baron     2011-03-16  307  {
d430d3d7e646eb Jason Baron     2011-03-16  308  	return 0;
d430d3d7e646eb Jason Baron     2011-03-16  309  }
b202952075f626 Gleb Natapov    2011-11-27  310  
e33886b38cc82a Peter Zijlstra  2015-07-24  311  static inline void static_key_enable(struct static_key *key)
e33886b38cc82a Peter Zijlstra  2015-07-24  312  {
5cdda5117e125e Borislav Petkov 2017-10-18  313  	STATIC_KEY_CHECK_USE(key);
e33886b38cc82a Peter Zijlstra  2015-07-24  314  
1dbb6704de91b1 Paolo Bonzini   2017-08-01  315  	if (atomic_read(&key->enabled) != 0) {
1dbb6704de91b1 Paolo Bonzini   2017-08-01 @316  		WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
1dbb6704de91b1 Paolo Bonzini   2017-08-01  317  		return;
1dbb6704de91b1 Paolo Bonzini   2017-08-01  318  	}
1dbb6704de91b1 Paolo Bonzini   2017-08-01  319  	atomic_set(&key->enabled, 1);
e33886b38cc82a Peter Zijlstra  2015-07-24  320  }
e33886b38cc82a Peter Zijlstra  2015-07-24  321  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
