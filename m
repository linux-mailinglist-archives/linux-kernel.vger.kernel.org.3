Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0643A496551
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiAUSwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:52:31 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:42705 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiAUSvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:51:48 -0500
Received: by mail-ed1-f47.google.com with SMTP id p12so44332769edq.9;
        Fri, 21 Jan 2022 10:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=pr/5QKzb6ToiCGRJqJUCw/c9mGEuN4OsH5UfA8KKh98=;
        b=0hfsO+43bzRH4CModhIp3wee/y2fjXLFXSprp5BO3Fp0smGl6zRAwime9kRx9af4LV
         jivb22dgQ8rEs4C2KGJ4svUeaNKgYgvEiOeVeUQFuxw3b2k6rFL/mAE3V6cl4W3x3r4+
         RIRCaFr4VrmOFpfSaw/32YLGkMFdeHCi12pmFQ4EWiRzY4QbKFg9swGHmDQ1RKu3oJZN
         Znsa0yUIHQrJsMcYYEAyWDtnNeYBF8+hWCaCg3Jpdqe60PN9fVdEdDlKwMBI64odKcfw
         mlwerXhUfiAAdfpuepjbBezjJNEE/cxOOAOnb3YcfLSGlnxK5Al7CN9MU9owZgjceGEn
         HKyg==
X-Gm-Message-State: AOAM532QAJ9CWD6VIzlhp9UKdKjmEHSGrbkuYHD6MJewV0m2+Md0MHbC
        FrsKA5ZX+hCdKsJ/a62OW/Y=
X-Google-Smtp-Source: ABdhPJxj0HoivAhgudAe2G3Y+/yLisodc6m1q7KE10/KIPC2fCSfw2yRzZAR0/F2axmjojQeOh80vg==
X-Received: by 2002:aa7:db8d:: with SMTP id u13mr5423945edt.111.1642791106615;
        Fri, 21 Jan 2022 10:51:46 -0800 (PST)
Received: from [192.168.0.51] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.googlemail.com with ESMTPSA id u18sm2276882eje.37.2022.01.21.10.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 10:51:45 -0800 (PST)
Message-ID: <d24379ab-5627-d37e-d61f-af68dd56ab12@kernel.org>
Date:   Fri, 21 Jan 2022 19:51:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [Patch V3] memory: tegra: Add MC error logging on tegra186 onward
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Snikam@nvidia.com, vdumpa@nvidia.com
References: <1642763962-32129-1-git-send-email-amhetre@nvidia.com>
 <dc9b0c08-bd2a-6ffa-ad75-47afd036f3ef@gmail.com>
 <625e47a5-a6a6-826f-6f9d-f036732588b6@kernel.org>
In-Reply-To: <625e47a5-a6a6-826f-6f9d-f036732588b6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2022 19:49, Krzysztof Kozlowski wrote:
> On 21/01/2022 13:31, Dmitry Osipenko wrote:
>> ...
>>> @@ -529,12 +536,44 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
>>>  		u8 id, type;
>>>  		u32 value;
>>>  
>>> -		value = mc_readl(mc, MC_ERR_STATUS);
>>> +		switch (bit) {
>>
>> Again, I see that the code wasn't tested :/ Shouldn't be too difficult
>> to create memory-read errors to check that at least basics work
>> properly. Please always test your changes next time.
>>
>> So it must be "switch(BIT(bit))" here, please write it like this:
>>
>> u32 intmask = BIT(bit);
>> ...
>> 	switch(intmask) {
>>
> 
> Also, please build your changes with W=1... It's the second try of
> sending un-tested and not-working code. This time also with a compiler
> warning. This looks very bad :(

I am afraid this might be taken too literally and W=1 build will replace
other required steps, so let me be explicit:
We not only expect to compile it but also compile with W=1, run sparse,
smatch and coccicheck. Then also test.

> 
> For big companies with a lot of engineers, like nVidia, it is useful if
> some internal review happens. It is a nice way to offload community
> reviewers which are - like maintainers - a scarce resource. Doing
> internal review is not a requirement, but helps to find such mistakes
> earlier, before using the community. It is simply nice to us.
> 

Best regards,
Krzysztof
