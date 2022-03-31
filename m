Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EFA4ED3DE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiCaGZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiCaGZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:25:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676D31EC9AB;
        Wed, 30 Mar 2022 23:23:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qa43so45873049ejc.12;
        Wed, 30 Mar 2022 23:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=w5BXLzExPvLy27DAJ3ZamzJyzqTGo81JxFpaPVP/VLA=;
        b=olJo5YdOtfqTBQM9Ub3iNkh8oeIA86UqihpWIbCdVSf2biR8yB7EzT3Td1z6nidWJl
         hXbVwamwSal2W0CcQVDh8JHBHRDUU7cHYk4yX2/2JI9dLA7MfY95oe03qAGgTjF5H783
         LLQ2VH/g9H9OPMOGog4thFk3jzupi0V2On9pTBSKgDXK+P9tHSIMfSKbiKI3T5iFi5XT
         U3vyA7lQoBnpsbW+cPWChWWwHVMD5+9MgEBqJ6mZI0p1GBuadVl1qaDG8M6spVZH48gw
         GTvKV+t+yMt0x8QwdmRvP4U1WaDBAsnwGQCpdIs6VBlGHwcCCbw0KKo2AbKsx0nm8mQ1
         Tk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w5BXLzExPvLy27DAJ3ZamzJyzqTGo81JxFpaPVP/VLA=;
        b=Eg8VaiFceIrD1Y6w8Fd92sYu7izgEynYm0BkfEODlxW8MhbZjovrJsXZvU4H2zvkl2
         WifQeaw5XSdkXyYz4BE0A0yIMJqWjaRX6FbNvHJYp8thEsO02ZfF0f4l+KTjgk9eZNLF
         OmTVGlpiFM/8T3f4btZ2pp7n4gsk0Sa+j0ttnys8Bz05nhmKt5QPrL4k9WgKuYWv6dC9
         0uzIcsA0goi7OtJba8V4ELgwsbNYz1HquFO00Op9lxIUm6BHS+tkgTQNlUfukyst5LX6
         bl74E/y8UO87kvSB5exUHelU96EYKARiAM3ovFITOGe5WNUyKkVqqr6o0u6hwfyIcI29
         FI+w==
X-Gm-Message-State: AOAM530AC4Q+wwYv3KJt8lB9RWltBVVrMoXS26qwC9F6aGImvtQW2Wnf
        37eSxzh3tz+E8lX2wqoG7mc=
X-Google-Smtp-Source: ABdhPJxO80/M/f7BqS/olgn8Kzmn3xXrn20lQSM53d9a1FvcAf1W9tQ77sqsf7hkTpHjWEUDxo1xCA==
X-Received: by 2002:a17:907:1614:b0:6df:678a:a7d5 with SMTP id hb20-20020a170907161400b006df678aa7d5mr3507506ejc.719.1648707814453;
        Wed, 30 Mar 2022 23:23:34 -0700 (PDT)
Received: from [192.168.178.21] (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
        by smtp.gmail.com with ESMTPSA id hp11-20020a1709073e0b00b006dfd53a0e39sm9004473ejc.135.2022.03.30.23.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 23:23:33 -0700 (PDT)
Message-ID: <2d1f9ba9-ea2a-e41c-eae6-0ba348cdf202@gmail.com>
Date:   Thu, 31 Mar 2022 08:23:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Linaro-mm-sig] [PATCH next] dma-buf/sync-file: do not allow zero
 size allocations
Content-Language: en-US
To:     Pavel Skripkin <paskripkin@gmail.com>, sumit.semwal@linaro.org,
        gustavo@padovan.org, christian.koenig@amd.com,
        daniel.vetter@ffwll.ch
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        syzbot+5c943fe38e86d615cac2@syzkaller.appspotmail.com
References: <20220329221425.22691-1-paskripkin@gmail.com>
 <8af3d213-6cb7-a021-c198-e1bd37c47e7c@gmail.com>
 <ecf7ccdd-0d6f-9407-6778-ae7f0a6bf538@gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <ecf7ccdd-0d6f-9407-6778-ae7f0a6bf538@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 30.03.22 um 20:24 schrieb Pavel Skripkin:
> Hi Christian,
>
> On 3/30/22 10:09, Christian König wrote:
>> That problem is already fixed with patch 21d139d73f77 dma-buf/sync-file:
>> fix logic error in new fence merge code.
>>
>> Am 30.03.22 um 00:14 schrieb Pavel Skripkin:
>>> syzbot reported GPF in dma_fence_array_first(), which is caused by
>>> dereferencing ZERO_PTR in dma-buf internals.
>>>
>>> ZERO_PTR was generated in sync_file_merge(). This functuion tries to
>>> reduce allocation size, but does not check if it reducing to 0.
>>
>> This is actually perfectly ok. The code above should have prevented the
>> size to become 0.
>>
>> Regards,
>> Christian.
>>
>
> Thanks for your reply! I see that 21d139d73f77 fixes GPF in 
> dma_fence_array_first(), but what about this part:
>
>>>   -    if (num_fences > INT_MAX)
>>> +    if (num_fences > INT_MAX || !num_fences)
>>>           goto err_free_sync_file;
>>>         fences = kcalloc(num_fences, sizeof(*fences), GFP_KERNEL);
>>> @@ -264,7 +264,7 @@ static struct sync_file *sync_file_merge(const 
>>> char *name, struct sync_file *a,
>>>       if (index == 0)
>
> If num_fences is equal to zero then fences dereference will cause an 
> oops. Or this one is also fixed in your tree?

Well it is illegal for sync_file->fence to be NULL or we would run into 
NULL pointer dereference much more often, so num_fences can't be zero 
here either.

Regards,
Christian.

>
>
> Thanks!
>
>
>
>
> With regards,
> Pavel Skripkin

