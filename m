Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D025F57284B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiGLVNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiGLVNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:13:09 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A87037FB1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:13:08 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id cw12so3501805qvb.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kZcVDwWPHTQfTjMoqKy5WY6hg7zcTdUaNPrz0DE0+wg=;
        b=mFt3Kqx+cl8tHXR1iv5wb2gIO7oc0ywY85DklmItz6he6SNAyGvByShJFVqgZUcyhS
         Mze5ut9JTI8cdXILTIv3TO4AL45F9j1++OpBThYUpaj1Qd8S0lc766iwHHvHNtEaas/t
         12zSUlBTS6IjL3TFsfc8sySjc8Rp3I8DmGYPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kZcVDwWPHTQfTjMoqKy5WY6hg7zcTdUaNPrz0DE0+wg=;
        b=2eyb7xfPAfqtW/x8dMi4CRlLAVrwM119CBGAICijMcX59z1vFVVkf6qQ6PemXagYzR
         8nuMf8b2Xu8TlMiDhm2O440qi0d3lZhbasRlse39iyUw3CveoD7jZLn6IJgfYqPsDt+j
         3WmiApPPfGFesb4iMRgFojmxOqRN9WPVTXLOjQSWeZHdk6NO2nXkvmxwCT97qZ+eirI7
         vSR/37m9z6d10USRLHZpWmQA4jmTBaBiiw6wPPcYXpaKHm9nr56qp/gFdsHUPNuw4+JW
         m0wlYqoKdgW25gG803Jfq/vMib5rPkKpJkg9tZEaEqbt7U8kPItHRzizC+8w7Zn9wabv
         OuoQ==
X-Gm-Message-State: AJIora9G5iLV7XLIKcd9GNqYPYQVBJS1ZyKuWTEsOVPcGlJbYtYBwNzq
        RP1Xcivhg7cbrV58ZQsB8mhBig==
X-Google-Smtp-Source: AGRyM1tTu6pfLmvZ/icZP3G7UAhhSDtYABLXSGk2pLXY3sAjaJBFm11q4T3wSwvQfCIFd7SZn3jUcg==
X-Received: by 2002:a05:6214:1cc7:b0:470:5371:26ff with SMTP id g7-20020a0562141cc700b00470537126ffmr19292095qvd.9.1657660387207;
        Tue, 12 Jul 2022 14:13:07 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a254a00b006a6d74f8fc9sm11062857qko.127.2022.07.12.14.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 14:13:06 -0700 (PDT)
Message-ID: <8441c152-2953-3cb1-c585-b3b0d48a363f@joelfernandes.org>
Date:   Tue, 12 Jul 2022 17:10:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH v2 1/8] rcu: Introduce call_rcu_lazy() API implementation
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-3-joel@joelfernandes.org>
 <20220626040019.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <Yso4690g+lI/8eJS@google.com>
 <20220710160330.GI1790663@paulmck-ThinkPad-P17-Gen-1>
 <aef0f8a6-cde6-18f3-16ab-7e07a4413f31@joelfernandes.org>
 <20220712210406.GF1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220712210406.GF1790663@paulmck-ThinkPad-P17-Gen-1>
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



On 7/12/2022 5:04 PM, Paul E. McKenney wrote:
> On Tue, Jul 12, 2022 at 04:53:48PM -0400, Joel Fernandes wrote:
>>
>> On 7/10/2022 12:03 PM, Paul E. McKenney wrote:
>> [..]
>>>>>> +	// Note that if the bypass list has lazy CBs, and the main list is
>>>>>> +	// empty, and rhp happens to be non-lazy, then we end up flushing all
>>>>>> +	// the lazy CBs to the main list as well. That's the right thing to do,
>>>>>> +	// since we are kick-starting RCU GP processing anyway for the non-lazy
>>>>>> +	// one, we can just reuse that GP for the already queued-up lazy ones.
>>>>>> +	if ((rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy && !lazy) ||
>>>>>> +	    (lazy && n_lazy_cbs >= qhimark)) {
>>>>>>  		rcu_nocb_lock(rdp);
>>>>>>  		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
>>>>>>  		if (*was_alldone)
>>>>>>  			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
>>>>>> -					    TPS("FirstQ"));
>>>>>> -		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
>>>>>> +					    lazy ? TPS("FirstLazyQ") : TPS("FirstQ"));
>>>>>> +		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false));
>>>>>
>>>>> The "false" here instead of "lazy" is because the caller is to do the
>>>>> enqueuing, correct?
>>>>
>>>> There is no difference between using false or lazy here, because the bypass
>>>> flush is not also enqueuing the lazy callback, right?
>>>>
>>>> We can also pass lazy instead of false if that's less confusing.
>>>>
>>>> Or maybe I missed the issue you're raising?
>>>
>>> I am mostly checking up on your intended meaning of "lazy" in various
>>> contexts.  It could mean only that the caller requested laziness, or in
>>> some cases it could mean that the callback actually will be lazy.
>>>
>>> I can rationalize the "false" above as a "don't care" in this case
>>> because (as you say) there is not callback.  In which case this code
>>> is OK as is, as long as the header comment for rcu_nocb_flush_bypass()
>>> clearly states that this parameter has meaning only when there really
>>> is a callback being queued.
>>
>> I decided to change this and the below to "lazy" variable instead of
>> true/false, as the code is cleaner and less confusing IMO. It makes
>> sense to me and in my testing it works fine. Hope that's Ok with you.
> 
> Sounds plausible.
> 
>> About changing the lazy length count to a flag, one drawback of doing
>> that is, say if there are some non-lazy CBs in the bypass list, then the
>> lazy shrinker will end up reporting an inaccurate count. Also
>> considering that it might be harder to add the count back later say if
>> we need it for tracing, I would say lets leave it as is. I will keep the
>> counter for v3 and we can discuss. Does that sound good to you?
> 
> You lost me on this one.  If there are any non-lazy callbacks, the whole
> bypass list is already being treated as non-lazy, right?  If so, then
> the lazy shrinker should report the full count if all callbacks are lazy,
> and should report none otherwise.  Or am I missing something here?
> 

That's one way to interpret it, another way is say there were a 1000
lazy CBs, and now 1 non-lazy came in. The shrinker could report the lazy
count as 0 per your interpretation. Yes its true they will get flushed
out in the next jiffie, but for that time instant, the number of lazy
CBs in the list is not zero! :) Yeah OK its a weak argument, still an
argument! ;-)

In any case, we saw the need for the length of the segcb lists to figure
out things via tracing, so I suspect we may need this in the future as
well, its a small cost so I would rather keep it if that's Ok with you! :)

Thanks,

- Joel

