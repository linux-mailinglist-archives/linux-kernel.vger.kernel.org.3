Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC65C592991
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiHOGYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiHOGXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:23:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777C0193C2;
        Sun, 14 Aug 2022 23:23:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qn6so11925182ejc.11;
        Sun, 14 Aug 2022 23:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=g6xD4nL/8TaKP3Oc8FoGSHeffZNL83IBED3zRKVGQAg=;
        b=iQsGt7d2MVUBuZSkGPZ/w5qO2/pn1fzc4aWxHBNEIbM7xzGmz0EXG3AEcktGZxO7My
         mihhuQi7dotX1/Zcs3AohuIUNNB55Gw2xCu8xDkHGPPL4H+ElATE3539AyQtHG4ppO68
         wbE5IELWiFYaW7EAy/+0za41PEVPTeOjuUEcX9VdEO1zsETJXH2Kd4NHuJeJx04NuMTd
         DlPgH0sgt/BhtXWkorwdfqCH/4YSKYCj4ED+9uFNRWbAMPL9CTJdzGWoKj3MfDNhiOAN
         ymAMZxoTuukhWq82ROeDw6EbeQHqqEg8hBZxvypEcJwvf8hA1TM+YP72/CCwAPq+HnTa
         oEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=g6xD4nL/8TaKP3Oc8FoGSHeffZNL83IBED3zRKVGQAg=;
        b=C9z/LPIvYUteaYnFtmmBTk5x+DI0QeUxGX0IUnby2CENlRO7hKM9QXiUtHA24/GQKG
         o3g4mK1+hMXuiiIc1MalXa1khZ1cnM4UjsxNiAerwgCxfV0OTt6E6EQlLseLOnjNbB11
         VhP2ISYTVllL071i12DX0gdBKt2O7ZYnUepnj2FcwdbGwAwBpEh8j+lkkc7qOTIiGAVW
         aLNQwA6TmQ8nlpx44qHAjkMBSoBOkajAqTPqumtMvIcMEsRQRTOgmXDhSDUwocY+756P
         FBRCeZZKDQfUim1HFcjnLCvzhGbiDVwHQ4u/kmZj6LAxXYpevdK5zDFkccboaqP6GxZq
         82UA==
X-Gm-Message-State: ACgBeo06KHARrTXW+MIHr5gBY57errOn9hKti+txjb8je9WXwc9zMbW7
        CGhEniUi2Fanuy0WhL3Ki1k=
X-Google-Smtp-Source: AA6agR5SOSjcUz28Aqy1iZqJzrtsPW/+H1VYz/5JKhpZCCR2J3Nky25QvvgHoG9nAu+QRmwX6Fbv5g==
X-Received: by 2002:a17:906:8a44:b0:730:9d18:17b5 with SMTP id gx4-20020a1709068a4400b007309d1817b5mr9417763ejc.378.1660544612813;
        Sun, 14 Aug 2022 23:23:32 -0700 (PDT)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id u4-20020a50eac4000000b0043ba7df7a42sm6022349edp.26.2022.08.14.23.23.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Aug 2022 23:23:32 -0700 (PDT)
Subject: Re: [PATCH 3/3] drm: omapdrm: Do no allocate non-scanout GEMs through
 DMM/TILER
To:     Yongqin Liu <yongqin.liu@linaro.org>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, tomba@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        merlijn@wizzup.org, tony@atomide.com,
        "Bajjuri, Praneeth" <praneeth@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>
References: <1642587791-13222-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1642587791-13222-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <5b6d3e7f-c638-fdc7-5080-44d34abed610@ideasonboard.com>
 <a3ed3a2c-86ce-1c85-e8aa-c08b54ad1a43@gmail.com>
 <CAMSo37XdZSZUHLWJj373DdtOBA9=uD8SJ7ywWCYF2pU1i4cB_g@mail.gmail.com>
 <ed4fe238-4fcd-1253-658f-18fe1e1f13b0@gmail.com>
 <CAMSo37V3U5nYng77jzSnKH73CTLhGYQJu11Q5wRt289se5nFJw@mail.gmail.com>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <4128aed0-211a-d12a-6a86-deb4457d39f7@gmail.com>
Date:   Mon, 15 Aug 2022 09:23:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMSo37V3U5nYng77jzSnKH73CTLhGYQJu11Q5wRt289se5nFJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

