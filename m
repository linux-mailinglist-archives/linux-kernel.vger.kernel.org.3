Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3D24CC0F8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiCCPRA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Mar 2022 10:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiCCPQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:16:58 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762CE190C30;
        Thu,  3 Mar 2022 07:16:12 -0800 (PST)
Date:   Thu, 03 Mar 2022 15:15:54 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v16 4/4] drm/bridge: dw-hdmi: fix bus formats negotiation
 for 8 bit modes
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Paul Boddie <paul@boddie.org.uk>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>
Message-Id: <I2D68R.CP2B1MABRO51@crapouillou.net>
In-Reply-To: <d75cd860-2a4c-6f81-b5d0-dc75f37b7150@baylibre.com>
References: <cover.1645895582.git.hns@goldelico.com>
        <169afe64b4985c3f420177cd6f4e1e72feeb2449.1645895582.git.hns@goldelico.com>
        <5da069b6-8a99-79c2-109c-c85715165857@baylibre.com>
        <E0D3B7E8-0C8D-4119-8267-0556AB921B24@goldelico.com>
        <fca28594-8d4e-dd2f-93a0-a052cb888d90@baylibre.com>
        <75CBD357-577A-402D-9E3B-DBE82A84BC43@goldelico.com>
        <4cb08b5d-c1ec-f2b4-a107-63a771146ec0@baylibre.com>
        <598F3A49-9CE2-4C59-95D4-CDA888A3B3BF@goldelico.com>
        <3625b23b-9718-640a-1aac-0b30773a26ab@baylibre.com>
        <E95145AB-DEFC-419D-B926-B0BAF0985D09@goldelico.com>
        <d75cd860-2a4c-6f81-b5d0-dc75f37b7150@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

Any feedback on the other patches?

They look fine to me, but I still need an ack to merge them in 
drm-misc-next.

Cheers,
-Paul


Le jeu., mars 3 2022 at 12:42:02 +0100, Neil Armstrong 
<narmstrong@baylibre.com> a écrit :
> On 03/03/2022 11:40, H. Nikolaus Schaller wrote:
>> Hi Neil,
>> 
>>> Am 03.03.2022 um 09:35 schrieb Neil Armstrong 
>>> <narmstrong@baylibre.com>:
>>> 
>>> Hi,
>>> 
>>> On 02/03/2022 23:24, H. Nikolaus Schaller wrote:
>>>> Hi Neil,
>>>>> Am 02.03.2022 um 15:34 schrieb Neil Armstrong 
>>>>> <narmstrong@baylibre.com>:
>>>>> 
>>>>> Hi,
>>>>> 
>>>>>> (cross-checked: RGB mode still works if I force 
>>>>>> hdmi->sink_is_hdmi = false)
>>>>> 
>>>>> I don't understand what's wrong, can you try to make the logic 
>>>>> select MEDIA_BUS_FMT_YUV8_1X24 instead of 
>>>>> DRM_COLOR_FORMAT_YCBCR422 ?
>>>> I have forced hdmi->sink_is_hdmi = false and replaced
>>>>   	/* Default 8bit RGB fallback */
>>>> -	output_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
>>>> +	output_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
>>>> And then screen remains black. MEDIA_BUS_FMT_RGB888_1X24 works.
>>>> (MEDIA_BUS_FMT_VUY8_1X24 doesn't work either).
>>>> So this indicates that YUV conversion is not working properly. 
>>>> Maybe missing some special
>>>> setup.
>>>> What I have to test if it works on a different monitor.
>> 
>> Same effect on a Xiaomi monitor (user manual just telling HDMI1,4 
>> compatible), an
>> older Acer video projector and a Sharp TV set.
>> 
>> The Xiaomi monitor does not say "No signal" but shows a black 
>> screen. The others
>> do not even report any HDMI signals. All work well with 
>> MEDIA_BUS_FMT_RGB888_1X24.
>> 
>> This means the transcoding to YUV does not work properly on the 
>> jz4780 SoC setup.
>> 
>> So it looks as if we have to disable it (at least unless someone 
>> finds a fix).
>> 
>>>> Not that this specific panel
>>>> (a 7 inch waveshare touch with HDMIinput) is buggy and reports YUV 
>>>> capabilities
>>>> but does not handle them...
>>>> On the other hand this panel works on RasPi and OMAP5 (where I 
>>>> admit I do not know in
>>>> which mode).
>>> 
>>> Pretty sure they don't support YUV HDMI output.
>>> 
>>> If you can try on a certified HDMI devices like a TV, it would here 
>>> figuring out where comes the issue.
>> 
>> I am not sure if the Sharp TV is fully certified but would assume...
>> 
>>> 
>>>>> If your CSC is broken, we'll need to disable it on your platform.
>>>> Indeed.
>>>> So it seems as if we need a mechanism to overwrite 
>>>> dw_hdmi_bridge_atomic_get_output_bus_fmts()
>>>> in our ingenic-dw-hdmi platform specialization [1] to always 
>>>> return MEDIA_BUS_FMT_RGB888_1X24.
>>>> Or alternatively set sink_is_hdmi = false there (unfortunately 
>>>> there is no direct access to
>>>> struct dw_hdmi in a specialization drivers).
>>>> Is this already possible or how can it be done?
>>> 
>>> It's not handled yet, but we may add the logic to handle the lack 
>>> of CSC config bit and
>>> add a glue config bit to override this like we already did for CEC.
>>> 
>>> I wrote an initial support to disable CSC (only compile-tested), 
>>> could you try on your platform with setting disable_csc = 1 in your 
>>> dw-hdmi glue code ?
>> 
>> This works!
>> 
>> So how can we get that merged? IMHO your proposal should be before 
>> we add ingenic-dw-hdmi.
>> If you have a version with proper commit message I can add it to the 
>> beginning of my
>> seried and include it in a v17. Or if you get yours merged to 
>> drm-misc/drm-misc-next I
>> can build on top.
> 
> You can add it in your v17 patchset with my authorship and my 
> Signed-off-by tag + yours.
> 
> As commit message something like :
> ====================
> drm/bridge: dw-hdmi: handle unusable or non-configured CSC module
> 
> The dw-hdmi integrates an optional Color Space Conversion feature used
> to handle color-space conversions.
> 
> On some platforms, the CSC isn't built-in or non-functional.
> 
> This adds the necessary code to disable the CSC functionality
> and limit the bus format negotiation to force using the same
> input bus format as the output bus format.
> ====================
> 
> Thanks,
> Neil
> 
>> 
>> BR and thanks,
>> Nikolaus
>> 
> 


