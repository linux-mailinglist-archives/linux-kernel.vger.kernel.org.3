Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D878D4B191A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345453AbiBJXKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:10:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbiBJXKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:10:15 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740EDE31;
        Thu, 10 Feb 2022 15:10:15 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b13so13745745edn.0;
        Thu, 10 Feb 2022 15:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4zd+d9NdEXjmSBG6eKyyZ32RF9eXdrBZvgQdiNkAdR4=;
        b=JerGdJDRLq42TNluoDiDdyNEa5OPpLv5oClSPNriUX77iN4SVSpFrrCj8awES3byVZ
         2hEJabfnFYY7ptl7M0jjxrmxJscJjkMV15GrCx0y8xw5KrBZ+vq80gW4uVItK2r3WlxK
         X5jbpvzf31Xsq6M9tQ/KjGinbM0jA+y/SzxuDAdbSrrUb47JQP5TDiIKR10idscms+Fq
         DNUrbm6iPhhQ/eIEktGPAv2iSPib/cmjz/ouIiOxUdWavH2Bzw5Yg0EMLS76DpofHavh
         zCYmP8sgju1C0daSBk7jIl8mZINhLQlBSKmqjaPQixwVMlq9JlivNQ6QPCIGpBsj/b7R
         E9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4zd+d9NdEXjmSBG6eKyyZ32RF9eXdrBZvgQdiNkAdR4=;
        b=7an6M1ozyB8FHSH8kHBqJnCz6A/N42eTizictQkWhW6tO62xu/jlyOcdg1eJLA5RJg
         8FnhVKDq//ipk8YW400HypI3WZuJl1mN0ULuaoLKAvyN+jHkZynVaxx02TzKkmK7pYlf
         qepfAUbgW5YJitostbAj/TwouQcG6cdUDrmeGREMaf3CJBbGnke6SovQkx0BJT6997Ku
         jPZywYUK4deyFqU2f97ft6LMggcHZSXw3FiQUUaX9XZcJMug4Qx2HTUba8WICtEYLVHI
         D6StjQ5G/dxuDoIwgKvFr6hzNKk8U8WZ4tW3CPLPiPCBByDMUNYyUjY9ln24ugAdtOnq
         eWVg==
X-Gm-Message-State: AOAM530INHaqL+eKWrjXSN2ymtGSX9OPnC7ihQ25abEUxvl+ZyOXfErV
        TmIQsUHXyqAtfoP7MY08N3M=
X-Google-Smtp-Source: ABdhPJzX7WEZ/93GNx4TcH64x4mdLF678GL6+j9Mynk3mAi5IzBr1N/UwQtqQ7WyHJfKSEpndcM+Pw==
X-Received: by 2002:a05:6402:440a:: with SMTP id y10mr10569403eda.215.1644534614032;
        Thu, 10 Feb 2022 15:10:14 -0800 (PST)
Received: from localhost (92.40.202.152.threembb.co.uk. [92.40.202.152])
        by smtp.gmail.com with ESMTPSA id h6sm2213164ede.50.2022.02.10.15.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:10:13 -0800 (PST)
Date:   Thu, 10 Feb 2022 23:10:45 +0000
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linus.walleij@linaro.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: ingenic: Fix regmap on X series SoCs
Message-ID: <YgWbdYDiVQyHkHiJ@localhost>
References: <20220209230452.19535-1-aidanmacdonald.0x0@gmail.com>
 <DD537R.K2D13DXGNPGH@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DD537R.K2D13DXGNPGH@crapouillou.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 11:03:13AM +0000, Paul Cercueil wrote:
> Hi Aidan,
> 
> Le mer., févr. 9 2022 at 23:04:54 +0000, Aidan MacDonald 
> <aidanmacdonald.0x0@gmail.com> a écrit :
> > The X series Ingenic SoCs have a shadow GPIO group which
> > is at a higher offset than the other groups, and is used
> > for all GPIO configuration. The regmap did not take this
> > offset into account and set max_register too low. Writes
> > to the shadow group registers were blocked, which made it
> > impossible to change any pin configuration.
> > 
> > Fix this by pretending there are at least 8 chips on any
> > 'X' SoC for the purposes of calculating max_register. This
> > ensures the shadow group is accessible.
> 
> I don't like your solution, it sounds very hacky. I think it would make 
> more sense to use a dedicated x1000_pinctrl_regmap_config that would be 
> used for the X1000 SoC. That would also allow you to express that there 
> are no registers in the 0x400-0x700 range (through 
> regmap_config.wr_table / .rd_table).
> 
> Cheers,
> -Paul
> 

That's fine, I'll put together a v2 patch using the approach you suggest.
I think all the 'X' SoCs will require a similar regmap as they're using
ingenic_gpio_shadow_* functions too, but I'll check their datasheets to
be sure.

> > Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> > ---
> >  drivers/pinctrl/pinctrl-ingenic.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pinctrl/pinctrl-ingenic.c 
> > b/drivers/pinctrl/pinctrl-ingenic.c
> > index 2712f51eb238..9d2bccda50f1 100644
> > --- a/drivers/pinctrl/pinctrl-ingenic.c
> > +++ b/drivers/pinctrl/pinctrl-ingenic.c
> > @@ -4168,7 +4168,10 @@ static int __init ingenic_pinctrl_probe(struct 
> > platform_device *pdev)
> >  		return PTR_ERR(base);
> > 
> >  	regmap_config = ingenic_pinctrl_regmap_config;
> > -	regmap_config.max_register = chip_info->num_chips * 
> > chip_info->reg_offset;
> > +	if (chip_info->version >= ID_X1000)
> > +		regmap_config.max_register = MIN(8, chip_info->num_chips) * 
> > chip_info->reg_offset;
> > +	else
> > +		regmap_config.max_register = chip_info->num_chips * 
> > chip_info->reg_offset;
> > 
> >  	jzpc->map = devm_regmap_init_mmio(dev, base, &regmap_config);
> >  	if (IS_ERR(jzpc->map)) {
> > --
> > 2.34.1
> > 
> 
> 
