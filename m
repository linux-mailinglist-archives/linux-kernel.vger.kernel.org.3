Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6854AA18A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbiBDVCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbiBDVCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:02:37 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F57C061714;
        Fri,  4 Feb 2022 13:02:36 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id v74so6122077pfc.1;
        Fri, 04 Feb 2022 13:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dkQHeMhrccAmwfWNY5MWOMZzEpP2OXc/XHH4flu61oM=;
        b=dq4SE1XEa8u21mjcr6eMEytMhYg0aQalnIbqS7HXMgJCjhQ87uYH+YL8p1TQVPUusO
         AveLxZtspWrrzjLIA1Xg9XQZ51nY1zG9yj7VgGoG3X8pFfsGSen3P31bPLWisaYla58Y
         ACmasENnmcJe12R5DD/EZXYaPr/rtMttEemz6Yg2ENO4sy3gtcBH9l0R02jJvJVgfDqk
         qiK6CC+j7gSIm2g2XSbX4snj2nGn3oGT311CggSv3J+m5ABkRykesdVlDX+gVRYAQG2l
         Zw9opDHElZIvNG6qNnJCv2EKb+UYJsvQojzkxOJs8gtyLolD56Wx+A0xcLHmZfqQOeU3
         V4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dkQHeMhrccAmwfWNY5MWOMZzEpP2OXc/XHH4flu61oM=;
        b=MnloRjZHBuLRXvaze6tpoGIZvkfK//6bcpHMBr5SXwg/ns2OZaO3ZPphxwQkGyXchj
         E4n1ZHhu+Vgic/usbc23FZQRHXF8xsHOaGm33dNVcYiKDcErDXtjXAtkKc+pgNe/z5ZX
         iNEv9jshFSHDPG5UkHIxataxkbypi2nujEhs7+HahdOfSissoxe2kb8W7RiQA93SJpzb
         NxvVd3ORkIKbQYQ7R1O+F3Fp7vleXG/5/DOZLvq71WpONqjzSBeaQh0wrndldtSTFKmo
         ggj943dVQMLr+0p4PEiIy+HMiUO/8f1qToiLWedSr8TEyMFr9A13AwG1QFKpufZM/PgZ
         8m0g==
X-Gm-Message-State: AOAM531QS375dmSpJZ2Um892fDzWadMucvdRnyB5cUnLtbAP6OSlYckg
        za0hiJk4UWwG2cTtzTiEm3M=
X-Google-Smtp-Source: ABdhPJzAKRivnZMC5UiCVKzWreftQArfG/EpExywTGoMa2OGFzXCWFvltJWv1DAD/qTxXPnUbbNylQ==
X-Received: by 2002:a63:b141:: with SMTP id g1mr673240pgp.269.1644008555875;
        Fri, 04 Feb 2022 13:02:35 -0800 (PST)
Received: from google.com ([2620:15c:202:201:4c5b:5873:55d5:5b84])
        by smtp.gmail.com with ESMTPSA id o9sm3142837pfw.86.2022.02.04.13.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 13:02:34 -0800 (PST)
Date:   Fri, 4 Feb 2022 13:02:32 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Hans De Goede <hdegoede@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Wrongly bound Elantech touchpad on Lenovo Yoga Slim 7
Message-ID: <Yf2UaMp8ttjrBjU0@google.com>
References: <s5hleyqwowl.wl-tiwai@suse.de>
 <CAO-hwJK-7migm7VWkwvTPHwxgTZEbNX0XYpk0A1pr6N2jkYrxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJK-7migm7VWkwvTPHwxgTZEbNX0XYpk0A1pr6N2jkYrxw@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Fri, Feb 04, 2022 at 06:39:40PM +0100, Benjamin Tissoires wrote:
