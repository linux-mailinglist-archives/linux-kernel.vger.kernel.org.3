Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC3046E550
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhLIJQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhLIJQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:16:07 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F071C061746;
        Thu,  9 Dec 2021 01:12:34 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4C8921F4654A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639041153; bh=sPBqbsrB9UT6NfM6wy4+leJCOrkH2CX3quBKt/V3f9E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MhGZXeGyFwxOfTnQjje19Du8KHtsplWlJvMpNzYzmwMk3a/OPh0fN61y65fFoF0vS
         +PgKFPuIuu2hazvEwXL5VW45nwzH5vPz/+TLFAHGpTQAyp7vS2XqmEDzwwsbw/UuVg
         TqdxSNvGLRirp/WjjGshxpzIKo9Li8XOgw9t0BPsFalocAK5CPF5uZclYJw3pnNk5f
         yOXFG6lq7B05YXEZcV+5JUyHrMqtJns5i1zLavCMfaavrLPU/a/ZTcmihlWNVewYe/
         IQwWTM/iCYTN0EMnmAUfzMMRrzM4qUWeCuPhC3+H0mXUEd7pOb5CEmPCInXgAG4Qjm
         bxVLN4hI1oNwQ==
Subject: Re: [PATCH 3/4] memory: mtk-smi: Add sleep ctrl function
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, lc.kan@mediatek.com, yi.kuo@mediatek.com,
        anthony.huang@mediatek.com, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20211203064027.14993-1-yong.wu@mediatek.com>
 <20211203064027.14993-4-yong.wu@mediatek.com>
 <f2ffd08a-44c3-9458-1bd8-68e3c0755611@collabora.com>
 <ebc8e4c0b0519043c5a82c6c967ac6d524e8869a.camel@mediatek.com>
 <47c30f6f-ce9d-9ea7-283c-9026ae9ed1c0@collabora.com>
 <e1d72db69f424b9ee8987b7bafa7423c672ceef1.camel@mediatek.com>
 <85ef182a-8ebe-7dbb-aa95-35e77cbb072c@collabora.com>
 <581d847ede5ce917762e2c5734e23dcd693fef32.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <dce1e8bd-c21c-202f-3e56-70be6e743a18@collabora.com>
