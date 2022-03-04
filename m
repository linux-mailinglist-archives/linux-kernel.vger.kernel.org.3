Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFCB4CD0C9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbiCDJIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239235AbiCDJIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:08:17 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0404F1A7DA3;
        Fri,  4 Mar 2022 01:07:18 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 26EE01F4637B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646384837;
        bh=y71jZr0BRLat9aUsDt8207drN0hQ3NtgJeEhAs5zIio=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BGl4nIN4JMJ9bhW/+QP0U8oI6uxINNZWxEjwiHyjSN5OryySVZOzx1avvy9n3eVBS
         KxWGSM9Zo60NlpyrINsd5pvxFAxub6ldRbik8OfRN1c6FhQaRd9e3sH4opUNYevDKm
         llU/z6Ifzr4iE7MuX+G6xjuSAVMu1aNjBmVhAfVyNPF8V6saPCZ0yngdUxPhTlF3jo
         0zPjZvdkYH85L0tZtmXxpLmN62AssaSZGsRwEmtXKVATeR9d5qiLSn4oJG/LMEIf8z
         LJOsB6zh7hHY2r5i1Yw+3bPQ39ZOf6MFrgzByPTPBw0GTxK+/3n/btxUGkjgpMSUN0
         ss+g2aNjn8VJg==
Message-ID: <d92c6083-9d87-8eca-c760-f5a6f05f13b2@collabora.com>
Date:   Fri, 4 Mar 2022 10:07:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2, 04/10] media: mtk-vcodec: Enable venc dual core usage
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, Yong Wu <yong.wu@mediatek.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220117120615.21687-1-irui.wang@mediatek.com>
 <20220117120615.21687-5-irui.wang@mediatek.com>
 <3eaa4c05-f8f2-9e18-e6d9-a627fe5e1e40@collabora.com>
 <0b7f30b6eabb54fa894dcffea5827023ffdd58ee.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <0b7f30b6eabb54fa894dcffea5827023ffdd58ee.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/03/22 03:12, Irui Wang ha scritto:
