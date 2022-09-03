Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BC05ABF35
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 16:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiICOFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 10:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiICOFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 10:05:33 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809FD3206E
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 07:05:31 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a22so3425308qtw.10
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 07:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yyyd1sxsmE6D0QxlQAOs5slwkgmkiRw7J9KYMdVF/nI=;
        b=JnpaPPUzT0cPHP1fhbSh0qZ6GChZnhQyLsbs9fabP7LH+x/Azw7dkoBHbb2MYD8U0o
         oO4/xqx68kMJ0CIOjgvSybbK/qTOPrmaqSqvLawtFU/j4/3YnfyaaxqnE+0yndLjRpIQ
         lI4khU2O53b8hCY9xErCstasXwylls+KtWHlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yyyd1sxsmE6D0QxlQAOs5slwkgmkiRw7J9KYMdVF/nI=;
        b=EQM1D69uN7Ph3f2nrXYYHOaccb8gFtpo1Xx2tKJVohMaqb/8GtsLh04Cwtv07Qrss/
         bzfvkI9xb8tc33NTn7oqDWb7qgkl/yYQTIsUDEeu5pjzYzPYgtixTgjxGwMtVLLKPG57
         zqqAsD2F50sGzZN5JyN9Smka3pRJm++zwrhCwLnd5jzqaVpZAlqfZOxVNtcxff4op3qU
         3xwiK5Z8eprI44+zSKWjFuuzQ8v02nor35T9G2w1aAGXt71DZjYqNyBbsQFvkPkEBOf1
         rkT9w1bl+BHzblPNJiPupnHbXm+gpBNyg6ECg0CiGhBzNmP3q+IsKJhXvYTcGf7Ukahr
         BqpA==
X-Gm-Message-State: ACgBeo2PuEooI4tjb0UCqhwMnsuG7Yo9Gp9WmR1fQ4PA2iQYb4yci+tY
        PAZ6PqKqy1jmpbEWY0EHnUF+yQ==
X-Google-Smtp-Source: AA6agR73skQVg8J2Imx9ubSCfVnAaNPqvzfDpU633Y7CafLZG5iQJ388BgfY5d4ESxY/+Pob9extYQ==
X-Received: by 2002:ac8:5a8b:0:b0:343:7075:2129 with SMTP id c11-20020ac85a8b000000b0034370752129mr33386358qtc.393.1662213930635;
        Sat, 03 Sep 2022 07:05:30 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id x19-20020ac87313000000b0034490214788sm2986718qto.49.2022.09.03.07.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Sep 2022 07:05:29 -0700 (PDT)
Message-ID: <c96c36f2-c324-39f7-1d66-7634eb26d909@joelfernandes.org>
Date:   Sat, 3 Sep 2022 10:05:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5 04/18] rcu: Fix late wakeup when flush of bypass cblist
 happens
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-5-joel@joelfernandes.org>
 <20220903140403.GU6159@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220903140403.GU6159@paulmck-ThinkPad-P17-Gen-1>
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



On 9/3/2022 10:04 AM, Paul E. McKenney wrote:
> On Thu, Sep 01, 2022 at 10:17:06PM +0000, Joel Fernandes (Google) wrote:
>> When the bypass cblist gets too big or its timeout has occurred, it is
>> flushed into the main cblist. However, the bypass timer is still running
>> and the behavior is that it would eventually expire and wake the GP
>> thread.
>>
>> Since we are going to use the bypass cblist for lazy CBs, do the wakeup
>> soon as the flush happens. Otherwise, the lazy-timer will go off much
>> later and the now-non-lazy cblist CBs can get stranded for the duration
>> of the timer.
>>
>> This is a good thing to do anyway (regardless of this series), since it
>> makes the behavior consistent with behavior of other code paths where queueing
>> something into the ->cblist makes the GP kthread in a non-sleeping state
>> quickly.
>>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>>  kernel/rcu/tree_nocb.h | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>> index 0a5f0ef41484..31068dd31315 100644
>> --- a/kernel/rcu/tree_nocb.h
>> +++ b/kernel/rcu/tree_nocb.h
>> @@ -447,7 +447,13 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>>  			rcu_advance_cbs_nowake(rdp->mynode, rdp);
>>  			rdp->nocb_gp_adv_time = j;
>>  		}
>> -		rcu_nocb_unlock_irqrestore(rdp, flags);
>> +
>> +		// The flush succeeded and we moved CBs into the ->cblist.
>> +		// However, the bypass timer might still be running. Wakeup the
>> +		// GP thread by calling a helper with was_all_done set so that
>> +		// wake up happens (needed if main CB list was empty before).
>> +		__call_rcu_nocb_wake(rdp, true, flags)
> 
> TREE01 and TREE04 gripe about the missing ";".  I added it.

Sorry about that, I must have messed lost the semicolon during re-basing.

 - Joel

