Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF86F5776E1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 17:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiGQPEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 11:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiGQPEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 11:04:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A9E1055B;
        Sun, 17 Jul 2022 08:04:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1F03B80E18;
        Sun, 17 Jul 2022 15:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD50BC3411E;
        Sun, 17 Jul 2022 15:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658070259;
        bh=BxuIeHHjKT+QK1LwDy/gj0wFfMVCa2LuSM5eUhYt+GE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=atuzkpNQ/XRR++UOciAGLH7C+M5MiCZItNh8JcRbFDT6uLbRu066f8shCDVt2KZTV
         G5DCwuB8InttFqL/9TyF8QNB40msPAP2el9nyJK26GP9POLfg1ASz65XT1u4zBrWYV
         051P93Gx6sW52t/uwXdNCm5c8H0A24sGe7I2LiAhC4ldoWjAyMmPt7NOfCUaeaECg/
         xE3nLpwOchcdiEBfCRdWwEWkhWXsDuBZ/SPDZWMweMHq/QBHBs35GwqXyk0wlCn870
         sfBeHjs0NVl9rPw4M415qsy59BgtcQMGhBUtqNeKjzZy+9TlG3purKiB49JVGf2P2b
         FftupYWp2WEJg==
Date:   Sun, 17 Jul 2022 16:14:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <j.neuschaefer@gmx.net>,
        <zhengbin13@huawei.com>, <openbmc@lists.ozlabs.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: npcm: Add NPCM8XX support
Message-ID: <20220717161412.69b2743e@jic23-huawei>
In-Reply-To: <20220713172132.0bc5002d@jic23-huawei>
References: <20220713132640.215916-1-tmaimon77@gmail.com>
        <20220713132640.215916-3-tmaimon77@gmail.com>
        <20220713172132.0bc5002d@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 17:21:32 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 13 Jul 2022 16:26:40 +0300
> Tomer Maimon <tmaimon77@gmail.com> wrote:
> 
> > Adding ADC NPCM8XX support to NPCM ADC driver.
> > ADC NPCM8XX uses a different resolution and voltage reference.
> > 
> > As part of adding NPCM8XX support:
> > - Add NPCM8XX specific compatible string.
> > - Add data to handle architecture-specific ADC parameters.
> > 
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>  
> missing 
> 
> #include <linux/property.h> 
> 
> So in current IIO togreg tree this doesn't build.  I could fix it up
> but given we are very late in cycle and I'd like to give this a little
> more time on list for Andy to take another look if he wishes, chances
> are this won't make it in until early next cycle.
> 
Applied to the togreg branch of iio.git and pushed out as testing for
now only as I'll be rebaseing on rc1 once available.

Thanks,

Jonathan

> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/adc/npcm_adc.c | 35 ++++++++++++++++++++++++++++-------
> >  1 file changed, 28 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
> > index f7bc0bb7f112..4c7ebcd57b88 100644
> > --- a/drivers/iio/adc/npcm_adc.c
> > +++ b/drivers/iio/adc/npcm_adc.c
> > @@ -16,6 +16,12 @@
> >  #include <linux/uaccess.h>
> >  #include <linux/reset.h>
> >  
> > +struct npcm_adc_info {
> > +	u32 data_mask;
> > +	u32 internal_vref;
> > +	u32 res_bits;
> > +};
> > +
> >  struct npcm_adc {
> >  	bool int_status;
> >  	u32 adc_sample_hz;
> > @@ -34,6 +40,7 @@ struct npcm_adc {
> >  	 * has finished.
> >  	 */
> >  	struct mutex lock;
> > +	const struct npcm_adc_info *data;
> >  };
> >  
> >  /* ADC registers */
> > @@ -52,13 +59,21 @@ struct npcm_adc {
> >  #define NPCM_ADCCON_CH(x)		((x) << 24)
> >  #define NPCM_ADCCON_DIV_SHIFT		1
> >  #define NPCM_ADCCON_DIV_MASK		GENMASK(8, 1)
> > -#define NPCM_ADC_DATA_MASK(x)		((x) & GENMASK(9, 0))
> >  
> >  #define NPCM_ADC_ENABLE		(NPCM_ADCCON_ADC_EN | NPCM_ADCCON_ADC_INT_EN)
> >  
> >  /* ADC General Definition */
> > -#define NPCM_RESOLUTION_BITS		10
> > -#define NPCM_INT_VREF_MV		2000
> > +static const struct npcm_adc_info npxm7xx_adc_info = {
> > +	.data_mask = GENMASK(9, 0),
> > +	.internal_vref = 2048,
> > +	.res_bits = 10,
> > +};
> > +
> > +static const struct npcm_adc_info npxm8xx_adc_info = {
> > +	.data_mask = GENMASK(11, 0),
> > +	.internal_vref = 1229,
> > +	.res_bits = 12,
> > +};
> >  
> >  #define NPCM_ADC_CHAN(ch) {					\
> >  	.type = IIO_VOLTAGE,					\
> > @@ -129,7 +144,8 @@ static int npcm_adc_read(struct npcm_adc *info, int *val, u8 channel)
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	*val = NPCM_ADC_DATA_MASK(ioread32(info->regs + NPCM_ADCDATA));
> > +	*val = ioread32(info->regs + NPCM_ADCDATA);
> > +	*val &= info->data->data_mask;
> >  
> >  	return 0;
> >  }
> > @@ -157,9 +173,9 @@ static int npcm_adc_read_raw(struct iio_dev *indio_dev,
> >  			vref_uv = regulator_get_voltage(info->vref);
> >  			*val = vref_uv / 1000;
> >  		} else {
> > -			*val = NPCM_INT_VREF_MV;
> > +			*val = info->data->internal_vref;
> >  		}
> > -		*val2 = NPCM_RESOLUTION_BITS;
> > +		*val2 = info->data->res_bits;
> >  		return IIO_VAL_FRACTIONAL_LOG2;
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> >  		*val = info->adc_sample_hz;
> > @@ -176,7 +192,8 @@ static const struct iio_info npcm_adc_iio_info = {
> >  };
> >  
> >  static const struct of_device_id npcm_adc_match[] = {
> > -	{ .compatible = "nuvoton,npcm750-adc", },
> > +	{ .compatible = "nuvoton,npcm750-adc", .data = &npxm7xx_adc_info},
> > +	{ .compatible = "nuvoton,npcm845-adc", .data = &npxm8xx_adc_info},
> >  	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, npcm_adc_match);
> > @@ -196,6 +213,10 @@ static int npcm_adc_probe(struct platform_device *pdev)
> >  		return -ENOMEM;
> >  	info = iio_priv(indio_dev);
> >  
> > +	info->data = device_get_match_data(dev);
> > +	if (!info->data)
> > +		return -EINVAL;
> > +
> >  	mutex_init(&info->lock);
> >  
> >  	info->dev = &pdev->dev;  
> 

