Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AF9460FDA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 09:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242018AbhK2IRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 03:17:03 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40032 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242058AbhK2IPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:15:02 -0500
Received: from [IPv6:2a00:c281:110c:e500:9c17:a789:903f:76c0] (unknown [IPv6:2a00:c281:110c:e500:9c17:a789:903f:76c0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 72D921F439F8;
        Mon, 29 Nov 2021 08:11:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638173502; bh=8mWtECRVNBUbb/TnwcCSBmiz1Z8p8086RdkugQDNe/I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=E2daxS9kg42vgTUEP2b8vGK7vwl/1i0jv29TYdpefOAVfLiGhQLJS1qQnEjIUFwej
         OQwXF3CjzXhBGTSB187wya1KoSDf6ODtzbJjrDrOI09mATmAlU2rWNOWf+RHs8maAs
         8vp2OENcGB/EQeSJHlEXepKPu25Z+jt7U27SAPyN4lFxnRUrn4gCHjnuQ1bKleKcl0
         gpDaDqVBjSGBHib+N+yNV0CaXCvt0a49DKGPbUkjaSf/X9VomJqtvw7JwSA+e+0kxS
         Lwfx20kXs2q7+/dvYxEgALAKak37FE8EoL7hFtlDzq8PW6GXVbY6p80Eo5aNHXQMy0
         58wqUPtALd6XA==
Subject: Re: [PATCH v4] media: mtk-vpu: Ensure alignment of 8 for DTCM buffer
To:     Irui Wang <irui.wang@mediatek.com>,
        houlong wei <houlong.wei@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Dafna Hirschfeld <dafna3@gmail.com>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>,
        =?UTF-8?B?TWluZ2hzaXUgVHNhaSAo6JSh5piO5L+uKQ==?= 
        <Minghsiu.Tsai@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20210920170408.1561-1-dafna.hirschfeld@collabora.com>
 <c59b7f40-d99e-370a-b797-5dc72979df46@xs4all.nl>
 <CAPBb6MW_i1_Lh2ZaF8jGjcV-4XBhjswtyKkZCk3HxKO7LX79Og@mail.gmail.com>
 <9475ac5b-79fe-da0e-ed1c-a91275cad46e@collabora.com>
 <c01c2c6e2351c915fb6e55b025bf2ab5c449f045.camel@mediatek.com>
 <8dfc07306b853126e8109fc953fd6388b63c65d2.camel@mediatek.com>
 <4e7ff420-f67d-5d4a-8733-f4b83d80af13@collabora.com>
 <428f216d-cdff-e22d-b96e-f9dd9cc158e3@collabora.com>
 <054260428d9d7718f630ecc1b2bdec34ecf1f799.camel@mediatek.com>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <fa138c32-0260-00dd-d094-8d64340d51a9@collabora.com>
Date:   Mon, 29 Nov 2021 10:11:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <054260428d9d7718f630ecc1b2bdec34ecf1f799.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.11.21 05:11, Irui Wang wrote:
> Hi, Dafna,
> 
> Thanks for the patch.
> On Tue, 2021-11-09 at 10:46 +0200, Dafna Hirschfeld wrote:
>>
>> On 03.11.21 13:04, Dafna Hirschfeld wrote:
>>>
>>>
>>> On 03.11.21 10:19, Irui Wang wrote:
>>>> Hi,
>>>>
>>>> The "len" of share_buf copied should be always 8 alignment;
>>>> do you have other logs to prove the len is not 8 alignment when
>>>> errors
>>>> appear?
>>>
>>> Hi, I found out that "sizeof(mdp_ipi_comm) = 20"
>>> this is due to the macro #pragma pack(push, 4) in mtk_mdp_ipi.h
>>>
>>> see [1]
>>>
>>> [1] http://lkml.iu.edu/hypermail/linux/kernel/2109.2/04978.html
>>>
>>
>> Hi Irui Wang,
>> Any update regarding that patch?
>> Can you give more explanation for that errors that we see
>> when the buffer size is not a multiple of 8?
>>
>> Thanks,
>> Dafna
> 
> share_buf is a mapped memory by ioremap, it should be better use
> memcpy_to/fromio instead of memcpy because of alignment.
> 
> As for memcpy_toio, it may also have requirements for alignment, we can
> also get such information from:
> 
> https://elixir.bootlin.com/linux/v5.15/source/drivers/mtd/spi-nor/controllers/aspeed-smc.c#L207
> .
> 
> So, it's not VPU HW bug or limitation, it's memcpy_toio requirements,
> maybe we can modify IPI message to do alignment, but it need modify
> both kernel and vpu firmware, which will break upstream backward
> compatible, we think it's unacceptale.
> 
> If this patch can solve the issue, we think it's OK.

In such case shouldn't we also make sure that the address of
send_obj->share_buf is 8 aligend before calling memcpy_toio,
and also shouldn't we make the same checks for the memcpy_fromio ?

Thanks,
Dafna

> 
> Thanks
>>
>>> Thanks,
>>> Dafna
>>>
>>>>>> [58.350841] mtk-mdp 14001000.rdma: processing failed: -22
>>>>
>>>> On Wed, 2021-11-03 at 16:03 +0800, houlong wei wrote:
>>>>> Add mtk-vpu driver expert irui.wang in the loop.
>>>>>
>>>>> On Mon, 2021-10-18 at 15:07 +0800, Dafna Hirschfeld wrote:
>>>>>>
>>>>>> On 18.10.21 03:16, Alexandre Courbot wrote:
>>>>>>> Hi Hans!
>>>>>>>
>>>>>>> On Mon, Oct 4, 2021 at 6:37 PM Hans Verkuil <
>>>>>>> hverkuil@xs4all.nl>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>> On 20/09/2021 19:04, Dafna Hirschfeld wrote:
>>>>>>>>> From: Alexandre Courbot <acourbot@chromium.org>
>>>>>>>>>
>>>>>>>>> When running memcpy_toio:
>>>>>>>>> memcpy_toio(send_obj->share_buf, buf, len);
>>>>>>>>> it was found that errors appear if len is not a
>>>>>>>>> multiple of
>>>>>>>>> 8:
>>>>>>>>>
>>>>>>>>> [58.350841] mtk-mdp 14001000.rdma: processing failed:
>>>>>>>>> -22
>>>>>>>>
>>>>>>>> Why do errors appear? Is that due to a HW bug? Some other
>>>>>>>> reason?
>>>>>>>
>>>>>>> MTK folks would be the best placed to answer this, but
>>>>>>> since the
>>>>>>> failure is reported by the firmware I'd suspect either a
>>>>>>> firmware
>>>>>>> or
>>>>>>> hardware limitation.
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> This patch ensures the copy of a multiple of 8 size by
>>>>>>>>> calling
>>>>>>>>> round_up(len, 8) when copying
>>>>>>>>>
>>>>>>>>> Fixes: e6599adfad30 ("media: mtk-vpu: avoid unaligned
>>>>>>>>> access
>>>>>>>>> to
>>>>>>>>> DTCM buffer.")
>>>>>>>>> Signed-off-by: Alexandre Courbot <acourbot@chromium.org
>>>>>>>>>>
>>>>>>>>> Signed-off-by: Enric Balletbo i Serra <
>>>>>>>>> enric.balletbo@collabora.com>
>>>>>>>>> Signed-off-by: Dafna Hirschfeld <
>>>>>>>>> dafna.hirschfeld@collabora.com
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Reviewed-by: Houlong Wei <houlong.wei@mediatek.com>
>>>>>>>>> ---
>>>>>>>>> changes since v3:
>>>>>>>>> 1. multile -> multiple
>>>>>>>>> 2. add inline doc
>>>>>>>>>
>>>>>>>>> changes since v2:
>>>>>>>>> 1. do the extra copy only if len is not multiple of 8
>>>>>>>>>
>>>>>>>>> changes since v1:
>>>>>>>>> 1. change sign-off-by tags
>>>>>>>>> 2. change values to memset
>>>>>>>>>
>>>>>>>>>     drivers/media/platform/mtk-vpu/mtk_vpu.c | 15
>>>>>>>>> ++++++++++++++-
>>>>>>>>>     1 file changed, 14 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c
>>>>>>>>> b/drivers/media/platform/mtk-vpu/mtk_vpu.c
>>>>>>>>> index ec290dde59cf..1df031716c8f 100644
>>>>>>>>> --- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
>>>>>>>>> +++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
>>>>>>>>> @@ -349,7 +349,20 @@ int vpu_ipi_send(struct
>>>>>>>>> platform_device
>>>>>>>>> *pdev,
>>>>>>>>>                  }
>>>>>>>>>          } while (vpu_cfg_readl(vpu, HOST_TO_VPU));
>>>>>>>>>
>>>>>>>>> -     memcpy_toio(send_obj->share_buf, buf, len);
>>>>>>>>> +     /*
>>>>>>>>> +      * when copying data to the vpu hardware, the
>>>>>>>>> memcpy_toio
>>>>>>>>> operation must copy
>>>>>>>>> +      * a multiple of 8. Otherwise the processing
>>>>>>>>> fails
>>>>>>>>
>>>>>>>> Same here: it needs to explain why the processing fails.
>>>>>>
>>>>>> Is writing 'due to hardware or firmware limitation' enough?
>>>>>> If not, then we should wait for mediatek people's response to
>>>>>> explain
>>>>>> if they know more
>>>>>>
>>>>>>>>
>>>>>>>>> +      */
>>>>>>>>> +     if (len % 8 != 0) {
>>>>>>>>> +             unsigned char data[SHARE_BUF_SIZE];
>>>>>>>>
>>>>>>>> Wouldn't it be more robust if you say:
>>>>>>>>
>>>>>>>>                    unsigned char data[sizeof(send_obj-
>>>>>>>>> share_buf)];
>>>>>>>
>>>>>>> Definitely yes.
>>>>>>
>>>>>> I'll send v5 fixing this
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> I also think that the SHARE_BUF_SIZE define needs a
>>>>>>>> comment
>>>>>>>> stating that it must be a
>>>>>>>> multiple of 8, otherwise unexpected things can happen.
>>>>>>>>
>>>>>>>> You also noticed that the current SHARE_BUF_SIZE define
>>>>>>>> is too
>>>>>>>> low, but I saw
>>>>>>>> no patch correcting this. Shouldn't that be fixed as
>>>>>>>> well?
>>>>>>>
>>>>>>> AFAICT the firmware expects this exact size on its end, so
>>>>>>> I
>>>>>>> don't
>>>>>>> believe it can be changed that easily. But maybe someone
>>>>>>> from MTK
>>>>>>> can
>>>>>>> prove me wrong.
>>>>>>>
>>>>>>
>>>>>> I looked further and noted that the structs that are larger
>>>>>> than
>>>>>> 'SHARE_BUF_SIZE'
>>>>>> (venc_ap_ipi_msg_enc_ext venc_ap_ipi_msg_set_param_ext)
>>>>>> are used by drivers that don't use this vpu api, so actually
>>>>>> SHARE_BUF_SIZE is
>>>>>> not too low and as Corurbot worte probably not changeable.
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Dafna
>>>>>>
>>>>>>> Cheers,
>>>>>>> Alex.
>>>>>>>
>>>>>
>>>>>
