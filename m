Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657605A826E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiHaPzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiHaPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:55:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264F17B79D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:55:17 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r204-20020a1c44d5000000b003a84b160addso3852197wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ukcegM/g94feWr92Y7b3EhVRfS5FixGTxdqnrp8f9Ro=;
        b=IoLBxyp/6PXQqlTRyar1lJsw8q/ujTBLewblnaj5stSn4mp6Ir+ny3b0PD89hMJnJt
         XNq3HtBLjfW3MaDjeHOOUNwlb1AI4UNtf9uosGt08Ji+ZPm+XGiEFeYRA0l9MqCQGzo+
         3A3ZVUmYFe6K9ApSEY7ga8W2wn9GKNeoPgJsnFT/h0WEXxxCT8nTVj0+KSFbStHfLXQe
         OS0G/rv4k0Rz5jkTmh1DcV6N9ZzBBGJCbXZpBaHSzgLhW/LnxJysulV9DgpndgA7yj2i
         5UiCinh9KdRlr5A7EaRpH/4n6qRIc14OGsp4vJ7xB9hvLlfSLT2DUK4iitiG20RF3gzi
         2OXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ukcegM/g94feWr92Y7b3EhVRfS5FixGTxdqnrp8f9Ro=;
        b=Wger5ltbfcsFzFvnZiAP9fqXbXYx13NyB/UVEzJDzfCVcJWCVeoU6lUPRItL9aMF9F
         6jSTj3JcZFnoDY5tRxDvk1c6IXuZ9/zKEBSowKIzMsz04JCAxw/l9uY8RJFZ0EifQXYG
         zxup7GDI6z0cRHwwVfSZvzEDCaB6+V9NEaPYQJbSxAIeWSIBPC6EXdATdNAcu+MnvcZY
         Hxkmqtuqnt6ObjhO/oaJ0jJfKi7mVarijsVFghzmxun94OsUjt3g6fKGTZX82LO1hIB7
         CoiW8SewIcN0NHpeMyio3AEF2jDohQDUt8LfKL8wQ0TtivlRK0lpWw9vfR8b+06MsGBp
         CsZw==
X-Gm-Message-State: ACgBeo1CSIpzW+wiUXzXy1SG3BS1fGa7raBqhQX5svJyZ9QALU4EFSSS
        bAG2pdegmPTnyU34leOGnJQ37A==
X-Google-Smtp-Source: AA6agR727wHiMJ6ECV6k7IH8j7RwzJKOVsEMLTFLTdkF3uTBJuF9c8MfL2fYoBM2r+DDkwFFrNT1Nw==
X-Received: by 2002:a1c:a383:0:b0:3a5:af21:1ef0 with SMTP id m125-20020a1ca383000000b003a5af211ef0mr2382771wme.123.1661961311721;
        Wed, 31 Aug 2022 08:55:11 -0700 (PDT)
Received: from [10.35.5.6] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id a11-20020a5d456b000000b0021f15514e7fsm14708953wrc.0.2022.08.31.08.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 08:55:11 -0700 (PDT)
Message-ID: <e9132264-bec6-0f39-ff42-d8b6e95b2492@sifive.com>
Date:   Wed, 31 Aug 2022 16:55:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] soc: sifive: ccache: reduce printing on init
Content-Language: en-GB
To:     Zong Li <zongbox@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Conor.Dooley@microchip.com, zong.li@sifive.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        greentime.hu@sifive.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220829062202.3287-1-zong.li@sifive.com>
 <20220830082620.1680602-1-ben.dooks@sifive.com>
 <fdec1b72-27f3-96e6-5e19-d54ded4aea68@microchip.com>
 <cefcf96f-5bcc-d134-fbe5-d1169313b6f3@codethink.co.uk>
 <CA+ZOyajWRUFppg26O1XHfRuJHWB3jk-=-i=FBV9XYgHgshuwQA@mail.gmail.com>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <CA+ZOyajWRUFppg26O1XHfRuJHWB3jk-=-i=FBV9XYgHgshuwQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2022 06:22, Zong Li wrote:
