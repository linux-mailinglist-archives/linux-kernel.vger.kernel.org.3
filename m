Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF37E5AB6CD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiIBQtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiIBQtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:49:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38D4F8F4D;
        Fri,  2 Sep 2022 09:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662137357; x=1693673357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8jceYqSMM1mSRJOm2IjtDyQSO41olBSWM0IT8mqUseg=;
  b=iRkja0qxyT/wGwBpjRKE+5nFMb2ibPE7mmQAO/U2rU/wn69A7moQUvCo
   UCxG94S2ChLIVs5rFwzhaj5i2l2yQVPQDIC4aTefDTUfP3YDQEzQI3bwj
   8/Vxr67z4WIe2Ge4417vFoNTBOyl1zdc818AqaRPuUA3EUB7JuFOEPAHV
   r7x5aDwM3b7eUz/CGria+iTfd5yodkeRYSGLhyCLI1xwfkfq3n52OKYKT
   epy7cWvUEprvTl+JVP1oWvGSYNss50zDlzworzjABwOxssk3h2OIvh5Oi
   RhR+Vdx7iwgrTw0IqnZDcQN/jal+pT23+waaHzn9p5ECH2j/2+Q4JWhy3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="357736058"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="357736058"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 09:49:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="941350390"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 02 Sep 2022 09:49:08 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oU9qt-0000K3-1d;
        Fri, 02 Sep 2022 16:49:07 +0000
Date:   Sat, 3 Sep 2022 00:48:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org, vineeth@bitbyteword.org, boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: [PATCH v5 08/18] rcu: Add per-CB tracing for queuing, flush and
 invocation.
Message-ID: <202209030052.20CJhjTX-lkp@intel.com>
References: <20220901221720.1105021-9-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901221720.1105021-9-joel@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Joel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on paulmck-rcu/dev]
[also build test ERROR on pcmoore-selinux/next drm-intel/for-linux-next linus/master v6.0-rc3]
[cannot apply to vbabka-slab/for-next rostedt-trace/for-next tip/timers/core next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joel-Fernandes-Google/Implement-call_rcu_lazy-and-miscellaneous-fixes/20220902-062156
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220903/202209030052.20CJhjTX-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c0f09b1d42d06649680f74a78ca363e7f1c158b2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Joel-Fernandes-Google/Implement-call_rcu_lazy-and-miscellaneous-fixes/20220902-062156
        git checkout c0f09b1d42d06649680f74a78ca363e7f1c158b2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'dst_hold',
       inlined from 'dst_clone' at include/net/dst.h:251:3,
       inlined from '__skb_dst_copy' at include/net/dst.h:284:3,
       inlined from 'ovs_vport_output' at net/openvswitch/actions.c:787:2:
>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
     335 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
     230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
         |         ^~~~~~~~~~~~
   In function 'dst_hold',
       inlined from 'execute_set_action' at net/openvswitch/actions.c:1093:3,
       inlined from 'do_execute_actions' at net/openvswitch/actions.c:1377:10:
>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
     335 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
     230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
         |         ^~~~~~~~~~~~
--
   In file included from <command-line>:
   In function 'dst_hold',
       inlined from 'dst_hold_and_use' at include/net/dst.h:244:2,
       inlined from 'dn_insert_route.constprop.isra' at net/decnet/dn_route.c:334:4:
>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
     335 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
     230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
         |         ^~~~~~~~~~~~
   In function 'dst_hold',
       inlined from 'dst_hold_and_use' at include/net/dst.h:244:2,
       inlined from 'dn_insert_route.constprop.isra' at net/decnet/dn_route.c:347:2:
>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
     335 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
     230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
         |         ^~~~~~~~~~~~
   In function 'dst_hold',
       inlined from 'dst_hold_and_use' at include/net/dst.h:244:2,
       inlined from 'dn_route_input' at net/decnet/dn_route.c:1535:4:
>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
     335 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
     230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
         |         ^~~~~~~~~~~~
   In function 'dst_hold',
       inlined from 'dst_hold_and_use' at include/net/dst.h:244:2,
       inlined from '__dn_route_output_key.isra' at net/decnet/dn_route.c:1257:5:
>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
     335 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
     230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
         |         ^~~~~~~~~~~~
   In function 'dst_hold',
       inlined from 'dst_clone' at include/net/dst.h:251:3,
       inlined from 'dn_cache_dump' at net/decnet/dn_route.c:1752:4:
>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
     335 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
     230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
         |         ^~~~~~~~~~~~
--
   In file included from <command-line>:
   In function 'dst_hold',
       inlined from 'dst_clone' at include/net/dst.h:251:3,
       inlined from 'ip6_copy_metadata' at net/ipv6/ip6_output.c:654:2:
>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
     335 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
     230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
         |         ^~~~~~~~~~~~
   In function 'dst_hold',
       inlined from 'ip6_append_data' at net/ipv6/ip6_output.c:1838:3:
>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
     335 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
     230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
         |         ^~~~~~~~~~~~
   In function 'dst_hold',
       inlined from 'dst_clone' at include/net/dst.h:251:3,
       inlined from 'ip6_sk_dst_lookup_flow' at net/ipv6/ip6_output.c:1262:3:
>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
     335 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
     230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
         |         ^~~~~~~~~~~~
--
   In file included from <command-line>:
   In function 'dst_hold',
       inlined from 'dst_clone' at include/net/dst.h:251:3,
       inlined from '__skb_dst_copy' at include/net/dst.h:284:3,
       inlined from 'skb_dst_copy' at include/net/dst.h:289:2,
       inlined from 'ip6_list_rcv_finish.constprop' at net/ipv6/ip6_input.c:128:4:
>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
     335 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
     230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_490 +354 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  340  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  341  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  342  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  343  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  344  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  345   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  346   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  347   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  348   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  349   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  350   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  351   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  352   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  353  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @354  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  355  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
