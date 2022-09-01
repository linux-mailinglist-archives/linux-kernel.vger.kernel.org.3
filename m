Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857405A95D3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiIALgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiIALga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:36:30 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3D072FE1;
        Thu,  1 Sep 2022 04:36:28 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MJJqL0TYMzHnVC;
        Thu,  1 Sep 2022 19:34:38 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 19:36:26 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 19:36:26 +0800
Subject: Re: [PATCH rcu 3/3] rcu: Simplify rcu_init_nohz() cpumask handling
To:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>
References: <20220831181040.GA2694278@paulmck-ThinkPad-P17-Gen-1>
 <20220831181044.2694488-3-paulmck@kernel.org>
 <20220901091557.GA101341@lothringen>
 <20220901102520.GQ6159@paulmck-ThinkPad-P17-Gen-1>
 <20220901111114.GA103483@lothringen>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <4788d77e-71b5-00a2-d55a-e6a7fe60202a@huawei.com>
Date:   Thu, 1 Sep 2022 19:36:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20220901111114.GA103483@lothringen>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/1 19:11, Frederic Weisbecker wrote:
> On Thu, Sep 01, 2022 at 03:25:20AM -0700, Paul E. McKenney wrote:
>> On Thu, Sep 01, 2022 at 11:15:57AM +0200, Frederic Weisbecker wrote:
>>>> +#elif defined(CONFIG_NO_HZ_FULL)
>>>> +	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
>>>> +		cpumask = tick_nohz_full_mask;
>>>> +#endif
>>>
>>> A subtle behaviour difference here too: CONFIG_RCU_NOCB_CPU_DEFAULT_ALL will
>>> now override nohz_full=
>>>
>>> I don't mind, it's probably what we want in the end, but the changelog should
>>> tell about it, or even better, this should be a separate change.
>>
>> Good point.  Perhaps the key point is that if there is nohz_full=,
>> rcu_nocbs=, and CONFIG_RCU_NOCB_CPU_DEFAULT_ALL, we still need rcu_nocbs=
>> to include at least those bits set by nohz_full=.
> 
> Not sure I get what you mean. nohz_full= should in any case always force
> rcu_nocbs at least on the nohz_full CPUs.
> 
> For example assuming the following combination: rcu_nocbs=6, nohz_full=7 AND
> CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y, then the result should be:
> 
> NOCB CPUs = 6,7
> NOHZ_FULL CPUs = 7
> 
> (CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y is overriden by rcu_nocbs=6).
> 
> Now if we have nohz_full=7 AND CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y, then the
> result is expected to be either:
> 
> NOCB CPUs = 7 (upstream behaviour)
> NOHZ_FULL CPUs = 7

OK, I got it. CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y takes effect only when there
are no 'rcu_nocbs=' and 'nohz_full='.

> 
> or 
> 
> NOCB CPUs = all
> NOHZ_FULL CPUs = 7
> 
> The second makes more sense IMHO but that should be in a separate change.

OK, in this case, CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y takes effect only when there
is no 'rcu_nocbs='.

> 
> Thanks.
> .
> 

-- 
Regards,
  Zhen Lei
