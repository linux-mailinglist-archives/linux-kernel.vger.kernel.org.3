Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFC14B535A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbiBNOa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:30:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbiBNOaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:30:24 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C265488AF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:30:16 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id q198-20020a1ca7cf000000b0037bb52545c6so11769861wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Qp0QN+QEErhlcS3GAx4mKpRDEEq8dEC8vvszvRmZuYs=;
        b=jnKm8XvoIMBGarRRZ4hzi45VYlJ478uh2abfv7JlrxZ1M6wFaz7itAVx1xJ+BlMqib
         qQC2TtbcHoCafKsj1jBoxHNnFdumz5p4amZKrLHYNs27PWfMjMD8Ph1ny/ijfkT4OvRA
         Dk4e8CWS4ZpazAVpRJ+lMkq0Nn5+eqlZO3727SvncCzFtaQLYabnojLtYInIQU3XUqQG
         52nE4W9F96sTI4su2+/eezi4lU4zd14RzEnrT0jhtBLMcq+sHJ44P+0CY+2Zrn7QFZsy
         vUQVpCj1Jeg05S/pRLKh1oWTW7UOVmcYCYg9/xHreAEbGWp9skhlxzIae/CfhcasUpNE
         jXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Qp0QN+QEErhlcS3GAx4mKpRDEEq8dEC8vvszvRmZuYs=;
        b=yqlXS29Or8j5AHV8VX8aBigRugJu7G9l1WckzjYBZUeYvxhFNwg0e1mgGatVXmmCWm
         j9jlVJs+uW2uUJXOBVaKcUQR7Q5rz5grAW97MrdbfOERRqqUd9mfHUyEpJKLVA/JYqbJ
         nW6hTQyoegDNNNDWkB5W+Rcr03BeeVWP8DEza7X1EedzcvJWvEv4dyajVMSk36w8Il01
         Zt6oE4V6zhLAS1BmRqM+8HOO1BrWChhaaKbkg6isZ9g343EzmdEDjxvt5hVagyABMUEG
         R4dTCvg4Ow4i3QSzgqZdm3fGgXool8RZwKzCQbOB5msGG68gu+uCjuX4Dovct5hd187R
         Qt+g==
X-Gm-Message-State: AOAM5330uqaKRBbnsuVSblJGk3FIs2S9A3NsjD1fBbOANdNrZhiYYRZ6
        zZhG98Dp5c1+qRhUf066UOB2yVtNacg1eA==
X-Google-Smtp-Source: ABdhPJxLQcXVZpjbmecg6yZuPlyk5ci26cfg2TtBYKtnC5XZytL2DW2wV5Ub0p6x+25l9jdRm5vzHA==
X-Received: by 2002:a7b:cdfa:: with SMTP id p26mr11414512wmj.109.1644849015011;
        Mon, 14 Feb 2022 06:30:15 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id t16sm2741411wmq.43.2022.02.14.06.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 06:30:14 -0800 (PST)
Date:   Mon, 14 Feb 2022 14:30:12 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mfd: stmfx: Improve error message triggered by regulator
 fault in .remove()
Message-ID: <YgpndOadzi0+5jQr@google.com>
References: <20220207081709.27288-1-u.kleine-koenig@pengutronix.de>
 <YgpdPTDurgsvR9mk@google.com>
 <20220214140639.jmdldyne6ffq4dlq@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220214140639.jmdldyne6ffq4dlq@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022, Uwe Kleine-König wrote:

> On Mon, Feb 14, 2022 at 01:46:37PM +0000, Lee Jones wrote:
> > On Mon, 07 Feb 2022, Uwe Kleine-König wrote:
> > 
> > > Returning a non-zero value in an i2c remove callback results in the i2c
> > > core emitting a very generic error message ("remove failed (-ESOMETHING),
> > > will be ignored") and as the message indicates not further error handling
> > > is done.
> > > 
> > > Instead emit a more specific error message and then return zero in
> > > .remove().
> > > 
> > > The long-term goal is to make the i2c remove prototype return void, making
> > > all implementations return 0 is preparatory work for this change.
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/mfd/stmfx.c | 16 +++++++++++-----
> > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
> > > index e095a3930142..16631c675f2f 100644
> > > --- a/drivers/mfd/stmfx.c
> > > +++ b/drivers/mfd/stmfx.c
> > > @@ -392,17 +392,21 @@ static int stmfx_chip_init(struct i2c_client *client)
> > >  	return ret;
> > >  }
> > >  
> > > -static int stmfx_chip_exit(struct i2c_client *client)
> > > +static void stmfx_chip_exit(struct i2c_client *client)
> > >  {
> > >  	struct stmfx *stmfx = i2c_get_clientdata(client);
> > >  
> > >  	regmap_write(stmfx->map, STMFX_REG_IRQ_SRC_EN, 0);
> > >  	regmap_write(stmfx->map, STMFX_REG_SYS_CTRL, 0);
> > >  
> > > -	if (stmfx->vdd)
> > > -		return regulator_disable(stmfx->vdd);
> > > +	if (stmfx->vdd) {
> > > +		int ret = regulator_disable(stmfx->vdd);
> > >  
> > > -	return 0;
> > > +		if (ret)
> > 
> > Nit: Premise of the patch is fine, but please can you use the standard
> > function call, check the return value format please.  Something about
> > this is triggering my OCD! :)
> > 
> >      	int ret;
> > 
> > 	ret = regulator_disable(stmfx->vdd);
> > 	if (ret)
> > 		do_thing();
> 
> Not sure I understand you correctly. Do you want just:
> 
>  	regmap_write(stmfx->map, STMFX_REG_SYS_CTRL, 0);
>  
>  	if (stmfx->vdd) {
> -		int ret = regulator_disable(stmfx->vdd);
> +		int ret;
> +
> +		ret = regulator_disable(stmfx->vdd);
>  		if (ret)
>  ...
> 
> squashed into the patch?

Effectively, yes please.

The diff would look like:

> > > -	if (stmfx->vdd)
> > > -		return regulator_disable(stmfx->vdd);
> > > +	if (stmfx->vdd) {
> > > +		int ret;
> > > +
> > > +		ret = regulator_disable(stmfx->vdd);
> > > -
> > > -	return 0;
> > > +		if (ret)

Thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
