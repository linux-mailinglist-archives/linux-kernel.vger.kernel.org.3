Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437464AAAB4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 18:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380792AbiBERrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 12:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiBERrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:47:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A0AC061348;
        Sat,  5 Feb 2022 09:47:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5891661160;
        Sat,  5 Feb 2022 17:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE73C340E8;
        Sat,  5 Feb 2022 17:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644083253;
        bh=yJVqw1+2/vGIl9CRw6dywwO5UFFzyHXbS+kXZvxW3dI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TrXDAMBdOYSjno5LMBN1UZS0tBKz31/e+NWfUoshuYAq6rJ+vgAIo0whShVzmCdZf
         VA2kOgJvGPOu05xgUBxJO5t0kGZ0vPFWd2Smz+dje1nCvpY8Voq/7gza3dqQNAouSD
         cGsmwPWS6KTOrhEE43Kchcdzt2AqvN+9hgBGv5dFnD2ZdYF3yER5YB/GnnKnVIWz6V
         4563+l/nZM+KGWJpTrpVauyxkKGuWeoLFWTkCUuv1m8WEW0yQiSEGKfe20EgJN9j9P
         e92LpGWHXx6QTVgzEhIvEOHgVemwyaOuAzpnQoZkFrAOpExy7e2l8TEQrmp8eF7CQy
         Aw/tp3SP8tfjw==
Date:   Sat, 5 Feb 2022 17:54:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, andy.shevchenko@gmail.com,
        lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v13 06/11] iio: afe: rescale: make use of units.h
Message-ID: <20220205175404.451c5c56@jic23-huawei>
In-Reply-To: <YfmJ3P1gYaEkVjlY@shaak>
References: <20220130161101.1067691-1-liambeguin@gmail.com>
        <20220130161101.1067691-7-liambeguin@gmail.com>
        <5da96dc7-696b-1bc0-a111-f6108ecfa54c@axentia.se>
        <YfmJ3P1gYaEkVjlY@shaak>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2022 14:28:28 -0500
Liam Beguin <liambeguin@gmail.com> wrote:

> Hi Peter,
> 
> On Mon, Jan 31, 2022 at 03:50:22PM +0100, Peter Rosin wrote:
> > Hi!
> > 
> > I noticed that I have not reviewed this patch. Sorry for my low
> > bandwidth.
> > 
> > On 2022-01-30 17:10, Liam Beguin wrote:  
> > > Make use of well-defined SI metric prefixes to improve code readability.
> > > 
> > > Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> > > ---
> > >  drivers/iio/afe/iio-rescale.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> > > index 67273de46843..27c6664915ff 100644
> > > --- a/drivers/iio/afe/iio-rescale.c
> > > +++ b/drivers/iio/afe/iio-rescale.c
> > > @@ -51,11 +51,11 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
> > >  		}
> > >  		fallthrough;
> > >  	case IIO_VAL_FRACTIONAL_LOG2:
> > > -		tmp = (s64)*val * 1000000000LL;
> > > +		tmp = (s64)*val * GIGA;
> > >  		tmp = div_s64(tmp, rescale->denominator);
> > >  		tmp *= rescale->numerator;
> > >  
> > > -		tmp = div_s64_rem(tmp, 1000000000LL, &rem);
> > > +		tmp = div_s64_rem(tmp, GIGA, &rem);  
> > 
> > It is NOT easy for me to say which of GIGA/NANO is most fitting.
> > There are a couple of considerations:  
> 
> I agree with you that the choice behind GIGA/NANO can be a bit
> confusing.
> 
> In my opinion, these defines makes the code easier to read if you
> consider them as multipliers with no physical meaning, basically a
> pretty name for a power of 10.
> 
> By this logic, we wouldn't ever use FEMTO to DECI.

Not sure if it would help but maybe it's worth a local define
of something like

#define MULT9 1000000000LL
to loose the association with any particular SI basis and
just indicate it's a bit number being used to retain precision
in some maths?  Would need a comment to stop people sending
patches to replace it with GIGA though ;)

My ultimate preference here is for whatever works for Peter and
Liam as the people who are mostly likely to have to deal
with any changes to this driver in the future.

Jonathan


