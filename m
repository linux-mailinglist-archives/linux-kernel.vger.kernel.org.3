Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DEA5A85EC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiHaSne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiHaSnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:43:05 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD25260C6;
        Wed, 31 Aug 2022 11:42:48 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 193so5453713ybc.10;
        Wed, 31 Aug 2022 11:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xzoGBbwJ3ZwrByKi856TIQu0OrENwqVUhnhirrGF5H4=;
        b=LfVse99iLmoMvSxqMbl686kNuMq/rDAS4UUXmVTpzLNJAYy/J2GDCWAbnPlmPiXp0t
         lbgeLK9j2DfpHqa4nSBzy5guSEiYoJEZAf2bSAIB1HlPrVeOeHYo2N2Y+wbVcy85+n4s
         wJ4MwfYHziTGAE8MJUTasRZfQ06LXtZ3yOXSe78l3qgFXym7G0JhHiTuUaamwmF1I7O+
         /dfHFN4kkTP/VXUXs46WGMli3WPxGp9HTGfa8Dz729bOpIIQBSPgpyCWdL5rEF7q6g+O
         SbLts6MNZwa+741fvM5wV0ZdL35BIWnVwFUkoS2Kr07pfUQ5m+66ACbsBJQMOxbJBL76
         x5hA==
X-Gm-Message-State: ACgBeo1NtiC3ZoxlxBLLdhCOuC8arwEDgVLcHAqXD/7L97oqV9yh9E3u
        0p+jbKE/y5S7OF+zVNGfkMESkJCnY74DDjTYPyY=
X-Google-Smtp-Source: AA6agR5JV1SYkvRX2LsVp9PLMmZQmg2hGokpEhZ7ZDChQbEa3WUq26eyLEcZjnDVTue2K3C+snPMP2110a5dT5nsZjY=
X-Received: by 2002:a25:2785:0:b0:69b:b1d2:fd05 with SMTP id
 n127-20020a252785000000b0069bb1d2fd05mr12156875ybn.81.1661971367951; Wed, 31
 Aug 2022 11:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220830231541.1135813-1-rrangel@chromium.org>
 <20220830171332.1.Id022caf53d01112188308520915798f08a33cd3e@changeid>
 <CAJZ5v0h10wrurjYG50dA+pCfRtNDqN=c8odQ0p6HJRnOyJh7KA@mail.gmail.com> <CAHQZ30BTYEYEAGjwsbuiYuYGhpFtQy_AEP66v3trdTzY_DRUOQ@mail.gmail.com>
In-Reply-To: <CAHQZ30BTYEYEAGjwsbuiYuYGhpFtQy_AEP66v3trdTzY_DRUOQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 31 Aug 2022 20:42:36 +0200
Message-ID: <CAJZ5v0gS6U6v-CEPNhgoj=f5E3q1T_Z8vOe2qokyHw4qeVhTsQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] Input: elan_i2c - Use PM subsystem to manage wake irq
To:     Raul Rangel <rrangel@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 8:14 PM Raul Rangel <rrangel@chromium.org> wrote:
>
> On Wed, Aug 31, 2022 at 12:01 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Aug 31, 2022 at 1:16 AM Raul E Rangel <rrangel@chromium.org> wrote:
> > >
> > > The Elan I2C touchpad driver is currently manually managing the wake
> > > IRQ. This change removes the explicit enable_irq_wake/disable_irq_wake
> > > and instead relies on the PM subsystem. This is done by calling
> > > dev_pm_set_wake_irq.
> > >
> > > i2c_device_probe already calls dev_pm_set_wake_irq when using device
> > > tree, so it's only required when using ACPI. The net result is that this
> > > change should be a no-op. i2c_device_remove also already calls
> > > dev_pm_clear_wake_irq, so we don't need to do that in this driver.
> > >
> > > I tested this on an ACPI system where the touchpad doesn't have _PRW
> > > defined. I verified I can still wake the system and that the wake source
> > > was the touchpad IRQ GPIO.
> > >
> > > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> >
>
>
> > I like this a lot, but the assumption in the wakeirq code is that the
> > IRQ in question will be dedicated for signaling wakeup.  Does it hold
> > here?
>
> The wakeirq code defines two methods: `dev_pm_set_wake_irq` and
> `dev_pm_set_dedicated_wake_irq`.
> The latter is used when you have a dedicated wakeup signal. In this
> driver it's currently assumed
> that the IRQ and the wake IRQ are the same, so I used `dev_pm_set_wake_irq`.
>
> This change in theory also fixes a bug where you define a dedicated
> wake irq in DT, but
> then the driver enables the `client->irq` as a wake source. In
> practice this doesn't happen
> since the elan touchpads only have a single IRQ line.

OK, thanks!

Please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to the patch.

> >
> > > ---
> > >
> > >  drivers/input/mouse/elan_i2c_core.c | 12 ++++--------
> > >  1 file changed, 4 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> > > index e1758d5ffe4218..7d997d2b56436b 100644
> > > --- a/drivers/input/mouse/elan_i2c_core.c
> > > +++ b/drivers/input/mouse/elan_i2c_core.c
> > > @@ -33,6 +33,7 @@
> > >  #include <linux/jiffies.h>
> > >  #include <linux/completion.h>
> > >  #include <linux/of.h>
> > > +#include <linux/pm_wakeirq.h>
> > >  #include <linux/property.h>
> > >  #include <linux/regulator/consumer.h>
> > >  #include <asm/unaligned.h>
> > > @@ -86,8 +87,6 @@ struct elan_tp_data {
> > >         u16                     fw_page_size;
> > >         u32                     fw_signature_address;
> > >
> > > -       bool                    irq_wake;
> > > -
> > >         u8                      min_baseline;
> > >         u8                      max_baseline;
> > >         bool                    baseline_ready;
> > > @@ -1337,8 +1336,10 @@ static int elan_probe(struct i2c_client *client,
> > >          * Systems using device tree should set up wakeup via DTS,
> > >          * the rest will configure device as wakeup source by default.
> > >          */
> > > -       if (!dev->of_node)
> > > +       if (!dev->of_node) {
> > >                 device_init_wakeup(dev, true);
> > > +               dev_pm_set_wake_irq(dev, client->irq);
> > > +       }
> > >
> > >         return 0;
> > >  }
> > > @@ -1362,8 +1363,6 @@ static int __maybe_unused elan_suspend(struct device *dev)
> > >
> > >         if (device_may_wakeup(dev)) {
> > >                 ret = elan_sleep(data);
> > > -               /* Enable wake from IRQ */
> > > -               data->irq_wake = (enable_irq_wake(client->irq) == 0);
> > >         } else {
> > >                 ret = elan_set_power(data, false);
> > >                 if (ret)
> > > @@ -1394,9 +1393,6 @@ static int __maybe_unused elan_resume(struct device *dev)
> > >                         dev_err(dev, "error %d enabling regulator\n", error);
> > >                         goto err;
> > >                 }
> > > -       } else if (data->irq_wake) {
> > > -               disable_irq_wake(client->irq);
> > > -               data->irq_wake = false;
> > >         }
> > >
> > >         error = elan_set_power(data, true);
> > > --
> > > 2.37.2.672.g94769d06f0-goog
> > >
