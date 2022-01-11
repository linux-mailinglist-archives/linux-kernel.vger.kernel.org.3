Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4103548AEA3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240730AbiAKNmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240677AbiAKNl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:41:56 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0DAC06173F;
        Tue, 11 Jan 2022 05:41:56 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B33CB1F41335
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641908515;
        bh=XWzCJsaH6wHTXJqGMpj21M7J1fiTCwiWPz1Rvurv6F0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=i63l37cdQxVHCycznoQLNqikVpR+XWURwD9UxexkQHuN5615sQmYug73Vj/l5IGvH
         ijC/fM9UARd3rdmuNeDZHp8clUFmoOP1AiSykJW6X7iNgID+N1MnaW2VpAXDRF7sIC
         x0OGlTAu8EHyM5SCUQglTJ+AJN7PFYsztLudLzwNbpRRPAQzTz27b1YPs1iQcq7aHf
         Vrfs9VD8aemndlNgvUC9r8upngqYOjpeSvNlcxuVFGPPuu09++d/TVm1XiFASpizud
         rHnx9KMKSiVCX5G1etKLPY+gF5HSPqYVM6Hao5vgZLykpTj6hIkboonZUgMA0DYHVD
         jpWarfJdQRtTw==
Subject: Re: [PATCH 6/7] pinctrl: mediatek: paris: Skip custom extra pin
 config dump for vrtual GPIOs
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
References: <20220111112244.1483783-1-wenst@chromium.org>
 <20220111112244.1483783-7-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <a8251721-9df2-8bea-11fd-87806d70f444@collabora.com>
Date:   Tue, 11 Jan 2022 14:41:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220111112244.1483783-7-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/01/22 12:22, Chen-Yu Tsai ha scritto:
> Virtual GPIOs do not have any hardware state associated with them. Any
> attempt to read back hardware state for these pins result in error
> codes.
> 
> Skip dumping extra pin config information for these virtual GPIOs.
> 
> Fixes: 184d8e13f9b1 ("pinctrl: mediatek: Add support for pin configuration dump via debugfs.")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Can you please fix the typo in the commit title? "vrtual"->"virtual"

After the typo fix:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Thank you!

> ---
>   drivers/pinctrl/mediatek/pinctrl-paris.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> index 1bacabfbc183..678c8aa33012 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> @@ -585,6 +585,9 @@ ssize_t mtk_pctrl_show_one_pin(struct mtk_pinctrl *hw,
>   	if (gpio >= hw->soc->npins)
>   		return -EINVAL;
>   
> +	if (mtk_is_virt_gpio(hw, gpio))
> +		return -EINVAL;
> +
>   	desc = (const struct mtk_pin_desc *)&hw->soc->pins[gpio];
>   	pinmux = mtk_pctrl_get_pinmux(hw, gpio);
>   	if (pinmux >= hw->soc->nfuncs)
> 

