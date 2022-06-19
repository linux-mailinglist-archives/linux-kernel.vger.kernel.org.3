Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953BC5509E5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 12:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbiFSKwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 06:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbiFSKwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 06:52:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEB510FE1;
        Sun, 19 Jun 2022 03:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DF4AB80D22;
        Sun, 19 Jun 2022 10:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CB1C34114;
        Sun, 19 Jun 2022 10:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655635932;
        bh=7OWf8G0jMiKkIOyazPpTYHLvbZq8teEs+PZVbvDwI6Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rVQRKLTdruRR6l4WvRrlC19nxkgW8EIkCQ2gqqYtXUUhFJiH1zLJwD6vbS//J8kC9
         44D/E1gNGoxLsOgXOvx+MiE1CN+Y+r6FtHtkIVD8xoC48AFFXYLATO6VzXx/4dYDSy
         DCdoxxbLUKoFriC43ZMHV9Asit/4Lr9bCgl4B8w+sh3HIwdjK1u5RL9sUPDkuuMF0j
         idn0/fCc560VvXDkdCoAf47ghxKd+fgqtC/q4RKc7yhglIHtY+Np+LLTtcxPauJMxt
         wXJK5FbTrlA8UQVzC56+25tCg9ofu9tHQfbpV9jn2869QABEU+uGtTx462oCqgkbsH
         142+V6S9BsF1Q==
Date:   Sun, 19 Jun 2022 12:01:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>, michael@walle.cc,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 10/16] iio: adc: axp20x_adc: Minor code cleanups
Message-ID: <20220619120126.54d0b586@jic23-huawei>
In-Reply-To: <CAGb2v65PLTcy53zjHA83qAaNq4y-Mmxfv4xvSuwqRLGBiwgjDQ@mail.gmail.com>
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
        <20220618214009.2178567-11-aidanmacdonald.0x0@gmail.com>
        <CAGb2v65PLTcy53zjHA83qAaNq4y-Mmxfv4xvSuwqRLGBiwgjDQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jun 2022 11:56:56 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Sun, Jun 19, 2022 at 5:40 AM Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> wrote:
> >
> > The code may be clearer if parameters are not re-purposed to hold
> > temporary results like register values, so introduce local variables
> > as necessary to avoid that. Also, use the common FIELD_PREP macro
> > instead of a hand-rolled version.
> >
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> > ---
> >  drivers/iio/adc/axp20x_adc.c | 61 +++++++++++++++++++-----------------
> >  1 file changed, 33 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> > index 53bf7d4899d2..041511280e1e 100644
> > --- a/drivers/iio/adc/axp20x_adc.c
> > +++ b/drivers/iio/adc/axp20x_adc.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/property.h>
> >  #include <linux/regmap.h>
> >  #include <linux/thermal.h>
> > +#include <linux/bitfield.h>  
> 
> Sort this group of headers alphabetically please.
> 
> >
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/driver.h>
> > @@ -22,20 +23,20 @@
> >  #include <linux/mfd/axp20x.h>
> >
> >  #define AXP20X_ADC_EN1_MASK                    GENMASK(7, 0)
> > -
> >  #define AXP20X_ADC_EN2_MASK                    (GENMASK(3, 2) | BIT(7))
> > +
> >  #define AXP22X_ADC_EN1_MASK                    (GENMASK(7, 5) | BIT(0))
> >
> >  #define AXP20X_GPIO10_IN_RANGE_GPIO0           BIT(0)
> >  #define AXP20X_GPIO10_IN_RANGE_GPIO1           BIT(1)
> > -#define AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(x)    ((x) & BIT(0))
> > -#define AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(x)    (((x) & BIT(0)) << 1)
> >
> >  #define AXP20X_ADC_RATE_MASK                   GENMASK(7, 6)
> > -#define AXP813_V_I_ADC_RATE_MASK               GENMASK(5, 4)
> > -#define AXP813_ADC_RATE_MASK                   (AXP20X_ADC_RATE_MASK | AXP813_V_I_ADC_RATE_MASK)
> >  #define AXP20X_ADC_RATE_HZ(x)                  ((ilog2((x) / 25) << 6) & AXP20X_ADC_RATE_MASK)
> > +
> >  #define AXP22X_ADC_RATE_HZ(x)                  ((ilog2((x) / 100) << 6) & AXP20X_ADC_RATE_MASK)
> > +
> > +#define AXP813_V_I_ADC_RATE_MASK               GENMASK(5, 4)
> > +#define AXP813_ADC_RATE_MASK                   (AXP20X_ADC_RATE_MASK | AXP813_V_I_ADC_RATE_MASK)  
> 
> Please also mention "grouping macros based on chip type" in the commit log.
> 
> Otherwise,
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
With Chen-Yu's suggested changes,

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan


