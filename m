Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020C64A92E6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 05:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356894AbiBDECh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 23:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239888AbiBDECg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 23:02:36 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F98CC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 20:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ZVHTl+4evudUQqpMq9P89GgpdyRepegfNHN+y+ufozM=; b=PhMZnmS9MMflO7XTDTvul9jZwH
        BsGLWg+k6Iy6lPO/8Ns/G6iAcg+4UHE9H0AuqXo3KJcsERpiTk0x87C+OcWGMObU7LUVfuv6mDqmo
        gFXrSaI96tk5dtodHNqG9r7fjIXUqtGRWUbTsHvpgQANN9AeyO51eyLHzCsPFxMTgGVs7efv9ZvTS
        xB4U2Q3Kk3EtbFpPRilzEUszV5mL0ZQMqIIUXouKIkBCeurAGWJPr4U4Sf8ogRVpFY20xqPX5E/sz
        aAYkUOieCK7hKYoBR8ydzu/JTNUkHBVR8p8cVELmLXXdAXmZvkpoxHPvaNISYq1GeWL2iDTgIC+JN
        rQva5CmQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFpng-006jPR-3N; Fri, 04 Feb 2022 04:02:20 +0000
Message-ID: <7ed6137e-cf19-3614-9404-e89389411a8f@infradead.org>
Date:   Thu, 3 Feb 2022 20:02:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Kconfig CONFIG_FB dependency regression
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        John Youn <John.Youn@synopsys.com>,
        Bing Yuan <Bing.Yuan@synopsys.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <6fc4a81f-1a13-bff9-7b2e-d5bec382cb42@synopsys.com>
 <9bab4777-3034-b789-fdf6-ca8d7e6a8c35@infradead.org>
 <CAOMZO5Aa4WxuadfoFGwwyYyD4UGPm-E258xTWU3-ozp_hwG-7g@mail.gmail.com>
 <d8981e2a-4f61-72bb-e5cc-bf4ded29c08a@synopsys.com>
 <CAK8P3a3ELrSC=KX6cr8UnP6kkJN0AXeAE4EG4oUY=Zz7gG_dgg@mail.gmail.com>
 <b44de208-6d5f-3fcd-0e36-f05745297747@synopsys.com>
 <CAK8P3a27RtHxYwtj=rjxcDzkMdKhC-w9ho=SApHpczma_vU8JQ@mail.gmail.com>
 <6743d6b1-13fe-9c83-f706-82338dd03897@synopsys.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6743d6b1-13fe-9c83-f706-82338dd03897@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/22 19:21, Thinh Nguyen wrote:
> Arnd Bergmann wrote:
>> On Thu, Feb 3, 2022 at 12:55 AM Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
>>> Arnd Bergmann wrote:
>>>> On Wed, Feb 2, 2022 at 1:14 AM Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
>>>>> Fabio Estevam wrote:
>>>>
>>>> CONFIG_FB should not normally be needed for booting, so unless
>>>> you have a graphical application in your initramfs that requires the /dev/fb0
>>>> device to work, it is not supposed to make a difference.
>>>>
>>>
>>> I'm not sure, but it seems like the setup we have isn't the only one
>>> that needed it. Fabio also noted that the imx_v6_v7_defconfig also needs
>>> to have CONFIG_FB set.
>>
>> No, that one is different: the change for imx_v6_v7_defconfig was
>> done because they actually use a framebuffer console on some devices,
>> so the patch just adds the symbol to enable the drivers they are using.
>>
>> This is expected with my original patch that doesn't implicitly enable
>> the framebuffer layer any more. What is not expected is for the kernel
>> to hang during boot as you reported for your unidentified platform.
>>
>>>> Are there any other differences in your .config before and after the patch?
>>>> It's possible that you use some other driver that in turn depends on
>>>> CONFIG_FB. Does your machine have any graphical output device?
>>>> If yes, which driver do you use?
>>>
>>> I don't have the answer to those questions yet. Need more investigation.
>>> I'm new to this particular test setup.
>>
>> Do you mean you don't know if there is a screen attached to the system?
>>
> 
> It does have a graphical output device, but I didn't check what it is or
> what driver is driving it. I just notice that after the reported commit,
> something stopped working.
> 
>>>>
>>>> You may also want to make sure that you have 9d6366e743f3 ("drm:
>>>> fb_helper: improve CONFIG_FB dependency") in your kernel, which
>>>> fixes a minor problem with my original patch.
>>>>
>>>
>>> The issue also occurs in mainline, which has your minor fix commit
>>> above. The revert isn't clean for the latest kernel version. I also have
>>> to revert some of the changes along with CONFIG_FB. The revert looks
>>> more like this for the latest kernel:
>>>
>>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>>> index b1f22e457fd0..7cbc733a8569 100644
>>> --- a/drivers/gpu/drm/Kconfig
>>> +++ b/drivers/gpu/drm/Kconfig
>>> @@ -118,8 +118,9 @@ config DRM_DEBUG_MODESET_LOCK
>>>
>>>  config DRM_FBDEV_EMULATION
>>>         bool "Enable legacy fbdev support for your modesetting driver"
>>> -       depends on DRM_KMS_HELPER
>>> -       depends on FB=y || FB=DRM_KMS_HELPER
>>> +       depends on DRM
>>> +       select DRM_KMS_HELPER
>>> +       select FB
>>>         select FB_CFB_FILLRECT
>>>         select FB_CFB_COPYAREA
>>>         select FB_CFB_IMAGEBLIT
>>>
>>>
>>>
>>> I attached the configs for kernel v5.17-rc1. The "bad" config is without
>>> any revert, the "good" config is with the change above.
>>
>> Looking at the config, I see that this is for an x86 machine,
>> and you have the FB_EFI driver and EFI_EARLYCON enabled.
>>
>> What I suspec is going on is that you are looking at a screen rather
>> than a serial console, and the kernel doesn't actually hang but you
>> just don't see any more messages after the DRM driver takes
>> over from EFI_EARLYCON because there is no console driver.
>>
>> In this case, what you see is the intended behavior, not a bug.
>> If you want a graphical console in your system, you need to
>> enable the support for this in your config.
>>
> 
> It sounds like that's the case. Unfortunately I'm not familiar with this
> subsystem to say that's what happening. If there's nothing actually
> broken from review, we can ignore this email thread.

Hi,
I don't know of anything that is broken...

I am curious how CONFIG_FB_EFI came to be set when going from bad.config to
good.config.  Can you explain that?

thanks.
-- 
~Randy
