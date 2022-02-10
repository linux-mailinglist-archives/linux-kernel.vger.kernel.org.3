Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA4C4B0FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242683AbiBJONT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:13:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237901AbiBJONS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:13:18 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03619194
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:13:19 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D9D674005E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644502397;
        bh=hHqRmwBM+7RA1FsnxWr2R/UGBrQXiz3iEv5wI0eWRho=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=LmQn7pOAUZ3OvE/C+LWSj4tzRYbPoxsmHTdKdhSI81nqDclOyAElIgKrsJNV98etI
         FFeS+veQZgW2t+Sd/LiSHXpWn0n8rVBaPSb3QZ7kkhgUOxbovhn2CP51M2rvmOxpU1
         2ar9ElWlf5LcmSedjbJMU8cV4PvehVZ3K0o+i0nlPMoJJkfFuSFWN761zwlfNWN55W
         HAejwl438QvlS7Eg6tGSkcyeSkUbg3P9IS7oXIknED2BL7ObAV6tRe0nOTUeouRHoD
         Zs33CcVPtL4x50aUaO7tQzdEA9shpLpeuawdZJU6zYRy0yCDcW8LmHzP9IQobRoNrx
         f/7pyV/fFIZ3A==
Received: by mail-ed1-f69.google.com with SMTP id ee7-20020a056402290700b0040f680071c9so3386166edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:13:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hHqRmwBM+7RA1FsnxWr2R/UGBrQXiz3iEv5wI0eWRho=;
        b=Sng4NGWnw5Sct6LHrBfBkx7FK73DNsTsLvEb+xbEEB6d409nuHqitjOn7Bf6abyvwt
         7VQ1zVdDFtHY8LLhOOYq/JhLLbOBVzhCCrnFJW/WovrUItomOJXix+PgE2MVNaBI80kV
         tdNw+MlVyLwWT/jrE98+/jGB+LNSuSrKOUTBMA1pildSs+7EJ2j/cguP8pCGknr7WTT9
         QDfy8I/I8Qj5yk/HABghLGVgie9mMS06bKqbn1212JbfFa5Z7mQl6Tsm2BiBfqotWMiJ
         J2NS32mkfk9dOSBJxW1qXi8qnU8wxyKmv+b/w45QepubySMAXwPOzZjiEo/b7yENWjEn
         L1lg==
X-Gm-Message-State: AOAM532i7rgVYlsEzZYTLYy1/oXqpc8N8f3bYR56mbsFt1NOJIMHodx6
        5TZjo6lTWsz8Q0v0g+ww5+Y/f2yp9XRjd3C5rXb1o3UE90yfpH1plHnCrGccFUWgNEm7+Ps91a2
        pCGijOLJ7GltZct7qIty1p0BoAY2VPzR0r6vTA3A9Xw==
X-Received: by 2002:a17:907:6d88:: with SMTP id sb8mr6493820ejc.25.1644502397480;
        Thu, 10 Feb 2022 06:13:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKV8TCZcJWN5L34rb74wIkQ6Jh9rhzbMYwLJm4thNkuEMEFmBKSz705+0NcRlXlKj8mCINJw==
X-Received: by 2002:a17:907:6d88:: with SMTP id sb8mr6493806ejc.25.1644502397287;
        Thu, 10 Feb 2022 06:13:17 -0800 (PST)
Received: from [192.168.0.98] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id s11sm4966412ejr.176.2022.02.10.06.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 06:13:16 -0800 (PST)
Message-ID: <429dd2fd-3ceb-6780-f970-4ea9b115388c@canonical.com>
Date:   Thu, 10 Feb 2022 15:13:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] selftests/ftrace: Do not trace do_softirq because of
 PREEMPT_RT
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220210083356.11212-1-krzysztof.kozlowski@canonical.com>
 <YgUXcGC1mH7VX1d9@linutronix.de>
 <546f147d-1682-fb92-42e5-7247dc19dcf1@canonical.com>
 <YgUc5HxfIdJ0Z5AN@linutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YgUc5HxfIdJ0Z5AN@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2022 15:10, Sebastian Andrzej Siewior wrote:
> On 2022-02-10 15:05:24 [+0100], Krzysztof Kozlowski wrote:
>> On 10/02/2022 14:47, Sebastian Andrzej Siewior wrote:
>>> On 2022-02-10 09:33:56 [+0100], Krzysztof Kozlowski wrote:
>>>> The PREEMPT_RT patchset does not use soft IRQs thus trying to filter for
>>>> do_softirq fails for such kernel:
>>>
>>> PREEMPT_RT does use soft IRQs.
>>
>> Correct. It does not use do_softirq() code, but follows different path
>> with ksoftirqd.
>> Shall I rephrase it towards something like this? Or maybe you have some
>> more accurate description?
> 
> It would be good to describe what the purpose of the change in terms of
> the actual problem and the aimed solution.

The purpose was explain - fix a failing test with PREEMPT_RT. I am not
planning to rework entire test, it is merely a fix.

> 
>> The implementation detail is that do_softirq() is in ifndef.
> 
> So let me ask again.  We have
>    FUNC1="schedule"
>    FUNC2="do_softirq"
> 
> What is the purpose of this? Do you need FUNC2 when ksoftirqd is run or
> when softirqs are served? Not sure how scheduler_tick fits in all this.

I guess this is more a question to the author of the test. Unless you
are now questioning the entire purpose of this test?

Best regards,
Krzysztof
