Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6327D48AEA9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240806AbiAKNmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:42:25 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50284 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240760AbiAKNmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:42:22 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4DB811F41337
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641908540;
        bh=lDIG2k9eO2sPUSgI8LCCCH2mTrm9xRp/KzzWiMNNXf0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SfFOkBYkK2fg5l+m5qJdXlftvPEmqYa4m+zRVveFr01WmlrICnNry3gsvZm9p08Zs
         /U/GWOrAHBEkGcZsvm8g3WZrLJVbzh7CLtq6qtwo/pse/YEVjoDLFjMaHCn3Yy10Oo
         OUrJOEbHIwpMRoLJ+nVsZ4qlJRwM8Glu+HyPV/1LvHVSbExGiqD8RSCO0jIuKL1dUl
         /oVJS7aPSrhid5G9fU9EXoyi83XpGByDm2vfE1czjjgcTlW0uYOPhwdYnZ8vd5zqy9
         Nhap0hmwxuqJo0pyeZQ1xGIMVa7qLqTwx9JU9FWLElWD3WOCBtayQFuH2wHDJVxLT4
         hq/DwkmduIIoQ==
Subject: Re: [PATCH 2/7] pinctrl: mediatek: paris: Fix PIN_CONFIG_BIAS_DISABLE
 readback
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
References: <20220111112244.1483783-1-wenst@chromium.org>
 <20220111112244.1483783-3-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <8ca8dd15-30c3-a89e-9a18-c8b8788e0904@collabora.com>
Date:   Tue, 11 Jan 2022 14:42:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220111112244.1483783-3-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/01/22 12:22, Chen-Yu Tsai ha scritto:
> When reading back pin bias settings, if the pin is not in a
> bias-disabled state, the function should return -EINVAL.
> 
> Fix this in the mediatek-paris pinctrl library so that the read back
> state is not littered with bogus a "input bias disabled" combined with
> "pull up" or "pull down" states.
> 
> Fixes: 805250982bb5 ("pinctrl: mediatek: add pinctrl-paris that implements the vendor dt-bindings")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/pinctrl/mediatek/pinctrl-paris.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> index f9f9110f2107..1ca598ea7ba7 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> @@ -97,8 +97,8 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
>   			if (err)
>   				goto out;
>   			if (param == PIN_CONFIG_BIAS_DISABLE) {
> -				if (ret == MTK_PUPD_SET_R1R0_00)
> -					ret = MTK_DISABLE;
> +				if (ret != MTK_PUPD_SET_R1R0_00)
> +					err = -EINVAL;
>   			} else if (param == PIN_CONFIG_BIAS_PULL_UP) {
>   				/* When desire to get pull-up value, return
>   				 *  error if current setting is pull-down
> 
