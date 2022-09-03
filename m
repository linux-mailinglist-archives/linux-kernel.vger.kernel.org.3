Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27BB5ABF3A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 16:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiICOIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 10:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiICOIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 10:08:01 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837665C9C8
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 07:07:59 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id cv7so3502307qvb.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 07:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=N5mHPFUeu6W+4xftAPomM/lR8YlmKBbHWZy9Q1X/ztA=;
        b=Uyb4PSmMzr3aq20omk6NMAiGRKe84CMRX2G/fwKKCdl+J9fj6GXxo/2ozMBIq6x/DD
         X/ZzUMDrq6IwIH5u4ECmh43+GV89r7d5geCupd+zuLp+8T2P+mmoFhVycdIjmhoAqy4b
         GyJuwRtD7kzeUpHp0sxZDOALnAgb6lndMaQY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=N5mHPFUeu6W+4xftAPomM/lR8YlmKBbHWZy9Q1X/ztA=;
        b=XDk49nkXDp1trSSyTeyICpTrjQLwEn5K8wmNZ+bveyoZmMfJ6wfTLeMYAAHd8a2qTu
         5bH4r98Iewn0t89EVciSJryAOr6kuzB2JFWP6aywNXQF2rQRinHqA3VBL6NNSTuvrvyy
         NQ/OAb/zulg+5l45Aw2YX29L52pW5xnHF9UVHUiPMa3muYW523AxMjvP5vMRZo77FjsD
         5fcD8Vp8oh1B7pffWGvMOx2qyQ8EuC4LN4/SvrtAp3RgQI2VrxAUq85cL74ZDSnP7efM
         IE4f2x96CG0rHiC1S2xYwpJBEWhWa+H5eFqasJyMxilrja9HW5xmN30o0CS0GbpspBWL
         oRvw==
X-Gm-Message-State: ACgBeo0a7WyXfvEfe4yO2/JjBwwS02CbeoD7BDoBEkEQNQV9Xdk7GlbP
        O7JSHz+YKjqooB+aniTKKQisew==
X-Google-Smtp-Source: AA6agR76iE3108cWNE8FbeDX4PCYgzK5/1QzX1yihDJZdwX+7jLb4lLlFtXShklpcDBOLUP7Of+hfw==
X-Received: by 2002:a05:6214:29cb:b0:476:7027:7f70 with SMTP id gh11-20020a05621429cb00b0047670277f70mr33457094qvb.131.1662214078402;
        Sat, 03 Sep 2022 07:07:58 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id s4-20020a05620a254400b006bacf4703c5sm3832220qko.111.2022.09.03.07.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Sep 2022 07:07:56 -0700 (PDT)
Message-ID: <5c6b1286-7035-98a2-456b-735fb5d27e6c@joelfernandes.org>
Date:   Sat, 3 Sep 2022 10:07:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5 08/18] rcu: Add per-CB tracing for queuing, flush and
 invocation.
Content-Language: en-US
To:     paulmck@kernel.org, kernel test robot <lkp@intel.com>
Cc:     rcu@vger.kernel.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        rostedt@goodmis.org, vineeth@bitbyteword.org, boqun.feng@gmail.com
References: <20220901221720.1105021-9-joel@joelfernandes.org>
 <202209030052.20CJhjTX-lkp@intel.com>
 <20220903123948.GP6159@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220903123948.GP6159@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/2022 8:39 AM, Paul E. McKenney wrote:
