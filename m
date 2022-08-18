Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D40D59816D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244071AbiHRKYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244083AbiHRKX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:23:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B26132EE2;
        Thu, 18 Aug 2022 03:23:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dc19so2356475ejb.12;
        Thu, 18 Aug 2022 03:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=RplyATs+5DTF+YjIK0v2cAulFjYeMsWMYti/7PKKBuw=;
        b=aYjcQom1/ahKC99eD3zz7Xglze6giU8J2ONzA84VxCMaIbHNGLMuhyFWrKrc+9w/1J
         4VZv0IBDRqeKF0tXVlAit6fA9CsV+A1eVnQL2R5sASz7/3OxN9ShJVhlWdvzSv1HkuFI
         dJ6gYEJONKWNzT0MRY5YI1hynADfkMlkaC2gxfCLf2+AsrO64rwP+jurziekwEpwhDmQ
         uP9HIpDstS2HSBfNzMMsjDsBX0UjCwW1pvhOLsH9yARayXn0FtJyMnY4wLacNOMCyQjD
         aXvun4f7NuepMwHxyPCQz3gsmpFnuYlFm8TijqSeMT9ZPG4wwNHv3zw3olu1Ynu3cYUM
         mTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=RplyATs+5DTF+YjIK0v2cAulFjYeMsWMYti/7PKKBuw=;
        b=CXVvW+Ep89+8zvOu3unaLkaCqJc0MYisXDv3bFLEA0B3RHVzRVDXol/uTpbkfhiVmT
         xtZK9k7kZWDDXAO6Fy+i436Ds8+JkjbVlXhDv+MebxnnfyDTaeHGjG2DDv+LliyzkiKh
         SL+0HTQ9iDsqwdyX52DEqSKKHcl5dpIUf19rPn6nlApkPPFNNqLezJV8B1Vntdvtifet
         fJlbkeHlowpx3Mo4BxLp6oklZYu95uWpnZ/xb/oX0yYRhyairCT+NfZWlQs5c+gDh/9K
         bwdKjVBVOJTFylJ0F19i/QoubnGPVWw7p8zkM9QbSEqC2qRX7tyvPgYQXIceiKvBupHj
         cB/g==
X-Gm-Message-State: ACgBeo351uBO1sUIGPJ2MqMgMRsa0wP6HOi0QqwCIuBxsoWI+cypiCBs
        /gvjGHx/BjZFepyJSYqw4ME=
X-Google-Smtp-Source: AA6agR7v55O6fmuAibhOnU4DaDnmMfWOyg0+OpOuC63m83RUwzfpGMQ5bnZdUFMXatCXdS01KS0sHg==
X-Received: by 2002:a17:906:9bfa:b0:730:cd06:ba3f with SMTP id de58-20020a1709069bfa00b00730cd06ba3fmr1501168ejc.224.1660818234767;
        Thu, 18 Aug 2022 03:23:54 -0700 (PDT)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id a21-20020a50ff15000000b00445bda73fbesm880047edu.33.2022.08.18.03.23.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2022 03:23:53 -0700 (PDT)
Subject: Re: [PATCH 3/3] drm: omapdrm: Do no allocate non-scanout GEMs through
 DMM/TILER
To:     Yongqin Liu <yongqin.liu@linaro.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     tomba@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, merlijn@wizzup.org, tony@atomide.com,
        "Bajjuri, Praneeth" <praneeth@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
References: <1642587791-13222-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1642587791-13222-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <5b6d3e7f-c638-fdc7-5080-44d34abed610@ideasonboard.com>
 <a3ed3a2c-86ce-1c85-e8aa-c08b54ad1a43@gmail.com>
 <CAMSo37XdZSZUHLWJj373DdtOBA9=uD8SJ7ywWCYF2pU1i4cB_g@mail.gmail.com>
 <ed4fe238-4fcd-1253-658f-18fe1e1f13b0@gmail.com>
 <CAMSo37V3U5nYng77jzSnKH73CTLhGYQJu11Q5wRt289se5nFJw@mail.gmail.com>
 <4128aed0-211a-d12a-6a86-deb4457d39f7@gmail.com>
 <CAMSo37W-DePLDP=zk-nY6FGcZuk0QzHj4=usrieyV0TNcNfbXw@mail.gmail.com>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <da2a661e-9da0-850c-3067-8c1e8d5531bc@gmail.com>
