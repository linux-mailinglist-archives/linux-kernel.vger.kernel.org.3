Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A894B7B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244868AbiBOXtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:49:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244857AbiBOXtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:49:31 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A65D5F56
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644968959; x=1676504959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xk2VuQ6HTJ8skldNRO8iaX1TEhPx7lxFF06ro5m68sw=;
  b=RR5sg4k95ap0j6VuPoV/O2D5hMZcmvwWlxTqSTIz8qwzBYa+QsGRwHL+
   YjbX8gInUtFjAKqYmFzNi+mPePmOWEL3UUaV8eJFWNM2IRNBxps0PcmIf
   V4H1e0RbpAw9In77SwWfXF+hR2XLgi9f3ojd+fJBT6hXNOQ3piDUnHCat
   vN8RIyl55OuV8VWf8Kq45S6FdexxJyPBX2TPj9k98BHNepqB0Y/hQaIgn
   cBQqfzO4iL5Qlr1nBgO6ES+C60nvEw7VyGpg5qufg0GhTNqQG79xG1N4Y
   V6lrU8lalYv//3wS8Tjpq0Dq2GFe6WtZ7ROeSa9UVDyvJdMUa3kwpqBS3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="231112037"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="231112037"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 15:49:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="588014904"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 Feb 2022 15:49:15 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK7ZK-000A9l-SR; Tue, 15 Feb 2022 23:49:14 +0000
Date:   Wed, 16 Feb 2022 07:48:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
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
Message-ID: <202202160721.IhkGJaXa-lkp@intel.com>
References: <51ae4a56205a41953971113ab2c264c7e2e5d969.1644938763.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51ae4a56205a41953971113ab2c264c7e2e5d969.1644938763.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220216/202202160721.IhkGJaXa-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/50334edb33a25643468715fbfc0e6d4a7d594432
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review andrey-konovalov-linux-dev/kasan-test-support-async-again-and-asymm-modes-for-HW_TAGS/20220215-232923
        git checkout 50334edb33a25643468715fbfc0e6d4a7d594432
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash lib// mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   mm/kasan/report.c: In function 'kasan_update_kunit_status':
>> mm/kasan/report.c:360:26: error: invalid use of undefined type 'struct kunit_kasan_status'
     360 |         WRITE_ONCE(status->report_found, true);
         |                          ^~
   include/linux/compiler_types.h:326:23: note: in definition of macro '__compiletime_assert'
     326 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/kasan/report.c:360:9: note: in expansion of macro 'WRITE_ONCE'
     360 |         WRITE_ONCE(status->report_found, true);
         |         ^~~~~~~~~~
>> mm/kasan/report.c:360:26: error: invalid use of undefined type 'struct kunit_kasan_status'
     360 |         WRITE_ONCE(status->report_found, true);
         |                          ^~
   include/linux/compiler_types.h:326:23: note: in definition of macro '__compiletime_assert'
     326 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/kasan/report.c:360:9: note: in expansion of macro 'WRITE_ONCE'
     360 |         WRITE_ONCE(status->report_found, true);
         |         ^~~~~~~~~~
>> mm/kasan/report.c:360:26: error: invalid use of undefined type 'struct kunit_kasan_status'
     360 |         WRITE_ONCE(status->report_found, true);
         |                          ^~
   include/linux/compiler_types.h:326:23: note: in definition of macro '__compiletime_assert'
     326 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/kasan/report.c:360:9: note: in expansion of macro 'WRITE_ONCE'
     360 |         WRITE_ONCE(status->report_found, true);
         |         ^~~~~~~~~~
>> mm/kasan/report.c:360:26: error: invalid use of undefined type 'struct kunit_kasan_status'
     360 |         WRITE_ONCE(status->report_found, true);
         |                          ^~
   include/linux/compiler_types.h:326:23: note: in definition of macro '__compiletime_assert'
     326 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/kasan/report.c:360:9: note: in expansion of macro 'WRITE_ONCE'
     360 |         WRITE_ONCE(status->report_found, true);
         |         ^~~~~~~~~~
>> mm/kasan/report.c:360:26: error: invalid use of undefined type 'struct kunit_kasan_status'
     360 |         WRITE_ONCE(status->report_found, true);
         |                          ^~
   include/linux/compiler_types.h:326:23: note: in definition of macro '__compiletime_assert'
     326 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/kasan/report.c:360:9: note: in expansion of macro 'WRITE_ONCE'
     360 |         WRITE_ONCE(status->report_found, true);
         |         ^~~~~~~~~~
   In file included from ./arch/arm/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:255,
                    from include/linux/build_bug.h:5,
                    from include/linux/bits.h:22,
                    from include/linux/bitops.h:6,
                    from mm/kasan/report.c:12:
