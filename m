Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33CC574CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbiGNL5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238003AbiGNL5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:57:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F73C5C362;
        Thu, 14 Jul 2022 04:57:39 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 433AD6601A3B;
        Thu, 14 Jul 2022 12:57:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657799858;
        bh=2viWGbCfExA/tWGEf8o0sIu0spzfJUPHwjKHCwMZ8QI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EEikQaXTSB2NOfx2y1x+0VfJ4xdH2VrKYXTbbP9EmMC5RLbPYSkxCbuuEuNwD9dgJ
         Ie/0/NTP14exe0g2Gz8fH9vR906iG3QPToKxSVur+23Y+X15k9rPlfivjD48HuaU+s
         qZwwBrRacfVi86iXglemjk2PJHGT1f6Q/USp/8E+qMRBPfSy03E0qp093ODbHzAnuv
         xj6QHqmqUCUclM4F71BBEN78VrxjL2MH+vzpFSY9Dom5jUwdhJRzwtVYBNrTSYpwZS
         oPNR4m3+L/ghQYhU32xE4ETANyIrZAPozqVN9EDuNIt8wRsu1szPpqYueYyTWfqLzm
         Ox0VBllhp0q3Q==
Message-ID: <3b74cc48-2e18-3ad1-613c-fb90fced5d7d@collabora.com>
Date:   Thu, 14 Jul 2022 13:57:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [V10,5/7] mtk-jpegenc: add jpeg encode worker interface
Content-Language: en-US
To:     "kyrie.wu" <kyrie.wu@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        nicolas.dufresne@collabora.com, wenst@chromium.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, srv_heupstream@mediatek.com
References: <20220627025625.8956-1-irui.wang@mediatek.com>
 <20220627025625.8956-6-irui.wang@mediatek.com>
 <46eaafc0-478e-8a74-cf8b-dd1f236df035@collabora.com>
 <f8091b62835e99bac2450076c02a39c057a23ad8.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <f8091b62835e99bac2450076c02a39c057a23ad8.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/07/22 10:51, kyrie.wu ha scritto:
> On Tue, 2022-07-05 at 15:27 +0200, AngeloGioacchino Del Regno wrote:
>> Il 27/06/22 04:56, Irui Wang ha scritto:
>>> From: kyrie wu <kyrie.wu@mediatek.com>
>>>
>>> Add jpeg encoding worker to ensure that two HWs
>>> run in parallel in MT8195.
>>>
>>> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
>>> ---
>>>    .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 208
>>> ++++++++++++++++--
>>>    .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  30 ++-
>>>    .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  |  39 +++-
>>>    3 files changed, 240 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
>>> b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
>>> index 0c5c85a112ca..544673a527a0 100644
>>> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
>>> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
>>
>> ..snip..
>>

..snip..

>>> @@ -218,30 +222,37 @@ static irqreturn_t
>>> mtk_jpegenc_hw_irq_handler(int irq, void *priv)
>>>    
>>>    	cancel_delayed_work(&jpeg->job_timeout_work);
>>>    
>>> +	ctx = jpeg->hw_param.curr_ctx;
>>> +	src_buf = jpeg->hw_param.src_buffer;
>>> +	dst_buf = jpeg->hw_param.dst_buffer;
>>> +	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
>>> +
>>>    	irq_status = readl(jpeg->reg_base + JPEG_ENC_INT_STS) &
>>>    		JPEG_ENC_INT_STATUS_MASK_ALLIRQ;
>>>    	if (irq_status)
>>>    		writel(0, jpeg->reg_base + JPEG_ENC_INT_STS);
>>> -	if (!(irq_status & JPEG_ENC_INT_STATUS_DONE))
>>> -		return IRQ_NONE;
>>> -
>>> -	ctx = v4l2_m2m_get_curr_priv(master_jpeg->m2m_dev);
>>> -	if (!ctx) {
>>> -		v4l2_err(&master_jpeg->v4l2_dev, "Context is NULL\n");
>>> -		return IRQ_HANDLED;
>>> +	if (!(irq_status & JPEG_ENC_INT_STATUS_DONE)) {
>>> +		dev_err(jpeg->dev, " Not JPEG_ENC_INT_STATUS_DONE\n");
>>
>> Please be more descriptive in error messages. Also, should this
>> really be
>> a dev_err?!?
> maybe dev_warn is right, I will fix it.
> 

I think that v4l2_err() would be more appropriate.

Regards,
Angelo
