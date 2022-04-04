Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F0D4F1234
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354650AbiDDJlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354565AbiDDJlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:41:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D650237C4;
        Mon,  4 Apr 2022 02:39:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B53661F45A8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649065192;
        bh=ejbWWBRRhO2pkMXezZwlIm/0bzJATXn2Cr+L273WGxo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GQ8rJ2j2ij1Vx/dE2N0SrOdeXaoLfW0GfJk8vsWvUAFowWUramgIeHSn6Yo3n22eN
         aRX4bYldlzgWMoQOpmU2uuFA6iO7TrVYli0HdfZ/CsLPsj+8UXZgjwjCHLbr2SLXAE
         ek4b2Mzk7KwzDwHLbrFC2WYhmGLJ/IZty5j1BXUWDpDY1EXVTovq04ugFPmX1Zr7Zz
         t/QC/X+NSb8A7L8TqD0n5GzFyK/UpztFySVIg4/RANTe04L54t2KdxkDZ3CyWVtEq5
         rhdlPkkXvyL3/RKDzTBUvh6W/YO6IOskjA0a7lXKX02FB52cE0gjb28p+lHJT+mxF5
         5rxhXJ2VeNeBg==
Message-ID: <af2b304a-a407-3fc6-dfc6-edc85ce1caea@collabora.com>
Date:   Mon, 4 Apr 2022 11:39:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] dt-bindings: mfd: syscon: Add support for regmap
 fast-io
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, arnd@arndb.de,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nfraprado@collabora.com,
        kernel@collabora.com
References: <20220401135048.23245-1-angelogioacchino.delregno@collabora.com>
 <20220401135048.23245-3-angelogioacchino.delregno@collabora.com>
 <8588a941-6d3e-9e14-cb21-d7af29b4b2bd@linaro.org>
 <7775eb70-692f-3f1b-f226-f7e0fad47e37@collabora.com>
 <26af9701-267d-5a23-8688-24608617d3f6@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <26af9701-267d-5a23-8688-24608617d3f6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/04/22 10:55, Krzysztof Kozlowski ha scritto:
> On 04/04/2022 10:40, AngeloGioacchino Del Regno wrote:
>> Il 02/04/22 13:38, Krzysztof Kozlowski ha scritto:
>>> On 01/04/2022 15:50, AngeloGioacchino Del Regno wrote:
>>>> The syscon driver now enables the .fast_io regmap configuration when
>>>> the 'fast-io' property is found in a syscon node.
>>>>
>>>> Keeping in mind that, in regmap, fast_io is checked only if we are
>>>> not using hardware spinlocks, allow the fast-io property only if
>>>> there is no hwlocks reference (and vice-versa).
>>>
>>> I have doubts you need a property for this. "fast" is subjective in
>>> terms of hardware, so this looks more like a software property, not
>>> hardware.
>>>
>>> I think most of MMIOs inside a SoC are considered fast. Usually also the
>>> syscon/regmap consumer knows which regmap it gets, so knows that it is
>>> fast or not.
>>>
>>
>> Hello Krzysztof,
>>
>> well yes, this property is changing how software behaves - specifically,
>> as you've correctly understood, what regmap does.
>>
>> It's true that most of MMIOs inside a SoC are considered fast.. the word "most" is
>> the exact reason why I haven't proposed simply hardcoding '.fast_io = true' in
>> syscon, or in regmap-mmio...
>> There are too many different SoCs around, and I didn't want to end up breaking
>> anything (even if it should be unlikely, since MMIO is fast by principle).
> 
> What I am proposing, is the regmap consumer knows whether access is fast
> or not, so it could call get_regmap() or
> syscon_regmap_lookup_by_phandle() with appropriate argument.
> 
> Even if we stay with a DT property, I am not sure if this is an
> attribute of syscon but rather of a bus.
> 
> Best regards,
> Krzysztof

I'm sorry for sending a v2 so fast - apparently, I initially didn't fully
understand your comment, but now it's clear.

Actually, since locking in regmap's configuration does not use DT at all
in any generic case, maybe bringing this change purely in code may be a
good one... and I have evaluated that before proposing this kind of change.

My concerns about that kind of approach are:
- First of all, there are * a lot * of drivers, in various subsystems, that
   are using syscon, so changing some function parameter in syscon.c would
   result in a commit that would be touching hundreds of them... and some of
   them would be incorrect, as the default would be no fast-io, while they
   should indeed enable that. Of course this would have to be changed later
   by the respective driver maintainer(s), potentially creating a lot of
   commit noise with lots of Fixes tags, which I am trying to avoid;
- Not all drivers are using the same syscon exported function to get a
   handle to regmap and we're looking at 6 of them; changing only one of
   the six would be rather confusing, and most probably logically incorrect
   as well...

Of course you know, but for the sake of making this easily understandable
for any casual developers reading this, functions are:
- device_node_to_regmap()
- syscon_node_to_regmap()
- syscon_regmap_lookup_by_compatible()
- syscon_regmap_lookup_by_phandle()
- syscon_regmap_lookup_by_phandle_args()
- syscon_regmap_lookup_by_phandle_optional().


Regarding making this a bus-wide property... premise: it is possible that
I haven't fully understood what you're trying to say - in which case, I'm
sorry again. Replying on the base of what my brain understands.

 From what I get, if we make this a bus-wide property, this would mean that
we would have something like:

soc {
   ...something...
   fast-io;

   something@12345678 { blah... };
};

.... or we may have instead something like:

soc {
   compatible = "simple-bus";
   ...something...
   some-fast-mmio {
     compatible = "simple-bus";
     fast-io;

       something@12345678 { blah };
   };
};

I would expect the first one to be used in the vast majority of the cases,
while the second one would be used in corner cases in which a SoC has only
a portion of MMIO that can be considered "fast" and the rest cannot, which
I think would be pretty much uncommon (but obviously has to be taken into
account for flexibility).

So. Recapping.

I would tend to say that the first strategy (changing syscon.c function
signatures) is not the best way to proceed... while the second one may
actually be smart.

I'm not sure, though, how would I express the condition for which you can
use hwlocks only when fast-io is not set (and vice-versa): the issue about
this is that, at that point, the binding to be changed wouldn't be just syscon,
because it's not the only driver that may use hwlocks, there's others as
well, which may or may not use both (both = hwlocks *and* fast-io), depending
on the implementation, so would we end up changing a lot of dt-bindings in
that case?

And if not, I can see a long story of misunderstandments about what each
driver does since on some, fast-io excludes hwlocks, but *not* on others.
Of course, I had evaluated most of (but not all of) that before deciding
to send this series... and I was definitely expecting to get some constructive
resistance on this (so thank you for that!).

Besides, I realized that this reply is a big wall of text, hope it won't be
too boring to read.

Regards,
Angelo
