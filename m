Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890275ADA13
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 22:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiIEUSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 16:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiIEUSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 16:18:30 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930614E617
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 13:18:25 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a10so6858711qkl.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 13:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=2lKv+fdVam07HvfL+Ai9IQOMxrXcUFmXBIhanA2QXpU=;
        b=uZg5HXTVMRfAZjNiDR7C8b9lmli1btoML921b2pMi59dgckdm/GhsR/39xTUWfUMi6
         IQHO6552A8TWhKVZi4G+RmwYwJP7bbEadJ/6+2Cs5A70m2pYcoIa63nJsEosj76024HS
         bBubpi0QjiPB7hO2T3a4GSRxTijc9pD/9MWy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2lKv+fdVam07HvfL+Ai9IQOMxrXcUFmXBIhanA2QXpU=;
        b=ukgZFugtrXFViLnn/jL5xGKIgLAJlS745qMVOZqpyf5ueJkrQuRKVoCGZG0s3s0nIa
         I/FskYyQWNVRF8j5YPnM4oIRZkjBgDH4K5fqOyQyNtafWTm3ZASDZhSN7PT7NYOyd1EX
         ByAWeO4fUAShRtmbk47TjySVEaW0Oy0MVL/SNXwGOmOoBXbx5HV3K3Zedk7RyNYgREuW
         Ph3NpCYF1qpLUGE9CNF2B631yonm+MoiKhNBgiNraHOss5/MkBy1chD3rnzciLBMvevd
         he5Z9TNq2WRC1sRcaXnY5IlWc/Kv/z+3GHbmYCpu/tqC3wEASPFaPoBnCQ1P6GfhBrmG
         DMFA==
X-Gm-Message-State: ACgBeo0BjHLzJSd7tgMw7hJ82Fz8Rot8Hu/1DOPFyL6Z2Em7txSdCOWL
        E+yBg7xDC/foY4WIulregmT8sQ==
X-Google-Smtp-Source: AA6agR6J2ktpx/nqQm82yqgi4YeExHNmpeA38kgFFVfMp0ktPpniEk9f7qkFDYJD0B7wDeApJzMKMg==
X-Received: by 2002:a05:620a:101a:b0:6bb:e7de:791f with SMTP id z26-20020a05620a101a00b006bbe7de791fmr34281994qkj.463.1662409104568;
        Mon, 05 Sep 2022 13:18:24 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id dm34-20020a05620a1d6200b006bb024c5021sm9130732qkb.25.2022.09.05.13.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 13:18:23 -0700 (PDT)
Message-ID: <bce9f5b5-860e-3364-7ee3-b24fdf8839b1@joelfernandes.org>
Date:   Mon, 5 Sep 2022 16:18:22 -0400
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
 <20220902152132.GA115525@lothringen>
 <67122ae3-d69e-438c-18fc-a8de6e40201e@joelfernandes.org>
 <20220905125949.GA173859@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220905125949.GA173859@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederick,

On 9/5/2022 8:59 AM, Frederic Weisbecker wrote:
>>> Also that's a subtle change which purpose isn't explained. It means that
>>> rcu_barrier_entrain() used to wait for the bypass timer in the worst case
>>> but now we force rcuog into it immediately. Should that be a separate change?
>> It could be split, but it is laziness that amplifies the issue so I thought of
>> keeping it in the same patch. I don't mind one way or the other.
> Ok then lets keep it here but please add a comment for the reason to
> force wake here.

Ok will do, thanks.

>>>> +	case RCU_NOCB_WAKE_BYPASS:
>>>> +		mod_jif = 2;
>>>> +		break;
>>>> +
>>>> +	case RCU_NOCB_WAKE:
>>>> +	case RCU_NOCB_WAKE_FORCE:
>>>> +		// For these, make it wake up the soonest if we
>>>> +		// were in a bypass or lazy sleep before.
>>>>  		if (rdp_gp->nocb_defer_wakeup < RCU_NOCB_WAKE)
>>>> -			mod_timer(&rdp_gp->nocb_timer, jiffies + 1);
>>>> -		if (rdp_gp->nocb_defer_wakeup < waketype)
>>>> -			WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>>>> +			mod_jif = 1;
>>>> +		break;
>>>>  	}
>>>>  
>>>> +	if (mod_jif)
>>>> +		mod_timer(&rdp_gp->nocb_timer, jiffies + mod_jif);
>>>> +
>>>> +	if (rdp_gp->nocb_defer_wakeup < waketype)
>>>> +		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
>>> So RCU_NOCB_WAKE_BYPASS and RCU_NOCB_WAKE_LAZY don't override the timer state
>>> anymore? Looks like something is missing.
>> My goal was to make sure that NOCB_WAKE_LAZY wake keeps the timer lazy. If I
>> don't do this, then when CPU enters idle, it will immediately do a wake up via
>> this call:
>>
>> 	rcu_nocb_need_deferred_wakeup(rdp_gp, RCU_NOCB_WAKE)
> But if the timer is in RCU_NOCB_WAKE_LAZY mode, that shouldn't be a problem.
> 
>> That was almost always causing lazy CBs to be non-lazy thus negating all the
>> benefits.
>>
>> Note that bypass will also have same issue where the bypass CB will not wait for
>> intended bypass duration. To make it consistent with lazy, I made bypass also
>> not override nocb_defer_wakeup.
> I'm surprised because rcu_nocb_flush_deferred_wakeup() should only do the wake up
> if the timer is RCU_NOCB_WAKE or RCU_NOCB_WAKE_FORCE. Or is that code buggy
> somehow?
> Actually your change is modifying the timer delay without changing the timer
> mode, which may shortcut rcu_nocb_flush_deferred_wakeup() check and actually
> make it perform early upon idle loop entry.
> 
> Or am I missing something?
> 

You could very well have a point and I am not sure now (I happen to 'forget' the
issue once the code was working). I distinctly remember not being able to be
lazy without doing this. Maybe there is some other path. I am kicking myself for
not commenting in the code or change log enough about the issue.

I will test again sync'ing the lazy timer and the ->nocb_defer_wakeup field
properly and see if I can trigger the issue.

Thanks!

 - Joel







