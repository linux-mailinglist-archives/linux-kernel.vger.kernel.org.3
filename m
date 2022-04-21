Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC12509BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387320AbiDUJKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387302AbiDUJKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:10:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2885F22BF6;
        Thu, 21 Apr 2022 02:07:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 338501F45278
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650532066;
        bh=Ok2xpcEn5emFMgKWShnHgzIgT6cNmeF1Ydap3fmSPDQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RQ2rb4G0p8u/U/mVG9b1DXMed38LBPMOONrHbW2IdK5YXhRY/vdeTQw32yN2O/OK+
         PNPRjKT9Oh1ZMC2NXs33SgcApxZVhCRgTVA67ShZTQpZa7ye4YzUNEr3cUkiEOiW4A
         twkkOCDvW3N5XHPJ1/5fr8PvU+6WX+apqeuwCar+RMe1Fnuxop9zK/K4iNstZanx7O
         nKwKd9C5wt/A08OjVuF+FS1GJi8kbYE2ZsrX04M28ciqfoHD8L9aDRUSP0ELCSmgQt
         Sbl7V09aG4ATVE/iZsimAvMMoUn2znspR3YWHOSA1OLrh0iTdwuIc6ayyD4cUIDP/D
         YIc9Ia7m6KZ5w==
Message-ID: <b9839f51-fef1-c54a-3024-674209987f13@collabora.com>
Date:   Thu, 21 Apr 2022 11:07:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 09/12] clk: mediatek: reset: Add support for input
 offset and bit from DT
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
 <20220420130527.23200-10-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220420130527.23200-10-rex-bc.chen@mediatek.com>
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
> To use the clock reset function easier, we implement the of_xlate.
> This function is only adopted in version MTK_SET_CLR because of
> the method of id calculation.
> 
> There is no impact for original use. If the argument number is not
> larger than 1, it will return original id.
> 
> With this implementation if we want to set offset 0x120 and bit 16,
> we can just write something like "resets = <&infra_rst 0x120 16>;".
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/clk/mediatek/reset.c | 24 ++++++++++++++++++++++++
>   drivers/clk/mediatek/reset.h |  1 +
>   2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
> index 1173111af3ab..dbe812062bf5 100644
> --- a/drivers/clk/mediatek/reset.c
> +++ b/drivers/clk/mediatek/reset.c
> @@ -59,6 +59,20 @@ static const struct reset_control_ops mtk_reset_ops_set_clr = {
>   	.reset = mtk_reset_set_clr,
>   };
>   
> +static int reset_xlate(struct reset_controller_dev *rcdev,
> +		       const struct of_phandle_args *reset_spec)
> +{
> +	unsigned int offset, bit;
> +
> +	if (reset_spec->args_count <= 1)
> +		return reset_spec->args[0];
> +
> +	offset = reset_spec->args[0];
> +	bit = reset_spec->args[1];
> +
> +	return (offset >> 4) * 32 + bit;
> +}
> +
>   static const struct reset_control_ops *rst_op[MTK_RST_MAX] = {
>   	[MTK_RST_SIMPLE] = &reset_simple_ops,
>   	[MTK_RST_SET_CLR] = &mtk_reset_ops_set_clr,
> @@ -98,6 +112,11 @@ int mtk_clk_register_rst_ctrl(struct device_node *np,
>   	data->rcdev.ops = rst_op[desc->version];
>   	data->rcdev.of_node = np;
>   
> +	if (desc->version == MTK_RST_SET_CLR) {

...following my previous advice to use switch(version), this would fit in
just fine :-)

Everything else looks ok.

Cheers,
Angelo
