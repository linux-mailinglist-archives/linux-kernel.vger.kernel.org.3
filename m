Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508B75B05F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiIGOB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIGOBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:01:21 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BC46DAD6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:01:20 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id b9so10517937qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 07:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/s29LV2sR+vq6yN67Lm8Tg/CBgP8Mafr42Z5nWlRis4=;
        b=a1EH48PXO2HWnFkMr2lckeI3ZeIMzujU9/AVEutHPRJbwWB4FXTYrKVICugf0zgD0l
         C9ijJ0XmodomYxoNRd906F8T7JlQv9gPAn1QGXrESsy99SvMcFO0ta/O0ftnRkTuypMa
         r7vpYltcScc+dBchRLYT/A/bAm/k53n+hTneU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/s29LV2sR+vq6yN67Lm8Tg/CBgP8Mafr42Z5nWlRis4=;
        b=jVbYNR/9LbKheKKNmXyQC+dBRZ2x1teCVFFKwi0fAX7WKr/AvMJS/XKRtHc9uu4C0Z
         T6Vw/SakODbDctqn3eQRb6he4vtm98a1SLctpXj7nWEd63dmMLxXkI37iIQ7ACVpFwNd
         4vAyQnB7vB3WvSb5mgpGwj6xLi7QOu7xgTDR8owpqe2ANrdgHlC5Q/xQ65+kX1+Z06s9
         J14QnerJulQOP5DUpzTmaNLQ6v+QPLp0Yv2EVfQq7wLDi44aJ+N4aJ2RG3W/NL4nSQSq
         Laki9NhLuCitoVYFkMIuDImnSFXKd4NEdG7rCWrv60z6kI3G3HVTDE0bG/3Yo2TCIvFG
         0YMQ==
X-Gm-Message-State: ACgBeo2nubCR+0qflQiKeWOi20KyId7m7uiQ11vJLH/5t0+pyAAFQqbI
        sG354tEvTTenz7uKcgF9VnDY7g==
X-Google-Smtp-Source: AA6agR7Vf1kI9nc64NEmeizsB7LyogdUqy4T6UbinGSXFJslNqEA7lhb3SWeJvZiL15yTsHtKnb1hw==
X-Received: by 2002:a37:4553:0:b0:6be:6c1d:92ff with SMTP id s80-20020a374553000000b006be6c1d92ffmr2819196qka.151.1662559279446;
        Wed, 07 Sep 2022 07:01:19 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id 6-20020a370c06000000b006bbbd4ce6e1sm13319885qkm.35.2022.09.07.07.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 07:01:18 -0700 (PDT)
Message-ID: <b106edc3-2557-0669-86bf-10c08739a86a@joelfernandes.org>
Date:   Wed, 7 Sep 2022 10:01:16 -0400
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
 <20220906151757.GA183806@lothringen>
 <cde6586e-ae61-5e85-3c9a-1ce7dd2464ed@joelfernandes.org>
 <20220907100349.GB194889@lothringen>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220907100349.GB194889@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2022 6:03 AM, Frederic Weisbecker wrote:
> On Tue, Sep 06, 2022 at 12:15:19PM -0400, Joel Fernandes wrote:
>>>> +
>>>> +	// We had CBs in the bypass list before. There is nothing else to do if:
>>>> +	// There were only non-lazy CBs before, in this case, the bypass timer
>>>
>>> Kind of misleading. I would replace "There were only non-lazy CBs before" with
>>> "There was at least one non-lazy CBs before".
>>
>> I really mean "There were only non-lazy CBs ever queued in the bypass list
>> before". That's the bypass_is_lazy variable. So I did not fully understand your
>> suggested comment change.
> 
> I may well be missing something but to me it seems that:
> 
> bypass_is_lazy = all bypass callbacks are lazy
> !bypass_is_lazy = there is at least one non-lazy bypass callback
> 
> And indeed as long as there is at least one non-lazy callback, we don't
> want to rely on the LAZY timer.
> 
> Am I overlooking something?

No you are not over looking and you are very right that I may need to change the
comment.

To clarify my intent, a wake up or timer adjustment needs to be done only if:

1. Bypass list was fully empty before (this is the first bypass list entry).

Or both the below conditions are met:

1. Bypass list had only lazy CBs before.

2. The new CB is non-lazy.

Instead of saying, "nothing needs to be done if...", I will change it to:

        // A wake up of the grace period kthread or timer adjustment needs to
        // be done only if:
        // 1. Bypass list was empty before (this is the first bypass queue).
        //      Or, both the below conditions are met:
        // 1. Bypass list had only lazy CBs before.
        // 2. The new CB is non-lazy.

That sounds less confusing...

Or, I can just make the edit you suggested... let me know either way!

Thanks!

 - Joel
