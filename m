Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69AB5ABF01
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 14:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiICMk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 08:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiICMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 08:40:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76172A253;
        Sat,  3 Sep 2022 05:39:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFF2D6147C;
        Sat,  3 Sep 2022 12:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1A3C433D6;
        Sat,  3 Sep 2022 12:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662208789;
        bh=0F0I2sqYEFYRNU2XAAmsZATQL/3mfPMgHTmULZG0OYc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jBe5Lf0FTb2EuhEluJ0Zo/l02nzIq6jNyXwDrcxUOd2DQMcIby8p1jpfrQGuM/EnX
         ur5M7qVayz7lj4gS7D92d0y3kT+mlzfC364vxYRH2UhhLAhx+BGOzrigHAXQus+Sg9
         1arjDOER2LY3CuaaZDUoclRP+Z+jBjwsSmDITJXMxxP60+/+bOjLvrBnowjroHJs2Q
         EsRwaZjptwC8FUFxqE67cdN2VOBSDguGlQ5HFVuietHgolIsB10uSxZkc7Dqpt7UNO
         b1lDm6Ckdz6WXUGacewKqtjRdpAgwHn5doc7gysV9W5T/LeMfl0eilslr/Qm1oh28r
         mHiJRQacSBk2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B2FBA5C0691; Sat,  3 Sep 2022 05:39:48 -0700 (PDT)
Date:   Sat, 3 Sep 2022 05:39:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        rostedt@goodmis.org, vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 08/18] rcu: Add per-CB tracing for queuing, flush and
 invocation.
Message-ID: <20220903123948.GP6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220901221720.1105021-9-joel@joelfernandes.org>
 <202209030052.20CJhjTX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209030052.20CJhjTX-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 12:48:28AM +0800, kernel test robot wrote:
> Hi "Joel,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on paulmck-rcu/dev]
> [also build test ERROR on pcmoore-selinux/next drm-intel/for-linux-next linus/master v6.0-rc3]
> [cannot apply to vbabka-slab/for-next rostedt-trace/for-next tip/timers/core next-20220901]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Joel-Fernandes-Google/Implement-call_rcu_lazy-and-miscellaneous-fixes/20220902-062156
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
> config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220903/202209030052.20CJhjTX-lkp@intel.com/config)
> compiler: mips-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/c0f09b1d42d06649680f74a78ca363e7f1c158b2
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Joel-Fernandes-Google/Implement-call_rcu_lazy-and-miscellaneous-fixes/20220902-062156
>         git checkout c0f09b1d42d06649680f74a78ca363e7f1c158b2
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from <command-line>:
>    In function 'dst_hold',
>        inlined from 'dst_clone' at include/net/dst.h:251:3,
>        inlined from '__skb_dst_copy' at include/net/dst.h:284:3,
>        inlined from 'ovs_vport_output' at net/openvswitch/actions.c:787:2:
> >> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                             ^
>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>      335 |                         prefix ## suffix();                             \
>          |                         ^~~~~~
>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>          |         ^~~~~~~~~~~~

This looks like fallout from the rcu_head structure changing size,
given that __refcnt comes after rcu_head on 32-bit systems.

It looks like the per-CB tracing code needs to be kept on the side for
the time being rather than being sent to -next (let alone mainline).

Any reason I cannot just move this one to the end of the stack, after
"fork: Move thread_stack_free_rcu() to call_rcu_lazy()"?

							Thanx, Paul

