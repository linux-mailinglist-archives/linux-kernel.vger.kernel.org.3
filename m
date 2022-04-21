Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C1C509BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387337AbiDUJKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387317AbiDUJKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:10:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF7313F80;
        Thu, 21 Apr 2022 02:07:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AED2A1F45275
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650532072;
        bh=YhirVsiU72VmlViC0qF9dJVu+SZvUIko/Y4uOCGf3MI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AYLSWEI419fRBsa/VH6DZe33qRGRWn+AvtYeJmCTbyhRxr7uRbmfEpoOKftWN7RYN
         BeyJmuzVrRfedyxDyZ5R89L6PJh6Pp0x/lxraEqvz/kvlCfU1F3kcUiWCAX4g0Y54e
         hEG3EMstHWlXTu30rwEO5Bi2IGI7w6g+bhi1UJ+xTD3JGNDmqgdTIn1RbCm+jkUcXJ
         wptat8V+y4M7tnFn8g3t+pQFoaQOIie0b96DbhP8VSdnmCZ6LS6+KxnttmUfE7zmhn
         OKJqNQxVSM6maCH3/Sf0KRP5zb7rilWYixPLnCsbF4vb5qlLPZiMsJAJ7yCiw+EAzD
         0EQ622FZGi8fw==
Message-ID: <dc2018a0-d981-acf3-9822-f01529782aa6@collabora.com>
Date:   Thu, 21 Apr 2022 11:07:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 07/12] clk: mediatek: reset: Add return for clock reset
 register function
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        allen-kh.cheng@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
 <20220420130527.23200-8-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220420130527.23200-8-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/04/22 15:05, Rex-BC Chen ha scritto:
> To make error handling, we add return for mtk_clk_register_rst_ctrl().
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/clk/mediatek/reset.c | 14 ++++++++------
>   drivers/clk/mediatek/reset.h |  4 ++--
>   2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
> index d67c13958458..b164b1da7dd3 100644
> --- a/drivers/clk/mediatek/reset.c
> +++ b/drivers/clk/mediatek/reset.c

..snip..

> @@ -103,6 +103,8 @@ void mtk_clk_register_rst_ctrl(struct device_node *np,
>   		pr_err("could not register reset controller: %d\n", ret);
>   		kfree(data);

If you return for all error conditions, you can return 0 at the end, so here:

		return ret;

>   	}
> +
> +	return ret;

and here:

	return 0;

>   }
>   
>   MODULE_LICENSE("GPL");


Cheers,
Angelo
