Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E5755FB8D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiF2JPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiF2JPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:15:19 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDE329819
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:15:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id pk21so31318635ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L7wjVzwYiQNNDss7ZeyhgJmoh/+dTEb2fLiC8HBD/kk=;
        b=bt1EKqzTrBt5h8uv3/tx1sCxbmzEk6oLQ3N+mybSM2M5wIY8sV+dJdem2fNUDAl6bX
         9hUoGAaWDyNgrQyjCNTjMvNhLXjRzPTJ13QO2L9UB9tWN3kMqJY6Okc2EwPM8kxeoM47
         oKknoyLf5gF7OzH8/0dPuGMt+YcBOYKEnYwCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L7wjVzwYiQNNDss7ZeyhgJmoh/+dTEb2fLiC8HBD/kk=;
        b=5JOkBpi+PV1LootwKLUVXlnb1H16LVGa1WMveDwbv6gBu8Big5qkIotfU+krGZbYsg
         2pEl1MwH9Mq6RXeusPBjSVhVgHO6rROWpeRqSFaRPq86irqhNqOBRbIxtYeY4+1JVQvw
         iwqyJg1f6e0UhsJECnTDSdPcKYPgxhP+ytVHKXf4aCGnLm8LOocj3TfZVCWAo3JNGDLb
         PTd6oHU4fP9ND1//xnNdQf0V2AGnES8NQBYeAVX3DwOErUE8lS72N4mK724OIiP7N6ha
         ernQ6BFkpL/yzt6uC0IT7bXUn31Ckg6GArkJq+DNSP4ZgBuzAjrvqBAP/qYUCn13Ip90
         HkPw==
X-Gm-Message-State: AJIora9Qj6gxiJCF1NHvhEJEHJSEBQbkgHXS73UdTHzTsGEelsLWNJgL
        HCZdTlqD7Ar+QB6LPvI2sgluGw==
X-Google-Smtp-Source: AGRyM1tke9XKBdzZQLV5gX3xfKF5wJ/OjBVDZjKsRrNDkB5m8P24fXXPItsPsDZxmwic52HeVrjdMQ==
X-Received: by 2002:a17:906:2bda:b0:726:3b59:3ea9 with SMTP id n26-20020a1709062bda00b007263b593ea9mr2217117ejg.43.1656494116450;
        Wed, 29 Jun 2022 02:15:16 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id r1-20020aa7cb81000000b004357b717a96sm10977159edt.85.2022.06.29.02.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 02:15:16 -0700 (PDT)
Date:   Wed, 29 Jun 2022 11:15:14 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Daniel Scally <djrscally@gmail.com>, linuxfancy@googlegroups.com,
        linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] media: ov5693: move hw cfg functions into
 ov5693_check_hwcfg
Message-ID: <20220629091514.GB381128@tom-ThinkPad-T14s-Gen-2i>
References: <20220627150453.220292-1-tommaso.merciai@amarulasolutions.com>
 <20220627150453.220292-5-tommaso.merciai@amarulasolutions.com>
 <20220629081635.zvdj6pzodg4rhrdf@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629081635.zvdj6pzodg4rhrdf@uno.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Wed, Jun 29, 2022 at 10:16:35AM +0200, Jacopo Mondi wrote:
> Hi Tommaso,
> 
> On Mon, Jun 27, 2022 at 05:04:50PM +0200, Tommaso Merciai wrote:
> > Move hw configuration functions into ov5693_check_hwcfg. This is done to
> > separe the code that handle the hw cfg from probe in a clean way
> 
> s/separe/separate/
> 
> You also seem to change the logic of the clk handling, please mention
> this in the commit message, otherwise one could be fooled into
> thinking you're only moving code around with no functional changes...

Right. I'll add some comments on support to get clock-frequency using
fwnode_property_read_u32 in v3

> 
> >
> > Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> > ---
> >  drivers/media/i2c/ov5693.c | 53 +++++++++++++++++++++++---------------
> >  1 file changed, 32 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
> > index d2adc5513a21..d5a934ace597 100644
> > --- a/drivers/media/i2c/ov5693.c
> > +++ b/drivers/media/i2c/ov5693.c
> > @@ -1348,6 +1348,38 @@ static int ov5693_check_hwcfg(struct ov5693_device *ov5693)
> >  	struct fwnode_handle *endpoint;
> >  	unsigned int i;
> >  	int ret;
> > +	u32 xvclk_rate;
> 
> nit: move it up to maintain reverse-xmas-tree order (I know, it's an
> annoying comment, but since variables are already declared in this order..)

