Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A5A4D1BB1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347828AbiCHP2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347815AbiCHP2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:28:17 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466E34DF65;
        Tue,  8 Mar 2022 07:27:20 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 151A41F42FA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646753237;
        bh=YrSAmlhNuPnA20I9mMIbUEsD2fCEnGkr+ilv13TXmk0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aZym5RVsJPVDcroiovKdN5qUHaiQw37QTqDdx6ByCKcjne7NAEcAa855Qxs2Qy+2J
         4Erm1YYwLasG3hnrcp8f521OYbDSlkLMryuCh8uHkckeFMY6NyhlLoN2F7oIfV3hF1
         F0Uy5gnihs4lYPJcdqAKH+8CARbpTD5P9QOlevuoPwC9yeJdeYAkeCOKc7pvOvumzK
         5ikJdOToe7gKT1qIplS7M21F4FyLLpViSLYOpz0otypIGMJx72aGO3r4kMAmt/I//K
         BXY7nM2LmyWl5W2v+kl1JWgPHo+Cx0ClCTosYQ3RArpsb2+ugZ0q/WNzX/GUiHTK7G
         eh6swMwlBtAOg==
Message-ID: <1dacb30a-ee81-d6a9-d2a0-500385c57de4@collabora.com>
Date:   Tue, 8 Mar 2022 16:27:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 02/11] pinctrl: mediatek: paris: Fix PIN_CONFIG_BIAS_*
 readback
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220308100956.2750295-1-wenst@chromium.org>
 <20220308100956.2750295-3-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220308100956.2750295-3-wenst@chromium.org>
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

Il 08/03/22 11:09, Chen-Yu Tsai ha scritto:
> When reading back pin bias settings, if the pin is not in the
> corresponding bias state, the function should return -EINVAL.
> 
> Fix this in the mediatek-paris pinctrl library so that the read back
> state is not littered with bogus a "input bias disabled" combined with
> "pull up" or "pull down" states.
> 
> Fixes: 805250982bb5 ("pinctrl: mediatek: add pinctrl-paris that implements the vendor dt-bindings")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/pinctrl/mediatek/pinctrl-paris.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> index f9f9110f2107..7037560ecda9 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> @@ -96,20 +96,16 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
>   			err = hw->soc->bias_get_combo(hw, desc, &pullup, &ret);
>   			if (err)
>   				goto out;
> +			if (ret == MTK_PUPD_SET_R1R0_00)
> +				ret = MTK_DISABLE;
>   			if (param == PIN_CONFIG_BIAS_DISABLE) {
> -				if (ret == MTK_PUPD_SET_R1R0_00)
> -					ret = MTK_DISABLE;
> +				if (ret != MTK_DISABLE)
> +					err = -EINVAL;
>   			} else if (param == PIN_CONFIG_BIAS_PULL_UP) {
> -				/* When desire to get pull-up value, return
> -				 *  error if current setting is pull-down
> -				 */
> -				if (!pullup)
> +				if (!pullup || ret == MTK_DISABLE)
>   					err = -EINVAL;
>   			} else if (param == PIN_CONFIG_BIAS_PULL_DOWN) {
> -				/* When desire to get pull-down value, return
> -				 *  error if current setting is pull-up
> -				 */
> -				if (pullup)
> +				if (pullup || ret == MTK_DISABLE)
>   					err = -EINVAL;
>   			}
>   		} else {