> On Sat, Sep 03, 2022 at 12:48:28AM +0800, kernel test robot wrote:
>> Hi "Joel,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on paulmck-rcu/dev]
>> [also build test ERROR on pcmoore-selinux/next drm-intel/for-linux-next linus/master v6.0-rc3]
>> [cannot apply to vbabka-slab/for-next rostedt-trace/for-next tip/timers/core next-20220901]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Joel-Fernandes-Google/Implement-call_rcu_lazy-and-miscellaneous-fixes/20220902-062156
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
>> config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220903/202209030052.20CJhjTX-lkp@intel.com/config)
>> compiler: mips-linux-gcc (GCC) 12.1.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://github.com/intel-lab-lkp/linux/commit/c0f09b1d42d06649680f74a78ca363e7f1c158b2
>>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>>         git fetch --no-tags linux-review Joel-Fernandes-Google/Implement-call_rcu_lazy-and-miscellaneous-fixes/20220902-062156
>>         git checkout c0f09b1d42d06649680f74a78ca363e7f1c158b2
>>         # save the config file
>>         mkdir build_dir && cp config build_dir/.config
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag where applicable
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>    In file included from <command-line>:
>>    In function 'dst_hold',
>>        inlined from 'dst_clone' at include/net/dst.h:251:3,
>>        inlined from '__skb_dst_copy' at include/net/dst.h:284:3,
>>        inlined from 'ovs_vport_output' at net/openvswitch/actions.c:787:2:
>>>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |                                             ^
>>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>>      335 |                         prefix ## suffix();                             \
>>          |                         ^~~~~~
>>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |         ^~~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>          |                                     ^~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>>          |         ^~~~~~~~~~~~~~~~
>>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>>          |         ^~~~~~~~~~~~
> 
> This looks like fallout from the rcu_head structure changing size,
> given that __refcnt comes after rcu_head on 32-bit systems.
> 

Yes, I also thought of that as the likely cause.

> It looks like the per-CB tracing code needs to be kept on the side for
> the time being rather than being sent to -next (let alone mainline).

True, that should be Ok. It is a debug patch and can make it a bit later.

> Any reason I cannot just move this one to the end of the stack, after
> "fork: Move thread_stack_free_rcu() to call_rcu_lazy()"?

No reason, it is an independent patch.

 - Joel



