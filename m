Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6064A48AEB3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240830AbiAKNmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbiAKNmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:42:32 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D94C06173F;
        Tue, 11 Jan 2022 05:42:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4C8251F41337
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641908551;
        bh=S0e9ARTzAtOgvzTS0yLRD4LzdD1nK8G8odiHX264OtU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C0hzcMGIv+omsReBHdCQqtwRp3ld7tYoNqW+9W+h2cTejXkDYZ2u6HEuu9lR2xDz6
         Q+ORrX/6nTkfDSuNHe5P/wXShrJQ/t0KD3Z4tfhWldwbVSVemgBY7SpgfDqm1O/W5Y
         5IuJM5HryMdx81rbUeJG4mjVh4QiugryW/8FZjuoJY9ZxjxnbMRV0nJOLOEE0/qxwH
         IF2VH8o6JjrQ++8QPnQ/r6EFQ4mdGglcy7nfCc+Bl2TlNCNom9IWrkBlGl/gUl75iB
         tCQJIQFFc4IwI1gP6NNd589vqWOwTfk3Aeq/HwceWUvNC6niE33pqmjW9rpffqKPZL
         +hT4HMYk0OKlQ==
Subject: Re: [PATCH 1/7] pinctrl: pinconf-generic: Print arguments for
 bias-pull-*
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
References: <20220111112244.1483783-1-wenst@chromium.org>
 <20220111112244.1483783-2-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <2dc957b1-300f-161c-edb6-efacf11942e0@collabora.com>
Date:   Tue, 11 Jan 2022 14:42:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220111112244.1483783-2-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/01/22 12:22, Chen-Yu Tsai ha scritto:
> The bias-pull-* properties, or PIN_CONFIG_BIAS_PULL_* pin config
> parameters, accept optional arguments in ohms denoting the strength of
> the pin bias.
> 
> Print these values out in debugfs as well.
> 
> Fixes: eec450713e5c ("pinctrl: pinconf-generic: Add flag to print arguments")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Tested on qcom-SC7180 Trogdor, mtk-MT8173 Elm, and others;

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/pinctrl/pinconf-generic.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
> index f8edcc88ac01..415d1df8f46a 100644
> --- a/drivers/pinctrl/pinconf-generic.c
> +++ b/drivers/pinctrl/pinconf-generic.c
> @@ -30,10 +30,10 @@ static const struct pin_config_item conf_items[] = {
>   	PCONFDUMP(PIN_CONFIG_BIAS_BUS_HOLD, "input bias bus hold", NULL, false),
>   	PCONFDUMP(PIN_CONFIG_BIAS_DISABLE, "input bias disabled", NULL, false),
>   	PCONFDUMP(PIN_CONFIG_BIAS_HIGH_IMPEDANCE, "input bias high impedance", NULL, false),
> -	PCONFDUMP(PIN_CONFIG_BIAS_PULL_DOWN, "input bias pull down", NULL, false),
> +	PCONFDUMP(PIN_CONFIG_BIAS_PULL_DOWN, "input bias pull down", "ohms", true),
>   	PCONFDUMP(PIN_CONFIG_BIAS_PULL_PIN_DEFAULT,
> -				"input bias pull to pin specific state", NULL, false),
> -	PCONFDUMP(PIN_CONFIG_BIAS_PULL_UP, "input bias pull up", NULL, false),
> +				"input bias pull to pin specific state", "ohms", true),
> +	PCONFDUMP(PIN_CONFIG_BIAS_PULL_UP, "input bias pull up", "ohms", true),
>   	PCONFDUMP(PIN_CONFIG_DRIVE_OPEN_DRAIN, "output drive open drain", NULL, false),
>   	PCONFDUMP(PIN_CONFIG_DRIVE_OPEN_SOURCE, "output drive open source", NULL, false),
>   	PCONFDUMP(PIN_CONFIG_DRIVE_PUSH_PULL, "output drive push pull", NULL, false),
> 

