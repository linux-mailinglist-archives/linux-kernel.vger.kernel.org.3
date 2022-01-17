Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E3B490B37
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbiAQPME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiAQPMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:12:03 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCD3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:12:02 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso25084387wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iobZ9nIGQYOcCvMsLNiuSueXQIR4Q93XXCRE5G/Gobc=;
        b=uBbnoT68ad0CaZ2z4c+QV0CuII+8J3rnGOJVehC4ySqxyK+ZWJj6ihSWXZhrEmH51E
         24OHvfLpL0HjzFVLZvrDuS/fFnvQx74Uy2ZU0Z3UUsfOG2Dz08cB6KybWUvIeK5eDTxS
         phOal6YFDo8zXfOgYjULbSGpF3f2EtKSdgZMuq9JUJSzDHgKTZriArJHisUOk6/0U11e
         +jK3NfFEfW8GTVIIjSQ6/afnFAfcxP0bCfRKQFunIM2lJkqzcenA/nSnMLjho+hP+KfV
         0euUq3vrdA2vZ+lnoNpvD+5AI2JJHRnhcFRwptzKPsqG8AtVikmwB3dcO2x7JVZBAUbs
         QCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iobZ9nIGQYOcCvMsLNiuSueXQIR4Q93XXCRE5G/Gobc=;
        b=GnQprR+/yGxtZDNZFr9OvxoX8wfu/mUZngfAg+IFnX2F8qBOyaWBqBU1iAeDJivAeB
         9dKtWK8Tcdpst2w1Ru5vuCPWzgzSKcOiAuFu2U/f2XXww01GgwgnkhHiTkKSTZCnk4RP
         T9+l3BjJsogHyiqC6/ZHnX52aUQgCvAfBKuytAaHvNL/4Zw9DPBDtA5DICJ6DMXqps1U
         ZclHNUMEMyZoyH2HmB12AU1xwB3N7drEVu3nxUbNaRUQg14ZmaC68F/cXQ3OcAGnsujo
         pzY7OzDglA6c47xFN05ee8Rz4axf3ItinIBen/mc6mBRinF9MXdMVCSlG4DblytUhKR7
         S9LQ==
X-Gm-Message-State: AOAM531MRHk8vPz7v5LTu58DiZy/TXeIyPm601w3eTjWjddyaHA+XEur
        CFAcVBGHL1RVlMzbYTtlvmLTjw==
X-Google-Smtp-Source: ABdhPJzkNeQEobN5QpybM3e8obvxhbFXFSFUTDbbVh1vK9voBPPmlRJxDdyzSsnY0+lrrKtC1xP+8w==
X-Received: by 2002:a05:600c:3b9a:: with SMTP id n26mr14317988wms.88.1642432321271;
        Mon, 17 Jan 2022 07:12:01 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:c004:9fe1:fbda:2d0c? ([2001:861:44c0:66c0:c004:9fe1:fbda:2d0c])
        by smtp.gmail.com with ESMTPSA id p62sm13589984wmp.10.2022.01.17.07.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 07:12:00 -0800 (PST)
Subject: Re: [PATCH] drm/bridge: dw-hdmi: use safe format when first in bridge
 chain
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        "robert.foss@linaro.org" <robert.foss@linaro.org>
Cc:     "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
References: <20220117141750.1182223-1-narmstrong@baylibre.com>
 <OS0PR01MB592290D81CE917A0125C519E86579@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <89d47094-e23f-7c36-7cc8-c261a921c2ab@baylibre.com>
Date:   Mon, 17 Jan 2022 16:11:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <OS0PR01MB592290D81CE917A0125C519E86579@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2022 15:27, Biju Das wrote:
> Hi Neil,
> 
> Thanks for the patch
> 
>> Subject: [PATCH] drm/bridge: dw-hdmi: use safe format when first in bridge
>> chain
>>
>> When the dw-hdmi bridge is in first place of the bridge chain, this means
>> there is now way to select an input format of the dw-hdmi HW component.
>>
>> Since introduction of display-connector, negociation was broken since the
>> dw-hdmi negociation code only worked when the dw-hdmi bridge was in last
>> position of the bridge chain or behind another bridge also supporting
>> input & output format negociation.
>>
>> Commit 0656d1285b79 ("drm/bridge: display-connector: implement bus fmts
>> callbacks") was introduced to make negociation work again by making
>> display-connector act as a pass-through concerning input & output format
>> negociation.
>>
>> But in the case were the dw-hdmi was single in the bridge chain, for
>> example on Renesas SoCs, with the disply-connector bridge the dw-hdmi is
>> no more single, breaking output format.
>>
>> Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
>> Bisected-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> Fixes: 0656d1285b79 ("drm/bridge: display-connector: implement bus fmts
>> callbacks").
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index 54d8fdad395f..9f2e1cac0ae2 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -2551,8 +2551,9 @@ static u32
>> *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
>>  	if (!output_fmts)
>>  		return NULL;
>>
>> -	/* If dw-hdmi is the only bridge, avoid negociating with ourselves
>> */
>> -	if (list_is_singular(&bridge->encoder->bridge_chain)) {
>> +	/* If dw-hdmi is the first or only bridge, avoid negociating with
>> ourselves */
>> +	if (list_is_singular(&bridge->encoder->bridge_chain) ||
>> +	    list_is_first(&bridge->chain_node,
>> +&bridge->encoder->bridge_chain)) {
>>  		*num_output_fmts = 1;
>>  		output_fmts[0] = MEDIA_BUS_FMT_FIXED;
>>
>> @@ -2673,6 +2674,10 @@ static u32
>> *dw_hdmi_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>>  	if (!input_fmts)
>>  		return NULL;
>>
>> +	/* If dw-hdmi is the first bridge fall-back to safe output format */
>> +	if (list_is_first(&bridge->chain_node, &bridge->encoder-
>>> bridge_chain))
>> +		output_fmt = MEDIA_BUS_FMT_FIXED;
>> +
> 
> Based on my debugging, this looks redundant, as get_output_bus_fmts already sets output_fmt = MEDIA_BUS_FMT_FIXED,
> And *num_output_fmts = 1, so the function parameter output_fmt in input_bus_fmts will have MEDIA_BUS_FMT_FIXED
> And no need to override output_fmt value.  I may be wrong here.

You're right, I added this in case another bridge than display-connector is used, but in fact it should instead
check if first bridge of the chain and output_fmt == MEDIA_BUS_FMT_RGB888_1X24 || output_fmt == MEDIA_BUS_FMT_FIXED
otherwise return an error.

I'll send it separately since it's out of the scope of the issue fixed.

Neil

> 
> Regards,
> Biju
> 
>>  	switch (output_fmt) {
>>  	/* If MEDIA_BUS_FMT_FIXED is tested, return default bus format */
>>  	case MEDIA_BUS_FMT_FIXED:
>> --
>> 2.25.1
> 

