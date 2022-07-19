Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634B7579197
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbiGSEDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiGSEDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:03:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BFC2BB3F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658203428; x=1689739428;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=k6xew0vBEET7pgohrBFZhssaEPBwElRmvZixY6k2Uf0=;
  b=TPA/HS3eZYxve+a4OCF6ajNoPxal186fv8CF3LiEqIzJyQ+O3/fM1UL5
   gLFEpa1DNNUJC5GS/yWxW17PelIZ8X2cAmp0nvqf1tyc2cqN7OnbvGjUx
   chCnTEKmLOdYgXEQFYQ94EpXQJ97N30MqFBqU0C7Fxavt+I87UyU3PjdG
   HaD7JNtIS0X/LsWfgXJqiMFlXcAr5NehUb8kb5MKoS6adlHpZ27sREh+0
   snqli0Xenscb6JmK2ETLd4Yh0DxlOec06UGvfhDj+V3LGj7cTMFGGZqMI
   4J468sdlbS9f1sWe1Lzg8y7DecxtdgE1rrJm4VssCJYTP4RNw/6NJ6sxj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="350347728"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="350347728"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 21:02:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="630170031"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 18 Jul 2022 21:02:33 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDeRM-0005FK-Ls;
        Tue, 19 Jul 2022 04:02:32 +0000
Date:   Tue, 19 Jul 2022 12:01:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: futex_wait_wouldblock.c:47:34: warning: excess elements in struct
 initializer
Message-ID: <202207191106.c5cbgZFs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ca85855bdcae8f84f1512e88b4c75009ea17ea2f
commit: 9d57f7c79748920636f8293d2f01192d702fe390 selftests: futex: Test sys_futex_waitv() wouldblock
date:   10 months ago
reproduce: make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from futex_wait_wouldblock.c:25:
   ../include/futex2test.h:18:47: warning: 'struct futex_waitv' declared inside parameter list will not be visible outside of this definition or declaration
      18 | static inline int futex_waitv(volatile struct futex_waitv *waiters, unsigned long nr_waiters,
         |                                               ^~~~~~~~~~~
   ../include/futex2test.h: In function 'futex_waitv':
   ../include/futex2test.h:21:24: error: '__NR_futex_waitv' undeclared (first use in this function); did you mean 'futex_waitv'?
      21 |         return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
         |                        ^~~~~~~~~~~~~~~~
         |                        futex_waitv
   ../include/futex2test.h:21:24: note: each undeclared identifier is reported only once for each function it appears in
   futex_wait_wouldblock.c: In function 'main':
   futex_wait_wouldblock.c:46:16: error: variable 'waitv' has initializer but incomplete type
      46 |         struct futex_waitv waitv = {
         |                ^~~~~~~~~~~
   futex_wait_wouldblock.c:47:26: error: 'struct futex_waitv' has no member named 'uaddr'
      47 |                         .uaddr = (uintptr_t)&f1,
         |                          ^~~~~
>> futex_wait_wouldblock.c:47:34: warning: excess elements in struct initializer
      47 |                         .uaddr = (uintptr_t)&f1,
         |                                  ^
   futex_wait_wouldblock.c:47:34: note: (near initialization for 'waitv')
   futex_wait_wouldblock.c:48:26: error: 'struct futex_waitv' has no member named 'val'
      48 |                         .val = f1+1,
         |                          ^~~
   futex_wait_wouldblock.c:48:32: warning: excess elements in struct initializer
      48 |                         .val = f1+1,
         |                                ^~
   futex_wait_wouldblock.c:48:32: note: (near initialization for 'waitv')
   futex_wait_wouldblock.c:49:26: error: 'struct futex_waitv' has no member named 'flags'
      49 |                         .flags = FUTEX_32,
         |                          ^~~~~
   futex_wait_wouldblock.c:49:34: error: 'FUTEX_32' undeclared (first use in this function); did you mean 'FUTEX_OP'?
      49 |                         .flags = FUTEX_32,
         |                                  ^~~~~~~~
         |                                  FUTEX_OP
   futex_wait_wouldblock.c:49:34: warning: excess elements in struct initializer
   futex_wait_wouldblock.c:49:34: note: (near initialization for 'waitv')
   futex_wait_wouldblock.c:50:26: error: 'struct futex_waitv' has no member named '__reserved'
      50 |                         .__reserved = 0
         |                          ^~~~~~~~~~
   futex_wait_wouldblock.c:50:39: warning: excess elements in struct initializer
      50 |                         .__reserved = 0
         |                                       ^
   futex_wait_wouldblock.c:50:39: note: (near initialization for 'waitv')
   futex_wait_wouldblock.c:46:28: error: storage size of 'waitv' isn't known
      46 |         struct futex_waitv waitv = {
         |                            ^~~~~
>> futex_wait_wouldblock.c:46:28: warning: unused variable 'waitv' [-Wunused-variable]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
