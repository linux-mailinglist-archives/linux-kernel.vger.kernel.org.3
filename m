Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA71F46BC1B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbhLGNFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbhLGNFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:05:44 -0500
Received: from lb1-smtp-cloud9.xs4all.net (lb1-smtp-cloud9.xs4all.net [IPv6:2001:888:0:108::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C95BC061574;
        Tue,  7 Dec 2021 05:02:13 -0800 (PST)
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id ua6hm8RaalcdAua6kmmAdR; Tue, 07 Dec 2021 14:02:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1638882132; bh=Yt4VY8ambnxcmyU8WM3Nofvl83aZYAnuuv5nqZx0eTg=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=Hxrg/Djz4MChK45dg55U7AIRpg+M6WoqyYB9JQkexihGt9MJX5xNxpLU6XI9hrlre
         6p4lz5Ffs3Zqm1MSNP3DcHBUCbo+GwyPBD1k65mn1RiED6OrPnlroypvCO0ZAmAp2d
         tYx+T9buzKtoiNLHYMKVi9pjbsOvqn1eTyR+gQxJadh/aFrZyH/U0KXmGckseYhSGL
         4+GRFAPsuOFBuGN64SsSxN183HEaGhe2zS/FdlwCrZKi8ss+7auTs7UyWzZ3EiKamd
         6zea85qGwFS1iI79nD5Es3Ufg2FJ5MPuohZoJLUv+3Bs3RJec6zaYVTnnCDcUCcGL2
         tf8d//f3cIbcg==
Subject: Re: [PATCH v7 2/7] mtk-mdp: add driver to probe mdp components
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     houlong wei <houlong.wei@mediatek.com>,
        Eizan Miyamoto <eizan@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?UTF-8?B?Q0sgSHUgKOiDoeS/ig==?= =?UTF-8?B?5YWJKQ==?= 
        <ck.hu@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?B?TWluZ2hzaXUgVHNhaSAo6JSh5piO5L+uKQ==?= 
        <Minghsiu.Tsai@mediatek.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-media <linux-media@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20210825063323.3607738-1-eizan@chromium.org>
 <20210825163247.v7.2.Ie6d1e6e39cf9b5d6b2108ae1096af34c3d55880b@changeid>
 <CAAEAJfDNDXdJFfB-bHhFcqnnKZ0TY--d_wLGddKRymQOLQY4TQ@mail.gmail.com>
 <fc309940c9e59f80397b90c8b11424fea344e1b5.camel@mediatek.com>
 <a0b3a10d-9313-7ac5-692c-822aeff50858@xs4all.nl>
 <CAAEAJfDOU+tCjm=B8Mg0esZf=e99MM1cv+8SUN6sCBKq0hVvZw@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <ed43d910-d293-fb27-39fe-119836672738@xs4all.nl>
Date:   Tue, 7 Dec 2021 14:02:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAAEAJfDOU+tCjm=B8Mg0esZf=e99MM1cv+8SUN6sCBKq0hVvZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOGBdAXbSiNV8TnHDwlxXnJeIohGqJ8BZ7Z0kW8d/GDeEafF13KJ5xYm8S/80Uug+X9+/GmjAgWAP0hs80ijIRrUiJMpD2FlTjQ/is0WHay0dEhiRQhV
 jy4P1sQB0mL9K2H3mzedhtk9WPqP4FiTt+o4V9pJzhZXhZMJ8SBGXcSdT3v0vgnAp3pEx99F4AHra4ieCAE8/EfbAg9esYDau5aRIF2uqCsUCgDpbUJyPP8q
 GXycsa+Gzm8OMY8dFX65udksjhLzax6RQtvBdqo/DOv/3xYuwn1Dxv9pYr5gh5mWWlMNF54un+0mtp/YGwr1vwqnJJIlejJ78FP2vjqgU5bfQU7FcKichO85
 kL9zgggxsaO6CKl0BakaUZEm+Absn8oReNywxro4uK57ucqwmAzdfTfxtTXdxYgM0tbXk0/ud3c3AcNGrfETOxmnGihfL4x0B6fnVJxf4uLAessRm/ZDnSwm
 Cdr0D+5hQUsyktfCW6kTCMHxEfovuOIik2t+u73DLaNYgUFUMvHUYpz9V2v1vpOll8RHZC2dgpbU6LHbTh1aCjnfNq5kZ7X1ctWoX37cpuSxcpiGGHUiF1cc
 rYwIvVS4a7ADqcyb61ja2Y+9+iUBy9CRY475nt7i/+GafvrBD3pRCe+G+7f86J+GmF7xxFSOWgoUNRPjJjwxZsaqRrqHc2XGIIMNi5XY59H+InqouWLJLspi
 upg1UGp8rIkzMC5KlgBVuUOivlhnfksjurOQyJhkyxIX0z1UMT9FnHhJnG/AyttXGqsZVfC4v4P2pFzRjr6viWkaw4fzX4LHpsWUzjx9K+3cFf2B0NDj1uvs
 U6513aGHxKAfQh1VMVc9hlpkb30TD+kJ3Aej5iqsEk/tgHHlGSbgSuStK2Xb9kB702+4jUIRV2r+sWWPn1M=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 1:46 PM, Ezequiel Garcia wrote:
> Hi everyone,
> 
> On Tue, 7 Dec 2021 at 09:37, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>
>> On 9/5/21 6:23 PM, houlong wei wrote:
>>> Hi Ezequiel,
>>>
>>> Thank you for your attention to this series of patches. I answer partial of your questions below.
>>> Regards,
>>> Houlong
>>>
>>> On Sat, 2021-09-04 at 20:34 +0800, Ezequiel Garcia wrote:
>>>> Hi Eizan,
>>>>
>>>> Sorry for seeing this series so late.
>>>>
>>>> On Wed, 25 Aug 2021 at 03:35, Eizan Miyamoto <eizan@chromium.org>
>>>> wrote:
>>>>>
>>>>> Broadly, this patch (1) adds a driver for various MTK MDP
>>>>> components to
>>>>> go alongside the main MTK MDP driver, and (2) hooks them all
>>>>> together
>>>>> using the component framework.
>>>>>
>>>>> (1) Up until now, the MTK MDP driver controls 8 devices in the
>>>>> device
>>>>> tree on its own. When running tests for the hardware video decoder,
>>>>> we
>>>>> found that the iommus and LARBs were not being properly configured.
>>>>
>>>> Why were not being properly configured? What was the problem?
>>>> Why not fixing that instead?
>>>>
>>>> Does this mean the driver is currently broken and unusable?
>>>
>>> This series of patches are supplements to another series, please refer
>>> to
>>> https://patchwork.kernel.org/project/linux-mediatek/list/?series=515129c
>>> , which add device link between the mtk-iommu consumer and the mtk-larb
>>> devices. Without that series of patches, the mtk-mdp driver can work
>>> well so far.
>>> But with that series, it seems the device link only can be established
>>> for the device which is registered as a platform driver. That's why
>>> Eizan adds this series of patches to make all mdp components to be
>>> registered as platform drivers.
>>
>> Hold on, so this means that if that iommu device-link series is merged,
>> then the mtk-mdp driver breaks? I posted a PR for that iommu series, but
>> I've just withdrawn that PR until this issue is clarified.
>>
>> Is it only mtk-mdp that is affected by this iommu device-link series, or
>> others as well?
>>
> 
> Like I said before, I think it's a mistake to introduce the component
> framework in V4L2. This whole idea looks like a hack to me.
> 
> If we merge this, then we validate using the component framework
> as a way to avoid fixing things properly.

I agree with Ezequiel.

	Hans
