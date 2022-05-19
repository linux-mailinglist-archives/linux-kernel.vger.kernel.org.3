Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F3552CBD4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 08:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbiESGPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 02:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiESGPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:15:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4D88CB38;
        Wed, 18 May 2022 23:15:36 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x143so4230642pfc.11;
        Wed, 18 May 2022 23:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GM2DilYnUlbpl9c8YbSsfo3PD4EXIuNCsM/7fLpZMbk=;
        b=ZgWtyXFcN42Su4w/dRiLt//+1HTaLTF0NYjXRAkxuvqe+tSlBwTFp/PV4/Zoe5oH2w
         QpQjeihipmITPEWD0+r3qzjVi73UN784Lpf0rRZqtY1xu1DZjgTjyJDeD3dkyNMEJtVq
         kLENc+N5nuaNZ/IFO2KOwoMLkE0S9GtXzrbPF2ncePgEKONKiOOVUeC5XK64Jgs4PxkN
         4g8NO8bDZqMtEVUc7P0Hfk2ukxEFq9XdhiuWYi47Gk8+iT0f+FplQlzFWtjzrCe7wkg8
         4rb/OzSrQHFPfBTvFr/a/qse3AP8nAUKhTc00A1Yd13mqGS3PfFNkCX9Vhsd99fcp6tA
         HmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GM2DilYnUlbpl9c8YbSsfo3PD4EXIuNCsM/7fLpZMbk=;
        b=O3riVZWYwTyhsT4TiOmftytn/Xa3PUb98bY4OqvS1KVu0I+ucoSh4tzRFX9DM61U/N
         +Jo0OI9a8Vsf/7mFRky/bEj4xwd+Sdtb42PXU3QBwY44BwGy+MOEmv3vpgaVlIClnyDs
         OwpR95pxi4LRh9FXFWM/ZLEGSAFbGrn123IqHYhaGxIKUeGPX3yJQFhi7HwY9fpGJAyA
         Vp4yZ2SBSFwHN1EZ7WLHjk+RlNAFSJPpunyWnmwaUdnGxsb67yDWSO+3vSDhZPIyUXAH
         hDNg75IkLFD19dnQmOZw8sow9pnjj21PAAvYMX50wXwxxSaRUhlVS7NqLypdOUv4siKK
         UueQ==
X-Gm-Message-State: AOAM532KwEWJjBLQnVYzaiPG6NGvgIfEtQUxYhI5KNvmFTOxPgSnu6rL
        loNG/splCFdWbK5sI+OaIdY=
X-Google-Smtp-Source: ABdhPJzP+YquqdsWg1hwqj8EvjvRXcdk1HrEyT49vwaBOgDIvC7lsbT7Hl57goCwnXHPUImn1Ergvg==
X-Received: by 2002:a05:6a00:cd5:b0:510:7f58:267b with SMTP id b21-20020a056a000cd500b005107f58267bmr3115337pfv.67.1652940935821;
        Wed, 18 May 2022 23:15:35 -0700 (PDT)
Received: from [192.168.2.225] (93.179.119.173.16clouds.com. [93.179.119.173])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090ae50f00b001dc1e6db7c2sm4661938pjy.57.2022.05.18.23.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 23:15:35 -0700 (PDT)
Message-ID: <29d66a46-d141-2d02-45dd-a8931786588e@gmail.com>
Date:   Thu, 19 May 2022 14:15:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] psi: add support for multi level pressure stall
 trigger
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Chen Wandun <chenwandun@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20220516033524.3130816-1-chenwandun@huawei.com>
 <30b37eeb-e77b-882e-fc24-3367321a8ca3@gmail.com>
 <CAJuCfpE7fBsp8ntYVeLsW7Cd0Z09OmxN75X9Az_Qco0GJrz3Wg@mail.gmail.com>
 <CAJuCfpH-BDqsft1YvGFhkbR60VC0TJgfXKRVN+80e0iqQdhxpA@mail.gmail.com>
 <3a31521f-a68a-b2a9-baae-9a458ee17033@huawei.com>
 <070fe87d-43a0-5e4f-e4c7-c44782c2c195@gmail.com>
 <CAJuCfpH1mTxe5hmzZTe+AbPFse9heenx8uhGzCXE6fAh5G8SzA@mail.gmail.com>
From:   Alex Shi <seakeel@gmail.com>
In-Reply-To: <CAJuCfpH1mTxe5hmzZTe+AbPFse9heenx8uhGzCXE6fAh5G8SzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/22 05:38, Suren Baghdasaryan wrote:
> On Wed, May 18, 2022 at 3:29 AM Alex Shi <seakeel@gmail.com> wrote:
>>
>>
>>
>> On 5/17/22 20:46, Chen Wandun wrote:
>>>>>> This breaks the old ABI. And why you need this new function?
>>>>> Both great points.
>>>> BTW, I think the additional max_threshold parameter could be
>>>> implemented in a backward compatible way so that the old API is not
>>>> broken:
>>>>
>>>> arg_count = sscanf(buf, "some %u %u %u", &min_threshold_us,  &arg2, &arg3);
>>>> if (arg_count < 2) return ERR_PTR(-EINVAL);
>>>> if (arg_count < 3) {
>>>>      max_threshold_us = INT_MAX;
>>>>      window_us = arg2;
>>>> } else {
>>>>      max_threshold_us = arg2;
>>>>      window_us = arg3;
>>>> }
>>> OK
>>>
>>> Thanks.
>>>> But again, the motivation still needs to be explained.
>>> we want do different operation for different stall level,
>>> just as prev email explain, multi trigger is also OK in old
>>> ways, but it is a litter complex.
>>
>> In fact, I am not keen for this solution, the older and newer
>> interface is easy to be confused by users, for some resolvable
>> unclear issues. It's not a good idea.
> 
> Maybe adding the max_threshold as an optional last argument will be
> less confusing? Smth like this:
> 
> some/full min_threshold window_size [max_threshold]

It's already confused enough. :)
BTW, I still don't see the strong reason for the pressure range.

> > Also, if we do decide to add it, there should be a warning in the
> documentation that max_threshold usage might lead to a stall being
> missed completely. In your example:
> 
> echo "some 150000 350000 1000000" > /proc/pressure/memory
> 
> If there is a stall of more than 350ms within a given window, that
> trigger will not fire at all.

Right. 
And what if others propose more pressure combinations?
Maybe leave them to user space is more likely workable?

Thanks
Alex
