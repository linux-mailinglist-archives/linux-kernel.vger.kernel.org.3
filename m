Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD15B52EE8B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349159AbiETO4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350525AbiETO4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:56:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F0115814;
        Fri, 20 May 2022 07:55:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id AACB51F46542
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653058557;
        bh=jxX878QWawgfvMOXk/YfULJcGJes7LLWJjg8hH9kCTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qp+eGoXC12xS0US+up3AlAeSEDKDGEXAPjch3KWyCwzTClULych8zz0ibHqnTODRR
         G4rG2kxigej4l/KJ0XIgq5nph59Dym7LEXSDLoqZ7WdA9BJL2jAdofZS+0UiB7P7GK
         UQ8hg2zb7DWeq0g/pElSQw1ktp2ekGitloZsfJ0Xzznf7LsGa9zimN5TcwVFR/C7ib
         TI9pOyWzqApc7fhRwNSI815uGNqXDLnXsWajfm93QhDnkksdfKGXkAQtKmGdQ5cvWg
         w8tB+P+d2GF10vgVOHyflekvmgd9D60EqKj1xMxVE7lQjZMcr0rZwYZSJbmUicXt0W
         T5nUb3G2ru02w==
Date:   Fri, 20 May 2022 10:55:51 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v7 04/19] clk: mediatek: reset: Extract common drivers to
 update function
Message-ID: <20220520145551.b2sqheaizkegna3n@notapiano>
References: <20220519125527.18544-1-rex-bc.chen@mediatek.com>
 <20220519125527.18544-5-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220519125527.18544-5-rex-bc.chen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 08:55:12PM +0800, Rex-BC Chen wrote:
> To make drivers more clear and readable, we extract common code
> within assert and deassert to mtk_reset_update_set_clr() and
> mtk_reset_update().
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/reset.c | 38 +++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
> index 5cbbcc22a4fc..22fa9f09752c 100644
> --- a/drivers/clk/mediatek/reset.c
> +++ b/drivers/clk/mediatek/reset.c
> @@ -12,24 +12,27 @@
>  
>  #include "reset.h"
>  
> -static int mtk_reset_assert(struct reset_controller_dev *rcdev,
> -			    unsigned long id)
> +static int mtk_reset_update(struct reset_controller_dev *rcdev,
> +			    unsigned long id, bool deassert)

I'd have called the bool 'assert', and then passed true on assert and false on
deassert, as I think that's slightly more intuitive, but that's just personal
preference. It's fine like this as well.

Thanks,
Nícolas

>  {
>  	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
> +	unsigned int val = deassert ? 0 : ~0;
>  
>  	return regmap_update_bits(data->regmap,
>  				  data->regofs + ((id / 32) << 2),
> -				  BIT(id % 32), ~0);
> +				  BIT(id % 32), val);
> +}
> +
> +static int mtk_reset_assert(struct reset_controller_dev *rcdev,
> +			    unsigned long id)
> +{
> +	return mtk_reset_update(rcdev, id, false);
>  }
>  
>  static int mtk_reset_deassert(struct reset_controller_dev *rcdev,
>  			      unsigned long id)
>  {
> -	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
> -
> -	return regmap_update_bits(data->regmap,
> -				  data->regofs + ((id / 32) << 2),
> -				  BIT(id % 32), 0);
> +	return mtk_reset_update(rcdev, id, true);
>  }
>  
>  static int mtk_reset(struct reset_controller_dev *rcdev, unsigned long id)
> @@ -43,24 +46,27 @@ static int mtk_reset(struct reset_controller_dev *rcdev, unsigned long id)
>  	return mtk_reset_deassert(rcdev, id);
>  }
>  
> -static int mtk_reset_assert_set_clr(struct reset_controller_dev *rcdev,
> -				    unsigned long id)
> +static int mtk_reset_update_set_clr(struct reset_controller_dev *rcdev,
> +				    unsigned long id, bool deassert)
>  {
>  	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
> +	unsigned int deassert_ofs = deassert ? 0x4 : 0;
>  
>  	return regmap_write(data->regmap,
> -			    data->regofs + ((id / 32) << 4),
> +			    data->regofs + ((id / 32) << 4) + deassert_ofs,
>  			    BIT(id % 32));
>  }
>  
> +static int mtk_reset_assert_set_clr(struct reset_controller_dev *rcdev,
> +				    unsigned long id)
> +{
> +	return mtk_reset_update_set_clr(rcdev, id, false);
> +}
> +
>  static int mtk_reset_deassert_set_clr(struct reset_controller_dev *rcdev,
>  				      unsigned long id)
>  {
> -	struct mtk_reset *data = container_of(rcdev, struct mtk_reset, rcdev);
> -
> -	return regmap_write(data->regmap,
> -			    data->regofs + ((id / 32) << 4) + 0x4,
> -			    BIT(id % 32));
> +	return mtk_reset_update_set_clr(rcdev, id, true);
>  }
>  
>  static int mtk_reset_set_clr(struct reset_controller_dev *rcdev,
> -- 
> 2.18.0
> 
> 
