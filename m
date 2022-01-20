Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C207C495000
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345649AbiATOUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiATOUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:20:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405F3C061574;
        Thu, 20 Jan 2022 06:20:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECE87B81CD9;
        Thu, 20 Jan 2022 14:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5746C340E0;
        Thu, 20 Jan 2022 14:20:33 +0000 (UTC)
Message-ID: <7b0ac4d2-a78e-f1be-e7ee-6f4c69acc386@xs4all.nl>
Date:   Thu, 20 Jan 2022 15:20:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RFT v2 1/8] media: hantro: jpeg: Relax register writes
 before write starting hardware
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220107093455.73766-1-wenst@chromium.org>
 <20220107093455.73766-2-wenst@chromium.org> <Yecq111pZDP9XFNO@eze-laptop>
 <CAGXv+5GfNgQGJOBihdpGQDbdx-1co_wi0m=-HyxiHDn-kKZBsA@mail.gmail.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <CAGXv+5GfNgQGJOBihdpGQDbdx-1co_wi0m=-HyxiHDn-kKZBsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

I'll take patches 2-8.

So should I mark patch 1/8 as 'Rejected' or 'Changes Requested' in patchwork?

Regards,

	Hans

On 1/19/22 11:08, Chen-Yu Tsai wrote:
> Hi,
> 
> On Wed, Jan 19, 2022 at 5:02 AM Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
>>
>> Hi Chen-Yu,
>>
>> The series looks good, thanks for picking up this task.
>>
>> Just a one comment.
>>
>> On Fri, Jan 07, 2022 at 05:34:48PM +0800, Chen-Yu Tsai wrote:
>>> In the earlier submissions of the Hantro/Rockchip JPEG encoder driver, a
>>> wmb() was inserted before the final register write that starts the
>>> encoder. In v11, it was removed and the second-to-last register write
>>> was changed to a non-relaxed write, which has an implicit wmb() [1].
>>> The rockchip_vpu2 (then rk3399_vpu) variant is even weirder as there
>>> is another writel_relaxed() following the non-relaxed one.
>>>
>>> Turns out only the last writel() needs to be non-relaxed. Device I/O
>>> mappings already guarantee strict ordering to the same endpoint, and
>>> the writel() triggering the hardware would force all writes to memory
>>> to be observed before the writel() to the hardware is observed.
>>>
>>> [1] https://lore.kernel.org/linux-media/CAAFQd5ArFG0hU6MgcyLd+_UOP3+T_U-aw2FXv6sE7fGqVCVGqw@mail.gmail.com/
>>>
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>> ---
>>>  drivers/staging/media/hantro/hantro_h1_jpeg_enc.c        | 3 +--
>>>  drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c | 3 +--
>>>  2 files changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c b/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
>>> index 1450013d3685..03db1c3444f8 100644
>>> --- a/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
>>> +++ b/drivers/staging/media/hantro/hantro_h1_jpeg_enc.c
>>> @@ -123,8 +123,7 @@ int hantro_h1_jpeg_enc_run(struct hantro_ctx *ctx)
>>>               | H1_REG_AXI_CTRL_INPUT_SWAP32
>>>               | H1_REG_AXI_CTRL_OUTPUT_SWAP8
>>>               | H1_REG_AXI_CTRL_INPUT_SWAP8;
>>> -     /* Make sure that all registers are written at this point. */
>>> -     vepu_write(vpu, reg, H1_REG_AXI_CTRL);
>>> +     vepu_write_relaxed(vpu, reg, H1_REG_AXI_CTRL);
>>>
>>
>> As far as I can remember, this logic comes from really old Chromium Kernels.
>> You might be right, and this barrier isn't needed... but then OTOH the comment
>> is here for a reason, so maybe it is needed (or was needed on some RK3288 SoC revision).
> 
> I just realized that my commit log is wrong.
> 
> " ... a wmb() was inserted before the final register write that starts the
> encoder. ... " . It is actually before the second-to-last register write.
> 
>> I don't have RK3288 boards near me, but in any case, I'm not sure
>> we'd be able to test this easily (maybe there are issues that only
>> trigger under a certain load).
> 
> I see. I do have a Veyron around that I haven't used in awhile. But as you
> said, it might not be an obvious hardware limitation.
> 
>> I'd personally avoid this one change, but if you are confident enough with it
>> that's fine too.
> 
> Unfortunately they didn't leave a whole lot of clues around. For most hardware,
> as I mentioned in the commit log, I think the final non-relaxed write should
> suffice. I'd point to the decoder drivers not having any barriers or
> non-relaxed writes except the final one, but IIUC they are actually two
> distinct pieces of hardware.
> 
> I suspect we will never know. This JPEG encoder doesn't seem to get used
> a lot. The VP8 and H.264 encoders on ChromeOS work correctly without the
> extra barrier and get tested a lot, but that's only testing the RK3399.
> 
> Hans, would it be possible for you to skip this patch and pick the rest?
> Or would you like me to resent without this one?
> 
> 
> Thanks
> ChenYu
> 
>> Thanks!
>> Ezequiel
>>
>>>       reg = H1_REG_ENC_CTRL_WIDTH(MB_WIDTH(ctx->src_fmt.width))
>>>               | H1_REG_ENC_CTRL_HEIGHT(MB_HEIGHT(ctx->src_fmt.height))
>>> diff --git a/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c b/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c
>>> index 4df16f59fb97..b931fc5fa1a9 100644
>>> --- a/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c
>>> +++ b/drivers/staging/media/hantro/rockchip_vpu2_hw_jpeg_enc.c
>>> @@ -152,8 +152,7 @@ int rockchip_vpu2_jpeg_enc_run(struct hantro_ctx *ctx)
>>>               | VEPU_REG_INPUT_SWAP8
>>>               | VEPU_REG_INPUT_SWAP16
>>>               | VEPU_REG_INPUT_SWAP32;
>>> -     /* Make sure that all registers are written at this point. */
>>> -     vepu_write(vpu, reg, VEPU_REG_DATA_ENDIAN);
>>> +     vepu_write_relaxed(vpu, reg, VEPU_REG_DATA_ENDIAN);
>>>
>>>       reg = VEPU_REG_AXI_CTRL_BURST_LEN(16);
>>>       vepu_write_relaxed(vpu, reg, VEPU_REG_AXI_CTRL);
>>> --
>>> 2.34.1.575.g55b058a8bb-goog
>>>
