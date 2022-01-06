Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA99486430
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 13:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbiAFMQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 07:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238347AbiAFMQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 07:16:32 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E21C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 04:16:31 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r17so4420426wrc.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 04:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cNva4ekHb1mto7cd3Pts0E9i1PphtyKKgu0TDFlUPns=;
        b=G4tRh5hznsgzcdqlGnLe0CSzoY/y4QeBNHlOI2isfo1K5/YCCbdCXv3DKH/Isknxnd
         jDa1w7eLk6V1S9OIbL7MS7Nq0vFNaBEkWpedPldd4HCthxVhqgEF0JP2PMHor9yBfk2p
         BQvE7Y+nwGtrcfRE+KBDeyY73rWdnx9DCmd/lnwpYBceSDRLd1D5b1kArMuQdjnVNbrG
         ABxnagK3qAIBepgCiLfcPgQUqo+pdKs+cY5FEFOMABbDnxEV/F3bHqMOtcaOnWR5KYbW
         MTM1wdJxXHwbi+1LTB8TkdsUKFSBqdUiPs7Fjb3ORyWKBYp5grEq1kxzNz6002KB9hd5
         Iuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cNva4ekHb1mto7cd3Pts0E9i1PphtyKKgu0TDFlUPns=;
        b=mhOzRm09SGACp2jSE+JBQDakLMg+GG6QPeFxNEUyLHEDmvZdaGPZ2n+Fq0JqNXOZSo
         5HJstrDrzKdY7iiKi+yfRnVCN7CCvMpepjVvuYnB4Q4dAQek3V52IPnLpKflW3QnQMVE
         u803BmQRnUMthaikDfVChxYeINkY0xDXanQbZ3U9CThSwxsyVSj7RwobNkZNFC/Abdo8
         8Gm03VTcpdgk8PAGSZfBUyf0woqwz189iuUIPjiNUQVCtb6eqrPxzEMnQyL5xfWlyfIV
         ww1MeaEVGiDoSIlHv6yPzuU15qxbf7u3eWxYjIcVM7V12JhqcU3kd+EMJoBHUETzfV5P
         oxkg==
X-Gm-Message-State: AOAM532QpB14+VZPOM7bGUtU4yY7/PFsg/C9W+731fR8Z4nl7hpeJvW3
        ZtUInxqpMrZzCOgTT8HZznuKpA==
X-Google-Smtp-Source: ABdhPJxHDBAyaNAFX27yjyxA6SMn1pal0lkcgvL88/SE4KwSXlVeA4BwtxXmxMNy3Fc5XfZbpxkZgw==
X-Received: by 2002:a05:6000:1210:: with SMTP id e16mr1798084wrx.434.1641471390233;
        Thu, 06 Jan 2022 04:16:30 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:499e:b45e:e5e1:2c33? ([2a01:e34:ed2f:f020:499e:b45e:e5e1:2c33])
        by smtp.googlemail.com with ESMTPSA id b2sm2076441wrd.35.2022.01.06.04.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 04:16:29 -0800 (PST)
Subject: Re: [PATCH v2][RFC 1/2] Implement Ziegler-Nichols Heuristic
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org, amitk@kernel.org,
        Chetankumar Mistry <chetan.mistry@arm.com>,
        rui.zhang@intel.com, linux-pm@vger.kernel.org
References: <20211217184907.2103677-1-chetan.mistry@arm.com>
 <23c3480a-c46b-f049-5758-d11124367190@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1b6047eb-2f14-ddde-4712-145a26dc8aa5@linaro.org>
Date:   Thu, 6 Jan 2022 13:16:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <23c3480a-c46b-f049-5758-d11124367190@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Lukasz,

On 06/01/2022 12:54, Lukasz Luba wrote:
> Hi Daniel,
> 
> Could you have a look at this, please?

Yes, I had a quick look at the code and went to the algorithm description.

Still digesting ...

> On 12/17/21 6:49 PM, Chetankumar Mistry wrote:
>> Implement the Ziegler-Nichols Heuristic algorithm to better
>> estimate the PID Coefficients for a running platform.
>> The values are tuned to minimuse the amount of overshoot in
>> the temperature of the platform and subsequently minimise
>> the number of switches for cdev states.
>>
>> Signed-off-by: Chetankumar Mistry <chetan.mistry@arm.com>
> 
> 
> This is the continuation of the previous idea to have
> better k_* values. You might remember this conversation [1].
> 
> I've spent some time researching papers how and what can be done
> in this field and if possible to plumb in to the kernel.
> We had internal discussions (~2017) of one method fuzzy-logic that I
> found back then, but died at the begging not fitting into this
> IPA kernel specific environment and user-space. Your suggestion with
> observing undershooting and overshooting results sparked better idea.
> I thought it's worth to invest in it but I didn't have
> time. We are lucky, Chetan was designated to help me and
> experiment/implement/test these ideas and here is the patch set.
> 
> He's chosen the Ziegler-Nichols method, which shows really
> good results in benchmarks (Geekbench and GFXbench on hikey960 Android).
> The improved performance in Geekbench is ~10% (vs. old IPA).

+10% perf improvements sounds great. What about the temperature
mitigation (temp avg + stddev) ?

> The main question from our side is the sysfs interface
> which we could be used to trigger this algorithm for
> better coefficients estimations.
> We ask user to echo to some sysfs files in thermal zone
> and start his/her workload. This new IPA 'learns' the system
> utilization and reaction in temperature. After a few rounds,
> we get better fitted coefficients.
> If you need more background about the code or mechanisms, or tests,
> I'm sure Chetan is happy to provide you those.

I'm worried about the complexity of the algorithm and the overhead implied.

The k_* factors are tied with the system and the thermal setup (fan,
heatsink, processor, opp, ...). So IIUC when the factors are found, they
should not change and could be part of the system setup.

Would the algorithm fit better in a separate userspace kernel tooling?
So we can run it once and find the k_* for a board.

Additionally, the values can be stored in the Documentation for
different board and a documentation on how to use the tool.

Then up to the SoC vendor to setup the k_* in sysfs, so no need to
change any interface.

> If you are interested in those analyses we can find a way to share a> .html file with the results from LISA notebook.

Yes,

> We are waiting for your decision regarding the design and user
> interface.
> 
> Regards,
> Lukasz
> 
> [1]
> https://lore.kernel.org/lkml/42360f0f-5d53-085b-536f-33df93b787ca@arm.com/


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
