Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E343152BA70
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiERMPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbiERMPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:15:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C637D188E77;
        Wed, 18 May 2022 05:15:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C929E1F45027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652876116;
        bh=FtVu2AuXw/AthOSnF4m9ZOeWkCS8FD3CfCIxTGildz4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aW57lKMy568QDyibKHFp8KIuYtoEcTU9ZlysDg7TgOISJeQkR21ZzG6i6rm7EdkXp
         imamVhyO/QUhVa/GJhgXyfjHbhKOAWr7n0NB13CmQGEkiW6E8fmUXOy3Rl0Mc7A01I
         dUeRGME6DL6YM55g6xEdzyawSTicaFE99npv3YmHrfNlSDiqE32AIrR2uu6uO8ZE1C
         sC1bgLitM8tZY4IOPt1yeCXAtgs6YIG6WBneFohHm2TH9xUuQPXOsUbjE+qARBVU4l
         5tHC/JSN11roernrhQW2ggVmJnnDtWG3KVXUhO9RhmT+9G1lN04eNRIvS0EUkNSUo9
         pAkVqgogKF3jw==
Message-ID: <ead37cb0-c841-df1a-ca10-a396b5e9951c@collabora.com>
Date:   Wed, 18 May 2022 14:15:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] clk: mediatek: Fix unused 'ops' field in mtk_pll_data
Content-Language: en-US
To:     Boris Lysov <arz65xx@gmail.com>, arzamas-16@mail.ee,
        mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        wenst@chromium.org, miles.chen@mediatek.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220515122409.13423-1-arzamas-16@mail.ee>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220515122409.13423-1-arzamas-16@mail.ee>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/05/22 14:24, Boris Lysov ha scritto:
> From: Boris Lysov <arzamas-16@mail.ee>
> 
> Allow to specify optional clk_ops in mtk_pll_data which will be picked up in
> mtk_clk_register_pll. So far no already supported Mediatek SoC needs
> non-default clk_ops for PLLs but instead of removing this field it will be
> actually used in the future for supporting older SoCs (see [1] for details)
> with quirky PLLs.
> 

Hello Boris,

I disagree about this change and would rather see the ops pointer removed
with fire.

I got that you're trying to do something about "quirky PLLs", but is it
really about the PLLs that you're mentioning being "quirky", or are they
simply a different IP?

Also, if it's just about a bit inversion and a bigger delay:
1. Bigger delay: Depending on how bigger, we may simply delay more by default
    for all PLLs, even the ones that aren't requiring us to wait for longer...
    ...after all, if it's about waiting for 10/20 *microseconds* more, that's
    really not going to affect anyone's UX, nor make things slower for real,
    as the .prepare() ops for MediaTek PLLs are seldom called.. and even if
    that wasn't true, I don't think that a total of 30uS would be that much
    detrimental to the system's overall operation latency.
    Besides, if you see a case of a PLL not just switching on and off, but
    preparing and unpreparing continuously, there must be some big issue in
    some driver, or in the clock framework somewhere (and that ain't the case);

2. Bit inversion: that can be solved simply with a flag in the prepare/unprepare
    ops for this driver... and if you want something that performs even better,
    sparing you a nanosecond or two, you can always assign an "inverted" callback
    for managing that single bit;

3. Different IP: mtk_clk_register_(name-of-the-new-ip)_pll() - I don't think that
    there's anything to explain to that one.

Regards,
Angelo

> This patch depends on series "clk: mediatek: Move to struct clk_hw provider
> APIs" [2] by Chen-Yu Tsai.
> 
> [1] https://lists.infradead.org/pipermail/linux-mediatek/2022-February/035093.html
> [2] https://lists.infradead.org/pipermail/linux-mediatek/2022-May/040921.html
> 
> Signed-off-by: Boris Lysov <arzamas-16@mail.ee>
> ---
>   drivers/clk/mediatek/clk-pll.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index cabdf25a27f3..509959a325f0 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -347,7 +347,10 @@ static struct clk_hw *mtk_clk_register_pll(const struct mtk_pll_data *data,
>   
>   	init.name = data->name;
>   	init.flags = (data->flags & PLL_AO) ? CLK_IS_CRITICAL : 0;
> -	init.ops = &mtk_pll_ops;
> +	if (data->ops)
> +		init.ops = data->ops;
> +	else
> +		init.ops = &mtk_pll_ops;
>   	if (data->parent_name)
>   		init.parent_names = &data->parent_name;
>   	else
> 

