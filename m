Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC16E4B59F4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357479AbiBNSdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:33:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242646AbiBNSd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:33:28 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E1F652E4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:33:20 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id z7so13022054ilb.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tPJrWe/i1MqPMtoPzbeR0YlE4FVwmAqDMvl6+ufirY4=;
        b=COkS4HG2yhu5A+qPYPGPODAVhYDxh2/jZFV1uAoGVTzJcBYPaXav2ILkA+Rl8b+vzh
         aP96JiOp8O+222QWhSurBWbwFqm1uF1n0AtJu385qY5DwYoAzFLtML3w+T1hhCwz1UkV
         LxyE3mKgNIHtUkLv/tlfZQGknbGYd4tdDCNVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tPJrWe/i1MqPMtoPzbeR0YlE4FVwmAqDMvl6+ufirY4=;
        b=fgOJfU4pLd1nF4cBUDhSfim5FljTlgpSB63IpcceixzviV5Yd7OhximQqKZ0EB1Zli
         NpeDnAfFukjpCIiAltVZuDqaQI+v+yoefJ/fg3FQyaKPMi894vmjSpDxNdC5iZb6d64+
         2HD4Q58l4xWBVtfGQ3/dR6bILgHokKrg7H0tMD188T3cIZUw++0GVZ8KO516uJghUXJ3
         Bia3w4PhhOyOZZqFakVdT4OiNeOkTIwd3i4qgT1LsdoC5OI9QmSSGRnBelN+4n74IUTS
         WL3kOBHk7l7bfakVRBGm7TDGczRUCwro+5+k0BUiSE7iYTjp6hC9cfp31KMK6tcxhWp6
         Z3JA==
X-Gm-Message-State: AOAM531H1PNYHfv0dV+SwX2F32cnCdxcM+RTBbTUSTZ3EHwAjGKCwvGM
        wRME4w8plkc8rErmRuOimpDvdA==
X-Google-Smtp-Source: ABdhPJwmbomCs/78CZKWKJaM/G0NMmImZ7RDFmjRwVP0Cf9Pq2eAUr8RIwQIdHQv4nTc1UGomvsRnA==
X-Received: by 2002:a05:6e02:1544:: with SMTP id j4mr92677ilu.77.1644863599754;
        Mon, 14 Feb 2022 10:33:19 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g1sm23149484iob.34.2022.02.14.10.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 10:33:19 -0800 (PST)
Subject: Re: [PATCH v3] selftests/ftrace: Do not trace do_softirq because of
 PREEMPT_RT
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220214083657.165921-1-krzysztof.kozlowski@canonical.com>
 <Ygo6pqWmkTWJNNcR@linutronix.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8f034cd5-8495-de0e-6a3c-4d002e49cc51@linuxfoundation.org>
Date:   Mon, 14 Feb 2022 11:33:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <Ygo6pqWmkTWJNNcR@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 4:19 AM, Sebastian Andrzej Siewior wrote:
> On 2022-02-14 09:36:57 [+0100], Krzysztof Kozlowski wrote:
>> The PREEMPT_RT patchset does not use do_softirq() function thus trying
>> to filter for do_softirq fails for such kernel:
>>
>>    echo do_softirq
>>    ftracetest: 81: echo: echo: I/O error
>>
>> Choose some other visible function for the test.  The function does not
>> have to be actually executed during the test, because it is only testing
>> filter API interface.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
>> Notes:
>> I understand that the failure does not exist on mainline kernel (only
>> with PREEMPT_RT patchset) but the change does not harm it.
> 

Steve,

Would you like me to take this through linux-kselftest next for 5.18-rc1

I am guessing there is no urgency on this - of not I can take this in for
rc5.

thanks,
-- Shuah
