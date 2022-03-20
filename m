Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC9D4E1BE2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 14:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245163AbiCTN0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 09:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbiCTN0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 09:26:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE823FDB5;
        Sun, 20 Mar 2022 06:25:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEF3D610A3;
        Sun, 20 Mar 2022 13:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9258AC340F2;
        Sun, 20 Mar 2022 13:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647782707;
        bh=HrB34Tu2zfRgzLPUpdgGO6lDIFScGxCJvI1REvQYs+4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I/Fyb/B+R04dTO+VFmPdHgppdiy1mudWW0VcOBHgH/52uLcW2sVg4fS4y1G3EzN+w
         6kzYb5ENxh4e2aYbzyAgy5ZiX14dFr4BA52lhmSA4CDBcMrKS/zIpxSrZIhgLC6Ggr
         G3+DfXfuD2CzlTF8B7raXVv0ve8hQBDpxAbHGNHMVb/M2YccPKFiwTRs6W8IlKqXnK
         ORfFR2VlykbHGA8MoVjsFdXbunKzUNmpZDNyOnHXtIk9JTvqzHRSE8mEzz+hhNNZyM
         OiJevBrm6roj7JqSfZeOCl4dKKELbSJ7oZprc6a5v4jr5urPTrImQLLp943rk7M00C
         4USHYp2VfpqAw==
Date:   Sun, 20 Mar 2022 13:32:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, yuming.zhu1@unisoc.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/7] iio: adc: sc27xx: fix read big scale voltage not
 right
Message-ID: <20220320133229.6026f51a@jic23-huawei>
In-Reply-To: <20220311164628.378849-3-gengcixi@gmail.com>
References: <20220311164628.378849-1-gengcixi@gmail.com>
        <20220311164628.378849-3-gengcixi@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Mar 2022 00:46:23 +0800
Cixi Geng <gengcixi@gmail.com> wrote:

> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> Fix wrong configuration value of SC27XX_ADC_SCALE_MASK and
> SC27XX_ADC_SCALE_SHIFT by spec documetation.
> 
> Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> 
No blank lines in a tag block (they break people's scripts)
Also, if this is a fix, I'd expect a fixes tag.

> Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  drivers/iio/adc/sc27xx_adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index 00098caf6d9e..aee076c8e2b1 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -36,8 +36,8 @@
>  
>  /* Bits and mask definition for SC27XX_ADC_CH_CFG register */
>  #define SC27XX_ADC_CHN_ID_MASK		GENMASK(4, 0)
> -#define SC27XX_ADC_SCALE_MASK		GENMASK(10, 8)
> -#define SC27XX_ADC_SCALE_SHIFT		8
> +#define SC27XX_ADC_SCALE_MASK		GENMASK(10, 9)
> +#define SC27XX_ADC_SCALE_SHIFT		9

This driver would benefit from use of FIELD_GET() / FIELD_PREP()
but that is obviously unrelated to this particular series.


Jonathan

>  
>  /* Bits definitions for SC27XX_ADC_INT_EN registers */
>  #define SC27XX_ADC_IRQ_EN		BIT(0)

