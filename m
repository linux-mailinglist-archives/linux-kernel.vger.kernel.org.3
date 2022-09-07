Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323F25AF99D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiIGCAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiIGCAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:00:16 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F665E559
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 19:00:14 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id 62so10425568iov.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 19:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=oprxcvCb9CdLXhIUoy3hm/HtEdsMeBacxGAfAMDDRL0=;
        b=npkTyul2G4yNCuUVgp7j1Sg8a1hqGBkGFDB8hs5wUUuWEnFmKAj1KKo1LUDW8EwcPW
         3zmz/Rrcno0o9THvrcv63K85C1mh2ZDQNDVoPHwi/j4gRv3EovOqwJPHFn0iVRJb332W
         D1cyySUMttqLsnPjPLMjHIq02d5OE5Bi8xfqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oprxcvCb9CdLXhIUoy3hm/HtEdsMeBacxGAfAMDDRL0=;
        b=PVBAODaPSh+WEiDwNcrVExZw8bQwK4f+s4OwwgkUw4DRymvO4iHGwyilnKAz+QekeQ
         LQUl7G1V4Z6EXqF6mnFP8ccGYQzRg8r/ZKsdCRkv/VhDJVnJr1OBfpHvffiILT/jSxOF
         eFYXn7tHucE0QWMzRDQF3EPwYmagpaJ3D1mjNyTJHSj4xRrlz3YJwe5YtapKOX1rq5qc
         V33qehCJPCzZgFhUjuknv8c1W8ygylWtNdJgAor78XjBWv5vaCFX3cZAQwk/mCAZZv8e
         ZVXrNjpTvInKr1ulkJIEJIyvWpBZD1GqcLNZ6btdVf0Oirl7Z0vfYCLqsFBABvhoPL3Z
         +jcg==
X-Gm-Message-State: ACgBeo1gBTG2Y87obX+gVu0+y3iHpMHxHs1HSnIDXdcg1a5atUca1ft1
        qsH5Fxi+wGyzVTDvZpSc9OFB1s6nhmql4g==
X-Google-Smtp-Source: AA6agR7UynIuiBAmegdE0x07R3cYiPlDpMWKSJa+tGH1MiAiAOgOAC4pncwKubPaYd8vI4NT07Ae3A==
X-Received: by 2002:a05:6638:349e:b0:346:ec62:5851 with SMTP id t30-20020a056638349e00b00346ec625851mr761915jal.157.1662516013968;
        Tue, 06 Sep 2022 19:00:13 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id w3-20020a92d603000000b002f1d2a4c7e9sm1136405ilm.79.2022.09.06.19.00.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 19:00:12 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id d68so10388911iof.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 19:00:11 -0700 (PDT)
X-Received: by 2002:a02:cb5b:0:b0:341:aebb:d13 with SMTP id
 k27-20020a02cb5b000000b00341aebb0d13mr848269jap.176.1662516011322; Tue, 06
 Sep 2022 19:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220830231541.1135813-1-rrangel@chromium.org>
 <20220830171332.4.I8af4282adc72eb9f247adcd03676a43893a020a6@changeid> <YxftNQrRx3fwsobk@google.com>
In-Reply-To: <YxftNQrRx3fwsobk@google.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Tue, 6 Sep 2022 20:00:00 -0600
X-Gmail-Original-Message-ID: <CAHQZ30DPmn1hN+xfck7CgOGLcze0jtHxxWnq7yVVL0Q_DzG6UQ@mail.gmail.com>
Message-ID: <CAHQZ30DPmn1hN+xfck7CgOGLcze0jtHxxWnq7yVVL0Q_DzG6UQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] i2c: acpi: Use ACPI GPIO wake capability bit to set wake_irq
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>,
        "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Tue, Sep 6, 2022 at 7:00 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Tue, Aug 30, 2022 at 05:15:37PM -0600, Raul E Rangel wrote:
> > Device tree already has a mechanism to pass the wake_irq. It does this
> > by looking for the wakeup-source property and setting the
> > I2C_CLIENT_WAKE flag. This CL adds the ACPI equivalent. It uses at the
> > ACPI GpioInt wake flag to determine if the interrupt can be used to wake
> > the system. Previously the i2c drivers had to make assumptions and
> > blindly enable the wake IRQ. This can cause spurious wake events. e.g.,
> > If there is a device with an Active Low interrupt and the device gets
> > powered off while suspending, the interrupt line will go low since it's
> > no longer powered and wake the system. For this reason we should respect
> > the board designers wishes and honor the wake bit defined on the
> > GpioInt.
> >
> > This change does not cover the ACPI Interrupt or IRQ resources.
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > ---
> >
> >  drivers/i2c/i2c-core-acpi.c |  8 ++++++--
> >  drivers/i2c/i2c-core-base.c | 17 +++++++++++------
> >  drivers/i2c/i2c-core.h      |  4 ++--
> >  3 files changed, 19 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> > index c762a879c4cc6b..cfe82a6ba3ef28 100644
> > --- a/drivers/i2c/i2c-core-acpi.c
> > +++ b/drivers/i2c/i2c-core-acpi.c
> > @@ -182,12 +182,13 @@ static int i2c_acpi_add_resource(struct acpi_resource *ares, void *data)
> >  /**
> >   * i2c_acpi_get_irq - get device IRQ number from ACPI
> >   * @client: Pointer to the I2C client device
> > + * @wake_capable: Set to 1 if the IRQ is wake capable
> >   *
> >   * Find the IRQ number used by a specific client device.
> >   *
> >   * Return: The IRQ number or an error code.
> >   */
> > -int i2c_acpi_get_irq(struct i2c_client *client)
> > +int i2c_acpi_get_irq(struct i2c_client *client, int *wake_capable)
> >  {
> >       struct acpi_device *adev = ACPI_COMPANION(&client->dev);
> >       struct list_head resource_list;
> > @@ -196,6 +197,9 @@ int i2c_acpi_get_irq(struct i2c_client *client)
> >
> >       INIT_LIST_HEAD(&resource_list);
> >
> > +     if (wake_capable)
> > +             *wake_capable = 0;
> > +
> >       ret = acpi_dev_get_resources(adev, &resource_list,
> >                                    i2c_acpi_add_resource, &irq);
>


> You also need to handle "Interrupt(..., ...AndWake)" case here. I would
> look into maybe defining
>
> #define IORESOURCE_IRQ_WAKECAPABLE      (1<<6)
>
> in include/linux/ioport.h and plumbing it through from ACPI layer.
>
> Thanks.

AFAIK the Intel (Not 100% certain) and AMD IO-APIC's can't actually
wake a system from suspend/suspend-to-idle. It requires either a GPE
or GPIO controller to wake the system. This is the reason I haven't
pushed patches to handle the Interrupt/IRQ resource. Can anyone
confirm?

Thanks

>
> --
> Dmitry
