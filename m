Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31CC55766A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiFWJP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFWJPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:15:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5126142EC4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:15:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 434D012FC;
        Thu, 23 Jun 2022 02:15:54 -0700 (PDT)
Received: from [10.57.85.4] (unknown [10.57.85.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63DC93F792;
        Thu, 23 Jun 2022 02:15:52 -0700 (PDT)
Message-ID: <4bec03b5-c496-ec0d-b968-d4d0e5d2e782@arm.com>
Date:   Thu, 23 Jun 2022 10:15:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 1/3] ASoC: rockchip: i2s: switch BCLK to GPIO
Content-Language: en-GB
To:     Judy Hsiao <judyhsiao@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Chen-Yu Tsai <wenst@chromium.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220623021153.587423-1-judyhsiao@chromium.org>
 <20220623021153.587423-2-judyhsiao@chromium.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220623021153.587423-2-judyhsiao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-23 03:11, Judy Hsiao wrote:
[...]
> @@ -736,6 +799,20 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
>   	}
>   
>   	i2s->bclk_ratio = 64;
> +	i2s->pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (IS_ERR(i2s->pinctrl)) {
> +		dev_err(&pdev->dev, "failed to find i2s pinctrl\n");

If we're still reworking this, it might be good to set i2s->pinctrl to 
NULL here, and similarly free and clear if we fail to get the states in 
the other path, so that everywhere else could consistently have just a 
simple "if (i2s->pinctrl)" check rather than the "IS_ERR() || 
IS_ERR_OR_NULL()" mess.

> +	} else { > +		i2s->bclk_on = pinctrl_lookup_state(i2s->pinctrl, "bclk_on");
> +		if (!IS_ERR_OR_NULL(i2s->bclk_on)) {
> +			i2s->bclk_off = pinctrl_lookup_state(i2s->pinctrl, "bclk_off");
> +			if (IS_ERR_OR_NULL(i2s->bclk_off)) {
> +				dev_err(&pdev->dev, "failed to find i2s bclk_off\n");
> +				goto err_clk;
> +			}
> +		}
> +		i2s_pinctrl_select_bclk_off(i2s);

FWIW it seems a bit odd to call this in the case where we didn't even 
get "bclk_on".

Robin.

> +	}
>   
>   	dev_set_drvdata(&pdev->dev, i2s);
>   