Date:   Thu, 18 Aug 2022 13:23:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMSo37W-DePLDP=zk-nY6FGcZuk0QzHj4=usrieyV0TNcNfbXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17.08.22 г. 7:52 ч., Yongqin Liu wrote:
> Hi, Ivaylo
> 
> On Mon, 15 Aug 2022 at 14:23, Ivaylo Dimitrov
> <ivo.g.dimitrov.75@gmail.com> wrote:
>>
>> Hi Liu,
>>
>> On 14.08.22 г. 17:27 ч., Yongqin Liu wrote:
>>> Hi, IvayIo
>>>
>>> Thanks very much for the reply!
>>>
>>> On Sat, 13 Aug 2022 at 14:58, Ivaylo Dimitrov
>>> <ivo.g.dimitrov.75@gmail.com> wrote:
>>>>
>>>> Hi Liu,
>>>>
>>>> On 12.08.22 г. 7:35 ч., Yongqin Liu wrote:
>>>>> Hi, Ivaylo, Tomi
>>>>>
>>>>> We have one X15 Android AOSP master build, it could not have the home
>>>>> screen displayed
>>>>> on the hdmi monitor connected with this change, with the following
>>>>> message printed on the serial console
>>>>>        [  607.404205] omapdrm omapdrm.0: Failed to setup plane plane-0
>>>>>        [  607.410522] omapdrm omapdrm.0: Failed to setup plane plane-1
>>>>>        [  607.416381] omapdrm omapdrm.0: Failed to setup plane plane-2
>>>>>        [  607.422088] omapdrm omapdrm.0: Failed to setup plane plane-3
>>>>>
>>>>>       # for details, please check the link here: http://ix.io/47m1
>>>>>
>>>>> It will work with home screen displayed on the hdmi monitor if this
>>>>> change is reverted.
>>>>>
>>>>> Is this the broken problem you talked about here?
>>>>>
>>>>> And could you please give some suggestions on how to have the x15
>>>>> Android build work with this change?
>>>>>
>>>>
>>>> Make sure scanout (i.e. those to be displayed) buffers are actually
>>>> allocated as such - OMAP_BO_SCANOUT flag must be set when calling
>>>> omap_bo_new().
>>>
>>> I am not familiar with this area, I am sorry if I asked quite silly questions:(
>>> I googled omap_bo_new, and found it's a function of libdrm here[1], is
>>> it what you meant here?
>>>
>>
>> Yes, calling this function from userspace ends in kernel code the
>> $subject patch is part of.
>>
>>> If it's the omap_bo_new that we should pass OMAP_BO_SCANOUT when it is called,
>>> then is it the correct way to update omap_bo_new to add the OMAP_BO_SCANOUT flag
>>> before it calls omap_bo_new_impl?
>>>
>>
>> omap_bo_new() is fine and does not need any updates/fixes, it is the
>> code that uses it (whoever it is, I am not familiar with the userspace
>> you are using) that shall pass correct flags (third parameter) when
>> calling it.
> 
> Sorry, I do not get the point here.
> Like you said, the code that calls omap_bo_new needs to pass OMAP_BO_SCANOUT,
> then IMO omap_bo_new should be the best place to add the OMAP_BO_SCANOUT flag,
> (like via flags = flags | OMAP_BO_SCANOUT), that could help avoid
> missing the flag by some code,
> and also avoids hacks/changes on the possible blob binaries.
> 
> Do I misunderstand somewhere?
> Or is there some case that OMAP_BO_SCANOUT shouldn't be passed when
> omap_bo_new is called?
> 

Exactly. You need to pass OMAP_BO_SCANOUT only when you want your 
buffers to be 'scanout' buffers(i.e. buffers that can be displayed on 
screen), which is not always the case - there is no need offscreen 
buffers or pixmaps to be scanout capable, for example. There are more 
cases like that.

The problem is that scanout buffer on OMAP4 allocate additional 
resources in DMM/TILER (a piece of hardware) and those resources are 
limited. Not only that, but DMM/TILER memory space eventually gets 
fragmented over time (if you have lots of allocataoins/deallocations) 
and you will start getting ENOMEM (or similar) errors.

Ofc, in your particular use case you may never hit such issues.

>> BTW you shall really find who and how uses OMAP BO API, in theory it
>> might use ioctls directly and not call omap_bo_xxx functions.
> 
> Do you mean the DRM_OMAP_GEM_NEW ioctl api?
> There is no place in the AOSP tree to call that except the
> omap_bo_new_impl function,
> which is called by the omap_bo_new and omap_bo_new_tiled functions.
> The omap_bo_new should not be called with the OMAP_BO_TILED flag,
> while the omap_bo_new_tiled should be called with the OMAP_BO_TILED flag
> 
> Regarding to the omap_bo_new function, there are 2 places call it in
> the AOSP tree:
> #1 ./external/libkmsxx/kms++/src/omap/omapframebuffer.cpp
> #2 ./device/ti/beagle_x15/gpu/gralloc.am57x.so
> 
> #1 seems not used in AOSP yet, and #2 is one blob binary we do not
> have the source for.
> 

I would bet on gralloc.am57x.so.

>> strace
>> would be your friend there. or gdb, or whatever tools are used on
>> android. Or put some printfs() in omap_bo_new() that output the PID of
>> the calling process, etc.
> 
> Thanks a lot for these great suggestions! Will use them when possible.
> 
>>> And another question is that, since the userspace(libdrm) will be used
>>> to work with different kernel versions,
>>> like the old 4.14, 4.19, etc, do you think there will be problem to
>>> pass  OMAP_BO_SCANOUT
>>> from the userspace side with the old kernels(which does not have this change)?
>>> does this change need to be backported to the old kernel versions?
>>
>> There should not be any issue. The changes could be backported if one
>> hits the issues this $series is fixing, but there is no need.
> 
> Thanks for the confirmation!
> I just boot-tested with adding OMAP_BO_SCANOUT in the omap_bo_new function,
> and it worked with the current 4.14, 4.19, and the mainline kernels.
> # via adding line "flags = flags | OMAP_BO_SCANOUT" in the omap_bo_new function.
> 

sure, the point is that with this change *every* BO will be allocated as 
scanout BO, potentially leading to the above explained issues.

>>>
>>> And the last question is that, omap_bo_new might be called by some
>>> property binaries what not everyone
>>> could get the source to update, for such case what's your suggestions?
>>>
>>
>> Hard to say without knowing what that library would be.
>>
>> When I hit issues with closed blobs, sometimes I reverse-engineer them
>> to fix the issue, example:
>>
>> https://github.com/maemo-leste/sgx-ddk-um/tree/master/dbm
>>
>> This is REed libdbm from sgx-ddk-um 1.17.4948957, that is responsible
>> for allocating BOs (what omap_bo_new() does) but it uses DUMB buffers
>> API, instead of OMAP BO API.
>>
>> I guess you are using some older version of sgx-ddk-um, so you may fix
>> in similar way. Or binary patch.
> 
> The blob binary that calls omap_bo_new is the gralloc.am57x.so here[2]:
> any suggestions with it?
> # sorry, I am not able to find out how you did the reverse-engineer
> work# with the dbm repository shared here,
> # not sure if you could give some tutorial steps for the similar
> reverse-engineer# work with gralloc.am57x.so
> 

Sorry, but it is like if you ask me to provide you with a tutorial on 
how to do brain surgery :)

