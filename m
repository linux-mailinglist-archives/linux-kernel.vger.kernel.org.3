Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC84348AEB2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbiAKNmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:42:35 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50320 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240826AbiAKNma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:42:30 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CA5AE1F43CE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641908549;
        bh=355U7/8IRwaZapVvN2SPzxYmIVxbYl9G7+lZldd4sOc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TKbGlYPU/iD9deLlA51q+hc7mwXl9abLPgm8nSMbWSAlRvN5tzpKoTFWt55jwImNh
         GfikhoG+7FjTNtu6ynUx+N+m9HtbgNQTWUE6Uj/QcJQSoY1XN3zSwP10P3AP/Xk39O
         tB7LwXcJKERHQ4iCNAvWH716W7SyAwsaMR6cjXjSRWnirqi/WN5UtKtWyJhHn4dvL7
         Iw8VtDLs9J3vK0CDtBhidqrqOxj0KDs46R/4qFHh4O+7NbP4p8ZGHNI8ANrrfCuwgt
         5LvcUBVQGj1NFvZKKjOgumd610gNp2+M+vclKVILGp1ZVN1ptveVC1XQeiRlObmnmr
         E1W5HOG6xNJlQ==
Subject: Re: [PATCH 3/7] pinctrl: mediatek: paris: Fix "argument" argument
 type for mtk_pinconf_get()
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
References: <20220111112244.1483783-1-wenst@chromium.org>
 <20220111112244.1483783-4-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <f6114de8-940b-558f-a231-2c960e113fc3@collabora.com>
Date:   Tue, 11 Jan 2022 14:42:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220111112244.1483783-4-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/01/22 12:22, Chen-Yu Tsai ha scritto:
> For mtk_pinconf_get(), the "argument" argument is typically returned by
> pinconf_to_config_argument(), which holds the value for a given pinconf
> parameter. It certainly should not have the type of "enum pin_config_param",
> which describes the type of the pinconf parameter itself.
> 
> Change the type to u32, which matches the return type of
> pinconf_to_config_argument().
> 
> Fixes: 805250982bb5 ("pinctrl: mediatek: add pinctrl-paris that implements the vendor dt-bindings")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>



Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/pinctrl/mediatek/pinctrl-paris.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> index 1ca598ea7ba7..d720624d8cd2 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> @@ -188,8 +188,7 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
>   }
>   
>   static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
> -			   enum pin_config_param param,
> -			   enum pin_config_param arg)
> +			   enum pin_config_param param, u32 arg)
>   {
>   	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
>   	const struct mtk_pin_desc *desc;
> 
