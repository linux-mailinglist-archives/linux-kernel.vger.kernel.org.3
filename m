Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C7B493679
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352318AbiASInV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:43:21 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46388 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350075AbiASInP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:43:15 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5B9CD1F43EEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642581794;
        bh=+B/hBYH7GoT/nMpZGsa7fzqnbMcaX/mKr3HkH43rjNs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=B7fnRyEiv3YXlB6PoTAFo3/4bmFrAPkPYZFXQ9ynaU9m5DUkcG4cTDilG0Z8MXAkB
         fCNIaIGNgV/V/et8nXtADyCRV1h15fCAkpqkQgiFvrztHWGUkhJzzRhLaObUZDf/gT
         56fo+GEB82DGmRemXivmBGri3BrqlGBj9z1IWzaY47v/fETPFfTjxqYaPoITkiH+Yo
         Dn0SyHHEZwYeCiDo+bg9qvJsTZBb5J/C7PoZD8bQUxwOSrS8Rp5z88453txR9Xzrpb
         CAgHXlokVWdyN3C61jZiIHHe71rhJClBQnvABRyQTMGMBtidCT14NMP4THvVYn+yal
         LOto4upOWFIhA==
Subject: Re: [v10,2/3] drm/mediatek: implement the DSI HS packets aligned
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        chunkuang.hu@kernel.org, matthias.bgg@gmail.com,
        narmstrong@baylibre.com, robert.foss@linaro.org, daniel@ffwll.ch,
        airlied@linux.ie, p.zabel@pengutronix.de
Cc:     xji@analogixsemi.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220119022543.26093-1-rex-bc.chen@mediatek.com>
 <20220119022543.26093-3-rex-bc.chen@mediatek.com>
 <4abe1f96-aafd-71bc-5f5e-bfcc4320c8c4@intel.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <35821437-8f62-e4f3-0614-2a6a59668938@collabora.com>
Date:   Wed, 19 Jan 2022 09:43:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <4abe1f96-aafd-71bc-5f5e-bfcc4320c8c4@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/01/22 09:35, Andrzej Hajda ha scritto:
> 
> On 19.01.2022 03:25, Rex-BC Chen wrote:
>> Some DSI RX devices (for example, anx7625) require last alignment of
>> packets on all lanes after each row of data is sent.
>> Otherwise, there will be some issues of shift or scroll for screen.
>>
>> Take horizontal_sync_active_byte for a example,
>> we roundup the HSA packet data to lane number, and the subtraction of 2
>> is the packet data value added by the roundup operation, making the
>> long packets are integer multiples of lane number.
>> This value (2) varies with the lane number, and that is the reason we
>> do this operation when the lane number is 4.
>>
>> In the previous operation of function "mtk_dsi_config_vdo_timing",
>> the length of HSA and HFP data packets has been adjusted to an
>> integration multiple of lane number.
>> Since the number of RGB data packets cannot be guaranteed to be an
>> integer multiple of lane number, we modify the data packet length of
>> HBP so that the number of HBP + RGB is equal to the lane number.
>> So after sending a line of data (HSA + HBP + RGB + HFP), the data
>> lanes are aligned.
>>
>> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
>> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
>> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> 
> Regards
> 
> Andrzej
> 
>> ---
>>   drivers/gpu/drm/mediatek/mtk_dsi.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> index 5d90d2eb0019..e91b3fff4342 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> @@ -500,6 +500,18 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
>>           DRM_WARN("HFP + HBP less than d-phy, FPS will under 60Hz\n");
>>       }
>> +    if ((dsi->mode_flags & MIPI_DSI_HS_PKT_END_ALIGNED) &&
>> +        (dsi->lanes == 4)) {
>> +        horizontal_sync_active_byte =
>> +            roundup(horizontal_sync_active_byte, dsi->lanes) - 2;
>> +        horizontal_frontporch_byte =
>> +            roundup(horizontal_frontporch_byte, dsi->lanes) - 2;
>> +        horizontal_backporch_byte =
>> +            roundup(horizontal_backporch_byte, dsi->lanes) - 2;
>> +        horizontal_backporch_byte -=
>> +            (vm->hactive * dsi_tmp_buf_bpp + 2) % dsi->lanes;
>> +    }
>> +
>>       writel(horizontal_sync_active_byte, dsi->regs + DSI_HSA_WC);
>>       writel(horizontal_backporch_byte, dsi->regs + DSI_HBP_WC);
>>       writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
