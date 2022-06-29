Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3239560409
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbiF2PH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiF2PHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:07:06 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682CA13CD3;
        Wed, 29 Jun 2022 08:07:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t24so28606620lfr.4;
        Wed, 29 Jun 2022 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=X7kFcchBkGtAozFYIhhWmH8j7mV7PoFuQksuWlZQBWs=;
        b=gcwdUlo7pR4Sdwvta8DpwPhDTEdgdaHa8EIn+saMIbSh2ycCmiO4WbTKo8jAB6Q6Gt
         /EcSq94IabAAkXEwOvtejBNkzOqrIodwB3GpZM3GjiPB4Kwdp3tmAgtuIR0WshPMaF8V
         2xotB2F9WWW+vKWvWzM9LWhudb/mzd5g0uhxIny89oUHRo4bN2tVuaxa6/EYmUXYqbzy
         6UYD7AmDbGe7CtfNAjQ5WbV9JsWM9GZEbgP5zAV/mw2JCFMTwYv7FCaDLZImLueFNQII
         r1+b9amQOxIA92SaVB1SRIojEQy+iVbuItTTClFgrOQ6Hfi6AddMKkPzkS3897xJeLiy
         tcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=X7kFcchBkGtAozFYIhhWmH8j7mV7PoFuQksuWlZQBWs=;
        b=b4q9YWE0IEQK2FrdVCS+JC/ueQfKSlN9x1rBQ7ymkWYCTyOmYqa3qB9Si4j3IUhSws
         +6mnkfDXnfoeTjIjqFE3YY/w46m5AEuQOQzCyvyjHgCVF+mzkT1FkvBFtQB+KU9wiShq
         seciTlLlGKcq3gHFcCDG5xmYsNUQqBSuJxlg/sqQMS+rDgUv/sbya/fe+BzsUpEPbky8
         5C4Vrina8lGKvzBABpAnZu5f9mvRhbAfm90Nr4HXNkoXPIyW1/46Q931mkhoc/BqDbo1
         84foWMVKap7QOssVrseKVFdZKXL+DwFAcCNEz1Yd7SpIWu63aAXLZeXpEQU//nv8dAmI
         ba+A==
X-Gm-Message-State: AJIora+DiQwt8vdh+VIdV8OdoXtHHa7bgc5REEH+1ehjAK2op3zr4DDO
        7XDlQ0FNInBbjiy/luLccjMJLxLxCaj1rQ==
X-Google-Smtp-Source: AGRyM1vHzF2/5EFz2vUjTUeqp2yrAeLOohVUMI38ZRSxGCEjLojVPTa1SuYM5A260UPY40fcLooq1Q==
X-Received: by 2002:ac2:4e4e:0:b0:47f:b3c0:2f3d with SMTP id f14-20020ac24e4e000000b0047fb3c02f3dmr2363445lfr.15.1656515222156;
        Wed, 29 Jun 2022 08:07:02 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id d22-20020a2e3316000000b0025907141aa6sm2172108ljc.83.2022.06.29.08.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 08:07:01 -0700 (PDT)
Date:   Wed, 29 Jun 2022 18:06:59 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 1/8] reset: Fix devm bulk optional exclusive
 control getter
Message-ID: <20220629150659.4mutbylylukmoduq@mobilestation>
References: <20220624141853.7417-1-Sergey.Semin@baikalelectronics.ru>
 <20220624141853.7417-2-Sergey.Semin@baikalelectronics.ru>
 <c6794e78b9425c84f090d3058b93319bbb17e10f.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6794e78b9425c84f090d3058b93319bbb17e10f.camel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 04:02:43PM +0200, Philipp Zabel wrote:
> Hi Serge,
> 
> On Fr, 2022-06-24 at 17:18 +0300, Serge Semin wrote:
> > Most likely due to copy-paste mistake the device managed version of the
> > denoted reset control getter has been implemented with invalid semantic,
> > which can be immediately spotted by having "WARN_ON(shared && acquired)"
> > warning in the system log as soon as the method is called. Anyway let's
> > fix it by altering the boolean arguments passed to the
> > __devm_reset_control_bulk_get() method from
> > - shared = true, optional = false, acquired = true
> > to
> > + shared = false, optional = true, acquired = true
> > That's what they were supposed to be in the first place (see the non-devm
> > version of the same method: reset_control_bulk_get_optional_exclusive()).
> > 
> > Fixes: 48d71395896d ("reset: Add reset_control_bulk API")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v4:
> > - This is a new patch added on v4 lap of the series.
> > ---
> >  include/linux/reset.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/reset.h b/include/linux/reset.h
> > index 8a21b5756c3e..514ddf003efc 100644
> > --- a/include/linux/reset.h
> > +++ b/include/linux/reset.h
> > @@ -731,7 +731,7 @@ static inline int __must_check
> >  devm_reset_control_bulk_get_optional_exclusive(struct device *dev, int num_rstcs,
> >  					       struct reset_control_bulk_data *rstcs)
> >  {
> > -	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, true, false, true);
> > +	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, false, true, true);
> >  }
> 

> You are right, thank you. I'll take this as a sign that the internal
> functions should probably switch from collecting ever more boolean
> arguments to a flags parameter, similar to enum gpiod_flags.
> 
> I'll pick this up separately into the reset/fixes branch.

Ok. Thanks. Meanwhile could you please take a look at the rest of the
reset-related patches of the series? They concern the reset-control
functionality updates of the Baikal-T1 CCU common-clock driver.

[PATCH RESEND v5 6/8] clk: baikal-t1: Move reset-controls code into a dedicated module
Link: https://lore.kernel.org/linux-clk/20220624141853.7417-7-Sergey.Semin@baikalelectronics.ru/
[PATCH RESEND v5 7/8] clk: baikal-t1: Add DDR/PCIe directly controlled resets support
Link: https://lore.kernel.org/linux-clk/20220624141853.7417-8-Sergey.Semin@baikalelectronics.ru/

The functionality has been placed in the clocks subsystem because the
reset-control is tightly coupled with the clock-control part of CCU.
It's a normal approach for the SoC CCU/RCU devices, which normally
have both clocks and reset controls intermixed. Anyway the main goal
of the series was to add the directly controlled resets of the
DDR and PCIe SoC sub-domains provided in the framework of the patch
7/8. Please see the patches log for details.

-Sergey

> 
> regards
> Philipp
