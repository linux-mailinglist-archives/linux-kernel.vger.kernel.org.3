Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98825ABB7F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 01:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiIBX6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 19:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIBX6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 19:58:49 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C82ED024
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 16:58:48 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id w18so2922838qki.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 16:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=OLpWEjAueAliO4tspjAqBu7T8qnoqOml+2IkcaXQv7U=;
        b=vxuCgJWKwuKgkzkruaZYbPLfIziJaojRQlWtBoy8T+90AFmxCVzW00pcvFQvsmWQvp
         mh0TSgG/gE8DpcHBqX9+F21wfoQQUkqCwbN+wwI8VLghHIXn8uyVJIZByRS4rM83MRdm
         LWDmDEPNi4Nwr/LBK8KQMzclQ8KlqkFQq4lb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OLpWEjAueAliO4tspjAqBu7T8qnoqOml+2IkcaXQv7U=;
        b=QZWV8LrDRUpJ851h1NejGyk28yi89A7zt7Qw1iRwXUC0qKw6po+HBBwNYp8Bby4+Ae
         QmxGIpL20YM2PkkUEMBla0SvVLHqZd7Qei9Utb56rnoGyHNsHJS6Pas/EAzFNUJAUYVi
         BmjfyOfnWevjuNBAL4xiKf1Jrl3zuD9mTvKrX7ON6UDde6PuAW1yDW+hoiDqd7XH/KL4
         /MjyLOdQ7sCCh0jt43uN/0IybkTukKKD8KlQleTGKjRFnF8ofeMLoIR5gt2RuuFBw8xj
         RzV/foE6jYJdazwnLueaHmsbsXlQPPda4W/jq1y+FAxFzaJh+9oRIKyvqJ6Y+5VqqZg1
         CeVQ==
X-Gm-Message-State: ACgBeo2hpwyXESPRKX6Y1sKb5rzF/LTyxqGrGo5oezjdqnt4D0PLdzAJ
        o6KTxG70ha1bSuRzBPrNNk46XA==
X-Google-Smtp-Source: AA6agR7z4UZ213YpInA8vfnSFPuIGJep8rvlb/udAMR979v+ERa/LCu/syzJxSdTitqBuko9tR9H9Q==
X-Received: by 2002:a05:620a:400c:b0:6a6:f8e6:92cc with SMTP id h12-20020a05620a400c00b006a6f8e692ccmr25813321qko.561.1662163127471;
        Fri, 02 Sep 2022 16:58:47 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id a9-20020ac844a9000000b0034305a91aaesm1756221qto.83.2022.09.02.16.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Sep 2022 16:58:47 -0700 (PDT)
Message-ID: <d24157f4-924c-7113-75ac-ed691191584f@joelfernandes.org>
Date:   Fri, 2 Sep 2022 19:58:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5 04/18] rcu: Fix late wakeup when flush of bypass cblist
 happens
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-5-joel@joelfernandes.org>
 <20220902113500.GA113405@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220902113500.GA113405@lothringen>
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



On 9/2/2022 7:35 AM, Frederic Weisbecker wrote:
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
>> +
> 
> Ok so there are two different changes here:
> 
> 1) wake up nocb_gp as we just flushed the bypass list. Indeed if the regular
>    callback list was empty before flushing, we rather want to immediately wake
>    up nocb_gp instead of waiting for the bypass timer to process them.
> 
> 2) wake up nocb_gp unconditionally (ie: even if the regular queue was not empty
>    before bypass flushing) so that nocb_gp_wait() is forced through another loop
>    starting with cancelling the bypass timer (I suggest you put such explanation
>    in the comment btw because that process may not be obvious for mortals).
> 
> The change 1) looks like a good idea to me.
> 
> The change 2) has unclear motivation. It forces nocb_gp_wait() through another
> costly loop even though the timer might have been cancelled into some near
> future, eventually avoiding that extra costly loop. Also it abuses the
> was_alldone stuff and we may get rcu_nocb_wake with incoherent meanings
> (WakeEmpty/WakeEmptyIsDeferred) when it's actually not empty.

Yes #2 can be optimized as follows I think on top of this patch, good point:
=============
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index ee5924ba2f3b..24aabd723abd 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -514,12 +514,13 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp,
struct rcu_head *rhp,
            ncbs >= qhimark) {
                rcu_nocb_lock(rdp);

+               *was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+
                rcu_cblist_set_flush(&rdp->nocb_bypass,
                                lazy ? BIT(CB_DEBUG_BYPASS_LAZY_FLUSHED) :
BIT(CB_DEBUG_BYPASS_FLUSHED),
                                (j - READ_ONCE(cb_debug_jiffies_first)));

                if (!rcu_nocb_flush_bypass(rdp, rhp, j, lazy, false)) {
-                       *was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
                        if (*was_alldone)
                                trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
                                                    TPS("FirstQ"));
@@ -537,7 +538,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct
rcu_head *rhp,
                // However, the bypass timer might still be running. Wakeup the
                // GP thread by calling a helper with was_all_done set so that
                // wake up happens (needed if main CB list was empty before).
-               __call_rcu_nocb_wake(rdp, true, flags)
+               __call_rcu_nocb_wake(rdp, *was_all_done, flags)

                return true; // Callback already enqueued.
        }
=============

> So you may need to clarify the purpose. And I would suggest to make two patches
> here.
I guess this change only #2 is no longer a concern? And splitting is not needed
then as it is only #1.

Thanks,

 - Joel





