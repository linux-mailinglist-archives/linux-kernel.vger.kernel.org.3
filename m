Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC59491FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244562AbiARHQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiARHQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:16:56 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8185BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 23:16:56 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so5000205wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 23:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gQlMCAcARMG5FZb81MNJqivPJJioAm6mST3VLIgQHo4=;
        b=w13nMXKuBBBdeS+i26nmMjhAWRhH/ujBlUHnXn/tQNnXae/VTHb2qvO2cMKk8Ded55
         zpsoCUq5wgV41tQ725NEP4MDZr0E9c+BQar8DiNkXgjvz+n0u2a9XgB7RUtJiYydUxmt
         iKQLngsap/85QG67ppWGPT1b8qvuPdr8ejicf17/tg9IvNM7AOQ7E/tsAQHAgJ0PaqBK
         ww2wc+iJ50uwrUJl2LsPhA64ZFXR/EK05N4e9KQg+CY+kkH18XiFp2dEc/EOZ0/p5Kri
         2gENv9JA1CQ0qHKKJI2Q/NQZ1cNyS2he4/H9PC41Nvag5HQ9o9817+mcHQdz/LWPMbJa
         dA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gQlMCAcARMG5FZb81MNJqivPJJioAm6mST3VLIgQHo4=;
        b=W3+vJwMaBtjBm/ZaQjDjpneXbCo/8RTD0yupp7AThuLdZK5+8RYoX0CU12X3sI0ekt
         Cw4YyE1D+ZwyFpZu+8Yg+uwNYObQenSotvVPoXFqbSLQF8fbMucdS+cNS2mVwgv5+369
         qkUZAjTOX+utBIqv6uJLwkutQOfh2K/xwL+7s8ZiWyZNRInwWXOZErVgsFbYHpEWYy7o
         FWZOYhJW8FIK0UGpBQi6gZXH03swsZ1WzgL/zQY3k7VOMzbfMZnOAzy9hLZ9Q0g7pvHq
         JG44y8UPY4kDin77QWyKmSCeFK1NrcLLk8qFIdWzBrWo9ch4+ZdC9QvBsJbr1VpAtkQR
         0TRg==
X-Gm-Message-State: AOAM530zITNAImpghfBYrHiOTG2VmXbuJgZM/PoxCw4tEhhI34QklcR3
        nXxscZhhOq3RI6wCjLHDP7c6lUF9WC+nTA==
X-Google-Smtp-Source: ABdhPJxKc+ZC2Ld6AKfixfKo46o7GzpW/fBRbf7XtLwAgiclXSvE7816Dx7jzlhdzKg7Ogrm83MWJw==
X-Received: by 2002:a05:6000:15ca:: with SMTP id y10mr6369451wry.261.1642490214958;
        Mon, 17 Jan 2022 23:16:54 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:2b9:c814:ff2f:49bf? ([2001:861:44c0:66c0:2b9:c814:ff2f:49bf])
        by smtp.gmail.com with ESMTPSA id d200sm1422663wmd.28.2022.01.17.23.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 23:16:54 -0800 (PST)
Subject: Re: [PATCH] drm/bridge: dw-hdmi: use safe format when first in bridge
 chain
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "robert.foss@linaro.org" <robert.foss@linaro.org>
Cc:     "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "kieran.bingham@ideasonboard.com" <kieran.bingham@ideasonboard.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "kieran.bingham+renesas@ideasonboard.com" 
        <kieran.bingham+renesas@ideasonboard.com>
References: <20220117141750.1182223-1-narmstrong@baylibre.com>
 <cdc8dd0f08aea5f8a32a6da7ec087c8d48d627f5.camel@toradex.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <6558973d-8d16-9e41-44ca-4e8cde5ce049@baylibre.com>
Date:   Tue, 18 Jan 2022 08:16:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cdc8dd0f08aea5f8a32a6da7ec087c8d48d627f5.camel@toradex.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/01/2022 17:53, Marcel Ziswiler wrote:
> Hi Neil
> 
> Sorry, just some trivial spelling fixes.
> 
> On Mon, 2022-01-17 at 15:17 +0100, Neil Armstrong wrote:
>> When the dw-hdmi bridge is in first place of the bridge chain, this
>> means there is now way
> 
> no way
> 
>> to select an input format of the dw-hdmi HW
>> component.
>>
>> Since introduction of display-connector, negociation
> 
> :%s/negociation/negotiation/g
> 
>> was broken since
>> the dw-hdmi negociation code only worked when the dw-hdmi bridge was
>> in last position of the bridge chain or behind another bridge also
>> supporting input & output format negociation.
>>
>> Commit 0656d1285b79 ("drm/bridge: display-connector: implement bus fmts callbacks")
>> was introduced to make negociation work again by making display-connector
>> act as a pass-through concerning input & output format negociation.
>>
>> But in the case were
> 
> where
> 
>> the dw-hdmi was single in the bridge chain, for
>> example on Renesas SoCs, with the disply-connector
> 
> display-connector
> 
>> bridge the dw-hdmi
>> is no more single, breaking output format.
>>
>> Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
>> Bisected-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>> Fixes: 0656d1285b79 ("drm/bridge: display-connector: implement bus fmts callbacks").
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index 54d8fdad395f..9f2e1cac0ae2 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -2551,8 +2551,9 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
>>         if (!output_fmts)
>>                 return NULL;
>>  
>> -       /* If dw-hdmi is the only bridge, avoid negociating with ourselves */
>> -       if (list_is_singular(&bridge->encoder->bridge_chain)) {
>> +       /* If dw-hdmi is the first or only bridge, avoid negociating with ourselves */
>> +       if (list_is_singular(&bridge->encoder->bridge_chain) ||
>> +           list_is_first(&bridge->chain_node, &bridge->encoder->bridge_chain)) {
>>                 *num_output_fmts = 1;
>>                 output_fmts[0] = MEDIA_BUS_FMT_FIXED;
>>  
>> @@ -2673,6 +2674,10 @@ static u32 *dw_hdmi_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>>         if (!input_fmts)
>>                 return NULL;
>>  
>> +       /* If dw-hdmi is the first bridge fall-back to safe output format */
>> +       if (list_is_first(&bridge->chain_node, &bridge->encoder->bridge_chain))
>> +               output_fmt = MEDIA_BUS_FMT_FIXED;
>> +
>>         switch (output_fmt) {
>>         /* If MEDIA_BUS_FMT_FIXED is tested, return default bus format */
>>         case MEDIA_BUS_FMT_FIXED:
> 
> Cheers
> 
> Marcel
> 

Thanks for the spelling fixes,

Neil