> 
> Cheers,
> Liam
> 
> > A) 1000000000 is just a big value (GIGA fits). Something big is
> >    needed to not lose too much precision.
> > B) 1000000000 is what the IIO core uses to print fractional-log
> >    values with nano precision (NANO fits). This is not really
> >    relevant in this context.
> > C) 1000000000 makes the int-plus-nano and fractional-log cases
> >    align (NANO fits). This last consideration is introduced with
> >    patch 4/11.
> > 
> > There is simply no correct define to use. And whichever define is
> > chosen makes the other interpretation less obvious. Which is not
> > desirable, obscures things and make both GIGA and NANO bad
> > options.
> > 
> > So, I stepped back to the description provided by Andy in the
> > comments of v11:
> > 
> > On 2021-12-22 19:59, Andy Shevchenko wrote:
> > | You should get the proper power after the operation.
> > | Write a formula (mathematically speaking) and check each of them for this.
> > | 
> > | 10^-5/10^-9 == 1*10^4 (Used NANO)
> > | 10^-5/10^9 == 1/10^-14 (Used GIGA)
> > | 
> > | See the difference?
> > 
> > No, I don't really see the difference, that just makes me totally
> > confused. Dividing by 10^-9 or multiplying by 10^9 is as we all
> > know exactly the same, and the kernel cannot deal directly with
> > 10^-9 so both will look the same in code (multiplying by 10^9). So,
> > you must be referring to the "real formula" behind the code. But
> > in that case, if the "real formula" behind the (then equivalent)
> > code had instead been
> > 
> > 	10^-5*10^9 == 1*10^4 (Used GIGA)
> > 	10^-5*10^-9 == 1/10^-14 (Used NANO)
> > 
> > the outcome is the opposite. NANO turns GIGA and vice versa.
> > 
> > Since you can express the same thing differently in math too, it
> > all crumbles for me. Because of this duality, it will be a matter
> > of taste if GIGA or NANO fits best in any given instance. Sometimes
> > (perhaps commonly) it will be decidedly easy to pick one of them,
> > but in other cases (see above) we will end up with a conflict.
> > 
> > What to do then? Or, what am I missing?
> > 
> > My taste says NANO in this case, since A) is just some big number
> > and not really about units and B) is as stated not really relevant.
> > Which makes C) win the argument for me.
> >   
> > >  		*val = tmp;
> > >  
> > >  		if (!rem)
> > > @@ -71,7 +71,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
> > >  
> > >  		*val2 = rem / (int)tmp;
> > >  		if (rem2)
> > > -			*val2 += div_s64((s64)rem2 * 1000000000LL, tmp);
> > > +			*val2 += div_s64((s64)rem2 * GIGA, tmp);  
> > 
> > Here, 1000000000 matches the above use. If we go with NANO above,
> > we should go with NANO here as well.
> >   
> > >  		return IIO_VAL_INT_PLUS_NANO;
> > >  	case IIO_VAL_INT_PLUS_NANO:
> > > @@ -332,8 +332,8 @@ static int rescale_current_sense_amplifier_props(struct device *dev,
> > >  	 * gain_div / (gain_mult * sense), while trying to keep the
> > >  	 * numerator/denominator from overflowing.
> > >  	 */
> > > -	factor = gcd(sense, 1000000);
> > > -	rescale->numerator = 1000000 / factor;
> > > +	factor = gcd(sense, MEGA);
> > > +	rescale->numerator = MEGA / factor;  
> > 
> > Here, the 1000000 number comes from the unit of the sense resistor
> > (micro-ohms), so I would have preferred MICRO. But who can tell
> > if we -mathematically speaking- have divided the given resistance
> > integer by 10^6 (MEGA) or multiplied it with 10^-6 (MICRO) to
> > account for the unit? Or if we divided the other values with
> > 10^6 (MEGA) (or multiplied by 10^-6, MICRO) to make them fit the
> > unit of the shunt resistance?
> > 
> > All of the above is of course equivalent so both MEGA and MICRO
> > are correct. But as stated, MICRO makes to most sense as that is
> > what connects the code to reality and hints at where the value
> > is coming from. For me anyway.
> >   
> > >  	rescale->denominator = sense / factor;
> > >  
> > >  	factor = gcd(rescale->numerator, gain_mult);
> > > @@ -361,8 +361,8 @@ static int rescale_current_sense_shunt_props(struct device *dev,
> > >  		return ret;
> > >  	}
> > >  
> > > -	factor = gcd(shunt, 1000000);
> > > -	rescale->numerator = 1000000 / factor;
> > > +	factor = gcd(shunt, MEGA);
> > > +	rescale->numerator = MEGA / factor;  
> > 
> > Same here, 1000000 comes from the micro-ohms unit of the shunt
> > resistor, so I would have preferred MICRO.
> > 
> > 
> > 
> > Sorry for the long mail. I blame the duality of these ambiguous
> > SI-defines that are a bit confusing to me.
> > 
> > Cheers,
> > Peter
> >   
> > >  	rescale->denominator = shunt / factor;
> > >  
> > >  	return 0;  

