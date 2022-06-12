Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A942547912
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 08:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiFLGLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 02:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiFLGLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 02:11:15 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90ADC5F67;
        Sat, 11 Jun 2022 23:11:13 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id C69121E80D78;
        Sun, 12 Jun 2022 14:10:11 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cuOdn4AlAeKG; Sun, 12 Jun 2022 14:10:09 +0800 (CST)
Received: from [172.30.21.244] (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 7F34B1E80C8B;
        Sun, 12 Jun 2022 14:10:08 +0800 (CST)
Subject: Re: [PATCH] rcu: Handle failure of memory allocation functions
To:     paulmck@kernel.org
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        hukun@nfschina.com, qixu@nfschina.com, yuzhe@nfschina.com,
        renyu@nfschina.com
References: <20220611093055.1473-1-liqiong@nfschina.com>
 <20220611163432.GM1790663@paulmck-ThinkPad-P17-Gen-1>
From:   liqiong <liqiong@nfschina.com>
Message-ID: <e71a9031-68dc-93d0-7aff-e4060bb56a24@nfschina.com>
Date:   Sun, 12 Jun 2022 14:11:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20220611163432.GM1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022年06月12日 00:34, Paul E. McKenney 写道:
> On Sat, Jun 11, 2022 at 05:30:55PM +0800, Li Qiong wrote:
>> Add warning when these functions (eg:kmalloc,vmalloc) fail, handle the
>> failure.
>>
>> Signed-off-by: Li Qiong <liqiong@nfschina.com>
> Good catch, thank you!  However...
>
>> ---
>>  kernel/rcu/rcutorture.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>> index 7120165a9342..97f90e304ae3 100644
>> --- a/kernel/rcu/rcutorture.c
>> +++ b/kernel/rcu/rcutorture.c
>> @@ -1991,6 +1991,10 @@ static void rcu_torture_mem_dump_obj(void)
>>  
>>  	kcp = kmem_cache_create("rcuscale", 136, 8, SLAB_STORE_USER, NULL);
> As long as we are checking, why not also check this one?
>
> 							Thanx, Paul

Hi Paul,
Yes,  the kmem_cache_create  would fail too. 
I searched  "kernel" directory, found that It seems  all the code just check kmem_cache_alloc()，
So, I ignored   kmem_cache_create() .  I will submit a v2 patch.

Thanks,
Li Qiong


>
>>  	rhp = kmem_cache_alloc(kcp, GFP_KERNEL);
>> +	if (WARN_ON_ONCE(!rhp)) {
>> +		kmem_cache_destroy(kcp);
>> +		return;
>> +	}
>>  	pr_alert("mem_dump_obj() slab test: rcu_torture_stats = %px, &rhp = %px, rhp = %px, &z = %px\n", stats_task, &rhp, rhp, &z);
>>  	pr_alert("mem_dump_obj(ZERO_SIZE_PTR):");
>>  	mem_dump_obj(ZERO_SIZE_PTR);
>> @@ -2007,6 +2011,8 @@ static void rcu_torture_mem_dump_obj(void)
>>  	kmem_cache_free(kcp, rhp);
>>  	kmem_cache_destroy(kcp);
>>  	rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
>> +	if (WARN_ON_ONCE(!rhp))
>> +		return;
>>  	pr_alert("mem_dump_obj() kmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
>>  	pr_alert("mem_dump_obj(kmalloc %px):", rhp);
>>  	mem_dump_obj(rhp);
>> @@ -2014,6 +2020,8 @@ static void rcu_torture_mem_dump_obj(void)
>>  	mem_dump_obj(&rhp->func);
>>  	kfree(rhp);
>>  	rhp = vmalloc(4096);
>> +	if (WARN_ON_ONCE(!rhp))
>> +		return;
>>  	pr_alert("mem_dump_obj() vmalloc test: rcu_torture_stats = %px, &rhp = %px, rhp = %px\n", stats_task, &rhp, rhp);
>>  	pr_alert("mem_dump_obj(vmalloc %px):", rhp);
>>  	mem_dump_obj(rhp);
>> -- 
>> 2.11.0
>>
