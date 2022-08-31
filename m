Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C214D5A8559
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiHaSSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiHaSRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:17:50 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A76EF32C0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:14:15 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f4so11463282qkl.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=J57R+POjwarkhG0ohhPSH5aFm2b5W+GSzqYH/OtjluE=;
        b=coq0jRegFak07tL9CfIRw4qNyOsmTDdAeVhAFqpTTL9xu73mkSXYqMAd+h0jjTLInR
         YODQQ0l2SqeQrlpzTx49Z8yMSslvrqdOT3yyTgiPhTkvq/50a7Kr1TM3nT7Nz/KzlAUe
         JQ8RoQha7mg7lJPcdNXGfesGbfZZ6bYAZUF9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=J57R+POjwarkhG0ohhPSH5aFm2b5W+GSzqYH/OtjluE=;
        b=B/Y95xvrNS5lzEooD8nwmUKjyukqg25Zc3G3uDdyWd640b5X1CUYE7vQVcA9L50xrh
         yPrrS+5ggga2bq/drn/zbgtBwa0mxLkuNZiCPKwu0X2suVon7RN+bsxjcvEy4lw4hvaX
         /Pc4fjdijuOOhnv7bTQaGIJoECs7LiGy+NfRumJT+t9U7hHs6cTM9L3WgtUfCDF7rV9j
         wQkszu0JnHLh1+W86rAO+EexeSpZdw5xXp6KGUXmLISLVBrs+GgqqgB4r5EcRWNLHtBK
         twBnh/oICHVyTg5a+S4rMMFt4JtM11fzVEB53QgNROydbpybmHm+7KqqOQB2JhFmklnM
         +qiA==
X-Gm-Message-State: ACgBeo2Qa4jDOn0/b/fOaoDPnD1gdkXJLFVraK4Uk8gXMCxWT1kf4H6t
        ryyDA7chh9ENK0SWa5KF5bJjzUQ5esQzOg==
X-Google-Smtp-Source: AA6agR6pTE5GlZBKozvk3V08HA/HcxZ7l9V5Rbitq5ipHWqpEU7ylsiMUxLMpUacqjVaKRQCOB0jQw==
X-Received: by 2002:a37:c96:0:b0:6bc:15eb:351a with SMTP id 144-20020a370c96000000b006bc15eb351amr16427702qkm.473.1661969640448;
        Wed, 31 Aug 2022 11:14:00 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id u3-20020a37ab03000000b006bc68cfcdf7sm10050237qke.13.2022.08.31.11.13.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 11:13:58 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id y18so11635491qtv.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:13:57 -0700 (PDT)
X-Received: by 2002:ac8:5fd6:0:b0:343:4b4:1022 with SMTP id
 k22-20020ac85fd6000000b0034304b41022mr20415702qta.616.1661969637250; Wed, 31
 Aug 2022 11:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220830231541.1135813-1-rrangel@chromium.org>
 <20220830171332.1.Id022caf53d01112188308520915798f08a33cd3e@changeid> <CAJZ5v0h10wrurjYG50dA+pCfRtNDqN=c8odQ0p6HJRnOyJh7KA@mail.gmail.com>
In-Reply-To: <CAJZ5v0h10wrurjYG50dA+pCfRtNDqN=c8odQ0p6HJRnOyJh7KA@mail.gmail.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 31 Aug 2022 12:13:46 -0600
X-Gmail-Original-Message-ID: <CAHQZ30BTYEYEAGjwsbuiYuYGhpFtQy_AEP66v3trdTzY_DRUOQ@mail.gmail.com>
Message-ID: <CAHQZ30BTYEYEAGjwsbuiYuYGhpFtQy_AEP66v3trdTzY_DRUOQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] Input: elan_i2c - Use PM subsystem to manage wake irq
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 12:01 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Aug 31, 2022 at 1:16 AM Raul E Rangel <rrangel@chromium.org> wrote:
> >
> > The Elan I2C touchpad driver is currently manually managing the wake
> > IRQ. This change removes the explicit enable_irq_wake/disable_irq_wake
> > and instead relies on the PM subsystem. This is done by calling
> > dev_pm_set_wake_irq.
> >
> > i2c_device_probe already calls dev_pm_set_wake_irq when using device
> > tree, so it's only required when using ACPI. The net result is that this
> > change should be a no-op. i2c_device_remove also already calls
> > dev_pm_clear_wake_irq, so we don't need to do that in this driver.
> >
> > I tested this on an ACPI system where the touchpad doesn't have _PRW
> > defined. I verified I can still wake the system and that the wake source
> > was the touchpad IRQ GPIO.
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
>


> I like this a lot, but the assumption in the wakeirq code is that the
> IRQ in question will be dedicated for signaling wakeup.  Does it hold
> here?

The wakeirq code defines two methods: `dev_pm_set_wake_irq` and
`dev_pm_set_dedicated_wake_irq`.
The latter is used when you have a dedicated wakeup signal. In this
driver it's currently assumed
that the IRQ and the wake IRQ are the same, so I used `dev_pm_set_wake_irq`.

This change in theory also fixes a bug where you define a dedicated
wake irq in DT, but
then the driver enables the `client->irq` as a wake source. In
practice this doesn't happen
since the elan touchpads only have a single IRQ line.

>
> > ---
> >
> >  drivers/input/mouse/elan_i2c_core.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> > index e1758d5ffe4218..7d997d2b56436b 100644
> > --- a/drivers/input/mouse/elan_i2c_core.c
> > +++ b/drivers/input/mouse/elan_i2c_core.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/jiffies.h>
> >  #include <linux/completion.h>
> >  #include <linux/of.h>
> > +#include <linux/pm_wakeirq.h>
> >  #include <linux/property.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <asm/unaligned.h>
> > @@ -86,8 +87,6 @@ struct elan_tp_data {
> >         u16                     fw_page_size;
> >         u32                     fw_signature_address;
> >
> > -       bool                    irq_wake;
> > -
> >         u8                      min_baseline;
> >         u8                      max_baseline;
> >         bool                    baseline_ready;
> > @@ -1337,8 +1336,10 @@ static int elan_probe(struct i2c_client *client,
> >          * Systems using device tree should set up wakeup via DTS,
> >          * the rest will configure device as wakeup source by default.
> >          */
> > -       if (!dev->of_node)
> > +       if (!dev->of_node) {
> >                 device_init_wakeup(dev, true);
> > +               dev_pm_set_wake_irq(dev, client->irq);
> > +       }
> >
> >         return 0;
> >  }
> > @@ -1362,8 +1363,6 @@ static int __maybe_unused elan_suspend(struct device *dev)
> >
> >         if (device_may_wakeup(dev)) {
> >                 ret = elan_sleep(data);
> > -               /* Enable wake from IRQ */
> > -               data->irq_wake = (enable_irq_wake(client->irq) == 0);
> >         } else {
> >                 ret = elan_set_power(data, false);
> >                 if (ret)
> > @@ -1394,9 +1393,6 @@ static int __maybe_unused elan_resume(struct device *dev)
> >                         dev_err(dev, "error %d enabling regulator\n", error);
> >                         goto err;
> >                 }
> > -       } else if (data->irq_wake) {
> > -               disable_irq_wake(client->irq);
> > -               data->irq_wake = false;
> >         }
> >
> >         error = elan_set_power(data, true);
> > --
> > 2.37.2.672.g94769d06f0-goog
> >
