Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C25461A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348300AbhK2Ooi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 09:44:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43562 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378756AbhK2Omc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:42:32 -0500
Received: from [IPv6:2a00:c281:110c:e500:f02c:94f7:9527:dda] (unknown [IPv6:2a00:c281:110c:e500:f02c:94f7:9527:dda])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9C5961F4477B;
        Mon, 29 Nov 2021 14:39:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638196752; bh=FfGEQGlrfOenyEWOnXuV5BGmkW0riaVM2Q9KGlGPerw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NKSDqc07hFxDCwZ2EvSz6FDs4vYHgpaoVS1J/cR/qvW5puRtmb5cO/0K7AJGEzpjh
         JFmmu1+PAmS/QfYso6BJQAhC2UJRoI94kQKVeGp4+PW6jRe78YWFqi5pBbUx6Dq2OE
         23JmISRbED0vWYMZgHXAQ/xEm6AVwlr2SzRnCpRe7CNNrxCZGvwQiMp303dW87f2eB
         HywsSll6DK2UyPFlQKSACvFqHzQ58vx5TO8JcykxP27j/i/W+4UIq3IOUZhOfs7Xl9
         dMq0TQjz7fbPXlqwpWT2JqBCI1UeLydmkELRRwUqOMyV5I5mRTZ+HWjARGkZjrwlh/
         HbJYlPpYmzw/w==
Subject: Re: [PATCH v4] media: mtk-vpu: Ensure alignment of 8 for DTCM buffer
To:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Dafna Hirschfeld <dafna3@gmail.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        minghsiu.tsai@mediatek.com, houlong.wei@mediatek.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20210920170408.1561-1-dafna.hirschfeld@collabora.com>
 <c59b7f40-d99e-370a-b797-5dc72979df46@xs4all.nl>
 <CAPBb6MW_i1_Lh2ZaF8jGjcV-4XBhjswtyKkZCk3HxKO7LX79Og@mail.gmail.com>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <1d509eea-37ef-bfd1-cfe7-0a204d8c4bd4@collabora.com>
Date:   Mon, 29 Nov 2021 16:39:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPBb6MW_i1_Lh2ZaF8jGjcV-4XBhjswtyKkZCk3HxKO7LX79Og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.10.21 04:16, Alexandre Courbot wrote:
> Hi Hans!
> 
> On Mon, Oct 4, 2021 at 6:37 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>
>> On 20/09/2021 19:04, Dafna Hirschfeld wrote:
>>> From: Alexandre Courbot <acourbot@chromium.org>
>>>
>>> When running memcpy_toio:
>>> memcpy_toio(send_obj->share_buf, buf, len);
>>> it was found that errors appear if len is not a multiple of 8:
>>>
>>> [58.350841] mtk-mdp 14001000.rdma: processing failed: -22
>>
>> Why do errors appear? Is that due to a HW bug? Some other reason?
> 
> MTK folks would be the best placed to answer this, but since the
> failure is reported by the firmware I'd suspect either a firmware or
> hardware limitation.
> 
>>
>>>
>>> This patch ensures the copy of a multiple of 8 size by calling
>>> round_up(len, 8) when copying
>>>
>>> Fixes: e6599adfad30 ("media: mtk-vpu: avoid unaligned access to DTCM buffer.")
>>> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>>> Reviewed-by: Houlong Wei <houlong.wei@mediatek.com>
>>> ---
>>> changes since v3:
>>> 1. multile -> multiple
>>> 2. add inline doc
>>>
>>> changes since v2:
>>> 1. do the extra copy only if len is not multiple of 8
>>>
>>> changes since v1:
>>> 1. change sign-off-by tags
>>> 2. change values to memset
>>>
>>>   drivers/media/platform/mtk-vpu/mtk_vpu.c | 15 ++++++++++++++-
>>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
>>> index ec290dde59cf..1df031716c8f 100644
>>> --- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
>>> +++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
>>> @@ -349,7 +349,20 @@ int vpu_ipi_send(struct platform_device *pdev,
>>>                }
>>>        } while (vpu_cfg_readl(vpu, HOST_TO_VPU));
>>>
>>> -     memcpy_toio(send_obj->share_buf, buf, len);
>>> +     /*
>>> +      * when copying data to the vpu hardware, the memcpy_toio operation must copy
>>> +      * a multiple of 8. Otherwise the processing fails
>>
>> Same here: it needs to explain why the processing fails.
>>
>>> +      */
>>> +     if (len % 8 != 0) {
>>> +             unsigned char data[SHARE_BUF_SIZE];
>>
>> Wouldn't it be more robust if you say:
>>
>>                  unsigned char data[sizeof(send_obj->share_buf)];
> 
> Definitely yes.

won't it actually be better to implement it like this:
(assuming len is always multiply of 4 - which I think it must be since access must be 4 aligned)

	void __iomem *to = obj->share_buf;

         if (len % 8 != 0) {
                 memcpy_toio(to, buf, len - 4);
                 to += len - 4;
                 buf += len - 4;
                 writel_relaxed(*(u32 *)buf, to);
         } else {
                 memcpy_toio(obj->share_buf, buf, len);
         }
Thanks,
Dafna
> 
>>
>> I also think that the SHARE_BUF_SIZE define needs a comment stating that it must be a
>> multiple of 8, otherwise unexpected things can happen.
>>
>> You also noticed that the current SHARE_BUF_SIZE define is too low, but I saw
>> no patch correcting this. Shouldn't that be fixed as well?
> 
> AFAICT the firmware expects this exact size on its end, so I don't
> believe it can be changed that easily. But maybe someone from MTK can
> prove me wrong.
> 
> Cheers,
> Alex.
> 
