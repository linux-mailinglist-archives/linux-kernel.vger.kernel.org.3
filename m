Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6020D4C8DC3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbiCAObl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbiCAObg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:31:36 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B569A1460;
        Tue,  1 Mar 2022 06:30:50 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 803C11C001A;
        Tue,  1 Mar 2022 14:30:47 +0000 (UTC)
Date:   Tue, 1 Mar 2022 15:30:44 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v8 2/2] On Semi AR0521 sensor driver
Message-ID: <20220301143044.2l4vlwbnh5n3g5ng@uno.localdomain>
References: <m3pmn66pie.fsf@t19.piap.pl>
 <m3h78i6p4t.fsf@t19.piap.pl>
 <20220301093107.ihokyp4xptkzpbpc@uno.localdomain>
 <m38rtt7sx7.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m38rtt7sx7.fsf@t19.piap.pl>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

On Tue, Mar 01, 2022 at 01:34:28PM +0100, Krzysztof Hałasa wrote:
> Jacopo Mondi <jacopo@jmondi.org> writes:
>
> > In subject
> >
> > "media: i2c:"
> >
> > Same for 1/2 where permutation of "media: dt-bindings: i2c:" are used
> > when adding bindings for media i2c drivers.
>
> You know, it's rather hard to know all these tiny requirements. Let
> alone get them right all the time.
>

I usually rely on what git log suggests me if in doubt.

> >> +	pm_runtime_set_active(&client->dev);
> >> +	pm_runtime_enable(&client->dev);
> >> +	pm_runtime_idle(&client->dev);
> >
> > Do you have an _idle() callback ? This seems a no-op to me, or am I
> > mistaken ? (runtime_pm is still cryptic to me sometimes)
>
> Do you mean only the pm_runtime_idle()? Sakari just requested I add it.
>

Ok then

> > Can't you just remove power_on() if it's not needed ?
>
> It wouldn't work without CONFIG_PM then, would it?
>

True that. And an #ifdef is maybe undesirable.

Although, if with idle you can power-down the chip after probe, I'm
fine with that

> > There still are a few checkpatch warnings which might be worth
> > considering  but nothing huge.
>
> Do you mean this?
>
> WARNING: Block comments use * on subsequent lines
> #411: FILE: drivers/media/i2c/ar0521.c:351:
> +               /* Reset gain, the sensor may produce all white pixels without
> +                  this */
>
> WARNING: Block comments use a trailing */ on a separate line
> #411: FILE: drivers/media/i2c/ar0521.c:351:
> +                  this */
>
> ... which are about a single comment which I had to wrap to fit in 80
> columns, hardly a block comment by my standards. Not to mention Linus
> saying...

The warning suggests to go for

        /*
         * This when a comment
         * spans on multiple lines
         */

instead of

        /* Going for this style when
           a comment is on multiple lines */


> --
> Krzysztof "Chris" Hałasa
>
> Sieć Badawcza Łukasiewicz
> Przemysłowy Instytut Automatyki i Pomiarów PIAP
> Al. Jerozolimskie 202, 02-486 Warszawa
