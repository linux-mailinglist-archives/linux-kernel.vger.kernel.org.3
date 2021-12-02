Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABED6466BC1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 22:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377149AbhLBVri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377128AbhLBVrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:47:37 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234ECC06174A;
        Thu,  2 Dec 2021 13:44:14 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q16so1038322pgq.10;
        Thu, 02 Dec 2021 13:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kwtlx3rKw93kF2r0vr4LpXNW4MUM1QQz/4nwEzzQ1qo=;
        b=IKniZ/YD4ttaPJonrP6m+9+a37GGvJat5/hlsHogDcZJpgpmjqFThVNbmRMMPStNzi
         NRT6uHTz5cYffrLMMt540HN+ThquoOIQ6qZ1Y1Yw2eggTCvVYrkirxGPZMrlSF1gTKV2
         ViEMJwM+c/1cacsrDcGm8EjWIX23nVjAfVhIxxnkD/ZrfxSHlEWZ0wiEHfMqoimYFgQe
         ctWRqZtMXxa4ItqS6hKwvHsHPXbyZLtrWWohpOko1FIqhy9FPeyWu10183tIMGTuNlNl
         uilYv4wP7Cfc7CQOluEllC8lIsabYjWSz+hXiZlmEStQ1IufG5qRx5Byyq7h5CpNbgeH
         tv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kwtlx3rKw93kF2r0vr4LpXNW4MUM1QQz/4nwEzzQ1qo=;
        b=jwxkmzS3/nNoD5+CAVLx3b2bY0b37sTFaejvtv9j3JmadL8vioj6fYXSfqlcTP7aCI
         hUF77aeMrDzUTAsEiw2uOZ1djuCJDbYcWEwr+BDkKVws1V5aqgilqBGvgwo+NQpwRFfX
         dc/lh9bDQxX+9ev2yOHPKgmcWLPjc9abAQQSGluFqFToav0jD/UFbqEZhDM4htRv46V2
         hzjDVHXqQw1ICeSZTgA7DxXUrxxYQoi5VQUqdyrXRR7IFJy4mTKNZtWg+nLAZGgQ7r5w
         Xm4z4Cuu9cJu5iIWD51Drj7Gx3DBSPZxkcqhbgnJzjku8Q9X44ZygVcAt5Dty41QXhtB
         BZEQ==
X-Gm-Message-State: AOAM531pPW6NBtn0OySh7nlkJ4zX+BRIN3vhlASZP2pScFUX4KFXDlOb
        1nwCwl7vNveW8L+zcD0VjdA=
X-Google-Smtp-Source: ABdhPJzvsY9Unots2NzCZQvbQpuBpv9L3Puaz12SDCySbcq+KObJH0CEGUEVsvtIFpu1HLWTX8w47w==
X-Received: by 2002:a62:8042:0:b0:4a8:15eb:db10 with SMTP id j63-20020a628042000000b004a815ebdb10mr14776369pfd.28.1638481453588;
        Thu, 02 Dec 2021 13:44:13 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t8sm729728pfj.26.2021.12.02.13.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 13:44:13 -0800 (PST)
Subject: Re: [PATCH v3 1/3] irqchip: Pass platform_device pointer to init_cb
To:     Marc Zyngier <maz@kernel.org>, Shawn Guo <shawn.guo@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Neil Armstrong <narmstrong@baylibre.com>
References: <20211202122122.23548-1-shawn.guo@linaro.org>
 <20211202122122.23548-2-shawn.guo@linaro.org>
 <b221fec0-43d0-537d-d78e-84da10a9c2d7@gmail.com>
 <fa6ae407c1da16e571aaf04eb424fecd@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5db6079b-2d8e-9126-5f49-fc891765e360@gmail.com>
Date:   Thu, 2 Dec 2021 13:44:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <fa6ae407c1da16e571aaf04eb424fecd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 11:10 AM, Marc Zyngier wrote:
> On 2021-12-02 17:52, Florian Fainelli wrote:
>> On 12/2/21 4:21 AM, Shawn Guo wrote:
>>> It makes sense to just pass device_node for callback in IRQCHIP_DECLARE
>>> case, but not so much for IRQCHIP_PLATFORM_DRIVER one, because
>>> platform_driver probe/init usually needs device pointer for various
>>> purposes, e.g. resource allocation, service request, device prefixed
>>> message output, etc.  Create a new callback type irqchip_init_cb_t which
>>> takes platform_device pointer as parameter, and update the existing
>>> IRQCHIP_PLATFORM_DRIVER users accordingly.
>>>
>>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>>> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
>>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>>
>> Could you copy all recipients on all 3 patches plus your cover letter
>> next time so we have the full context? Thanks!
>>
>> [snip]
>>
>>>
>>> -static int __init bcm7120_l2_intc_probe_7120(struct device_node *dn,
>>> +static int __init bcm7120_l2_intc_probe_7120(struct platform_device
>>> *pdev,
>>>                           struct device_node *parent)
>>>  {
>>> -    return bcm7120_l2_intc_probe(dn, parent,
>>> bcm7120_l2_intc_iomap_7120,
>>> +    return bcm7120_l2_intc_probe(pdev->dev.of_node, parent,
>>> +                     bcm7120_l2_intc_iomap_7120,
>>>                       "BCM7120 L2");
>>
>> If you look further into that driver, you will see that we do something
>> like this in bcm7120_l2_intc_probe:
>>
>>           pdev = of_find_device_by_node(dn);
>>           if (!pdev) {
>>                   ret = -ENODEV;
>>                   goto out_free_data;
>>           }
>>
>> which would be completely superfluous now that we pass a platform_device
>> directly. Can you rework your patch so as to eliminate that
>> of_find_device_by_ndoe() (and the companion put_device call)?
> 
> Or just adopt the same construct in the MPM driver. At this stage, drivers
> requiring a platform_device are the minority.

Works for me.
-- 
Florian
