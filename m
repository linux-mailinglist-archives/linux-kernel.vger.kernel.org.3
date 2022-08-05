Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD33858A782
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbiHEHyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbiHEHyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:54:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6848B10FFE
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 00:54:06 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 130so1561093pfv.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 00:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Owm6wQj2NupeznmO58MYuBD5ySDXzw+r+a5vKcHhcjI=;
        b=vb/YMSTe7wCRRlcGz1iJhcMb2y0+C1VAbNvVaGCQfpA/K1hjRUL7gbGeNZnXEVB1ue
         xIccXFktnnXeiOSCMq9RSdGW9m5ME+6/gPePeHsBRdY5aYdOGroEHc8KY4sLNHf829Tf
         B2gw+FUhgNOnRYxOM+3IWn026m9tWQQSRQ60EZ8YoKFwT/jgqkYPSPASQzHWA2J8qy47
         b91sJOqsTSObfmRxMwp2RYUdXX2z605rPpQ+jV16aQ30yjkWYCjZlM8R8kOnmRZ8X6Z6
         l8UCRFNbylmb09SLlJrlKN8UJ3oePi1wimO2KVtdjfWPFAk55o5L6KUFtrDB1ZEMFcNe
         RAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Owm6wQj2NupeznmO58MYuBD5ySDXzw+r+a5vKcHhcjI=;
        b=nwPuMSB74K8XLjPH8K7ZVnyNvtM8JOFH3Yj3p2vRNIj8C6emVCcBRhc/KcVQxy+nhl
         RX6OwrJpn68IomWr1PPgMOG16A8w6k9qK0vJWR05Z15vkaiq4QadwR7DD1Fwxaw/zK+/
         TGYwZ4VGpmvxiZSdO/BsBpjnWusAwmlDj9i7ti03jn3QOIjXcuCG/JSlNUSvAooy8Ugy
         W/gI61rzMq/0thbmEKDlIzlWWiYL+Pb71+Uji4lSRDNvZnpauKLo0m+RXUK4FPluqmhu
         GR6o2bY693CidKxr7e4ylmDB9XCziWvpc8v1EDz6dEMYeZzTSlhnO/kYyhCpzXg1qRI0
         6Tsw==
X-Gm-Message-State: ACgBeo2z8NwuzSWjXaXpj7UhtWZSPAp2vR7gd7uFEgTvDquPHFie98u3
        gxp2S5Jzqnb+zPErw+cXy+vJKA==
X-Google-Smtp-Source: AA6agR7XjourpJaZx+BeWjp4OgijUr+QbqCz1LdseELKPEH8n9kyxtlLa4Kj5dVJi0ofQ51VfZ/UwQ==
X-Received: by 2002:a05:6a00:140d:b0:52a:d561:d991 with SMTP id l13-20020a056a00140d00b0052ad561d991mr5835961pfu.46.1659686045902;
        Fri, 05 Aug 2022 00:54:05 -0700 (PDT)
Received: from [10.4.82.173] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id z20-20020aa79594000000b0052895642037sm2254764pfj.139.2022.08.05.00.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 00:54:05 -0700 (PDT)
Message-ID: <2782c300-f74e-9d00-cb71-2ea1151f44dc@bytedance.com>
Date:   Fri, 5 Aug 2022 15:54:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0
Subject: Re: [PATCH v2] arm64: run softirqs on the per-CPU IRQ stack
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20220802065325.39740-1-zhengqi.arch@bytedance.com>
 <5dbced25-7cef-7078-78a9-f47545e6a9fe@bytedance.com>
 <CAK8P3a1NmgTEiXDgYyXzAsBDj9cW5_Km=VRyrOX_Sr4dJ1aknw@mail.gmail.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAK8P3a1NmgTEiXDgYyXzAsBDj9cW5_Km=VRyrOX_Sr4dJ1aknw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/5 15:50, Arnd Bergmann wrote:
> On Fri, Aug 5, 2022 at 9:10 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>> On 2022/8/2 14:53, Qi Zheng wrote:
>>> Currently arm64 supports per-CPU IRQ stack, but softirqs
>>> are still handled in the task context.
>>>
>>> Since any call to local_bh_enable() at any level in the task's
>>> call stack may trigger a softirq processing run, which could
>>> potentially cause a task stack overflow if the combined stack
>>> footprints exceed the stack's size, let's run these softirqs
>>> on the IRQ stack as well.
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>>> Acked-by: Will Deacon <will@kernel.org>
>>
>> Are we good to merge it into 6.0-rc1?
> 
> I think you misunderstood the timing that Will proposed in
> 
> https://lore.kernel.org/linux-arm-kernel/d540aaff-ec6a-3f25-dd79-b27b4ad81b36@bytedance.com/
> 
> You should send your patch after 6.0-rc1 has been released, to be merged
> into the linux-next tree and sent as part of the 6.1 merge window.

Oh, got it. I will repost it after 6.0-rc1.

> 
> The two ways patches get merged are:
> 
> - bugfixes can get merged into maintainer trees at any time and sent
>    upstream regardless of the merge window, these never need to wait
> 
> - non-bugfix patches can get merged into maintainer trees based on an
>     -rc release and then sent upstream during the following merge window.

Thanks for such detailed information. :)

> 
>          Arnd

Thanks,
Qi

-- 
Thanks,
Qi
