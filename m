Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B374C4B7ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiBOW7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:59:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237901AbiBOW66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:58:58 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B22B91D0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644965926; x=1676501926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aVC1VWYu2/FOZnDI0tt4/RlhnPLtWk9kahE+Z9VUFDQ=;
  b=F1u0ymrKGLvzAKPqWDPJdsfvv6aE6j5xRfh+3k2CCBhDHOqtknX10wcx
   mkvltgyNS0Y7OoENfxKWIneh1HF90tpcX5vngC6xl8PaeL9b3klBZqEWe
   V6iG5b5N5IqoEVs4k+Ktfpac8PmL73wnfyTf2rN5BNfIYP/MwrjKWDK2V
   soUu16q12mLkzoF+oE6g24KWx3RE/UgaMEgBEPKgyQVSE6W/fBOyTf+oQ
   8Ukx6RHDqkvBcU64AXGCZ5VV4U/N5IMfFnqbDIoVgnjeBMennkDNPfNx8
   4vU1OcU18bVNxzqvENqi8Tiw90MBHfZhwigQ+kuS/z7gTfI6oN7ypFOcw
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="230435986"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="230435986"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 14:58:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="636179010"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2022 14:58:10 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK6lt-000A8D-Mp; Tue, 15 Feb 2022 22:58:09 +0000
Date:   Wed, 16 Feb 2022 06:57:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kasan: test: support async (again) and asymm modes for
 HW_TAGS
