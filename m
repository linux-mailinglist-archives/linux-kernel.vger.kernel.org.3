Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F361850907D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354000AbiDTTdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349446AbiDTTdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:33:46 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95AF3BBF9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:30:57 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-e2442907a1so3049830fac.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xIiCDpfY7BZIAGghFoSj6HCmwvDL6jlr0Z/Ms0MR3R0=;
        b=MzcWDOfLJXWY1gU7R6uLN9tTgWJgCIPTmOVBFgypmQomMAdfqWQrQ+tCAazxJ7/ZQH
         alBWfDT4XTNGp7PZEVQFDX3JmtVRlFCJkGk1mKRBmyj1miJRPaU6qlBq0L9Su1X0oMUw
         0SlnxE7v9xuiYt8MHPByf/Xo+21xDn+XMABhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xIiCDpfY7BZIAGghFoSj6HCmwvDL6jlr0Z/Ms0MR3R0=;
        b=t7evhazWC5KSBK1QiwT4zhUe2E919x/aTMG4tMpgKNVfszW/6rXMoBMpL+Y9+ueyLy
         W2cZg5WCKwPvz4UEWmMz75HHsHnvCYc1jIYtwXIp73Qy+aTqI6OlHajBmaZrIDhDYmbH
         qNcfbJWKiaercNi/7dnfWzrRaCkN2x6muXt0kEPK7+x3/dU3p22Q9y2ColDRTH74pxrZ
         ChYRmhuffZwyI8X1PiyZmS3J3f2X6UcwRl8PMva+t+scaXfzgJPkQY3rM6Fwpm0vBOSl
         fFt8LGHZ4fFahC078uEtx/94Zp3X3OscmYTK6VzfsjDjdgI93GuX4H12NywncmjJc33A
         dlIw==
X-Gm-Message-State: AOAM533LrzCM59ALOhGz5/8gYL/JNh27UZwfx9mU8+6tIwqDa9tIavBw
        gXTNIANZ6tluIrg7CAIIynWDH1dMdmV8kA==
X-Google-Smtp-Source: ABdhPJyTo46Lew1+Dd9OUfkZpureNg6lx4OD5cjGx50MbZxDjd6ZtLOMRaPLh56ACzHtO4Q4ycLc/Q==
X-Received: by 2002:a05:6870:e754:b0:e6:706f:8323 with SMTP id t20-20020a056870e75400b000e6706f8323mr74344oak.293.1650483056665;
        Wed, 20 Apr 2022 12:30:56 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id c8-20020a4ad788000000b0031ce69b1640sm6991209oou.10.2022.04.20.12.30.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 12:30:54 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id e4so3224229oif.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:30:53 -0700 (PDT)
X-Received: by 2002:a54:4197:0:b0:322:c080:4d4c with SMTP id
 23-20020a544197000000b00322c0804d4cmr2492033oiy.241.1650483052521; Wed, 20
 Apr 2022 12:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220418210046.2060937-1-evgreen@chromium.org>
 <20220418135819.v2.1.I2c636c4decc358f5e6c27b810748904cc69beada@changeid> <Yl7KEX++hJac8T6I@rowland.harvard.edu>
In-Reply-To: <Yl7KEX++hJac8T6I@rowland.harvard.edu>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 20 Apr 2022 12:30:16 -0700
X-Gmail-Original-Message-ID: <CAE=gft7DAXo628WjdmMkogVM5th4FSaG44poZhyyG=45sCMxfA@mail.gmail.com>
Message-ID: <CAE=gft7DAXo628WjdmMkogVM5th4FSaG44poZhyyG=45sCMxfA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] USB: core: Disable remote wakeup for freeze/quiesce
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rajat Jain <rajatja@chromium.org>,
        Razvan Heghedus <heghedus.razvan@gmail.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 7:41 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, Apr 18, 2022 at 02:00:45PM -0700, Evan Green wrote:
> > The PM_EVENT_FREEZE and PM_EVENT_QUIESCE messages should cause the
> > device to stop generating interrupts. USB core was previously allowing
> > devices that were already runtime suspended to keep remote wakeup
> > enabled if they had gone down that way. This violates the contract with
> > pm, and can potentially cause MSI interrupts to be lost.
> >
> > Change that so that if a device is runtime suspended with remote wakeups
> > enabled, it will be resumed to ensure remote wakeup is always disabled
> > across a freeze.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  drivers/usb/core/driver.c | 20 +++++++++-----------
> >  1 file changed, 9 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> > index 355ed33a21792b..93c8cf66adccec 100644
> > --- a/drivers/usb/core/driver.c
> > +++ b/drivers/usb/core/driver.c
> > @@ -1533,20 +1533,18 @@ static void choose_wakeup(struct usb_device *udev, pm_message_t msg)
> >  {
> >       int     w;
> >
> > -     /* Remote wakeup is needed only when we actually go to sleep.
> > -      * For things like FREEZE and QUIESCE, if the device is already
> > -      * autosuspended then its current wakeup setting is okay.
> > +     /* For FREEZE/QUIESCE, disable remote wakeups so no interrupts get generated
> > +      * by the device.
>
> You mean "by the host controller".  USB devices don't generate
> interrupts; they generate wakeup requests (which can cause a host
> controller to generate an interrupt).

Right, I guess I mean "at the behest of the device". I could probably
just delete "by the device", since the goal of the comment is simply
to highlight that we're trying to kill interrupts, and describing
their provenance isn't as relevant.

>
> >        */
> >       if (msg.event == PM_EVENT_FREEZE || msg.event == PM_EVENT_QUIESCE) {
> > -             if (udev->state != USB_STATE_SUSPENDED)
> > -                     udev->do_remote_wakeup = 0;
> > -             return;
> > -     }
> > +             w = 0;
> >
> > -     /* Enable remote wakeup if it is allowed, even if no interface drivers
> > -      * actually want it.
> > -      */
> > -     w = device_may_wakeup(&udev->dev);
> > +     } else {
> > +             /* Enable remote wakeup if it is allowed, even if no interface drivers
> > +              * actually want it.
> > +              */
> > +             w = device_may_wakeup(&udev->dev);
> > +     }
> >
> >       /* If the device is autosuspended with the wrong wakeup setting,
> >        * autoresume now so the setting can be changed.
> > --
>
> I would prefer it if you reformatted the comments to agree with the
> current style:
>
>         /*
>          * Blah blah blah
>          */
>
> and to avoid line wrap beyond 80 columns.  Apart from that:

Sure, I can fix these up, add your tags, and repost.

>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thanks!

>
> Alan Stern
