Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001975B08B8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiIGPjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiIGPjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:39:41 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1907219C29
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:39:40 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b2so10730998qkh.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=VFsvBRrLGMqiandnt/BZ5X7eFmfya9PSY9gKTWZIt0U=;
        b=JdHn0stdszmYFagtThduBXGIH0Pkq5WVZPr63iBGr/Pzbo81jgifE/mYkdYKuCxuVy
         1qG/Tu06lAnhlIAT2D7NA+IKMZdsJy8AX7pW+gV+x/dobLn0VlB3OVIHURlHeurGhVai
         RRgOjeGDFMBfxuhqpKKDkm9L3f8d3x6G6CIfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VFsvBRrLGMqiandnt/BZ5X7eFmfya9PSY9gKTWZIt0U=;
        b=gvv//vhg6lak5EDjAsx68InJahNdvhmz6/jjjIT46V0wZQ52bYXSh8BJ0/OJv7MyFE
         0CMWXEi9IGRNJpl1dT9lezDyh+KMeCuphs66hfm5mS7BOCkXwZZasO+gNCVecpsedYOk
         cCFV29JbgQ15M06QrNBlD2t+5eGStYtGnUJ74GHc56sNs8VHkOT9uBnxJC9MURTUrwAD
         kNjUc+z7EbhhoztSsgVVBRYpko0H1IR7eWczkV0M6Am/pO2i29TlVIq94H/zoemQ2lah
         ArLmVCtH5e2Q5rGXKrmG/xTU7SO6JQ/DcY6TxteKfEEmwWDT+8zSyjVGaaUpSg+RKQXp
         zXVA==
X-Gm-Message-State: ACgBeo2xnO4gVMhMgzybxfS8IGqxM+WX5yLRrsVAF6eXGG/+HySQzALU
        LBZGm2DULQQVA0NYdOoU8y7JAg==
X-Google-Smtp-Source: AA6agR5G32UCcKvI9zxhdNDRi1/Zv87RtjSFEmP61E05auhqP3lb8UrIHuJWnIFdWfHVf9XzdcO2aw==
X-Received: by 2002:a05:620a:2681:b0:6b5:b50c:99c0 with SMTP id c1-20020a05620a268100b006b5b50c99c0mr3122997qkp.527.1662565179215;
        Wed, 07 Sep 2022 08:39:39 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id k18-20020ac81412000000b003445b83de67sm12090609qtj.3.2022.09.07.08.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 08:39:38 -0700 (PDT)
Message-ID: <1a0df62f-1dfb-6ffe-651e-5908ff7069d3@joelfernandes.org>
Date:   Wed, 7 Sep 2022 11:39:37 -0400
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
 <20220902152132.GA115525@lothringen> <Yxa5Ch574cRZxRdo@google.com>
 <20220906151757.GA183806@lothringen> <Yxfggt1/cLBhUi/y@google.com>
 <20220907094014.GA193994@lothringen>
 <07215af0-4164-efb6-4ba8-63d33fe8664e@joelfernandes.org>
 <20220907153801.GB198228@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220907153801.GB198228@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2022 11:38 AM, Frederic Weisbecker wrote:
> On Wed, Sep 07, 2022 at 09:44:01AM -0400, Joel Fernandes wrote:
>> Hi Frederic,
>>
>> On 9/7/2022 5:40 AM, Frederic Weisbecker wrote:
>>>>
>>>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>>>> index bd8f39ee2cd0..e3344c262672 100644
>>>> --- a/kernel/rcu/tree_nocb.h
>>>> +++ b/kernel/rcu/tree_nocb.h
>>>> @@ -382,15 +382,19 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>>>>  				  unsigned long j, unsigned long flush_flags)
>>>>  {
>>>>  	bool ret;
>>>> +	bool was_alldone;
>>>>  
>>>>  	if (!rcu_rdp_is_offloaded(rdp))
>>>>  		return true;
>>>>  	rcu_lockdep_assert_cblist_protected(rdp);
>>>>  	rcu_nocb_bypass_lock(rdp);
>>>> +	if (flush_flags & FLUSH_BP_WAKE)
>>>> +		was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
>>>> +
>>> You can check that outside bypass lock (but you still need nocb_lock).
>>
>> Right, ok. I can make it outside the bypass lock, and the nocb_lock is implied
>> by rcu_lockdep_assert_cblist_protected().
>>
>>>
>>>>  	ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
>>>>  
>>>> -	if (flush_flags & FLUSH_BP_WAKE)
>>>> -		wake_nocb_gp(rdp, true);
>>>> +	if (flush_flags & FLUSH_BP_WAKE && was_alldone)
>>>> +		wake_nocb_gp(rdp, false);
>>> That doesn't check if the bypass list was empty.
>>
>> thanks, will add your suggested optimization, however I have a general question:
>>
>> For the case where the bypass list is empty, where does rcu_barrier() do a wake
>> up of the nocb GP thread after entrain()?
>>
>> I don't see a call to __call_rcu_nocb_wake() like rcutree_migrate_callbacks()
>> does. Is the wake up done in some other path?
> 
> Actually I can't find it. You're right it may be missing. It's not even just
> about the bypass list but also the entrain'ed callback. Would you be willing to
> cook a fix?

Sounds good, yes I am happy to make a fix and include it in the next series
posting. Thanks for confirming the potential issue.

I will be on a plan in a few hours, I can even try to do it on the plane but
will see how it goes ;)

Thanks!

 - Joel


