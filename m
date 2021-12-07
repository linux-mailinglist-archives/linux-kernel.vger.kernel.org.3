Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A0546B35C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhLGHJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhLGHJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:09:38 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EEBC061746;
        Mon,  6 Dec 2021 23:06:08 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v19so8771699plo.7;
        Mon, 06 Dec 2021 23:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+WUTgx0L85lxi2fdDbmVWfQm0Fyz5KOBASfXLKJ1914=;
        b=Qnj+3P7zN6U9mTLOmd2WzaOtEi5SlrvLkoST+sHw/BBxdY7+RyH2KjJc7goBB4sj8Z
         8rTMBm361UDpSVbMHKV8i0W8Ynk0nTI/uqs31ciJCCQhxSePwoQUz6AwTWCiD4XfoHkB
         1v9MWFQRmX8bNu7qZTFCWqyEOEAS11Lv06jJRXo5MQM8P8clC2qBmBuPgjbLYZDx+1VE
         S0t/BrDW2z1HaJq6FJNI9qKIPWOEfvbuS4W9YzVHf/fC3ttPKZysS6zVhxzYYgjDjgS4
         j4/DElGse8K0ZUHBR9WVJ1RZ4j6oIVHwqMp/5Urggfm8sYe2/kWBcpGI3gCzePAiAWa1
         h3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+WUTgx0L85lxi2fdDbmVWfQm0Fyz5KOBASfXLKJ1914=;
        b=DFBLl3MpkhtGMvuOn9ZIb3mzvHZNTablXaqOYjPUF9jP7GRp3dVTxIUyKRMQZeqnB0
         0Vng+4mkwQH7aYj2m8g27zadhSB/BtLHaJ1lGigUN6o2SUhGUJR70FGGOCc7mLAOLS1s
         kk5Ok67Z0VyMPS6h3on611wBrBR+osvyOlyfAxgbqWubGUHDFHboRHyLRcEjCDWTgm6L
         D8cEAxJ2YUXhzi+njakPlYnX7XRu+JntcgAO6VOKU6ArSoUL7WUyA+AQz+C2GQyJ+kE4
         7NBqTd2/bXP+KXaDJZsjgB1Q83MzsOBi/uC8br3p5b0j7KisZRCYyPrIqhrd9SJsyQCH
         hkfg==
X-Gm-Message-State: AOAM5302eHx8RKWmZVISH6e9TMJATspf3vK8EP8EKbwBO3kBELs4lnwN
        x3O4N68znKbPBSfpj4SYc+Q=
X-Google-Smtp-Source: ABdhPJwKMduaisPl4sUh7vNL0hUbGfNAGCj2DuKTt35IUcb8gAfCW29iwccLWh7N7iyAWnKiG6yCjg==
X-Received: by 2002:a17:902:9692:b0:143:d9ad:d151 with SMTP id n18-20020a170902969200b00143d9add151mr48695859plp.40.1638860768318;
        Mon, 06 Dec 2021 23:06:08 -0800 (PST)
Received: from google.com ([2620:15c:202:201:25b0:d110:b844:ea00])
        by smtp.gmail.com with ESMTPSA id m16sm7551996pfk.186.2021.12.06.23.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 23:06:07 -0800 (PST)
Date:   Mon, 6 Dec 2021 23:06:04 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v3 1/4] Input: Add driver for Cypress Generation 5
 touchscreen
Message-ID: <Ya8H3AHRqeJj7IUr@google.com>
References: <20211202122021.43124-1-alistair@alistair23.me>
 <20211202122021.43124-2-alistair@alistair23.me>
 <20211204233233.6c55875c@aktux>
 <CAKmqyKPDROFkAFgSjSDeTfhtZsArn4BbON9tyb1qTb_QcV5=xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKPDROFkAFgSjSDeTfhtZsArn4BbON9tyb1qTb_QcV5=xg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 08:46:50PM +1000, Alistair Francis wrote:
> On Sun, Dec 5, 2021 at 8:32 AM Andreas Kemnade <andreas@kemnade.info> wrote:
> >
> > Hi,
> >
> >
> > On Thu,  2 Dec 2021 22:20:18 +1000
> > Alistair Francis <alistair@alistair23.me> wrote:
> >
> > > From: Mylène Josserand <mylene.josserand@bootlin.com>
> > >
> > > This is the basic driver for the Cypress TrueTouch Gen5 touchscreen
> > > controllers. This driver supports only the I2C bus but it uses regmap
> > > so SPI support could be added later.
> > > The touchscreen can retrieve some defined zone that are handled as
> > > buttons (according to the hardware). That is why it handles
> > > button and multitouch events.
> > >
> > > Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > > Message-Id: <20180703094309.18514-2-mylene.josserand@bootlin.com>
> > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> >
> > I finally got it working. The order of initialisation is important.
> > Params are copied on input_mt_init_slots() from ABS_MT* to ABS_*, so you
> > have to set params first.
> >
> > Here is the patch i need on top of this one to make it actually work
> > with X (evdev and libinput is tested):
> >
> > diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
> > index b5d96eb71e46..3894ec85a732 100644
> > --- a/drivers/input/touchscreen/cyttsp5.c
> > +++ b/drivers/input/touchscreen/cyttsp5.c
> > @@ -415,19 +415,12 @@ static int cyttsp5_setup_input_device(struct device *dev)
> >         int max_x_tmp, max_y_tmp;
> >         int error;
> >
> > -       __set_bit(EV_REL, ts->input->evbit);
> 
> Does it work with this still included? I need this for my userspace program.

You need to fix your program, the kernel should not be declaring
capabilities that the device does not support.

Thanks.

-- 
Dmitry
