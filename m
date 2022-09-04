Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57955AC552
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 18:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiIDQLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 12:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiIDQLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 12:11:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3665727CFB;
        Sun,  4 Sep 2022 09:11:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C70F460F97;
        Sun,  4 Sep 2022 16:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C511C433C1;
        Sun,  4 Sep 2022 16:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662307906;
        bh=jEC7BDHEzbus1QSyICot3fVdFcnRPpNPPhhmw+RRi6A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J84kGNaQ40uemrQsVotTmGyqGCtvwPT2F1d6xSxr42ONecG7o2KKE6E5QMl5RXs81
         Q3M65yqa79MIHiBHGWJ8OcgstOwt5H2yaLanvFeMGNVQhQwmLLs3Zqv5mcqo3y7U53
         K2g27CbgCCln9z8kL8ICf17OuhrdnvkiMC+5tAQgi3emwUDOP5tmJuY4gj8FSnMm63
         HqjlxgY+UMRUxCxAtZKJTvpNdJEMs0j3QJ+R1BB1ewiMRHMbI8BS+IasyXSBef+Vyr
         1uSW0oTu/Fh/mf/+DPAyfsjNzfacqlTt0tV28Paj82nVrnlGrX0WTCjCCyP8OLlm52
         zwi2KOeW27zsQ==
Date:   Sun, 4 Sep 2022 16:37:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: add max11205 adc driver
Message-ID: <20220904163738.2bebf51f@jic23-huawei>
In-Reply-To: <BL1PR03MB59923C7F3907FA7A71CBA623807B9@BL1PR03MB5992.namprd03.prod.outlook.com>
References: <20220831133021.215625-1-ramona.bolboaca@analog.com>
        <20220831133021.215625-2-ramona.bolboaca@analog.com>
        <CAHp75Vco8ftAkjVEmKGKKYHS-1mnZzLuPA+N98giqi17mqQnRw@mail.gmail.com>
        <BL1PR03MB59923C7F3907FA7A71CBA623807B9@BL1PR03MB5992.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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


> >   
> > > +       if (!st->chip_info)
> > > +               st->chip_info = (const struct chip_info *)spi_get_device_id(spi)->driver_data;
> > > +
> > > +       indio_dev->name = st->chip_info->name;
> > > +       indio_dev->modes = INDIO_DIRECT_MODE;
> > > +       indio_dev->channels = max11205_channels;
> > > +       indio_dev->num_channels = 1;
> > > +       indio_dev->info = &max11205_iio_info;
> > > +
> > > +       st->vref = devm_regulator_get(&spi->dev, "vref");  
> > 

> > devm_regulator_get_enable() ?  

> I found the patches which implement devm_regulator_get_enable.
> However, I need to get the voltage of the regulator using
> regulator_get_voltage(struct regulator *regulator) and if I use
> devm_regulator_get_enable I do not have access to the regulator
> pointer. What should I do in this case? Is there an API which works
> like devm_regulator_get_enable but also gives access to the
> regulator's pointer? Thank you for you review!

Ah.  You've run into a fun long running 'discussion'.  There was
great resistance to adding devm_regulator_get_enable() because it
was felt that it was too easy to get the handling wrong and end up
with underflowing reference counters etc.  So the 'solution' was
to make it less useful than it would otherwise have been by making
sure it could not be combined with other accesses to the regulator.

Upshot is you are correct that it cannot be applied in this case.

Also relevant is that the patch in question is going through the
regulator tree so won't be generally available to the rest of the
kernel until next cycle.  As such we'd have had to make such a
change as a follow up patch if it were possible.

Jonathan

p.s. Wrap your replies at 80 chars as well as the code.
Kernel developers have an annoying habit of reading their email in
one small window even when they have very large monitors :)
Also, where sensible crop unnecessary parts of the email to only
include the bit you are responding to. Saves on lots of scrolling..

> Kind Regards, Ramona
> Bolboaca
