Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4279C48AEAC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbiAKNmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:42:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50306 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240776AbiAKNm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:42:27 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E0FD61F41337
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641908546;
        bh=UCreUbK892/kWiIWn2pdd9fxoWGUyIKiZH1nbbPcwdI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mwIvm5GO7zmMcNAK4oDZFfaZJj3/3JtrN0WrALn/LLSfuFPtFvs5LmZKNmvwFU3QY
         2QYGT+dndo/0mGDO6OWUB/AovOwJsq2e/HcS0y7q154vL39Yk1LzLy8cc8XRrD6ykk
         K9ffGt1ilunQa4IlfsWw0oZEmsyonFchE1pZBRKBISamAi/pQgSj3qqfF5JjLNb68O
         xYo1KkGKmD+zsCzMbZome9VxKNSfOM9uwHBQuw4SyS4yS36u+kHYanqs0N72ZoOWns
         u4Oi3KJn5SVy/53upnoEizvAgZeyrHvi03VX3jfwnJSUA4sY6Grf5IO97FBh1QUjuE
         HfpnjkqyG1J7A==
Subject: Re: [PATCH 4/7] pinctrl: mediatek: paris: Fix pingroup pin config
 state readback
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
References: <20220111112244.1483783-1-wenst@chromium.org>
 <20220111112244.1483783-5-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <97f46bb0-b446-92da-a83c-751f8b918570@collabora.com>
Date:   Tue, 11 Jan 2022 14:42:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220111112244.1483783-5-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/01/22 12:22, Chen-Yu Tsai ha scritto:
> mtk_pconf_group_get(), used to read back pingroup pin config state,
> simply returns a set of configs saved from a previous invocation of
> mtk_pconf_group_set(). This is an unfiltered, unvalidated set passed
> in from the pinconf core, which does not match the current hardware
> state.
> 
> Since the driver library is designed to have a pin per group, pass
> through mtk_pconf_group_get() to mtk_pinconf_get(), to read back
> the current pin config state of the only pin in the group.
> 
> Fixes: 805250982bb5 ("pinctrl: mediatek: add pinctrl-paris that implements the vendor dt-bindings")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>



Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


> ---
>   drivers/pinctrl/mediatek/pinctrl-paris.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> index d720624d8cd2..d259f075c62d 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> @@ -736,10 +736,10 @@ static int mtk_pconf_group_get(struct pinctrl_dev *pctldev, unsigned group,
>   			       unsigned long *config)
>   {
>   	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
> +	struct mtk_pinctrl_group *grp = &hw->groups[group];
>   
> -	*config = hw->groups[group].config;
> -
> -	return 0;
> +	 /* One pin per group only */
> +	return mtk_pinconf_get(pctldev, grp->pin, config);
>   }
>   
>   static int mtk_pconf_group_set(struct pinctrl_dev *pctldev, unsigned group,
> 