Date:   Thu, 9 Dec 2021 10:12:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <581d847ede5ce917762e2c5734e23dcd693fef32.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/12/21 03:42, Yong Wu ha scritto:
> On Tue, 2021-12-07 at 13:16 +0100, AngeloGioacchino Del Regno wrote:
>> Il 07/12/21 13:10, Yong Wu ha scritto:
>>> On Tue, 2021-12-07 at 09:56 +0100, AngeloGioacchino Del Regno
>>> wrote:
>>>> Il 07/12/21 07:24, Yong Wu ha scritto:
>>>>> Hi AngeloGioacchino,
>>>>>
>>>>> Thanks for your review.
>>>>>
>>>>> On Mon, 2021-12-06 at 16:08 +0100, AngeloGioacchino Del Regno
>>>>> wrote:
>>>>>> Il 03/12/21 07:40, Yong Wu ha scritto:
>>>>>>> sleep control means that when the larb go to sleep, we
>>>>>>> should
>>>>>>> wait
>>>>>>> a bit
>>>>>>> until all the current commands are finished. thus, when the
>>>>>>> larb
>>>>>>> runtime
>>>>>>> suspend, we need enable this function to wait until all the
>>>>>>> existed
>>>>>>> command are finished. when the larb resume, just disable
>>>>>>> this
>>>>>>> function.
>>>>>>> This function only improve the safe of bus. Add a new flag
>>>>>>> for
>>>>>>> this
>>>>>>> function. Prepare for mt8186.
>>>>>>>
>>>>>>> Signed-off-by: Anan Sun <anan.sun@mediatek.com>
>>>>>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>>>>>> ---
>>>>>>>      drivers/memory/mtk-smi.c | 39
>>>>>>> +++++++++++++++++++++++++++++++++++----
>>>>>>>      1 file changed, 35 insertions(+), 4 deletions(-)
>>>>>
>>>>> [snip]
>>>>>
>>>>>>>      static int __maybe_unused mtk_smi_larb_suspend(struct
>>>>>>> device
>>>>>>> *dev)
>>>>>>>      {
>>>>>>>      	struct mtk_smi_larb *larb =
>>>>>>> dev_get_drvdata(dev);
>>>>>>> +	int ret = 0;
>>>>>>> +
>>>>>>> +	if (MTK_SMI_CAPS(larb->larb_gen->flags_general,
>>>>>>> MTK_SMI_FLAG_SLEEP_CTL))
>>>>>>> +		ret = mtk_smi_larb_sleep_ctrl(dev, true);
>>>>>>
>>>>>> Sorry but what happens if SLP_PROT_RDY is not getting set
>>>>>> properly?
>>>>>>     From what I can understand in the commit description that
>>>>>> you
>>>>>> wrote,
>>>>>> if we reach
>>>>>> the timeout, then the LARB transactions are not over....
>>>>>>
>>>>>> I see that you are indeed returning a failure here, but you
>>>>>> are
>>>>>> also
>>>>>> turning off
>>>>>> the clocks regardless of whether we get a failure or a
>>>>>> success;
>>>>>> I'm
>>>>>> not sure that
>>>>>> this is right, as this may leave the hardware in an
>>>>>> unpredictable
>>>>>> state (since
>>>>>> there were some more LARB transactions that didn't go
>>>>>> through),
>>>>>> leading to crashes
>>>>>> at system resume (or when retyring to suspend).
>>>>>
>>>>> Thanks for this question. In theory you are right. In this
>>>>> case,
>>>>> the
>>>>> bus already hang.
>>>>>
>>>>> We only printed a fail log in this patch. If this fail happens,
>>>>> we
>>>>> should request the master to check which case cause the larb
>>>>> hang.
>>>>>
>>>>> If the master has a good reason or limitation, the hang is
>>>>> expected, I
>>>>> think we have to add larb reset in this fail case: Reset the
>>>>> larb
>>>>> when
>>>>> the larb runtime resume.
>>>>>
>>>>
>>>> Think about the case in which the system gets resumed only
>>>> partially
>>>> due to a
>>>>
>>>> failure during resume of some driver, or due to a RTC or arch
>>>> timer
>>>> resume and
>>>> suspend right after... or perhaps during runtime suspend/resume
>>>> of
>>>> some devices.
>>>> In that case, we definitely want to avoid any kind of failure
>>>> point
>>>> that would
>>>> lead to a system crash, or any kind of user noticeable (or UX
>>>> disrupting) "strange
>>>> behavior".
>>>>
>>>> I think that we should make sure that the system suspends
>>>> cleanly,
>>>> instead of
>>>> patching up any possible leftover issue at resume time: if this
>>>> is
>>>> doable with
>>>> a LARB reset in suspend error case, that looks like being a good
>>>> option indeed.
>>>>
>>>> As a side note, thinking about UX, losing a little more time
>>>> during
>>>> suspend is
>>>> nothing really noticeable for the user... on the other hand,
>>>> spending
>>>> more time
>>>> during resume may be something noticeable to the user.
>>>> For this reason, I think that guaranteeing that the system
>>>> resumes as
>>>> fast as
>>>> possible is very important, which adds up to the need of
>>>> suspending
>>>> cleanly.
>>>
>>> Thanks for this comment. I will put it in the suspend when adding
>>> the
>>> reset. But I have no plan to add it in this version since I don't
>>> see
>>> the need for this right now. Maybe I should add a comment in the
>>> code
>>> for this.
>>>
>>
>> What I understand from your reply is that the reset is not trivial
>> work
> 
> Yes. the reset bit is in different register regions, like mmsys,
> vdecsys. But the main problem is that I don't see why we need that. We
> never that problem.
> 

The fact that we didn't get any "visible" problem with that is very good,
indeed, but having a recovery mechanism in place in the event that something
like that happens is going to be helpful in the future, as driver updates (either
to support new SoCs or Linux API changes, or new APIs) may produce unexpected
results sometimes and this will make sure that, despite there may be a problem,
the hardware will still work even before solving the producer of the issue.

Sometimes it may happen that solving an issue is nothing trivial, hence requires
a lot of time, and that's the main usefulness of that - and it's as useful as
your *great* idea of enabling SLP_PROT_RDY to check on the bus.

> The sleep ctrl function is just for the safety of the bus. If we have
> not it, It also should be ok...If not, the question is: why does the
> larb master device call pm_runtime_put before his HW finish the job?
> 

I agree on the fact that calling pm_runtime_put before the HW finishes the
job is something that should *never* happen.

>> and needs quite some time to be done properly; in that case: yes,
>> please
>> add a TODO comment that explains the situation and the discussed
>> solution.
>>
>> Also, since this SLP_PROT_RDY flag seems to be very nice, just a
>> simple question: is this a new feature in the SMI IP of MT8186, or is
>> there anything similar that we may use on other SoCs, like 8183,
>> 8192, 8195, as a follow-up of this series?
> 
> All the three SoC support this function. I expect the later SoC will
> support this. but the previous SoC has already MP... If someone has
> already tested ok after adding it for the previous SoC, I'm ok of
> course.
> 

Thanks for the information. Again, this feature is very nice, so if it can
be used on any other SoC, it's going to be helpful in the future.

I will do some research.

Regards,
- Angelo
