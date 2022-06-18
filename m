Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F288C55037A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 10:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiFRIRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 04:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiFRIRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 04:17:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7B15F8F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 01:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655540232; x=1687076232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=loNvwNLk3aAAZlD5birYA6nAQLL7AUhBg/Y8RvgLrz4=;
  b=k1eoaALsqRVwEPidRPm4VSZFNLU5F3XAEI1Va/+bX9fXhgQpiXtIEG4f
   NSpNxbgKxp6cxfZi1J2+S1eQvxpHj6Vc+SpuxpqivT1HXTFVWHWapjlhD
   x9hqEICLxEk4M9/r/99c+J9yvVgG4Z5vU/IZYX22BWKHnEYJDSxQ/DYny
   TtHYEpfCX/Hyf1aWysV+LLpHiLhRFAVm2RGZS12QrSXR18/u0TBKKdH/M
   QXbLXl2+wNDFWaG96TlNAyOvCzSg9psnbFfdSJ6Tgjgm8shtGxubCvYOR
   e87DQ7bUnWVKsHcchS9U6XDzukojMLNf9jMRstAjJdRAGhaXL60BUml+t
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="279678096"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="279678096"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2022 01:17:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="613804850"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2022 01:17:09 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2Tdk-000Q9N-TH;
        Sat, 18 Jun 2022 08:17:08 +0000
Date:   Sat, 18 Jun 2022 16:16:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Latypov <dlatypov@google.com>, mark.rutland@arm.com,
        boqun.feng@gmail.com
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, peterz@infradead.org,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] lib/atomic64_test.c: convert to use KUnit
Message-ID: <202206181607.somVaD8p-lkp@intel.com>
References: <20220616180430.930721-1-dlatypov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616180430.930721-1-dlatypov@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 8ab2afa23bd197df47819a87f0265c0ac95c5b6a]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Latypov/lib-atomic64_test-c-convert-to-use-KUnit/20220617-020546
base:   8ab2afa23bd197df47819a87f0265c0ac95c5b6a
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220618/202206181607.somVaD8p-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/acffbe860bc2206b4cef16408809b9f558a24465
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Latypov/lib-atomic64_test-c-convert-to-use-KUnit/20220617-020546
        git checkout acffbe860bc2206b4cef16408809b9f558a24465
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   lib/atomic64_test.c: In function 'test_atomic64':
>> lib/atomic64_test.c:241:1: warning: the frame size of 3920 bytes is larger than 2048 bytes [-Wframe-larger-than=]
     241 | }
         | ^
   lib/atomic64_test.c: In function 'test_atomic':
   lib/atomic64_test.c:138:1: warning: the frame size of 3520 bytes is larger than 2048 bytes [-Wframe-larger-than=]
     138 | }
         | ^


vim +241 lib/atomic64_test.c

