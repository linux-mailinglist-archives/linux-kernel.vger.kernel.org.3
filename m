Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F9851E2C3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 02:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445068AbiEGAft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 20:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbiEGAfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 20:35:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FE15BE51
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 17:32:00 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so12196230pju.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 17:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Wn0dXbP2ZNZ5rtmEUdIAq+AKjqvzHBKlvsWStfjh/W0=;
        b=fOrVM+EV4Gunf/aPtxP1nt32zwg0Xwz4PfvGKYnHCgQwFAwWTfFddYQ/YZ4R+7AKqb
         yiWWR2ufEtrREpn9n4vplBM48DbtYM0u7ut3ChXkCkslhGtgm7lKrSesCev0H/+ruwKV
         RUcFjA56oR02AtOyIvEG4He/xOKdub2cATeQ45KylHC3J+N4e1sr09CX/oxFTm32kvDD
         bEiuOeH3vz12FQVgretkDDpYELaFELIc6FVOqt4G4YCPKtGSfn8wwoIMX7mXf31T6X0Q
         BAX8mKz3jEOI6r6BdE8CROzOUylSc5p6GfOJjTDCIieZRNatDok1m5TYn7FWJm8VPh0D
         oIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wn0dXbP2ZNZ5rtmEUdIAq+AKjqvzHBKlvsWStfjh/W0=;
        b=gzbWchQ+JvMAL0yD1LyDX8vmp6bF0vmxum8pumeWAj044eEPZqMVkGb5uL/zV9EOv5
         PdHF4dX6hbJWWAi1TVrv7ks4ewutRV/+gShGZcxJJdRHcoIkZP8vXt1Ty7xrRhDiDuMd
         rj68391IZyOo+31YIxz44Hiw4xjqItUUyZC62KRwHZ7FcsYqFvvyfvEFPXeBAr1BkmBo
         DWXfZzlnleQng2O3Qom0R2enzMf5hRIhpTXfCyy2M9yd9yaB0rMjsaVTiPOI/SQnVTsW
         myckyFQcf+knv9OysZ1mfuxleI8YHLcC3JKO+ByLy53EBT5mN5emRl/ryDvaWiGNGH5f
         gDAA==
X-Gm-Message-State: AOAM532gbR26kE5Ej8lNgxVrBVMnkRGwP315vU5r/ckfhVMEhfvCqvnL
        D+PpSLyvW7oIlyXTEJd6fAiLqg==
X-Google-Smtp-Source: ABdhPJyckdf3ooD9/x8FQrTgykRhfqi6qP1ZrPcpvmWgj2IWql69kx0Wu/RQ52gT5LiMdQFMnHPxLw==
X-Received: by 2002:a17:902:bd05:b0:158:544d:6557 with SMTP id p5-20020a170902bd0500b00158544d6557mr6514519pls.70.1651883520388;
        Fri, 06 May 2022 17:32:00 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090341c100b0015e8d4eb278sm2471067ple.194.2022.05.06.17.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 17:31:59 -0700 (PDT)
Message-ID: <a60933f2-ef07-92a3-66cf-071670a03101@bytedance.com>
Date:   Sat, 7 May 2022 08:28:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH 3/4] mm/memofy-failure.c: optimize hwpoison_filter
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wu Fengguang <fengguang.wu@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
References: <20220429142206.294714-1-pizhenwei@bytedance.com>
 <20220429142206.294714-4-pizhenwei@bytedance.com>
 <20220506085920.GC1356094@u2004>
 <3c0e25fb-695d-4a29-6de4-c892f89cea7a@bytedance.com>
 <ac3fc5b9-d09c-5fb6-998d-f7c655d7fa00@redhat.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <ac3fc5b9-d09c-5fb6-998d-f7c655d7fa00@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/7/22 00:28, David Hildenbrand wrote:
> On 06.05.22 15:38, zhenwei pi wrote:
>>
>>
>> On 5/6/22 16:59, Naoya Horiguchi wrote:
>>> On Fri, Apr 29, 2022 at 10:22:05PM +0800, zhenwei pi wrote:
>>>> In the memory failure procedure, hwpoison_filter has higher priority,
>>>> if memory_filter() filters the error event, there is no need to do
>>>> the further work.
>>>
>>> Could you clarify what problem you are trying to solve (what does
>>> "optimize" mean in this context or what is the benefit)?
>>>
>>
>> OK. The background of this work:
>> As well known, the memory failure mechanism handles memory corrupted
>> event, and try to send SIGBUS to the user process which uses this
>> corrupted page.
>>
>> For the virtualization case, QEMU catches SIGBUS and tries to inject MCE
>> into the guest, and the guest handles memory failure again. Thus the
>> guest gets the minimal effect from hardware memory corruption.
>>
>> The further step I'm working on:
>> 1, try to modify code to decrease poisoned pages in a single place
>> (mm/memofy-failure.c: simplify num_poisoned_pages_dec in this series).
>>
>> 2, try to use page_handle_poison() to handle SetPageHWPoison() and
>> num_poisoned_pages_inc() together. It would be best to call
>> num_poisoned_pages_inc() in a single place too. I'm not sure if this is
>> possible or not, please correct me if I misunderstand.
>>
>> 3, introduce memory failure notifier list in memory-failure.c: notify
>> the corrupted PFN to someone who registers this list.
>> If I can complete [1] and [2] part, [3] will be quite easy(just call
>> notifier list after increasing poisoned page).
>>
>> 4, introduce memory recover VQ for memory balloon device, and registers
>> memory failure notifier list. During the guest kernel handles memory
>> failure, balloon device gets notified by memory failure notifier list,
>> and tells the host to recover the corrupted PFN(GPA) by the new VQ.
> 
> Most probably you might want to do that asynchronously, and once the
> callback succeeds, un-poison the page.
> 
Yes!

>>
>> 5, host side remaps the corrupted page(HVA), and tells the guest side to
>> unpoison the PFN(GPA). Then the guest fixes the corrupted page(GPA)
>> dynamically.
> 
> I think QEMU already does that during reboots. Now it would be triggered
> by the guest for individual pages.
> 
Yes, currently QEMU supports to un-poison corrupted pages during 
reset/reboot. We can reuse some code to do the work in this case, this 
allows a VM to fix corrupted pages as soon as possible(also no need to 
reset/reboot).

>>
>> Because [4] and [5] are related to balloon device, also CC Michael,
>> David and Jason.
> 
> Doesn't sound too crazy for me, although it's a shame that we always
> have to use virtio-balloon for such fairly balloon-unrelated things.
> 
Thanks!

-- 
zhenwei pi