> [2]: https://android.googlesource.com/device/ti/beagle-x15/+/refs/heads/master/gpu/gralloc.am57x.so
> 

I investigated this a bit and it seems it calls omap_bo_new() in a 
wrapper function like:

bo = omap_bo_new(dev, -page_size & (size + page_size - 1), ((param5 & 
0x800000) != 0) | OMAP_BO_WC | OMAP_BO_MEM_CONTIG);

Didn't investigate further what param5 is, but it controls if 
OMAP_BO_SCANOUT is passed to omap_bo_new or not.

However, this library was not made with upstream kernel in mind, as 
AFAIK OMAP_BO_MEM_CONTIG never made it upstream:

https://yhbt.net/lore/all/2580272.MiZDHyRxZo@avalon/T/

@Tomi - any comment?

So, you have couple of options:

1. Ask TI for upstream-compatible library.
2. Try to push OMAP_BO_MEM_CONTIG patch upstream.
3. Modify omap_bo_new() to something like:

.
.
.
#define OMAP_BO_MEM_CONTIG	0x00000008	/* only use contiguous dma mem */
.
.
.
if (flags & OMAP_BO_MEM_CONTIG)
   flags |= OMAP_BO_SCANOUT;
.
.
.

This will not achieve exactly what OMAP_BO_MEM_CONTIG is supposed to do, 
but should make it work, at least.

Regards,
Ivo


> Thanks,
> Yongqin Liu
> 
>>>>> On Thu, 17 Feb 2022 at 23:29, Ivaylo Dimitrov
>>>>> <ivo.g.dimitrov.75@gmail.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 17.02.22 г. 14:46 ч., Tomi Valkeinen wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 19/01/2022 12:23, Ivaylo Dimitrov wrote:
>>>>>>>> On devices with DMM, all allocations are done through either DMM or
>>>>>>>> TILER.
>>>>>>>> DMM/TILER being a limited resource means that such allocations will start
>>>>>>>> to fail before actual free memory is exhausted. What is even worse is
>>>>>>>> that
>>>>>>>> with time DMM/TILER space gets fragmented to the point that even if we
>>>>>>>> have
>>>>>>>> enough free DMM/TILER space and free memory, allocation fails because
>>>>>>>> there
>>>>>>>> is no big enough free block in DMM/TILER space.
>>>>>>>>
>>>>>>>> Such failures can be easily observed with OMAP xorg DDX, for example -
>>>>>>>> starting few GUI applications (so buffers for their windows are
>>>>>>>> allocated)
>>>>>>>> and then rotating landscape<->portrait while closing and opening new
>>>>>>>> windows soon results in allocation failures.
>>>>>>>>
>>>>>>>> Fix that by mapping buffers through DMM/TILER only when really needed,
>>>>>>>> like, for scanout buffers.
>>>>>>>
>>>>>>> Doesn't this break users that get a buffer from omapdrm and expect it to
>>>>>>> be contiguous?
>>>>>>>
>>>>>>
>>>>>> If you mean dumb buffer, then no, this does not break users as dumb
>>>>>> buffers are allocated as scanout:
>>>>>>
>>>>>> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/omapdrm/omap_gem.c#L603
>>>>>>
>>>>>> If you mean omap_bo allocated buffers, then if users want
>>>>>> linear(scanout) buffer, then they request it explicitly by passing
>>>>>> OMAP_BO_SCANOUT.
>>>>>>
>>>>>> Ivo
>>>>>
>>>>>
>>>>>
>>>
>>>
>>>
> 
> 
> 