>    In function 'dst_hold',
>        inlined from 'execute_set_action' at net/openvswitch/actions.c:1093:3,
>        inlined from 'do_execute_actions' at net/openvswitch/actions.c:1377:10:
> >> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                             ^
>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>      335 |                         prefix ## suffix();                             \
>          |                         ^~~~~~
>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>          |         ^~~~~~~~~~~~
> --
>    In file included from <command-line>:
>    In function 'dst_hold',
>        inlined from 'dst_hold_and_use' at include/net/dst.h:244:2,
>        inlined from 'dn_insert_route.constprop.isra' at net/decnet/dn_route.c:334:4:
> >> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                             ^
>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>      335 |                         prefix ## suffix();                             \
>          |                         ^~~~~~
>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>          |         ^~~~~~~~~~~~
>    In function 'dst_hold',
>        inlined from 'dst_hold_and_use' at include/net/dst.h:244:2,
>        inlined from 'dn_insert_route.constprop.isra' at net/decnet/dn_route.c:347:2:
> >> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                             ^
>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>      335 |                         prefix ## suffix();                             \
>          |                         ^~~~~~
>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>          |         ^~~~~~~~~~~~
>    In function 'dst_hold',
>        inlined from 'dst_hold_and_use' at include/net/dst.h:244:2,
>        inlined from 'dn_route_input' at net/decnet/dn_route.c:1535:4:
> >> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                             ^
>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>      335 |                         prefix ## suffix();                             \
>          |                         ^~~~~~
>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>          |         ^~~~~~~~~~~~
>    In function 'dst_hold',
>        inlined from 'dst_hold_and_use' at include/net/dst.h:244:2,
>        inlined from '__dn_route_output_key.isra' at net/decnet/dn_route.c:1257:5:
> >> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                             ^
>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>      335 |                         prefix ## suffix();                             \
>          |                         ^~~~~~
>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>          |         ^~~~~~~~~~~~
>    In function 'dst_hold',
>        inlined from 'dst_clone' at include/net/dst.h:251:3,
>        inlined from 'dn_cache_dump' at net/decnet/dn_route.c:1752:4:
> >> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                             ^
>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>      335 |                         prefix ## suffix();                             \
>          |                         ^~~~~~
>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>          |         ^~~~~~~~~~~~
> --
>    In file included from <command-line>:
>    In function 'dst_hold',
>        inlined from 'dst_clone' at include/net/dst.h:251:3,
>        inlined from 'ip6_copy_metadata' at net/ipv6/ip6_output.c:654:2:
> >> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                             ^
>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>      335 |                         prefix ## suffix();                             \
>          |                         ^~~~~~
>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>          |         ^~~~~~~~~~~~
>    In function 'dst_hold',
>        inlined from 'ip6_append_data' at net/ipv6/ip6_output.c:1838:3:
> >> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                             ^
>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>      335 |                         prefix ## suffix();                             \
>          |                         ^~~~~~
>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>          |         ^~~~~~~~~~~~
>    In function 'dst_hold',
>        inlined from 'dst_clone' at include/net/dst.h:251:3,
>        inlined from 'ip6_sk_dst_lookup_flow' at net/ipv6/ip6_output.c:1262:3:
> >> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                             ^
>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>      335 |                         prefix ## suffix();                             \
>          |                         ^~~~~~
>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>          |         ^~~~~~~~~~~~
> --
>    In file included from <command-line>:
>    In function 'dst_hold',
>        inlined from 'dst_clone' at include/net/dst.h:251:3,
>        inlined from '__skb_dst_copy' at include/net/dst.h:284:3,
>        inlined from 'skb_dst_copy' at include/net/dst.h:289:2,
>        inlined from 'ip6_list_rcv_finish.constprop' at net/ipv6/ip6_input.c:128:4:
> >> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                             ^
>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>      335 |                         prefix ## suffix();                             \
>          |                         ^~~~~~
>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>          |         ^~~~~~~~~~~~
> 
> 
> vim +/__compiletime_assert_490 +354 include/linux/compiler_types.h
> 
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  340  
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  341  #define _compiletime_assert(condition, msg, prefix, suffix) \
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  342  	__compiletime_assert(condition, msg, prefix, suffix)
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  343  
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  344  /**
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  345   * compiletime_assert - break build and emit msg if condition is false
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  346   * @condition: a compile-time constant condition to check
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  347   * @msg:       a message to emit if condition is false
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  348   *
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  349   * In tradition of POSIX assert, this macro will break the build if the
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  350   * supplied condition is *false*, emitting the supplied error message if the
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  351   * compiler has support to do so.
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  352   */
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  353  #define compiletime_assert(condition, msg) \
> eb5c2d4b45e3d2 Will Deacon 2020-07-21 @354  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> eb5c2d4b45e3d2 Will Deacon 2020-07-21  355  
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