> Ben Dooks <ben.dooks@codethink.co.uk> 於 2022年8月31日 週三 凌晨1:04寫道：
>>
>> On 30/08/2022 17:30, Conor.Dooley@microchip.com wrote:
>>> On 30/08/2022 09:26, Ben Dooks wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>
>>>> The driver prints out 6 lines on startup, which can easily be redcued
>>>> to two lines without losing any information.
>>>>
>>>> Note, to make the types work better, uint64_t has been replaced with
>>>> ULL to make the unsigned long long match the format in the print
>>>> statement.
>>>>
>>>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>>>> ---
>>>>    drivers/soc/sifive/sifive_ccache.c | 25 +++++++++++--------------
>>>>    1 file changed, 11 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
>>>> index 46ce33db7d30..65a10a6ee211 100644
>>>> --- a/drivers/soc/sifive/sifive_ccache.c
>>>> +++ b/drivers/soc/sifive/sifive_ccache.c
>>>> @@ -76,20 +76,17 @@ static void setup_sifive_debug(void)
>>>>
>>>>    static void ccache_config_read(void)
>>>>    {
>>>> -       u32 regval, val;
>>>> -
>>>> -       regval = readl(ccache_base + SIFIVE_CCACHE_CONFIG);
>>>> -       val = regval & 0xFF;
>>>> -       pr_info("CCACHE: No. of Banks in the cache: %d\n", val);
>>>> -       val = (regval & 0xFF00) >> 8;
>>>> -       pr_info("CCACHE: No. of ways per bank: %d\n", val);
>>>> -       val = (regval & 0xFF0000) >> 16;
>>>> -       pr_info("CCACHE: Sets per bank: %llu\n", (uint64_t)1 << val);
>>>> -       val = (regval & 0xFF000000) >> 24;
>>>> -       pr_info("CCACHE: Bytes per cache block: %llu\n", (uint64_t)1 << val);
>>>> -
>>>> -       regval = readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
>>>> -       pr_info("CCACHE: Index of the largest way enabled: %d\n", regval);
>>>> +       u32 cfg;
>>>> +
>>>> +       cfg = readl(ccache_base + SIFIVE_CCACHE_CONFIG);
>>>> +
>>>> +       pr_info("CCACHE: %u banks, %u ways, sets/bank=%llu, bytes/block=%llu\n",
>>>> +               (cfg & 0xff), (cfg >> 8) & 0xff,
>>>> +               1ULL << ((cfg >> 16) & 0xff),
>>>
>>> This is just BIT_ULL((cfg >> 16) & 0xff), no?
>>> Would be nice too if these were defined, so you'd have something
>>> like BIT_ULL((cfg >> SETS_PER_BANK_SHIFT) & 0xff)
>>>
>>> I do like the cleanup of the uint64_t & cutting down on the prints
>>> though :) Again, it'd be nice if you and Zong could collaborate on
>>> a combined v2.
>>
>> I think even BIT_UL() would do here, if someone is going to make a
>> cache bigger than 2GiB we'll probably be quite old by then, so v2
>> might have the last two values down as %lu.
>>
> 
> Hi Ben,
> Thanks for your suggestion, If you don't mind, I will take this into
> my V2 patchset.

Thanks.

I may well post v2 of this tomorrow with the BIT_ULL() suggestions
from Conor, or even down to BIT_UL() and use %lu as noted.

> 
>>> Thanks,
>>> Conor.
>>>
>>>> +               1ULL << ((cfg >> 24) & 0xff));
>>>> +
>>>> +       cfg = readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
>>>> +       pr_info("CCACHE: Index of the largest way enabled: %d\n", cfg);
>>>>    }
>>>>
>>>>    static const struct of_device_id sifive_ccache_ids[] = {
>>>> --
>>>> 2.35.1
>>>>
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>>
>>
>> --
>> Ben Dooks                               http://www.codethink.co.uk/
>> Senior Engineer                         Codethink - Providing Genius
>>
>> https://www.codethink.co.uk/privacy.html
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