> Hello, Angelo,
> 
> Many thanks for your review.
> 
> On Thu, 2022-03-03 at 15:27 +0100, AngeloGioacchino Del Regno wrote:
>> Il 17/01/22 13:06, Irui Wang ha scritto:
>>> Adds new venc core mode to indicate different venc hardware mode:
>>> VENC_SINGLE_CORE_MODE means only one core, the device has its own
>>> power/clk/irq, init_clk/request_irq helper can be used.
>>>
>>> VENC_DUAL_CORE_MODE means more than one core inside, the core
>>> device
>>> can use the init_clk/request_irq helper to initialize their own
>>> power/clk/irq. And the main device doesn't need use these helper
>>> anymore.
>>>
>>> MT8195 has two H264 venc cores, enable dual_core_mode for it.
>>>
>>> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
>>> ---
>>>    drivers/media/platform/mtk-vcodec/Makefile    |   4 +-
>>>    .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  22 +++
>>>    .../platform/mtk-vcodec/mtk_vcodec_enc_core.c | 153
>>> ++++++++++++++++++
>>>    .../platform/mtk-vcodec/mtk_vcodec_enc_core.h |  36 +++++
>>>    .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |  88 +++++-----
>>>    5 files changed, 266 insertions(+), 37 deletions(-)
>>>    create mode 100644 drivers/media/platform/mtk-
>>> vcodec/mtk_vcodec_enc_core.c
>>>    create mode 100644 drivers/media/platform/mtk-
>>> vcodec/mtk_vcodec_enc_core.h
>>>
>>> diff --git a/drivers/media/platform/mtk-vcodec/Makefile
>>> b/drivers/media/platform/mtk-vcodec/Makefile
>>> index 93e7a343b5b0..c472b221bd6b 100644
>>> --- a/drivers/media/platform/mtk-vcodec/Makefile
>>> +++ b/drivers/media/platform/mtk-vcodec/Makefile
>>> @@ -3,7 +3,8 @@
>>>    obj-$(CONFIG_VIDEO_MEDIATEK_VCODEC) += mtk-vcodec-dec.o \
>>>    				       mtk-vcodec-enc.o \
>>>    				       mtk-vcodec-common.o \
>>> -				       mtk-vcodec-dec-hw.o
>>> +				       mtk-vcodec-dec-hw.o \
>>> +				       mtk-vcodec-enc-core.o
>>>    
>>>    mtk-vcodec-dec-y := vdec/vdec_h264_if.o \
>>>    		vdec/vdec_vp8_if.o \
>>> @@ -32,6 +33,7 @@ mtk-vcodec-enc-y := venc/venc_vp8_if.o \
>>>    		venc_drv_if.o \
>>>    		venc_vpu_if.o \
>>>    
>>> +mtk-vcodec-enc-core-y := mtk_vcodec_enc_core.o
>>>    
>>>    mtk-vcodec-common-y := mtk_vcodec_intr.o \
>>>    		mtk_vcodec_util.o \
>>> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
>>> b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
>>> index f78463ff4551..9e4e4290a69a 100644
>>> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
>>> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
>>> @@ -117,6 +117,23 @@ enum mtk_vdec_hw_count {
>>>    	MTK_VDEC_MAX_HW_COUNT,
>>>    };
>>>    
>>> +/*
>>> + * enum mtk_venc_core_id -- encoder core id
>>> + */
>>> +enum mtk_venc_core_id {
>>> +	MTK_VENC_CORE0 = 0,
>>> +	MTK_VENC_CORE1 = 1,
>>
>> You don't have to say "= 1" for core1, just...
>>
>> 	MTK_VENC_CORE0 = 0,
>> 	MTK_VENC_CORE1,
>>
>> ...is fine, and better.
> 
> I will fix it.
> 
>>
>>> +	MTK_VENC_CORE_MAX,
>>> +};
>>> +
>>> +/**
>>> + * enmu mtk_venc_core_mode - Used to indicate different encode
>>> mode
>>> + */
>>> +enum mtk_venc_core_mode {
>>> +	VENC_SINGLE_CORE_MODE = 0,
>>> +	VENC_DUAL_CORE_MODE = 1,
>>> +};
>>> +
>>>    /*
>>>     * struct mtk_video_fmt - Structure used to store information
>>> about pixelformats
>>>     */
>>> @@ -420,6 +437,7 @@ struct mtk_vcodec_dec_pdata {
>>>     * @output_formats: array of supported output formats
>>>     * @num_output_formats: number of entries in output_formats
>>>     * @core_type: stand for h264 or vp8 encode
>>> + * @core_mode: indicate encode core mode
>>>     */
>>>    struct mtk_vcodec_enc_pdata {
>>>    	bool uses_ext;
>>> @@ -430,6 +448,7 @@ struct mtk_vcodec_enc_pdata {
>>>    	const struct mtk_video_fmt *output_formats;
>>>    	size_t num_output_formats;
>>>    	int core_type;
>>> +	enum mtk_venc_core_mode core_mode;
>>>    };
>>>    
>>>    #define MTK_ENC_CTX_IS_EXT(ctx) ((ctx)->dev->venc_pdata-
>>>> uses_ext)
>>> @@ -479,6 +498,7 @@ struct mtk_vcodec_enc_pdata {
>>>     * @subdev_dev: subdev hardware device
>>>     * @subdev_prob_done: check whether all used hw device is prob
>>> done
>>>     * @subdev_bitmap: used to record hardware is ready or not
>>> + * @enc_core_dev: used to store venc core device
>>>     */
>>>    struct mtk_vcodec_dev {
>>>    	struct v4l2_device v4l2_dev;
>>> @@ -524,6 +544,8 @@ struct mtk_vcodec_dev {
>>>    	void *subdev_dev[MTK_VDEC_HW_MAX];
>>>    	int (*subdev_prob_done)(struct mtk_vcodec_dev *vdec_dev);
>>>    	DECLARE_BITMAP(subdev_bitmap, MTK_VDEC_HW_MAX);
>>> +
>>> +	void *enc_core_dev[MTK_VENC_CORE_MAX];
>>>    };
>>>    
>>>    static inline struct mtk_vcodec_ctx *fh_to_ctx(struct v4l2_fh
>>> *fh)
>>> diff --git a/drivers/media/platform/mtk-
>>> vcodec/mtk_vcodec_enc_core.c b/drivers/media/platform/mtk-
>>> vcodec/mtk_vcodec_enc_core.c
>>> new file mode 100644
>>> index 000000000000..d84914f615a5
>>> --- /dev/null
>>> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.c
>>> @@ -0,0 +1,153 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2021 MediaTek Inc.
>>> + */
>>> +
>>> +#include <linux/interrupt.h>
>>> +#include <linux/irq.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/pm_runtime.h>
>>> +#include <linux/slab.h>
>>> +
>>> +#include "mtk_vcodec_drv.h"
>>> +#include "mtk_vcodec_enc.h"
>>> +#include "mtk_vcodec_enc_core.h"
>>> +
>>> +static const struct of_device_id mtk_venc_core_ids[] = {
>>> +	{
>>> +		.compatible = "mediatek,mtk-venc-core0",
>>> +		.data = (void *)MTK_VENC_CORE0,
>>> +	},
>>> +	{
>>> +		.compatible = "mediatek,mtk-venc-core1",
>>> +		.data = (void *)MTK_VENC_CORE1,
>>> +	},
>>> +	{},
>>> +};
>>
>> Hello Irui,
>>
>> You don't need a different compatible for the different cores, as in
>> the
>> declaration, there's nothing special that differentiates them that
>> much.
>>
>> I understand that there may be a need to differentiate the core
>> number, as
>> in, CORE0 always has to be the leader, while CORE1 would be the
>> follower,
>> but this is not a good reason to give them a different compatible
>> string.
>>
>> I want to make you aware that Kyrie Wu did the same thing as you did
>> here
>> and in my review on his patch I was able to give an extensive example
>> of
>> how this should look; the exactly same logic would apply to this
>> patch.
>>
>> Please have a look here:
>> https://patchwork.kernel.org/comment/24726607/
>>
>> P.S.: In short, you should have only one "mediatek,mtk-venc-hw"
>> compatible
>>         used for probing both cores.
> 
> thanks for your suggestions, with your example, venc can be rewritten
> like this:
> venc {
>      compatible = "mediatek,mt8195-vcodec-enc";
>      ..... other properties .....
> 
>      venc_core0 {
>          compatible = "mediatek,mtk-venc-hw";
>          mediatek,hw-leader;//mediatek,venc-core0;
>          ..... other properties .....
>      };
> 
>      venc_core1 {
>          compatible = "mediatek,mtk-venc-hw";
>          //mediatek,venc-core1;
>          ..... other properties .....
>      };
> };
> I will rewrite this code if it matches your suggestions.

Yes, exactly. Just one nit, please don't use underscores.

venc_core0: venc-hw@(addr)
this is fine ^

venc_core0: venc_hw@(addr)
this is NOT ok ^^

By the way, one (or more than one) of the commits in this series
is not working correctly, giving a kernel panic on dma mem alloc.

Looking forward to see the new version!

Regards,
Angelo