> Hi,
> 
> [adding Dmitry, the maintainer of the input tree and Hans, a colleague of mine]
> 
> On Fri, Feb 4, 2022 at 5:57 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > Hi,
> >
> > we've got a bug report on openSUSE Bugzilla about the broken touchpad
> > on Lenovo Yoga Slim 7:
> >   https://bugzilla.opensuse.org/show_bug.cgi?id=1193064
> >
> > The touchpad is an Elantech one, connected over i2c, and there are two
> > drivers supporting it.  Unfortunately, the default one the system
> > binds, elan-i2c input driver, doesn't seem working properly, while
> > i2c-hid driver works.
> 
> Hans, we do have a similar bug on RHEL at
> https://bugzilla.redhat.com/show_bug.cgi?id=2029078 (sorry, private
> bug).
> 
> IIRC you worked on the discrimination between i2c-hid and elan_i2c (I
> might be completely wrong though).
> Would this patch be OK with you?

I would prefer avoid DMI if possible.

I believe we need to do what Hans did for Elan Touch*screen* driver and
avoid binding to the device if it has i2c-hid-specific _DMS in ACPI.
I.e. we need to replicate elants_acpi_is_hid_device().

Even better would be to factor it out, maybe not into a shared module
but simply shared header with static inline function that we could share
between elan drivers and maybe others as well.

Thanks.

> 
> Cheers,
> Benjamin
> 
> >
> > I'm not sure what's the best fix for this, but below a quick
> > workaround using a deny list with DMI matching.
> > If this is OK, I can resubmit the patch for merging.
> >
> > Any comments appreciated.
> >
> >
> > thanks,
> >
> > Takashi
> >
> > -- 8< --
> > From: Takashi Iwai <tiwai@suse.de>
> > Subject: [PATCH] Input: elan_i2c: Add deny list for Lenovo Yoga Slim 7
> >
> > The touchpad on Lenovo Yoga Slim 7 doesn't work well with elan-i2c but
> > rather better with i2c-hid.  Add a deny list for avoiding to bind with
> > elan-i2c.
> >
> > BugLink: https://bugzilla.opensuse.org/show_bug.cgi?id=1193064
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >  drivers/input/mouse/elan_i2c_core.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> > index 47af62c12267..fd08481f7aea 100644
> > --- a/drivers/input/mouse/elan_i2c_core.c
> > +++ b/drivers/input/mouse/elan_i2c_core.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/acpi.h>
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> > +#include <linux/dmi.h>
> >  #include <linux/firmware.h>
> >  #include <linux/i2c.h>
> >  #include <linux/init.h>
> > @@ -1222,6 +1223,20 @@ static void elan_disable_regulator(void *_data)
> >         regulator_disable(data->vcc);
> >  }
> >
> > +static const struct dmi_system_id elan_i2c_denylist[] __initconst = {
> > +#if IS_ENABLED(CONFIG_I2C_HID_ACPI)
> > +       {
> > +               /* Lenovo Yoga Slim 7 is better supported by i2c-hid */
> > +               .matches = {
> > +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> > +                       DMI_MATCH(DMI_PRODUCT_NAME, "82A3"),
> > +                       DMI_MATCH(DMI_PRODUCT_VERSION, "Yoga Slim 7 14ITL05"),
> > +               },
> > +       },
> > +#endif
> > +       { }
> > +};
> > +
> >  static int elan_probe(struct i2c_client *client,
> >                       const struct i2c_device_id *dev_id)
> >  {
> > @@ -1233,6 +1248,10 @@ static int elan_probe(struct i2c_client *client,
> >
> >         if (IS_ENABLED(CONFIG_MOUSE_ELAN_I2C_I2C) &&
> >             i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> > +               if (dmi_check_system(elan_i2c_denylist)) {
> > +                       dev_info(dev, "Hits deny list, skipping\n");
> > +                       return -ENODEV;
> > +               }
> >                 transport_ops = &elan_i2c_ops;
> >         } else if (IS_ENABLED(CONFIG_MOUSE_ELAN_I2C_SMBUS) &&
> >                    i2c_check_functionality(client->adapter,
> > --
> > 2.31.1
> >
> >
> >
> >
> >
> >
> >
> 

-- 
Dmitry
