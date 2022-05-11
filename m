Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913CB522A64
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 05:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbiEKDXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 23:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiEKDWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 23:22:06 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937C614AC85;
        Tue, 10 May 2022 20:20:34 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 11 May
 2022 11:20:20 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 11 May
 2022 11:20:20 +0800
Message-ID: <427b0e8e-fb35-1091-abe1-bb2b9b229d11@meizu.com>
Date:   Wed, 11 May 2022 11:20:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] rcutorture: remove useless INIT_LIST_HEAD()
To:     <paulmck@kernel.org>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Neeraj Upadhyay" <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>
References: <1652237224-11656-1-git-send-email-baihaowen@meizu.com>
 <20220511030157.GB1790663@paulmck-ThinkPad-P17-Gen-1>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <20220511030157.GB1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/5/11 上午11:01, Paul E. McKenney 写道:
> On Wed, May 11, 2022 at 10:47:04AM +0800, Haowen Bai wrote:
>> list rcu_torture_freelist has been inited staticly through LIST_HEAD,
>> so there's no need to call another INIT_LIST_HEAD. Simply remove
>> it.
>>
>> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> For kernels with built-in rcutorture that starts automatically at
> boot, you are quite correct.
>
> But wouldn't there be trouble in the case where someone does a series of
> "modprobe rcutorture" "rmmod rcutorture" commands?
>
> 							Thanx, Paul
>
>> ---
>>  kernel/rcu/rcutorture.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>> index faf6b4c7a757..0005e259c4ce 100644
>> --- a/kernel/rcu/rcutorture.c
>> +++ b/kernel/rcu/rcutorture.c
>> @@ -3247,7 +3247,6 @@ rcu_torture_init(void)
>>  
>>  	/* Set up the freelist. */
>>  
>> -	INIT_LIST_HEAD(&rcu_torture_freelist);
>>  	for (i = 0; i < ARRAY_SIZE(rcu_tortures); i++) {
>>  		rcu_tortures[i].rtort_mbtest = 0;
>>  		list_add_tail(&rcu_tortures[i].rtort_free,
>> -- 
>> 2.7.4
>>
Thank you for kindly reply, got it.

-- 
Haowen Bai

