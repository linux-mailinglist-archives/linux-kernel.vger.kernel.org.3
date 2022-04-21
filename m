Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69742509BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbiDUJLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387348AbiDUJKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:10:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D8323179;
        Thu, 21 Apr 2022 02:08:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 90C341F45275
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650532083;
        bh=keF4Fz3OGotsfU3GInulCO4PoeVxbMwTjw3d7ZbAlvk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Bb1MiLDt5WVRhc5pZQS6j2l7V3Hq4uHiDP+kCfIHKQuV+aqzqwjwxvIDAWQu97Lzh
         LfdVIirABReOnE3Hqa2Ebv9ZPH8R/SoHojTpqfPSdOvAHH3i7is1k0KSG5xjO64gwU
         zTv9w+MhorhEHNU1QJtAQcUiDAjyfEnjChnJm+ANNQik4bWt2fn865cvQ0S2Nm2rIN
         cifi7lYzgGPRKdltTgbi5YuO81S3l5lhwbQXuQAd/q4L8ycRcZCGkPp7c6zfPGbM+x
         d8EldGH3a4j1KWXNZ0dAWWgsgjG/0t0VfbOTMhGVdSNluigdh2CrTfQlx3Xq+sfbet
         oeUtk2OFWpRLQ==
Message-ID: <d833bb7f-ee48-602d-9793-5d717d3b5582@collabora.com>
Date:   Thu, 21 Apr 2022 11:07:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 03/12] clk: mediatek: reset: Refine functions of
 set_clr
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
 <20220420130527.23200-4-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220420130527.23200-4-rex-bc.chen@mediatek.com>
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
> To make driver more readable, revise functions of set_clr.
> - Add to_rst_data().
> - Extract common code within assert and deassert to
>    mtk_reset_update_set_clr().
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/clk/mediatek/reset.c | 32 +++++++++++++++++++++-----------
>   1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
> index 9110d0b4229f..6574b19daf0f 100644
> --- a/drivers/clk/mediatek/reset.c
> +++ b/drivers/clk/mediatek/reset.c
> @@ -20,26 +20,36 @@ struct mtk_reset {
>   	struct reset_controller_dev rcdev;
>   };
>   
> -static int mtk_reset_assert_set_clr(struct reset_controller_dev *rcdev,
> -	unsigned long id)
> +static inline struct mtk_reset *to_rst_data(struct reset_controller_dev *rcdev)

to_mtk_reset() looks more consistent, as many developers are using the naming
"to_{struct_name}".

Also, can you please mention the indentation fixes in the commit description?

Thanks,
Angelo

