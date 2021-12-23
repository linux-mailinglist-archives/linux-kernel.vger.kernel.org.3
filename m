Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3109347E7C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 19:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349899AbhLWSsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 13:48:17 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:52795 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349895AbhLWSsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:48:06 -0500
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id AF3ED1BF206;
        Thu, 23 Dec 2021 18:48:01 +0000 (UTC)
Date:   Thu, 23 Dec 2021 19:48:56 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Joe Perches <joe@perches.com>
Cc:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v6 2/2] Driver for ON Semi AR0521 camera sensor
Message-ID: <20211223184856.v34ecibwzepahsju@uno.localdomain>
References: <m3ee63hkuu.fsf@t19.piap.pl>
 <m35yrfhkaf.fsf@t19.piap.pl>
 <cee1bbe6c8dda1c79ba19f7bbf68fc1d74558cae.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cee1bbe6c8dda1c79ba19f7bbf68fc1d74558cae.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,
  sorry to jump in

On Thu, Dec 23, 2021 at 09:49:58AM -0800, Joe Perches wrote:
> On Thu, 2021-12-23 at 08:06 +0100, Krzysztof Hałasa wrote:
> > The driver has been extensively tested in an i.MX6-based system.
> > AR0521 is a 5.7 mm x 4.3 mm, 5 MPix RGGB MIPI/HiSPi BSI CMOS sensor
> > from On Semiconductor.
>
> trivial notes:
>
> > diff --git a/drivers/media/i2c/ar0521.c b/drivers/media/i2c/ar0521.c
> []
> > +/* External clock (extclk) frequencies */
> > +#define AR0521_EXTCLK_MIN	  (10 * 1000 * 1000)
>
> Generally, adding a prefix like AR0521_ to defines that are
> locally defined in a single file unnecessarily increases
> identifier length.
>
> It makes using short line lengths difficult.
>
> e.g. Using this identifier anywhere
>
> > +#define AR0521_REG_HISPI_CONTROL_STATUS_FRAMER_TEST_MODE_ENABLE 0x80
>
> Many of the 80 column line lengths and line wrapping used in this
> file are not really nice to read.  I believe you don't have to be
> strict about 80 column lines.
>

Krzysztof first version had much longer lines, and in facts it has
been asked by me to reduce them to 80 cols. The media subsystem
requires to validate patches with

        ./scripts/checkpatch.pl --strict --max-line-length=80

We longly debated this and I believe it's now generally accepted to go
over 80 when it makes sense, but not regularly span to 120 cols like
in the previous version.

I think this 80-cols limit not being an hard limit anymore is doing
more worse than good, as each subsystem applies a different rule, and
I know how frustrating is for Krzysztof to be pushed in different
direction, as the same happened to me when I contributed to other
subsystems and I've been asked to span to 100 cols while I was trying
to stay in 80 no matter what.

Thanks
   j

> > +#define be		cpu_to_be16
>
> It's a pity there's no way to declare an array with all members
> having a specific endianness.  Making sure all elements in these
> arrays are declared with be() is tedious.
>
> > +#define AR0521_NUM_SUPPLIES ARRAY_SIZE(ar0521_supply_names)
>
> It's almost always better to use ARRAY_SIZE directly and not
> use a #define for the array size.
>
> > +static int ar0521_set_gains(struct ar0521_dev *sensor)
> > +{
> []
> > +	dev_dbg(&sensor->i2c_client->dev, "%s()\n", __func__);
>
> ftrace works and perhaps all the similar debug logging uses aren't
> really necessary.
>
>
