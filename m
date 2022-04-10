Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630554FAE9E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240387AbiDJQEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiDJQEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:04:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953333E5FD;
        Sun, 10 Apr 2022 09:02:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3411B6101A;
        Sun, 10 Apr 2022 16:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94196C385A1;
        Sun, 10 Apr 2022 16:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649606550;
        bh=ORLJNza4SE62fPcQwRQSQjgERx3YSV2NXwZ/2l/Uslk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HgYoxI/5TMxmmw9UYpzjztnb2c20x6Ipz2ubxL4RCqJKc+BdrMdZhRRD/uAEB3T2Q
         /SDO0sgXVXpJi0+6hr98diLIKjHHCpy8waVBibdWn+I4JwiAicd7aV9LJ3deko2BhH
         pSwHxsfGydIf18o4gQcbysr5MLKK5QIixC61/INkMBJgYmdTSOouXTs8EE7HwKSAdS
         gnsO/+XIJtbkre3TDw/j8URETt5yEMD4bKyiPrDUYAJ3v6ciIydQ+Ig8jyFfmYj1Ga
         lByPUMdGUFRe98aR+ksQBs4ty0Q5HGkZA7vGvWo1ZF7MNWNfV2/wT/FFTWVapApYtV
         7RbZq9VzH1pag==
Date:   Sun, 10 Apr 2022 17:10:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/7] iio: adc: sc27xx: fix read big scale voltage not
 right
Message-ID: <20220410171020.4fb2a894@jic23-huawei>
In-Reply-To: <20220407082148.571442-3-gengcixi@gmail.com>
References: <20220407082148.571442-1-gengcixi@gmail.com>
        <20220407082148.571442-3-gengcixi@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Apr 2022 16:21:43 +0800
Cixi Geng <gengcixi@gmail.com> wrote:

> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> Fix wrong configuration value of SC27XX_ADC_SCALE_MASK and
> SC27XX_ADC_SCALE_SHIFT by spec documetation.
> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>
Fixes tag?
No need to resend for this though, just reply with the appropriate
tag so when I use b4 it'll be picked up.

Thanks,

Jonathan

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
>  
>  /* Bits definitions for SC27XX_ADC_INT_EN registers */
>  #define SC27XX_ADC_IRQ_EN		BIT(0)

