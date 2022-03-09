Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528B24D2C86
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiCIJv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiCIJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:51:54 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5936A16EA91;
        Wed,  9 Mar 2022 01:50:55 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id F045F1F44798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646819453;
        bh=Wxi2sPEPW5Mnk1KFkrXeTYYuHUNi8Vd22+lhClnt9yg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XoouHc4xb1hLBRzEuSR0otwFxeo0/dtS24PFfocvqliUbmifiwlWmilMW1F5xbZtL
         Ke+zsplmmO7P62nx1fHPa7z5Relc93XNgn62Sq1fifTuPrjAoR2wP/nSeAobGf44Oq
         nUrL8OkMaBu92poQZWpL8f6rtrvCjn3n/bHJLOQMaWf7/jRttizKxTN4Ev3Jg8Ce5X
         knRCIpHV5uNaG+KUEwFYVNPNwaps29PFFUGfQxXMAkxQ3pG3p4USUh7zoJb1GzNyJf
         qpQwD31fb8+SidbyH+Lcp++Np0F3t889m+tmm+ZlefCtH5xKBXAJ7zt/in1QzaueOV
         FuSPkIixwVLbg==
Message-ID: <affb2499-d0c8-9f8f-bfc0-3bf8b2fa431c@collabora.com>
Date:   Wed, 9 Mar 2022 10:50:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] mmc: mtk-msdc: change a log level
Content-Language: en-US
To:     Alexandre Bailon <abailon@baylibre.com>,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220308094924.2868042-1-abailon@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220308094924.2868042-1-abailon@baylibre.com>
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

Il 08/03/22 10:49, Alexandre Bailon ha scritto:
> We write data to RPMB, we get many time the following log:
> mtk-msdc 11230000.mmc: phase: [map:ffffffff] [maxlen:32] [final:10]
> 
> dev_info is used to print that log but it seems that log is only
> useful for debbuging. Use dev_dbg instead of dev_info.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>

Hello Alexandre,

I definitely agree with this change, but the commit title is not clear enough;
can you please change it to something like

mmc: mtk-sd: Silence delay phase calculation debug log


After the change,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/mmc/host/mtk-sd.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index d5a9c269d492..05c8b4de46f3 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1914,8 +1914,8 @@ static struct msdc_delay_phase get_best_delay(struct msdc_host *host, u32 delay)
>   		final_phase = (start_final + len_final / 3) % PAD_DELAY_MAX;
>   	else
>   		final_phase = (start_final + len_final / 2) % PAD_DELAY_MAX;
> -	dev_info(host->dev, "phase: [map:%x] [maxlen:%d] [final:%d]\n",
> -		 delay, len_final, final_phase);
> +	dev_dbg(host->dev, "phase: [map:%x] [maxlen:%d] [final:%d]\n",
> +		delay, len_final, final_phase);
>   
>   	delay_phase.maxlen = len_final;
>   	delay_phase.start = start_final;
> 