>> mm/kasan/report.c:360:26: error: invalid use of undefined type 'struct kunit_kasan_status'
     360 |         WRITE_ONCE(status->report_found, true);
         |                          ^~
   include/asm-generic/rwonce.h:55:27: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                           ^
   mm/kasan/report.c:360:9: note: in expansion of macro 'WRITE_ONCE'
     360 |         WRITE_ONCE(status->report_found, true);
         |         ^~~~~~~~~~
>> mm/kasan/report.c:360:26: error: invalid use of undefined type 'struct kunit_kasan_status'
     360 |         WRITE_ONCE(status->report_found, true);
         |                          ^~
   include/asm-generic/rwonce.h:55:34: note: in definition of macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                  ^
   mm/kasan/report.c:360:9: note: in expansion of macro 'WRITE_ONCE'
     360 |         WRITE_ONCE(status->report_found, true);
         |         ^~~~~~~~~~
   In file included from <command-line>:
   mm/kasan/report.c:361:26: error: invalid use of undefined type 'struct kunit_kasan_status'
     361 |         WRITE_ONCE(status->sync_fault, sync);
         |                          ^~
   include/linux/compiler_types.h:326:23: note: in definition of macro '__compiletime_assert'
     326 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/kasan/report.c:361:9: note: in expansion of macro 'WRITE_ONCE'
     361 |         WRITE_ONCE(status->sync_fault, sync);
         |         ^~~~~~~~~~
   mm/kasan/report.c:361:26: error: invalid use of undefined type 'struct kunit_kasan_status'
     361 |         WRITE_ONCE(status->sync_fault, sync);
         |                          ^~
   include/linux/compiler_types.h:326:23: note: in definition of macro '__compiletime_assert'
     326 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/kasan/report.c:361:9: note: in expansion of macro 'WRITE_ONCE'
     361 |         WRITE_ONCE(status->sync_fault, sync);
         |         ^~~~~~~~~~
   mm/kasan/report.c:361:26: error: invalid use of undefined type 'struct kunit_kasan_status'
     361 |         WRITE_ONCE(status->sync_fault, sync);
         |                          ^~
   include/linux/compiler_types.h:326:23: note: in definition of macro '__compiletime_assert'
     326 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/kasan/report.c:361:9: note: in expansion of macro 'WRITE_ONCE'
     361 |         WRITE_ONCE(status->sync_fault, sync);
         |         ^~~~~~~~~~
   mm/kasan/report.c:361:26: error: invalid use of undefined type 'struct kunit_kasan_status'
     361 |         WRITE_ONCE(status->sync_fault, sync);
         |                          ^~
   include/linux/compiler_types.h:326:23: note: in definition of macro '__compiletime_assert'
     326 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:60:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      60 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/kasan/report.c:361:9: note: in expansion of macro 'WRITE_ONCE'
     361 |         WRITE_ONCE(status->sync_fault, sync);
         |         ^~~~~~~~~~
   mm/kasan/report.c:361:26: error: invalid use of undefined type 'struct kunit_kasan_status'
     361 |         WRITE_ONCE(status->sync_fault, sync);
         |                          ^~
   include/linux/compiler_types.h:326:23: note: in definition of macro '__compiletime_assert'
     326 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
--
   lib/test_kasan.c: In function 'kasan_test_init':