Message-ID: <202202160627.SICieucW-lkp@intel.com>
References: <51ae4a56205a41953971113ab2c264c7e2e5d969.1644938763.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51ae4a56205a41953971113ab2c264c7e2e5d969.1644938763.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.17-rc4 next-20220215]
[cannot apply to hnaz-mm/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/andrey-konovalov-linux-dev/kasan-test-support-async-again-and-asymm-modes-for-HW_TAGS/20220215-232923
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git d567f5db412ed52de0b3b3efca4a451263de6108
config: arm64-randconfig-r036-20220214 (https://download.01.org/0day-ci/archive/20220216/202202160627.SICieucW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 37f422f4ac31c8b8041c6b62065263314282dab6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/50334edb33a25643468715fbfc0e6d4a7d594432
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review andrey-konovalov-linux-dev/kasan-test-support-async-again-and-asymm-modes-for-HW_TAGS/20220215-232923
        git checkout 50334edb33a25643468715fbfc0e6d4a7d594432
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash mm/kasan/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/kasan/report.c:360:19: error: incomplete definition of type 'struct kunit_kasan_status'
           WRITE_ONCE(status->report_found, true);
                      ~~~~~~^
   include/asm-generic/rwonce.h:60:33: note: expanded from macro 'WRITE_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                                            ^
   include/linux/compiler_types.h:313:10: note: expanded from macro '__native_word'
           (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
                   ^
   include/linux/compiler_types.h:346:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                               ^~~~~~~~~
   include/linux/compiler_types.h:334:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
                                ^~~~~~~~~
   include/linux/compiler_types.h:326:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   mm/kasan/report.c:350:9: note: forward declaration of 'struct kunit_kasan_status'
           struct kunit_kasan_status *status;
                  ^
>> mm/kasan/report.c:360:19: error: incomplete definition of type 'struct kunit_kasan_status'
           WRITE_ONCE(status->report_found, true);
                      ~~~~~~^
   include/asm-generic/rwonce.h:60:33: note: expanded from macro 'WRITE_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                                            ^
   include/linux/compiler_types.h:313:39: note: expanded from macro '__native_word'
           (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
                                                ^
   include/linux/compiler_types.h:346:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                               ^~~~~~~~~
   include/linux/compiler_types.h:334:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
                                ^~~~~~~~~
   include/linux/compiler_types.h:326:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   mm/kasan/report.c:350:9: note: forward declaration of 'struct kunit_kasan_status'
           struct kunit_kasan_status *status;
                  ^
>> mm/kasan/report.c:360:19: error: incomplete definition of type 'struct kunit_kasan_status'
           WRITE_ONCE(status->report_found, true);
                      ~~~~~~^
   include/asm-generic/rwonce.h:60:33: note: expanded from macro 'WRITE_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                                            ^
   include/linux/compiler_types.h:314:10: note: expanded from macro '__native_word'
            sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
                   ^
   include/linux/compiler_types.h:346:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                               ^~~~~~~~~
   include/linux/compiler_types.h:334:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
                                ^~~~~~~~~
   include/linux/compiler_types.h:326:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   mm/kasan/report.c:350:9: note: forward declaration of 'struct kunit_kasan_status'
           struct kunit_kasan_status *status;
                  ^
>> mm/kasan/report.c:360:19: error: incomplete definition of type 'struct kunit_kasan_status'
           WRITE_ONCE(status->report_found, true);
                      ~~~~~~^
   include/asm-generic/rwonce.h:60:33: note: expanded from macro 'WRITE_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                                            ^
   include/linux/compiler_types.h:314:38: note: expanded from macro '__native_word'
            sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
                                               ^
   include/linux/compiler_types.h:346:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                               ^~~~~~~~~
   include/linux/compiler_types.h:334:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
                                ^~~~~~~~~
   include/linux/compiler_types.h:326:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   mm/kasan/report.c:350:9: note: forward declaration of 'struct kunit_kasan_status'
           struct kunit_kasan_status *status;
                  ^
>> mm/kasan/report.c:360:19: error: incomplete definition of type 'struct kunit_kasan_status'
           WRITE_ONCE(status->report_found, true);
                      ~~~~~~^
   include/asm-generic/rwonce.h:60:33: note: expanded from macro 'WRITE_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   include/asm-generic/rwonce.h:36:48: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                                                         ^
   include/linux/compiler_types.h:346:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                               ^~~~~~~~~
   include/linux/compiler_types.h:334:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
                                ^~~~~~~~~
   include/linux/compiler_types.h:326:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   mm/kasan/report.c:350:9: note: forward declaration of 'struct kunit_kasan_status'
           struct kunit_kasan_status *status;
                  ^
>> mm/kasan/report.c:360:19: error: incomplete definition of type 'struct kunit_kasan_status'
           WRITE_ONCE(status->report_found, true);
                      ~~~~~~^
   include/asm-generic/rwonce.h:61:15: note: expanded from macro 'WRITE_ONCE'
           __WRITE_ONCE(x, val);                                           \
                        ^
   include/asm-generic/rwonce.h:55:20: note: expanded from macro '__WRITE_ONCE'
           *(volatile typeof(x) *)&(x) = (val);                            \
                             ^
   mm/kasan/report.c:350:9: note: forward declaration of 'struct kunit_kasan_status'
           struct kunit_kasan_status *status;
                  ^
>> mm/kasan/report.c:360:19: error: incomplete definition of type 'struct kunit_kasan_status'
           WRITE_ONCE(status->report_found, true);
                      ~~~~~~^
   include/asm-generic/rwonce.h:61:15: note: expanded from macro 'WRITE_ONCE'
           __WRITE_ONCE(x, val);                                           \
                        ^
   include/asm-generic/rwonce.h:55:27: note: expanded from macro '__WRITE_ONCE'
           *(volatile typeof(x) *)&(x) = (val);                            \
                                    ^
   mm/kasan/report.c:350:9: note: forward declaration of 'struct kunit_kasan_status'
           struct kunit_kasan_status *status;
                  ^
   mm/kasan/report.c:361:19: error: incomplete definition of type 'struct kunit_kasan_status'
           WRITE_ONCE(status->sync_fault, sync);
                      ~~~~~~^
   include/asm-generic/rwonce.h:60:33: note: expanded from macro 'WRITE_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                                            ^
   include/linux/compiler_types.h:313:10: note: expanded from macro '__native_word'
           (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
                   ^
   include/linux/compiler_types.h:346:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                               ^~~~~~~~~
   include/linux/compiler_types.h:334:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
                                ^~~~~~~~~
   include/linux/compiler_types.h:326:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   mm/kasan/report.c:350:9: note: forward declaration of 'struct kunit_kasan_status'
           struct kunit_kasan_status *status;
                  ^
   mm/kasan/report.c:361:19: error: incomplete definition of type 'struct kunit_kasan_status'
           WRITE_ONCE(status->sync_fault, sync);
                      ~~~~~~^
   include/asm-generic/rwonce.h:60:33: note: expanded from macro 'WRITE_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                                            ^
   include/linux/compiler_types.h:313:39: note: expanded from macro '__native_word'
           (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
                                                ^
   include/linux/compiler_types.h:346:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                               ^~~~~~~~~
   include/linux/compiler_types.h:334:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
                                ^~~~~~~~~
   include/linux/compiler_types.h:326:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   mm/kasan/report.c:350:9: note: forward declaration of 'struct kunit_kasan_status'
           struct kunit_kasan_status *status;
                  ^
   mm/kasan/report.c:361:19: error: incomplete definition of type 'struct kunit_kasan_status'
           WRITE_ONCE(status->sync_fault, sync);
                      ~~~~~~^
   include/asm-generic/rwonce.h:60:33: note: expanded from macro 'WRITE_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                                            ^
   include/linux/compiler_types.h:314:10: note: expanded from macro '__native_word'
            sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
                   ^
   include/linux/compiler_types.h:346:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                               ^~~~~~~~~
   include/linux/compiler_types.h:334:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
                                ^~~~~~~~~
   include/linux/compiler_types.h:326:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   mm/kasan/report.c:350:9: note: forward declaration of 'struct kunit_kasan_status'
           struct kunit_kasan_status *status;
                  ^
   mm/kasan/report.c:361:19: error: incomplete definition of type 'struct kunit_kasan_status'
           WRITE_ONCE(status->sync_fault, sync);
                      ~~~~~~^
   include/asm-generic/rwonce.h:60:33: note: expanded from macro 'WRITE_ONCE'
           compiletime_assert_rwonce_type(x);                              \
                                          ^
   include/asm-generic/rwonce.h:36:35: note: expanded from macro 'compiletime_assert_rwonce_type'
           compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
                                            ^
   include/linux/compiler_types.h:314:38: note: expanded from macro '__native_word'
            sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
                                               ^
   include/linux/compiler_types.h:346:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                               ^~~~~~~~~
   include/linux/compiler_types.h:334:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)


vim +360 mm/kasan/report.c

   345	
   346	#if IS_ENABLED(CONFIG_KUNIT)
   347	static void kasan_update_kunit_status(struct kunit *cur_test, bool sync)
   348	{
   349		struct kunit_resource *resource;
   350		struct kunit_kasan_status *status;
   351	
   352		resource = kunit_find_named_resource(cur_test, "kasan_status");
   353	
   354		if (!resource) {
   355			kunit_set_failure(cur_test);
   356			return;
   357		}
   358	
   359		status = (struct kunit_kasan_status *)resource->data;
 > 360		WRITE_ONCE(status->report_found, true);
   361		WRITE_ONCE(status->sync_fault, sync);
   362		kunit_put_resource(resource);
   363	}
   364	#endif /* IS_ENABLED(CONFIG_KUNIT) */
   365	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
