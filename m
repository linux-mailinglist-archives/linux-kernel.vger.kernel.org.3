Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA7959B1FB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 07:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiHUFB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 01:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiHUFBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 01:01:03 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21641F2CC;
        Sat, 20 Aug 2022 22:01:02 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so8390065pjl.0;
        Sat, 20 Aug 2022 22:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=yYbuoP8aiNdzjNucGmLOyWlT9Bpa0wRaE8Dmtu5m2vA=;
        b=NWJNGh7ZvNh1DkptDTyGM8P7AHb1Qmmd/7Gs1xbHWTYVLZ9507MdW8Qrf4wFM60afI
         jMRtbouQ+eX+y5Jtpk5Tsbx8S05CWh7aMsxzRdjYWLdyiLWvshUFC75J+pp9GwgVjmhB
         POJnCEVD/BVxvyjIPnfr0Joq7vU556veA/7mnrj4JW4fhplAY3qG8VD1GE8DXxDSczqx
         9od6NtWIG7huVhkqyMGUVTCc3pTidbsfAhyWvzr3ZNpPGt+3AMDBLosj2hQJsXOzb4wD
         CsLidvYY1IvIiTZOF86tTn3asIBguR+0sqarLshbn97EbOrxjGrOhtBClbUGozUBdnrr
         +jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=yYbuoP8aiNdzjNucGmLOyWlT9Bpa0wRaE8Dmtu5m2vA=;
        b=RjYA9oAoOMcvkrmTl/wbDe5BX8ZxstJrE6h3wIvT7FGKDDe8b2DRK8QuRw0zA+YV8i
         UIpeZVe/otJ9kKE6KIFSXerEENvcG8bJ/1xM40HepV99zPxIrUd9e7S9ERMKWQqDSUcJ
         EOl91SAVavUDPD3UciCz7I+UnGkNDmm16KGSYXtj+6qQwh8Nb04bscDSKFmt19ilxdY/
         a+CneDcdmVxgS8jTUqtQS/onTJ+TXZ3K0PhblrHmf84xYH7wy8vS8EaDHlFJxUsBkPR5
         rccl7yH+QDgEa2o4lJnUaChLkT8KDg2YAQcy9SANmms7tJTfbq0ziKE9GkYimtsS1jSr
         DLQA==
X-Gm-Message-State: ACgBeo0bzkNQwTJYfRHjhftiukmFGxZy1O+OJ4luWjU8a80WmZlzUicc
        ibqhfM77VnXY+1+jtua8Q4w=
X-Google-Smtp-Source: AA6agR6ps4TmBKlFXVuuW0dJ0uWopC9NxZaGNWK4vlZ06sq8mj21tmV1glVBGCy7KGA6nXsGQ0yHQQ==
X-Received: by 2002:a17:902:7c94:b0:170:aed6:7e6c with SMTP id y20-20020a1709027c9400b00170aed67e6cmr14222331pll.10.1661058062191;
        Sat, 20 Aug 2022 22:01:02 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:2c40:97f7:f170:cdca])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902d1c500b0016eea511f2dsm5700875plb.242.2022.08.20.22.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 22:01:01 -0700 (PDT)
Date:   Sat, 20 Aug 2022 22:00:58 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Gireesh.Hiremath@in.bosch.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, bcousson@baylibre.com,
        tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mkorpershoek@baylibre.com,
        davidgow@google.com, swboyd@chromium.org, fengping.yu@mediatek.com,
        y.oudjana@protonmail.com, rdunlap@infradead.org,
        colin.king@intel.com, sjoerd.simons@collabora.co.uk,
        VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