41b9e9fcc1c44b Peter Zijlstra   2015-07-13  139  
86a8938078a8bb Luca Barbieri    2010-02-24  140  #define INIT(c) do { atomic64_set(&v, c); r = c; } while (0)
acffbe860bc220 Daniel Latypov   2022-06-16  141  static void test_atomic64(struct kunit *test)
86a8938078a8bb Luca Barbieri    2010-02-24  142  {
86a8938078a8bb Luca Barbieri    2010-02-24  143  	long long v0 = 0xaaa31337c001d00dLL;
86a8938078a8bb Luca Barbieri    2010-02-24  144  	long long v1 = 0xdeadbeefdeafcafeLL;
86a8938078a8bb Luca Barbieri    2010-02-24  145  	long long v2 = 0xfaceabadf00df001LL;
ffba19ccae8d98 Michael Ellerman 2017-07-14  146  	long long v3 = 0x8000000000000000LL;
86a8938078a8bb Luca Barbieri    2010-02-24  147  	long long onestwos = 0x1111111122222222LL;
86a8938078a8bb Luca Barbieri    2010-02-24  148  	long long one = 1LL;
ffba19ccae8d98 Michael Ellerman 2017-07-14  149  	int r_int;
86a8938078a8bb Luca Barbieri    2010-02-24  150  
86a8938078a8bb Luca Barbieri    2010-02-24  151  	atomic64_t v = ATOMIC64_INIT(v0);
86a8938078a8bb Luca Barbieri    2010-02-24  152  	long long r = v0;
acffbe860bc220 Daniel Latypov   2022-06-16  153  	KUNIT_ASSERT_EQ(test, v.counter, r);
86a8938078a8bb Luca Barbieri    2010-02-24  154  
86a8938078a8bb Luca Barbieri    2010-02-24  155  	atomic64_set(&v, v1);
86a8938078a8bb Luca Barbieri    2010-02-24  156  	r = v1;
acffbe860bc220 Daniel Latypov   2022-06-16  157  	KUNIT_ASSERT_EQ(test, v.counter, r);
acffbe860bc220 Daniel Latypov   2022-06-16  158  	KUNIT_ASSERT_EQ(test, atomic64_read(&v), r);
86a8938078a8bb Luca Barbieri    2010-02-24  159  
41b9e9fcc1c44b Peter Zijlstra   2015-07-13  160  	TEST(64, add, +=, onestwos);
41b9e9fcc1c44b Peter Zijlstra   2015-07-13  161  	TEST(64, add, +=, -one);
41b9e9fcc1c44b Peter Zijlstra   2015-07-13  162  	TEST(64, sub, -=, onestwos);
41b9e9fcc1c44b Peter Zijlstra   2015-07-13  163  	TEST(64, sub, -=, -one);
41b9e9fcc1c44b Peter Zijlstra   2015-07-13  164  	TEST(64, or, |=, v1);
41b9e9fcc1c44b Peter Zijlstra   2015-07-13  165  	TEST(64, and, &=, v1);
41b9e9fcc1c44b Peter Zijlstra   2015-07-13  166  	TEST(64, xor, ^=, v1);
41b9e9fcc1c44b Peter Zijlstra   2015-07-13  167  	TEST(64, andnot, &= ~, v1);
86a8938078a8bb Luca Barbieri    2010-02-24  168  
978e5a3692c3b6 Boqun Feng       2015-11-04  169  	RETURN_FAMILY_TEST(64, add_return, +=, onestwos);
978e5a3692c3b6 Boqun Feng       2015-11-04  170  	RETURN_FAMILY_TEST(64, add_return, +=, -one);
978e5a3692c3b6 Boqun Feng       2015-11-04  171  	RETURN_FAMILY_TEST(64, sub_return, -=, onestwos);
978e5a3692c3b6 Boqun Feng       2015-11-04  172  	RETURN_FAMILY_TEST(64, sub_return, -=, -one);
86a8938078a8bb Luca Barbieri    2010-02-24  173  
28aa2bda2211f4 Peter Zijlstra   2016-04-18  174  	FETCH_FAMILY_TEST(64, fetch_add, +=, onestwos);
28aa2bda2211f4 Peter Zijlstra   2016-04-18  175  	FETCH_FAMILY_TEST(64, fetch_add, +=, -one);
28aa2bda2211f4 Peter Zijlstra   2016-04-18  176  	FETCH_FAMILY_TEST(64, fetch_sub, -=, onestwos);
28aa2bda2211f4 Peter Zijlstra   2016-04-18  177  	FETCH_FAMILY_TEST(64, fetch_sub, -=, -one);
28aa2bda2211f4 Peter Zijlstra   2016-04-18  178  
28aa2bda2211f4 Peter Zijlstra   2016-04-18  179  	FETCH_FAMILY_TEST(64, fetch_or,  |=, v1);
28aa2bda2211f4 Peter Zijlstra   2016-04-18  180  	FETCH_FAMILY_TEST(64, fetch_and, &=, v1);
28aa2bda2211f4 Peter Zijlstra   2016-04-18  181  	FETCH_FAMILY_TEST(64, fetch_andnot, &= ~, v1);
28aa2bda2211f4 Peter Zijlstra   2016-04-18  182  	FETCH_FAMILY_TEST(64, fetch_xor, ^=, v1);
28aa2bda2211f4 Peter Zijlstra   2016-04-18  183  
86a8938078a8bb Luca Barbieri    2010-02-24  184  	INIT(v0);
86a8938078a8bb Luca Barbieri    2010-02-24  185  	atomic64_inc(&v);
86a8938078a8bb Luca Barbieri    2010-02-24  186  	r += one;
acffbe860bc220 Daniel Latypov   2022-06-16  187  	KUNIT_ASSERT_EQ(test, v.counter, r);
86a8938078a8bb Luca Barbieri    2010-02-24  188  
86a8938078a8bb Luca Barbieri    2010-02-24  189  	INIT(v0);
86a8938078a8bb Luca Barbieri    2010-02-24  190  	atomic64_dec(&v);
86a8938078a8bb Luca Barbieri    2010-02-24  191  	r -= one;
acffbe860bc220 Daniel Latypov   2022-06-16  192  	KUNIT_ASSERT_EQ(test, v.counter, r);
86a8938078a8bb Luca Barbieri    2010-02-24  193  
978e5a3692c3b6 Boqun Feng       2015-11-04  194  	INC_RETURN_FAMILY_TEST(64, v0);
978e5a3692c3b6 Boqun Feng       2015-11-04  195  	DEC_RETURN_FAMILY_TEST(64, v0);
86a8938078a8bb Luca Barbieri    2010-02-24  196  
978e5a3692c3b6 Boqun Feng       2015-11-04  197  	XCHG_FAMILY_TEST(64, v0, v1);
978e5a3692c3b6 Boqun Feng       2015-11-04  198  	CMPXCHG_FAMILY_TEST(64, v0, v1, v2);
86a8938078a8bb Luca Barbieri    2010-02-24  199  
86a8938078a8bb Luca Barbieri    2010-02-24  200  	INIT(v0);
acffbe860bc220 Daniel Latypov   2022-06-16  201  	KUNIT_ASSERT_FALSE(test, atomic64_add_unless(&v, one, v0));
acffbe860bc220 Daniel Latypov   2022-06-16  202  	KUNIT_ASSERT_EQ(test, v.counter, r);
86a8938078a8bb Luca Barbieri    2010-02-24  203  
86a8938078a8bb Luca Barbieri    2010-02-24  204  	INIT(v0);
acffbe860bc220 Daniel Latypov   2022-06-16  205  	KUNIT_ASSERT_TRUE(test, atomic64_add_unless(&v, one, v1));
86a8938078a8bb Luca Barbieri    2010-02-24  206  	r += one;
acffbe860bc220 Daniel Latypov   2022-06-16  207  	KUNIT_ASSERT_EQ(test, v.counter, r);
86a8938078a8bb Luca Barbieri    2010-02-24  208  
86a8938078a8bb Luca Barbieri    2010-02-24  209  	INIT(onestwos);
acffbe860bc220 Daniel Latypov   2022-06-16  210  	KUNIT_ASSERT_EQ(test, atomic64_dec_if_positive(&v), (onestwos - 1));
86a8938078a8bb Luca Barbieri    2010-02-24  211  	r -= one;
acffbe860bc220 Daniel Latypov   2022-06-16  212  	KUNIT_ASSERT_EQ(test, v.counter, r);
86a8938078a8bb Luca Barbieri    2010-02-24  213  
86a8938078a8bb Luca Barbieri    2010-02-24  214  	INIT(0);
acffbe860bc220 Daniel Latypov   2022-06-16  215  	KUNIT_ASSERT_EQ(test, atomic64_dec_if_positive(&v), -one);
acffbe860bc220 Daniel Latypov   2022-06-16  216  	KUNIT_ASSERT_EQ(test, v.counter, r);
86a8938078a8bb Luca Barbieri    2010-02-24  217  
86a8938078a8bb Luca Barbieri    2010-02-24  218  	INIT(-one);
acffbe860bc220 Daniel Latypov   2022-06-16  219  	KUNIT_ASSERT_EQ(test, atomic64_dec_if_positive(&v), (-one - one));
acffbe860bc220 Daniel Latypov   2022-06-16  220  	KUNIT_ASSERT_EQ(test, v.counter, r);
86a8938078a8bb Luca Barbieri    2010-02-24  221  
86a8938078a8bb Luca Barbieri    2010-02-24  222  	INIT(onestwos);
acffbe860bc220 Daniel Latypov   2022-06-16  223  	KUNIT_ASSERT_TRUE(test, atomic64_inc_not_zero(&v));
86a8938078a8bb Luca Barbieri    2010-02-24  224  	r += one;
acffbe860bc220 Daniel Latypov   2022-06-16  225  	KUNIT_ASSERT_EQ(test, v.counter, r);
86a8938078a8bb Luca Barbieri    2010-02-24  226  
86a8938078a8bb Luca Barbieri    2010-02-24  227  	INIT(0);
acffbe860bc220 Daniel Latypov   2022-06-16  228  	KUNIT_ASSERT_FALSE(test, atomic64_inc_not_zero(&v));
acffbe860bc220 Daniel Latypov   2022-06-16  229  	KUNIT_ASSERT_EQ(test, v.counter, r);
86a8938078a8bb Luca Barbieri    2010-02-24  230  
86a8938078a8bb Luca Barbieri    2010-02-24  231  	INIT(-one);
acffbe860bc220 Daniel Latypov   2022-06-16  232  	KUNIT_ASSERT_TRUE(test, atomic64_inc_not_zero(&v));
86a8938078a8bb Luca Barbieri    2010-02-24  233  	r += one;
acffbe860bc220 Daniel Latypov   2022-06-16  234  	KUNIT_ASSERT_EQ(test, v.counter, r);
ffba19ccae8d98 Michael Ellerman 2017-07-14  235  
ffba19ccae8d98 Michael Ellerman 2017-07-14  236  	/* Confirm the return value fits in an int, even if the value doesn't */
ffba19ccae8d98 Michael Ellerman 2017-07-14  237  	INIT(v3);
acffbe860bc220 Daniel Latypov   2022-06-16  238  
ffba19ccae8d98 Michael Ellerman 2017-07-14  239  	r_int = atomic64_inc_not_zero(&v);
acffbe860bc220 Daniel Latypov   2022-06-16  240  	KUNIT_ASSERT_NE(test, r_int, 0);
41b9e9fcc1c44b Peter Zijlstra   2015-07-13 @241  }
41b9e9fcc1c44b Peter Zijlstra   2015-07-13  242  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
