Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632D04C5AB1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 12:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiB0LnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 06:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiB0LnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 06:43:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB4811142;
        Sun, 27 Feb 2022 03:42:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1578AB80881;
        Sun, 27 Feb 2022 11:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC6BC340E9;
        Sun, 27 Feb 2022 11:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645962162;
        bh=2GZAa88jl8nwc/hfdhteF303XDxGjwubhEYfJOwbaqQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nMMzAIUGv35rsu8OipfLeJFxbKcKWV73XzPuf+i6arMdEuZmI7TKrmNekoDu4Hs44
         377pGHtab86XXGGKsN0QqpbkH+GFOwWrwqpS9jX0JLVWw95AUxOXDBDZRe7QGnBJhE
         t8kj9gNcjnJMu+HKIh43cYkWdcLSkZZe1AKgrO/0A4reL9QFXoGrGoYa91nr6IMPOt
         QNWw9HCaB0TvGIIiz9sV7wy3tK6tFw2knx/KvVgnkA2hA329lpTM5d4ZQ5KD7Kr8es
         IsTjOyRgjZqeHIjlfe0hIxoKhcijSpGAShcrAo97PIrKrJb12oM056MaO9pXqv5s7L
         fIyd5oiXRTLnA==
Date:   Sun, 27 Feb 2022 11:49:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Billy Tsai <billy_tsai@aspeedtech.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrew Jeffery <andrew@aj.id.au>,
        Colin King <colin.king@canonical.com>,
        linux-iio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Klubnichkin <kitsok@yandex-team.ru>
Subject: Re: [PATCH v2] iio: adc: aspeed: Add divider flag to fix incorrect
 voltage reading.
Message-ID: <20220227114944.4706bea1@jic23-huawei>
In-Reply-To: <CACPK8XdsRorJvMjUMNYGAYNLGLzhYJEZSQMTk1ZywwY+SyqDbQ@mail.gmail.com>
References: <20220221012705.22008-1-billy_tsai@aspeedtech.com>
        <CACPK8XdsRorJvMjUMNYGAYNLGLzhYJEZSQMTk1ZywwY+SyqDbQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2022 05:45:16 +0000
Joel Stanley <joel@jms.id.au> wrote:

> On Mon, 21 Feb 2022 at 01:26, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
> >
> > The formula for the ADC sampling period in ast2400/ast2500 is:
> > ADC clock period = PCLK * 2 * (ADC0C[31:17] + 1) * (ADC0C[9:0])
> > When ADC0C[9:0] is set to 0 the sampling voltage will be lower than
> > expected, because the hardware may not have enough time to
> > charge/discharge to a stable voltage. This patch use the flag
> > CLK_DIVIDER_ONE_BASED which will use the raw value read from the
> > register, with the value of zero considered invalid to conform to the
> > corrected formula.  
> 
> (to answer my own question)
> 
> ..and this is okay on the 2600, because we do not set need_prescaler =
> true on that platform.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Applied to the fixes-togreg branch of iio.git.

Depending on how timing works out in the coming week I might just pull
all the fixes in for the next merge window rather than doing a separate
pull request.

Thanks,

Jonathan

> 
> >
> > Fixes: 573803234e72 ("iio: Aspeed ADC")
> > Reported-by: Konstantin Klubnichkin <kitsok@yandex-team.ru>
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > ---
> >  drivers/iio/adc/aspeed_adc.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> > index a957cad1bfab..ffae64f39221 100644
> > --- a/drivers/iio/adc/aspeed_adc.c
> > +++ b/drivers/iio/adc/aspeed_adc.c
> > @@ -539,7 +539,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
> >         data->clk_scaler = devm_clk_hw_register_divider(
> >                 &pdev->dev, clk_name, clk_parent_name, scaler_flags,
> >                 data->base + ASPEED_REG_CLOCK_CONTROL, 0,
> > -               data->model_data->scaler_bit_width, 0, &data->clk_lock);
> > +               data->model_data->scaler_bit_width,
> > +               data->model_data->need_prescaler ? CLK_DIVIDER_ONE_BASED : 0,
> > +               &data->clk_lock);
> >         if (IS_ERR(data->clk_scaler))
> >                 return PTR_ERR(data->clk_scaler);
> >
> > --
> > 2.25.1
> >  