No problem :)
I'll do it in v3.

> 
> > +
> > +	ov5693->xvclk = devm_clk_get(ov5693->dev, "xvclk");
> 
> Isn't this broken ?
> 
> if you use ov5693->xvclk to identify the ACPI vs OF use case shouldn't
> you use the get_optionl() version ? Otherwise in the ACPI case you will have
> -ENOENT if there's not 'xvclk' property and bail out.

You are right, devm_clk_get_optional is the correct way.

Thanks,
Tommaso

> 
> Unless my understanding is wrong on ACPI we have "clock-frequency" and
> on OF "xvclk" with an "assigned-clock-rates",
> 
> Dan you upstreamed this driver and I assume it was tested on ACPI ?
> Can you clarify how this worked for you, as it seems the original code
> wanted a mandatory "xvclk" ? Are there ACPI tables with an actual
> 'xvclk' property ?
> 
> > +	if (IS_ERR(ov5693->xvclk))
> > +		return dev_err_probe(ov5693->dev, PTR_ERR(ov5693->xvclk),
> > +				     "failed to get xvclk: %ld\n",
> > +				     PTR_ERR(ov5693->xvclk));
> > +
> > +	if (ov5693->xvclk) {
> > +		xvclk_rate = clk_get_rate(ov5693->xvclk);
> > +	} else {
> > +		ret = fwnode_property_read_u32(fwnode, "clock-frequency",
> > +					       &xvclk_rate);
> > +
> > +		if (ret) {
> > +			dev_err(ov5693->dev, "can't get clock frequency");
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	if (xvclk_rate != OV5693_XVCLK_FREQ)
> > +		dev_warn(ov5693->dev, "Found clk freq %u, expected %u\n",
> > +			 xvclk_rate, OV5693_XVCLK_FREQ);
> > +
> > +	ret = ov5693_configure_gpios(ov5693);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ov5693_get_regulators(ov5693);
> > +	if (ret)
> > +		return dev_err_probe(ov5693->dev, ret,
> > +				     "Error fetching regulators\n");
> >
> >  	endpoint = fwnode_graph_get_next_endpoint(fwnode, NULL);
> >  	if (!endpoint)
> > @@ -1390,7 +1422,6 @@ static int ov5693_check_hwcfg(struct ov5693_device *ov5693)
> >  static int ov5693_probe(struct i2c_client *client)
> >  {
> >  	struct ov5693_device *ov5693;
> > -	u32 xvclk_rate;
> >  	int ret = 0;
> >
> >  	ov5693 = devm_kzalloc(&client->dev, sizeof(*ov5693), GFP_KERNEL);
> > @@ -1408,26 +1439,6 @@ static int ov5693_probe(struct i2c_client *client)
> >
> >  	v4l2_i2c_subdev_init(&ov5693->sd, client, &ov5693_ops);
> >
> > -	ov5693->xvclk = devm_clk_get(&client->dev, "xvclk");
> > -	if (IS_ERR(ov5693->xvclk)) {
> > -		dev_err(&client->dev, "Error getting clock\n");
> > -		return PTR_ERR(ov5693->xvclk);
> > -	}
> > -
> > -	xvclk_rate = clk_get_rate(ov5693->xvclk);
> > -	if (xvclk_rate != OV5693_XVCLK_FREQ)
> > -		dev_warn(&client->dev, "Found clk freq %u, expected %u\n",
> > -			 xvclk_rate, OV5693_XVCLK_FREQ);
> > -
> > -	ret = ov5693_configure_gpios(ov5693);
> > -	if (ret)
> > -		return ret;
> > -
> > -	ret = ov5693_get_regulators(ov5693);
> > -	if (ret)
> > -		return dev_err_probe(&client->dev, ret,
> > -				     "Error fetching regulators\n");
> > -
> >  	ov5693->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
> >  	ov5693->pad.flags = MEDIA_PAD_FL_SOURCE;
> >  	ov5693->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
> > --
> > 2.25.1
> >

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
