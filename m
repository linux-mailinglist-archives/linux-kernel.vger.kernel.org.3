Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBD85ADA14
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 22:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiIEUUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 16:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIEUUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 16:20:08 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F16012631
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 13:20:07 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id v15so4239720qvi.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 13:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=A7rOAmNlXCdkcDQTJzD9muqEqItMweVqNhp8pSdMDDE=;
        b=ZLJtjk+519vUT/+rOJG0alJPgD9zGPCZtcZ96i73GiPxCIpSFDcIv58/jVr/K3OpT7
         gpnutAgfqgOqB8d8WQFSmGQws5nOaGehcPqm7EQ9bfKHkrz7DIVU6vQJ1cfF3LnNJ2Fv
         HZGS2tX8ZjopKaGPLJ784jzcP6pjaxgWeQPw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=A7rOAmNlXCdkcDQTJzD9muqEqItMweVqNhp8pSdMDDE=;
        b=itpIS/8+U0ndhXbjYNME3ufysShzvQk+s5cSZ/w1ETAWovjCMj7vtKbjjWaKKeFOOw
         xIo2f4ecbBKCzcRP9TubtlAsVP4wLjQtBWZi826On3uejhxoL+xWyvePYGAHCPqf6Uye
         veIl2tuAJzgRlbB97ODI+7eWU0N11j8Rss2lG+CON89BZThKDvMJ1aa0FO95F6w2Ysw4
         SoivcNEIc+dOYzveOL9PE3GOXl5bNlVib+Y+isImZrvQmWNUbdrpinc5sdajkhCHB26N
         09OPcrQw5CLwHD+PzGiDLBzMUdEqJpohdfpnoj6rDZMRKCC+nb+X7flNY03lv7RJVRbY
         GrlA==
X-Gm-Message-State: ACgBeo3pCeK5ouliGyyW/nC7Q8TWPw22AtT7pp6Pr1RH6q0AnH66DpMa
        e1qd/34AriPX4FTFCIpNLtX2mUcMfnExZQ==
X-Google-Smtp-Source: AA6agR6UBa+GT8cbSN0/hcSYNvBCBXPm20T2wL5jgK/TjtWBrQcFkAL4gBwTvYBpTYs0dTJRLnjmtw==
X-Received: by 2002:ad4:5d6c:0:b0:4aa:9dd7:4e0b with SMTP id fn12-20020ad45d6c000000b004aa9dd74e0bmr698161qvb.92.1662409206678;
        Mon, 05 Sep 2022 13:20:06 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id y13-20020a05620a25cd00b006b5e50057basm9212430qko.95.2022.09.05.13.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 13:20:05 -0700 (PDT)
Message-ID: <e188418a-67a3-d0d4-8bf1-b6ad1e55fd6e@joelfernandes.org>
Date:   Mon, 5 Sep 2022 16:20:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen> <YxPOfVMzRWEa7xqf@google.com>
 <20220904210133.GA149888@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220904210133.GA149888@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,

On 9/4/2022 5:01 PM, Frederic Weisbecker wrote:
> On Sat, Sep 03, 2022 at 10:00:29PM +0000, Joel Fernandes wrote:
>> On Fri, Sep 02, 2022 at 05:21:32PM +0200, Frederic Weisbecker wrote:
>> +
>> +	raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
> 
> This is locking during the whole group iteration potentially contending call_rcu(),
> idle loop, resume to userspace on all rdp in the group...
> 
> How about not overwriting timers instead and only set the RCU_NOCB_WAKE_LAZY
> timer when it is previously in RCU_NOCB_WAKE_NOT state? After all if the timer is armed,
> it's because we have regular callbacks queued and thus we don't need to wait
> before processing the lazy callbacks since we are going to start a grace period
> anyway.
> 
> Thanks.

I like your idea better. I think it will work well to resolve the race you
described.

Thanks!

 - Joel


> 
> 
>>  	list_for_each_entry_rcu(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp, 1) {
>>  		bool needwake_state = false;
>>  		bool flush_bypass = false;
>> @@ -855,14 +870,15 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>>  		// If bypass list only has lazy CBs. Add a deferred
>>  		// lazy wake up.
>>  		if (lazy && !bypass) {
>> -			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_LAZY,
>> +			wake_nocb_gp_defer_locked(my_rdp, RCU_NOCB_WAKE_LAZY,
>>  					TPS("WakeLazyIsDeferred"));
>>  		// Otherwise add a deferred bypass wake up.
>>  		} else if (bypass) {
>> -			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_BYPASS,
>> +			wake_nocb_gp_defer_locked(my_rdp, RCU_NOCB_WAKE_BYPASS,
>>  					TPS("WakeBypassIsDeferred"));
>>  		}
>>  	}
>> +	raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
>>  
>>  	if (rcu_nocb_poll) {
>>  		/* Polling, so trace if first poll in the series. */
>> -- 
>> 2.37.2.789.g6183377224-goog
>>
