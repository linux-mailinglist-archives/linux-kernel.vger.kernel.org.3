Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058AB48E676
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240423AbiANI1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240174AbiANI0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:26:22 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FD8C0613EE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 00:23:55 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v6so14250551wra.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 00:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2SXNoXMdnGaSfy4KnO5GzxkSIdaPrK9msaNZUkt3T8Y=;
        b=TyRi88oeaki7bUJT9yoFyv6wUj9fpeayXEzTbacbcpowHz8FPfwCEa5pPeNp4hic2A
         1LUiMChZ/JgR4XfavZjb1aUuuO2byzLkGj1zOXheJtN63skSUHN8+KmF8d19GagVbsrr
         3fmQKuhufkBrR7HLsFJkJOrO+niqCVoiY6pXytGHfK3Z/P2h4xZlwMO0M6mfyCp643jF
         mVBK4R++pEHgYWm8fqj840V0Bd7FVUMAC9/gMdKD2vUoCfCbBcTjHl4ISxc5ELSpzHNM
         hEOssy1EdHg2qUjygRA/8pzlYYvPdaPBs1bBkE4hJnxLCH+S/QkVvPnwozU/+o0Z1GpP
         y65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2SXNoXMdnGaSfy4KnO5GzxkSIdaPrK9msaNZUkt3T8Y=;
        b=Z+6frKUSNdTDhic4C/uD4QBeq00pREGnWSLX7sfeyqjIgPgjGVf3Scmc6ClfssVB8e
         en3ucdY8BF8zaUya+5TsWljYD50zzvZfvI5zLI7MZPgQC17RVdIR3xur/yG9bBoFcp7K
         G8gq6qFCgq29vIWL6FpZms51ECS8r2s9q4rJvE5LGWMNSYBUNGHipxu30BVolRLXj+HY
         SbU/aRU6E9T4fBgtYM2gkkHtgryzYl2sslLMrFYmklb9c0ECKEx4fNBemxeOjtvd7y5W
         wHptcuUC6KdWqiwk+0O4fTnoLERLRe2eiA1yJ5oSWktdtkOX8VyuKSfm0wwwJJGQRnGf
         akfQ==
X-Gm-Message-State: AOAM533B6Dey9VVpsuuJDNTgQZg7q2Tnla2omPj/JVAkicDi7V+HqIbw
        qM8O5eBwUWnqhrQF1YK5AFDszf/co+zr7Q==
X-Google-Smtp-Source: ABdhPJwtTLFQyCczvzEvPARkSbWXpC8Q4vilLBDbd9n7KTtKKzr0kpI3M6BrzPhUDH5NWo5f3LRQ0Q==
X-Received: by 2002:a5d:6781:: with SMTP id v1mr2909142wru.714.1642148633286;
        Fri, 14 Jan 2022 00:23:53 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:a3fc:c40b:5afc:88ee? ([2001:861:44c0:66c0:a3fc:c40b:5afc:88ee])
        by smtp.gmail.com with ESMTPSA id i82sm5990464wma.23.2022.01.14.00.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 00:23:52 -0800 (PST)
Subject: Re: dw_hdmi is showing wrong colour after commit
 7cd70656d1285b79("drm/bridge: display-connector: implement bus fmts
 callbacks")
To:     Fabio Estevam <festevam@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "robert.foss@linaro.org" <robert.foss@linaro.org>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <OS0PR01MB59221ED76B74231F5836D5FB86539@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAOMZO5DJiCb5bJN5_nxnYa-FsK-u7QtFghWNzs_-udE42XPDeA@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <502f3ec4-fea4-8e14-c7a9-39418fc05d6d@baylibre.com>
Date:   Fri, 14 Jan 2022 09:23:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5DJiCb5bJN5_nxnYa-FsK-u7QtFghWNzs_-udE42XPDeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/01/2022 21:01, Fabio Estevam wrote:
> Hi Biju,
> 
> On Thu, Jan 13, 2022 at 2:45 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>>
>> Hi All,
>>
>> RZ/G2{H, M, N} SoC has dw_hdmi IP and it was working ok(colour) till the commit
>> 7cd70656d1285b79("drm/bridge: display-connector: implement bus fmts callbacks").
>>
>> After this patch, the screen becomes greenish(may be it is setting it into YUV format??).
>>
>> By checking the code, previously it used to call get_input_fmt callback and set colour as RGB24.
>>
>> After this commit, it calls get_output_fmt_callbck and returns 3 outputformats(YUV16, YUV24 and RGB24)
>> And get_input_fmt callback, I see the outputformat as YUV16 instead of RGB24.
>>
>> Not sure, I am the only one seeing this issue with dw_HDMI driver.

This patch was introduced to maintain the bridge color format negotiation after using DRM_BRIDGE_ATTACH_NO_CONNECTOR,
but it seems it behaves incorrectly if the first bridge doesn't implement the negotiation callbacks.

Let me check the code to see how to fix that.

> 
> I have tested linux-next 20220112 on a imx6q-sabresd board, which shows:
> 
> dwhdmi-imx 120000.hdmi: Detected HDMI TX controller v1.30a with HDCP
> (DWC HDMI 3D TX PHY)
> 
> The colors are shown correctly here.
> 

The imx doesn't use DRM_BRIDGE_ATTACH_NO_CONNECTOR so the negotiation fails and use the RGB fallback input & output format.

Anyway thanks for testing

Neil