> 
> 							Thanx, Paul
> 
>>    In function 'dst_hold',
>>        inlined from 'execute_set_action' at net/openvswitch/actions.c:1093:3,
>>        inlined from 'do_execute_actions' at net/openvswitch/actions.c:1377:10:
>>>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |                                             ^
>>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>>      335 |                         prefix ## suffix();                             \
>>          |                         ^~~~~~
>>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |         ^~~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>          |                                     ^~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>>          |         ^~~~~~~~~~~~~~~~
>>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>>          |         ^~~~~~~~~~~~
>> --
>>    In file included from <command-line>:
>>    In function 'dst_hold',
>>        inlined from 'dst_hold_and_use' at include/net/dst.h:244:2,
>>        inlined from 'dn_insert_route.constprop.isra' at net/decnet/dn_route.c:334:4:
>>>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |                                             ^
>>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>>      335 |                         prefix ## suffix();                             \
>>          |                         ^~~~~~
>>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |         ^~~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>          |                                     ^~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>>          |         ^~~~~~~~~~~~~~~~
>>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>>          |         ^~~~~~~~~~~~
>>    In function 'dst_hold',
>>        inlined from 'dst_hold_and_use' at include/net/dst.h:244:2,
>>        inlined from 'dn_insert_route.constprop.isra' at net/decnet/dn_route.c:347:2:
>>>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |                                             ^
>>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>>      335 |                         prefix ## suffix();                             \
>>          |                         ^~~~~~
>>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |         ^~~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>          |                                     ^~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>>          |         ^~~~~~~~~~~~~~~~
>>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>>          |         ^~~~~~~~~~~~
>>    In function 'dst_hold',
>>        inlined from 'dst_hold_and_use' at include/net/dst.h:244:2,
>>        inlined from 'dn_route_input' at net/decnet/dn_route.c:1535:4:
>>>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |                                             ^
>>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>>      335 |                         prefix ## suffix();                             \
>>          |                         ^~~~~~
>>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |         ^~~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>          |                                     ^~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>>          |         ^~~~~~~~~~~~~~~~
>>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>>          |         ^~~~~~~~~~~~
>>    In function 'dst_hold',
>>        inlined from 'dst_hold_and_use' at include/net/dst.h:244:2,
>>        inlined from '__dn_route_output_key.isra' at net/decnet/dn_route.c:1257:5:
>>>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |                                             ^
>>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>>      335 |                         prefix ## suffix();                             \
>>          |                         ^~~~~~
>>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |         ^~~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>          |                                     ^~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>>          |         ^~~~~~~~~~~~~~~~
>>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>>          |         ^~~~~~~~~~~~
>>    In function 'dst_hold',
>>        inlined from 'dst_clone' at include/net/dst.h:251:3,
>>        inlined from 'dn_cache_dump' at net/decnet/dn_route.c:1752:4:
>>>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |                                             ^
>>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>>      335 |                         prefix ## suffix();                             \
>>          |                         ^~~~~~
>>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |         ^~~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>          |                                     ^~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>>          |         ^~~~~~~~~~~~~~~~
>>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>>          |         ^~~~~~~~~~~~
>> --
>>    In file included from <command-line>:
>>    In function 'dst_hold',
>>        inlined from 'dst_clone' at include/net/dst.h:251:3,
>>        inlined from 'ip6_copy_metadata' at net/ipv6/ip6_output.c:654:2:
>>>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |                                             ^
>>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>>      335 |                         prefix ## suffix();                             \
>>          |                         ^~~~~~
>>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |         ^~~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>          |                                     ^~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>>          |         ^~~~~~~~~~~~~~~~
>>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>>          |         ^~~~~~~~~~~~
>>    In function 'dst_hold',
>>        inlined from 'ip6_append_data' at net/ipv6/ip6_output.c:1838:3:
>>>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |                                             ^
>>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>>      335 |                         prefix ## suffix();                             \
>>          |                         ^~~~~~
>>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |         ^~~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>          |                                     ^~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>>          |         ^~~~~~~~~~~~~~~~
>>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>>          |         ^~~~~~~~~~~~
>>    In function 'dst_hold',
>>        inlined from 'dst_clone' at include/net/dst.h:251:3,
>>        inlined from 'ip6_sk_dst_lookup_flow' at net/ipv6/ip6_output.c:1262:3:
>>>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |                                             ^
>>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>>      335 |                         prefix ## suffix();                             \
>>          |                         ^~~~~~
>>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |         ^~~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>          |                                     ^~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>>          |         ^~~~~~~~~~~~~~~~
>>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>>          |         ^~~~~~~~~~~~
>> --
>>    In file included from <command-line>:
>>    In function 'dst_hold',
>>        inlined from 'dst_clone' at include/net/dst.h:251:3,
>>        inlined from '__skb_dst_copy' at include/net/dst.h:284:3,
>>        inlined from 'skb_dst_copy' at include/net/dst.h:289:2,
>>        inlined from 'ip6_list_rcv_finish.constprop' at net/ipv6/ip6_input.c:128:4:
>>>> include/linux/compiler_types.h:354:45: error: call to '__compiletime_assert_490' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct dst_entry, __refcnt) & 63
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |                                             ^
>>    include/linux/compiler_types.h:335:25: note: in definition of macro '__compiletime_assert'
>>      335 |                         prefix ## suffix();                             \
>>          |                         ^~~~~~
>>    include/linux/compiler_types.h:354:9: note: in expansion of macro '_compiletime_assert'
>>      354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>          |         ^~~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>          |                                     ^~~~~~~~~~~~~~~~~~
>>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>>          |         ^~~~~~~~~~~~~~~~
>>    include/net/dst.h:230:9: note: in expansion of macro 'BUILD_BUG_ON'
>>      230 |         BUILD_BUG_ON(offsetof(struct dst_entry, __refcnt) & 63);
>>          |         ^~~~~~~~~~~~
>>
>>
>> vim +/__compiletime_assert_490 +354 include/linux/compiler_types.h
>>
>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  340  
>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  341  #define _compiletime_assert(condition, msg, prefix, suffix) \
>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  342  	__compiletime_assert(condition, msg, prefix, suffix)
>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  343  
>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  344  /**
>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  345   * compiletime_assert - break build and emit msg if condition is false
>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  346   * @condition: a compile-time constant condition to check
>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  347   * @msg:       a message to emit if condition is false
>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  348   *
>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  349   * In tradition of POSIX assert, this macro will break the build if the
>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  350   * supplied condition is *false*, emitting the supplied error message if the
>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  351   * compiler has support to do so.
>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  352   */
>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  353  #define compiletime_assert(condition, msg) \
>> eb5c2d4b45e3d2 Will Deacon 2020-07-21 @354  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>> eb5c2d4b45e3d2 Will Deacon 2020-07-21  355  
>>
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://01.org/lkp
