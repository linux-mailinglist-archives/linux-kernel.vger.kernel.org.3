Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A34E4AEAA1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 07:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbiBIGw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 01:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbiBIGwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:52:18 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD2CC05CB81;
        Tue,  8 Feb 2022 22:52:21 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id on2so1312142pjb.4;
        Tue, 08 Feb 2022 22:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L7LK0FZV1hlAedFNQIte/FdywZl+jO7aEMMglnK0twM=;
        b=Qc6QFCgDie/Q4l0LuzIvTrMvzxE3gdLvNSGTlOOvGXqR8y9gtdFLueFRIkZq/jGSfL
         9H0E8E1BvMjOtXOBt4bwQWNhkXA4ePo5FGzIBZoqE6x/2JwiJgt7PTdzjWzpBIZN1HHs
         qIdjcy1sOVST6UA/P9t1Swd1vWTgwbbdOIrw4IEpRmqTScM1oFiKm2c1/AZwfxUJaCNL
         LLtxjyNOgMuUNoZKVY8+v/8Ds1FKq7XWT+guBCbyhPoaOu3KlGu/TL83l9G4MhS13jiD
         E/d+vydQYS00bZZVGhA5Yv0SS3lE+yv7uOkvuRRLSuMdSBx3OozzgFHQ94BVXMnmw4lI
         0MnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L7LK0FZV1hlAedFNQIte/FdywZl+jO7aEMMglnK0twM=;
        b=B5Z9qBkA5X/bCMt+20o5frY3fKTfkHY1DffBM4zy93E2N8MXyFY+kI0+uG6LV6G1tX
         3w1PCn7x05SM5rXr93Dbvu8DIcklOBQc7fehVIi8uPpFB6cABFAwKEykc/zPol11X5ne
         XM+DJbA3gZnNBKYdHl+NEh/ICae6ov3tm8GnHoqKvIj+FWZlijlGs5ws2mwWh0luIP0M
         9F8QEgQCBfRPWmfJVYR/B3LDqvEi/98lTJ7SuD8c+UmNlHDN+I9MNHqddYhPwdRhKiWg
         kDwPoJf/n/Yp9iK0ZmqdV5Y/GZ6+8ATGwYwQgh22JDsQQCqzdR2wzdKBtkL3nx94JQg8
         LadA==
X-Gm-Message-State: AOAM5327zA4XrqRV6+J/yKyTpEqTCCzIP3dqQwSV8CRA+0YdokSItXao
        ufaLoQUUb5fll7EFASAXFV8=
X-Google-Smtp-Source: ABdhPJwgESx+doT2n7dE17l9KVTunAqiMHZW0+ywND1QJHJqrQNKDzawC39nESR5orBsZc+PdStbmg==
X-Received: by 2002:a17:90b:180f:: with SMTP id lw15mr1000775pjb.90.1644389540791;
        Tue, 08 Feb 2022 22:52:20 -0800 (PST)
Received: from google.com ([2620:15c:202:201:3a7a:5580:400f:1e51])
        by smtp.gmail.com with ESMTPSA id h25sm16886466pfn.208.2022.02.08.22.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 22:52:19 -0800 (PST)
Date:   Tue, 8 Feb 2022 22:52:17 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     julian schroeder <julianmarcusschroeder@gmail.com>,
        bhanumaiya@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] fix serdev bind/unbind
Message-ID: <YgNkoegU7/NoAE6v@google.com>
References: <20220118194857.26546-1-julianmarcusschroeder@gmail.com>
 <CAL_JsqJ4MqMYNiKNF_3rkbnR0CE9GhV-jzbxKn2jeJBvPGibLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ4MqMYNiKNF_3rkbnR0CE9GhV-jzbxKn2jeJBvPGibLA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ resending as I managed to lose folks from CC list ]

Hi Rob,

On Fri, Jan 21, 2022 at 11:51 AM Rob Herring <robh@kernel.org> wrote:
>
> +Johan
>
> On Tue, Jan 18, 2022 at 1:47 PM julian schroeder
> <julianmarcusschroeder@gmail.com> wrote:
> >
> > On some chromebooks, the serdev is used to communicate with
> > an embedded controller. When the controller is updated, the
> > regular ttyS* is needed. Therefore unbind/bind needs to work
> > to be able to switch between the two modes without having to
> > reboot. In the case of ACPI enabled platforms, the underlying
> > serial device is marked as enumerated but this is not cleared
> > upon remove (unbind). In this state it can not be bound as
> > serdev.
>
> 'fix' implies this was supposed to work and doesn't, but unbind/bind
> was never a feature of serdev. Or more specifically, switching between
> serdev and tty was not a feature. There have been some attempts to add
> that. I suspect it is more than a 4 line change based on those, but
> maybe I'm wrong.
>
> For your usecase, how does a given piece of h/w that needs and/or
> provides kernel support continue to work when the driver is unbound.
> Are you leaving any power controls that the serdev driver configured
> enabled so that the tty happens to keep working? What happens to

Because we are dealing with EC it stays powered up even when main CPU
is powered down, so for the core EC there are no concerns with power
management in the absence of a [dedicated] driver.

> interfaces the EC provides? The kernel doesn't deal with resources
> going away too well. I have to wonder if the existing serdev EC driver
> should learn to handle the 'update mode' itself or provide some sort
> of raw/passthru mode to userspace. A TTY, while standard, brings a lot
> of complexities.

I think these are all very good questions and from what I see in
drivers/platform/chrome/cros_ec_uart.c we will simply yank services
that the EC provides while it is being updated (which is quite
reasonable behavior as we can not be sure what configuration we will end
up with once firmware is updated, so new discovery of interfaces and
their characteristics is needed and is prudent). So from the outside a
dedicated update mode or attempting to switch to using tty interface
would look pretty similar.

That said, we can forget about EC and switching from serdev to tty here
and concentrate on the simple fact that for serdev a simple bind/unbind
sequence is not working, and that is a basic functionality for pretty
much every bus that we have in the kernel and the patch does address
this deficiency.

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

>
> > Signed-off-by: julian schroeder <julianmarcusschroeder@gmail.com>
> > ---
> >  drivers/tty/serdev/core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> > index 92e3433276f8..668fa570bc07 100644
> > --- a/drivers/tty/serdev/core.c
> > +++ b/drivers/tty/serdev/core.c
> > @@ -138,7 +138,11 @@ EXPORT_SYMBOL_GPL(serdev_device_add);
> >  void serdev_device_remove(struct serdev_device *serdev)
> >  {
> >         struct serdev_controller *ctrl = serdev->ctrl;
> > +       struct acpi_device *adev;
> >
> > +       adev = ACPI_COMPANION(&serdev->dev);
> > +       if (adev)
> > +               acpi_device_clear_enumerated(adev);
> >         device_unregister(&serdev->dev);
> >         ctrl->serdev = NULL;
> >  }
> > --
> > 2.20.1
> >

Thanks.

-- 
Dmitry