Subject: Re: [PATCH v3 1/3] driver: input: matric-keypad: switch to gpiod
Message-ID: <YwG8CkhlK5xDJ1lr@google.com>
References: <20220819065946.9572-1-Gireesh.Hiremath@in.bosch.com>
 <20220819131231.nzi26cbrpgfrycl2@pengutronix.de>
 <YwAx38N0ICE37Vu9@google.com>
 <20220820193623.bnjgnydu3rkbdtbo@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820193623.bnjgnydu3rkbdtbo@pengutronix.de>
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Sat, Aug 20, 2022 at 09:36:23PM +0200, Marco Felsch wrote:
> Hi Dmitry,
> 
> On 22-08-19, Dmitry Torokhov wrote:
> > On Fri, Aug 19, 2022 at 03:12:31PM +0200, Marco Felsch wrote:
> > > Hi Gireesh,
> > > 
> > > On 22-08-19, Gireesh.Hiremath@in.bosch.com wrote:
> > > > From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
> > > > 
> > > > Switch from gpio API to gpiod API
> > > 
> > > Nice change.
> > > 
> > > Did you checked the users of this driver? This change changes the
> > > behaviour for actice_low GPIOs. A quick check showed that at least on
> > > upstream board: arch/arm/mach-pxa/palmtc.c uses active low GPIOs.
> > > 
> > > > Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
> > > > 
> > > > Gbp-Pq: Topic apertis/guardian
> > > > Gbp-Pq: Name driver-input-matric-keypad-switch-gpio-to-gpiod.patch
> > > 
> > > Please drop this internal tags.
> > > 
> > > > ---
> > > >  drivers/input/keyboard/matrix_keypad.c | 84 ++++++++++----------------
> > > >  include/linux/input/matrix_keypad.h    |  4 +-
> > > >  2 files changed, 33 insertions(+), 55 deletions(-)
> > > > 
> > > > diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
> > > > index 30924b57058f..b99574edad9c 100644
> > > > --- a/drivers/input/keyboard/matrix_keypad.c
> > > > +++ b/drivers/input/keyboard/matrix_keypad.c
> > > > @@ -15,11 +15,10 @@
> > > >  #include <linux/interrupt.h>
> > > >  #include <linux/jiffies.h>
> > > >  #include <linux/module.h>
> > > > -#include <linux/gpio.h>
> > > > +#include <linux/gpio/consumer.h>
> > > >  #include <linux/input/matrix_keypad.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/of.h>
> > > > -#include <linux/of_gpio.h>
> > > >  #include <linux/of_platform.h>
> > > >  
> > > >  struct matrix_keypad {
> > > > @@ -49,11 +48,11 @@ static void __activate_col(const struct matrix_keypad_platform_data *pdata,
> > > >  	bool level_on = !pdata->active_low;
> > > >  
> > > >  	if (on) {
> > > > -		gpio_direction_output(pdata->col_gpios[col], level_on);
> > > > +		gpiod_direction_output(pdata->col_gpios[col], level_on);
> > > 
> > > Now strange things can happen, if active_low is set and you specified
> > > GPIO_ACTIVE_LOW within the device-tree. We need a way to move to gpiod
> > > and keep the current behaviour.
> > > 
> > > >  	} else {
> > > > -		gpio_set_value_cansleep(pdata->col_gpios[col], !level_on);
> > > > +		gpiod_set_value_cansleep(pdata->col_gpios[col], !level_on);
> > > >  		if (!pdata->drive_inactive_cols)
> > > > -			gpio_direction_input(pdata->col_gpios[col]);
> > > > +			gpiod_direction_input(pdata->col_gpios[col]);
> 
> ...
> 
> > > > @@ -429,9 +410,6 @@ matrix_keypad_parse_dt(struct device *dev)
> > > >  	pdata->wakeup = of_property_read_bool(np, "wakeup-source") ||
> > > >  			of_property_read_bool(np, "linux,wakeup"); /* legacy */
> > > >  
> > > > -	if (of_get_property(np, "gpio-activelow", NULL))
> > > > -		pdata->active_low = true;
> > > > -
> > > 
> > > This removes backward compatibility, please don't do that.
> > 
> > I do not think there is a reasonable way of keeping the compatibility
> > while using gpiod API (sans abandoning polarity handling and using
> > *_raw() versions of API).
> > 
> > I would adjust the DTSes in the kernel and move on, especially given
> > that the DTSes in the kernel are inconsistent - they specify
> > gpio-activelow attribute while specifying "action high" in gpio
> > properties).
> 
> Yes, because the driver didn't respect that by not using the gpiod API.
> Got your point for the DTses but what about the boards based on the
> platform-data? Those boards must be changed as well.

Yes, that is correct.

> 
> Also I thought DTB is firmware and we should never break it, now we
> doing it by this commit. Just to get your opinion on this.

Well, this is true in theory, however from the practical POV the boards
that use this driver do not store DTB in firmware, but rather distribute
it with the kernel. So while we normally try to keep compatibility, in
cases like this I feel we can be practical and instead of trying to
handle a pure theoretical case simply fix up DTSes and move on with our
lives.

Thanks.

-- 
Dmitry