>> lib/test_kasan.c:56:20: error: invalid use of undefined type 'struct kunit_kasan_status'
      56 |         test_status.report_found = false;
         |                    ^
   lib/test_kasan.c:57:20: error: invalid use of undefined type 'struct kunit_kasan_status'
      57 |         test_status.sync_fault = false;
         |                    ^
   In file included from lib/test_kasan.c:25:
   lib/test_kasan.c: In function 'kasan_test_exit':
   lib/test_kasan.c:66:45: error: invalid use of undefined type 'struct kunit_kasan_status'
      66 |         KUNIT_EXPECT_FALSE(test, test_status.report_found);
         |                                             ^
   include/kunit/test.h:782:28: note: in definition of macro 'KUNIT_ASSERTION'
     782 |                            pass,                                               \
         |                            ^~~~
   include/kunit/test.h:841:9: note: in expansion of macro 'KUNIT_UNARY_ASSERTION'
     841 |         KUNIT_UNARY_ASSERTION(test,                                            \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:849:9: note: in expansion of macro 'KUNIT_FALSE_MSG_ASSERTION'
     849 |         KUNIT_FALSE_MSG_ASSERTION(test, assert_type, condition, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1341:9: note: in expansion of macro 'KUNIT_FALSE_ASSERTION'
    1341 |         KUNIT_FALSE_ASSERTION(test, KUNIT_EXPECTATION, condition)
         |         ^~~~~~~~~~~~~~~~~~~~~
   lib/test_kasan.c:66:9: note: in expansion of macro 'KUNIT_EXPECT_FALSE'
      66 |         KUNIT_EXPECT_FALSE(test, test_status.report_found);
         |         ^~~~~~~~~~~~~~~~~~
   lib/test_kasan.c: In function 'kmalloc_oob_right':
   lib/test_kasan.c:94:55: error: invalid use of undefined type 'struct kunit_kasan_status'
      94 |         KUNIT_EXPECT_FALSE(test, READ_ONCE(test_status.report_found));  \
         |                                                       ^
   include/kunit/test.h:782:28: note: in definition of macro 'KUNIT_ASSERTION'
     782 |                            pass,                                               \
         |                            ^~~~
   include/kunit/test.h:841:9: note: in expansion of macro 'KUNIT_UNARY_ASSERTION'
     841 |         KUNIT_UNARY_ASSERTION(test,                                            \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:849:9: note: in expansion of macro 'KUNIT_FALSE_MSG_ASSERTION'
     849 |         KUNIT_FALSE_MSG_ASSERTION(test, assert_type, condition, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1341:9: note: in expansion of macro 'KUNIT_FALSE_ASSERTION'
    1341 |         KUNIT_FALSE_ASSERTION(test, KUNIT_EXPECTATION, condition)
         |         ^~~~~~~~~~~~~~~~~~~~~
   lib/test_kasan.c:94:9: note: in expansion of macro 'KUNIT_EXPECT_FALSE'
      94 |         KUNIT_EXPECT_FALSE(test, READ_ONCE(test_status.report_found));  \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:334:9: note: in expansion of macro '__compiletime_assert'
     334 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/test_kasan.c:94:34: note: in expansion of macro 'READ_ONCE'
      94 |         KUNIT_EXPECT_FALSE(test, READ_ONCE(test_status.report_found));  \
         |                                  ^~~~~~~~~
   lib/test_kasan.c:138:17: note: in expansion of macro 'KUNIT_EXPECT_KASAN_FAIL'
     138 |                 KUNIT_EXPECT_KASAN_FAIL(test, ptr[size] = 'x');
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   lib/test_kasan.c:94:55: error: invalid use of undefined type 'struct kunit_kasan_status'
      94 |         KUNIT_EXPECT_FALSE(test, READ_ONCE(test_status.report_found));  \
         |                                                       ^
   include/kunit/test.h:782:28: note: in definition of macro 'KUNIT_ASSERTION'
     782 |                            pass,                                               \
         |                            ^~~~
   include/kunit/test.h:841:9: note: in expansion of macro 'KUNIT_UNARY_ASSERTION'
     841 |         KUNIT_UNARY_ASSERTION(test,                                            \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:849:9: note: in expansion of macro 'KUNIT_FALSE_MSG_ASSERTION'
     849 |         KUNIT_FALSE_MSG_ASSERTION(test, assert_type, condition, NULL)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/kunit/test.h:1341:9: note: in expansion of macro 'KUNIT_FALSE_ASSERTION'
    1341 |         KUNIT_FALSE_ASSERTION(test, KUNIT_EXPECTATION, condition)
         |         ^~~~~~~~~~~~~~~~~~~~~
   lib/test_kasan.c:94:9: note: in expansion of macro 'KUNIT_EXPECT_FALSE'
      94 |         KUNIT_EXPECT_FALSE(test, READ_ONCE(test_status.report_found));  \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:334:9: note: in expansion of macro '__compiletime_assert'
     334 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:346:9: note: in expansion of macro '_compiletime_assert'
     346 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/test_kasan.c:94:34: note: in expansion of macro 'READ_ONCE'
      94 |         KUNIT_EXPECT_FALSE(test, READ_ONCE(test_status.report_found));  \


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