On 14.08.22 г. 17:27 ч., Yongqin Liu wrote:
> Hi, IvayIo
> 
> Thanks very much for the reply!
> 
> On Sat, 13 Aug 2022 at 14:58, Ivaylo Dimitrov
> <ivo.g.dimitrov.75@gmail.com> wrote:
>>
>> Hi Liu,
>>
>> On 12.08.22 г. 7:35 ч., Yongqin Liu wrote:
>>> Hi, Ivaylo, Tomi
>>>
>>> We have one X15 Android AOSP master build, it could not have the home
>>> screen displayed
>>> on the hdmi monitor connected with this change, with the following
>>> message printed on the serial console
>>>       [  607.404205] omapdrm omapdrm.0: Failed to setup plane plane-0
>>>       [  607.410522] omapdrm omapdrm.0: Failed to setup plane plane-1
>>>       [  607.416381] omapdrm omapdrm.0: Failed to setup plane plane-2
>>>       [  607.422088] omapdrm omapdrm.0: Failed to setup plane plane-3
>>>
>>>      # for details, please check the link here: http://ix.io/47m1
>>>
>>> It will work with home screen displayed on the hdmi monitor if this
>>> change is reverted.
>>>
>>> Is this the broken problem you talked about here?
>>>
>>> And could you please give some suggestions on how to have the x15
>>> Android build work with this change?
>>>
>>
>> Make sure scanout (i.e. those to be displayed) buffers are actually
>> allocated as such - OMAP_BO_SCANOUT flag must be set when calling
>> omap_bo_new().
> 
> I am not familiar with this area, I am sorry if I asked quite silly questions:(
> I googled omap_bo_new, and found it's a function of libdrm here[1], is
> it what you meant here?
> 

Yes, calling this function from userspace ends in kernel code the 
$subject patch is part of.

> If it's the omap_bo_new that we should pass OMAP_BO_SCANOUT when it is called,
> then is it the correct way to update omap_bo_new to add the OMAP_BO_SCANOUT flag
> before it calls omap_bo_new_impl?
> 

omap_bo_new() is fine and does not need any updates/fixes, it is the 
code that uses it (whoever it is, I am not familiar with the userspace 
you are using) that shall pass correct flags (third parameter) when 
calling it.

BTW you shall really find who and how uses OMAP BO API, in theory it 
might use ioctls directly and not call omap_bo_xxx functions. strace 
would be your friend there. or gdb, or whatever tools are used on 
android. Or put some printfs() in omap_bo_new() that output the PID of 
the calling process, etc.

> And another question is that, since the userspace(libdrm) will be used
> to work with different kernel versions,
> like the old 4.14, 4.19, etc, do you think there will be problem to
> pass  OMAP_BO_SCANOUT
> from the userspace side with the old kernels(which does not have this change)?
> does this change need to be backported to the old kernel versions?

There should not be any issue. The changes could be backported if one 
hits the issues this $series is fixing, but there is no need.

> 
> And the last question is that, omap_bo_new might be called by some
> property binaries what not everyone
> could get the source to update, for such case what's your suggestions?
> 

Hard to say without knowing what that library would be.

When I hit issues with closed blobs, sometimes I reverse-engineer them 
to fix the issue, example:

https://github.com/maemo-leste/sgx-ddk-um/tree/master/dbm

This is REed libdbm from sgx-ddk-um 1.17.4948957, that is responsible 
for allocating BOs (what omap_bo_new() does) but it uses DUMB buffers 
API, instead of OMAP BO API.

I guess you are using some older version of sgx-ddk-um, so you may fix 
in similar way. Or binary patch.

Regards,
Ivo

> [1]: https://gitlab.freedesktop.org/mesa/drm/-/blob/main/omap/omap_drm.c#L227
> 
> Thanks,
> Yongqin Liu
>>> On Thu, 17 Feb 2022 at 23:29, Ivaylo Dimitrov
>>> <ivo.g.dimitrov.75@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 17.02.22 г. 14:46 ч., Tomi Valkeinen wrote:
>>>>> Hi,
>>>>>
>>>>> On 19/01/2022 12:23, Ivaylo Dimitrov wrote:
>>>>>> On devices with DMM, all allocations are done through either DMM or
>>>>>> TILER.
>>>>>> DMM/TILER being a limited resource means that such allocations will start
>>>>>> to fail before actual free memory is exhausted. What is even worse is
>>>>>> that
>>>>>> with time DMM/TILER space gets fragmented to the point that even if we
>>>>>> have
>>>>>> enough free DMM/TILER space and free memory, allocation fails because
>>>>>> there
>>>>>> is no big enough free block in DMM/TILER space.
>>>>>>
>>>>>> Such failures can be easily observed with OMAP xorg DDX, for example -
>>>>>> starting few GUI applications (so buffers for their windows are
>>>>>> allocated)
>>>>>> and then rotating landscape<->portrait while closing and opening new
>>>>>> windows soon results in allocation failures.
>>>>>>
>>>>>> Fix that by mapping buffers through DMM/TILER only when really needed,
>>>>>> like, for scanout buffers.
>>>>>
>>>>> Doesn't this break users that get a buffer from omapdrm and expect it to
>>>>> be contiguous?
>>>>>
>>>>
>>>> If you mean dumb buffer, then no, this does not break users as dumb
>>>> buffers are allocated as scanout:
>>>>
>>>> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/omapdrm/omap_gem.c#L603
>>>>
>>>> If you mean omap_bo allocated buffers, then if users want
>>>> linear(scanout) buffer, then they request it explicitly by passing
>>>> OMAP_BO_SCANOUT.
>>>>
>>>> Ivo
>>>
>>>
>>>
> 
> 
> 
