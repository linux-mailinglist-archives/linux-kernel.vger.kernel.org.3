Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702A650EAB4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245595AbiDYUl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbiDYUlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:41:24 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADCD3A5F8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:38:20 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2f7ca2ce255so62365887b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EKOHrVYni9xvs7+L4Ks12r0VkZa5fal1q0hxrC8iDII=;
        b=pI5SEWzs2KSeo7OJ9BaxRVNP6bzCJc0A52cY3RfMiztkV4JnDSd8lOMVKL+/QxdhgW
         VQZ9Ur7YmuEVpRX2Qr9v5aoG6SzgNBVEpyquqONdmSZeK0bapSmJhDaeHxg/58e9Xyre
         949ELWpDNA1uFOf3EVrO+2AZcb/7+stGJkRZWvVkHyiw8EJJv4PWhZvchdZUh4lxwxsT
         xz6j6jQwiXki8wfOWBuPDst5Mp2p6NTKC9jNSSMKBBiIBjeZNAzM7f5OQ0HrbMW3RdSV
         gr8L5rDU+mceJ9rUgYT46TYSTJr1LPcCc2FFf9vNdlGvE/t7kYZI0QvCANVEia6AvJB5
         4b9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EKOHrVYni9xvs7+L4Ks12r0VkZa5fal1q0hxrC8iDII=;
        b=V+2/+HAysb1Zy94Pu6MCfN1ZwtngggHDPtUBTjHrBDXj16/D1DVW0bg7q4UQObEI5U
         sPlE5dkR+v/aREFsT7pzRAy4ZfcX903x6ssUQ+EOd9DjAnQpeuOMJebFnq+psO4XH0Or
         X3Mt68yMpGxFnDeKUa6bGgfjJ53AqUygETiCiWsJ4o2Die7ssLkvEQ9WzcMD1a5FkYjM
         gzTEaAjL0kBOyieN//d+n56QTgiMNFCxKijkecnacVSJbOcHJAdW2C8AA7mSZb4F7F9S
         wxJfYaA15jA7zxQSSqjmiQ1aohLIay4nm8wgYbd9++MEGNf7Ne5vM6UFxrbzgGABExiX
         G8kg==
X-Gm-Message-State: AOAM532R97nj+OTDMWUTm3nacaHQ9YdLeNkNFTOANDyJQNXifby7czet
        fYkU22OnA27OnoI3swc1Wpdq4mqvMJ/VuVHl6oe4YQ==
X-Google-Smtp-Source: ABdhPJx0cRFmnkcRXSnlvAH/s+i67gX4XqlpKmn/ICwjou3ZKFFzhb03fJf+2j/zJFPnDYmeW16iPtutIvSdQow5dNg=
X-Received: by 2002:a81:2108:0:b0:2f5:6938:b2b8 with SMTP id
 h8-20020a812108000000b002f56938b2b8mr17509528ywh.151.1650919099262; Mon, 25
 Apr 2022 13:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220421192132.109954-1-nick.hawkins@hpe.com> <20220421192132.109954-5-nick.hawkins@hpe.com>
 <CAK8P3a0nQ1BrtfBJ7sUSaLkA=pbVwx83bEUpZczvLOSOHDR=dw@mail.gmail.com>
In-Reply-To: <CAK8P3a0nQ1BrtfBJ7sUSaLkA=pbVwx83bEUpZczvLOSOHDR=dw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Apr 2022 22:38:08 +0200
Message-ID: <CACRpkdbJ1N7VOgoBzGS+cOaErFcYiOVDeWRmhPyHA7=9W0CGhA@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] clocksource/drivers: Add HPE GXP timer
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 3:16 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Apr 21, 2022 at 9:21 PM <nick.hawkins@hpe.com> wrote:
>
> > +
> > +static struct platform_device gxp_watchdog_device = {
> > +       .name = "gxp-wdt",
> > +       .id = -1,
> > +};
> > +/*
> > + * This probe gets called after the timer is already up and running. This will create
> > + * the watchdog device as a child since the registers are shared.
> > + */
> > +
> > +static int gxp_timer_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +
> > +       /* Pass the base address (counter) as platform data and nothing else */
> > +       gxp_watchdog_device.dev.platform_data = local_gxp_timer->counter;
> > +       gxp_watchdog_device.dev.parent = dev;
> > +       return platform_device_register(&gxp_watchdog_device);
> > +}
>
> I don't understand what this is about: the device should be created from
> DT, not defined statically in the code. There are multiple ways of creating
> a platform_device from a DT node, or you can allocate one here, but static
> definitions are generally a mistake.
>
> I see that you copied this from the ixp4xx driver, so I think we should fix this
> there as well.

The ixp4xx driver looks like that because the register range used for
the timer and the watchdog is combined, i.e. it is a single IP block:

                timer@c8005000 {
                        compatible = "intel,ixp4xx-timer";
                        reg = <0xc8005000 0x100>;
                        interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
                };

Device tree probing does not allow two devices to probe from the same
DT node, so this was solved by letting the (less important) watchdog
be spawn as a platform device from the timer.

I don't know if double-probing for the same register range can be fixed,
but I was assuming that the one-compatible-to-one-driver assumption
was pretty hard-coded into the abstractions. Maybe it isn't?

Another way is of course to introduce an MFD. That becomes
problematic in another way: MFD abstractions are supposed to
be inbetween the resource and the devices it spawns, and with
timers/clocksources this creates a horrible special-casing since the
MFD bus (the parent may be providing e.g. an MMIO regmap)
then need to be early-populated and searched by the timer core
from TIMER_OF_DECLARE() early in boot.

So this solution was the lesser evil that I could think about.

Yours,
Linus Walleij
