Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836F6563086
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbiGAJq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbiGAJqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:46:55 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A8574DE3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:46:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b2so1952030pfb.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 02:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qGsuHiSRBF4a+hfC8xkVsaq/Jhcsln30Zs+0/bYcwWc=;
        b=QwkjhKN0KRNaB6TgWgBlM3rqneD5wB2CM7lgUbfLLHxFsdVnDRYvRIrg5SJO8yioa2
         cnLYTnzSwWqoc4FMz8Mvi6TbeXMMAGoDdguhBdB7hKOAmJVkQXO2wH5Irfips4otrPx0
         DO8mJ4rzZLw3apiQKVGl8H4bCA1Fo2Qdn2cl5/WSkjF3/SrFjwKBvANUA7EqPGdjAeei
         dhKeiD0o26SHCaIVANIXpjXzMV2ehsaRDLVLhq0wGyUYBdRy3BOrn6qWMObru/o+Dj5c
         CJrkjW879KBSJxEHQecMgbOHnGxzTgKTko5nIQzGzE/NGkbyd2VXJhJp6dABRH4tvE/+
         W9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qGsuHiSRBF4a+hfC8xkVsaq/Jhcsln30Zs+0/bYcwWc=;
        b=eBAjuIvyAKDAvL4mp16GQhyNCPORfsU9VEhVK6IJ8Mg96RJzZVvUpxZXAtIbvoLCdb
         fCYZiryYexhw8IDFGtK3KDyeKk1iZGW5Ornl9Cr0xhLhk0QH0qC7y8tdZzbMvQ0AyZvT
         l/zzKVKxAQ/FoOLVJ7D+z4mJeOU4eouJk1x2sRQu2onfFJgukOiTU8qKoip5kfS+ybRA
         Hl7CB8RvQ6eIE7/1Pxst7byH6DJPss6wMIkF4uQmBPls9f8/p2yzR4NImOoDNK1rMLQI
         jkKwo/iIK/AKN0A+Qqn2eK+m9rtnyTpjWACMZd8SPYeynevPsbCDpON9wcZftQfN/v8t
         +jsg==
X-Gm-Message-State: AJIora//d8hyVNbr9bHkTneb0uQJrAKoj6UJEblO/Hg6uIRIoJR6eUI1
        VrFNlgvfwIGCxaz2UNETJaKLhKFpGkyRl0dWf4zrqg==
X-Google-Smtp-Source: AGRyM1s6gj/T58f7mZSrb22X1jVZ/vnu19A/gAhnZ+Elqly+bgycKGBHCzEGm6PCza4In6ZLJozLLEAiuTong+Fo6Do=
X-Received: by 2002:a62:1589:0:b0:527:ffe7:168e with SMTP id
 131-20020a621589000000b00527ffe7168emr11498825pfv.48.1656668814394; Fri, 01
 Jul 2022 02:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220617102256.3253019-1-raychi@google.com> <YrFxLYibDtyuxSO6@kroah.com>
In-Reply-To: <YrFxLYibDtyuxSO6@kroah.com>
From:   Ray Chi <raychi@google.com>
Date:   Fri, 1 Jul 2022 17:46:42 +0800
Message-ID: <CAPBYUsBbP7ssGXSRyWN46u1-Qaa712QLm748FhJ-M3pANZUsng@mail.gmail.com>
Subject: Re: [PATCH] USB: hub: add module parameters to usbcore for port init retries
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Albert Wang <albertccwang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 3:20 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jun 17, 2022 at 06:22:56PM +0800, Ray Chi wrote:
> > Currently, there is a Kconfig (CONFIG_USB_FEW_INIT_RETRIES) to
> > reduce retries when the port initialization is failed. The retry
> > times are fixed and assigned in compile time. To improve the
> > flexibility, this patch add four module parameters:
> > port_reset_tries, set_address_tries, get_descriptor_tries,
> > and get_maxpacket0_tries, to replace the original default values.
> >
> > The default value of module parameters is the same as before
> > to preserve the existing behavior.
> >
> > Signed-off-by: Ray Chi <raychi@google.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         | 16 ++++++++++
> >  drivers/usb/core/hub.c                        | 31 ++++++++++++++++---
> >  2 files changed, 42 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 8090130b544b..c467b2778128 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6277,6 +6277,22 @@
> >                       USB_REQ_GET_DESCRIPTOR request in milliseconds
> >                       (default 5000 = 5.0 seconds).
> >
> > +     usbcore.port_reset_tries=
> > +                     [USB] Set the retry time of port reset for each
> > +                     port initialization (default PORT_RESET_TRIES = 5).
> > +
> > +     usbcore.set_address_tries=
> > +                     [USB] set the retry time of set address for each
> > +                     port initialization (default SET_ADDRESS_TRIES = 2).
> > +
> > +     usbcore.get_descriptor_tries=
> > +                     [USB] set the retry time of set address for each
> > +                     port initialization (default GET_DESCRIPTOR_TRIES = 2).
> > +
> > +     usbcore.get_maxpacket0_tries=
> > +                     [USB] set the retry time of get maxpacket0 for each
> > +                     port initialization (default GET_MAXPACKET0_TRIES = 3).
> > +
> >       usbcore.nousb   [USB] Disable the USB subsystem
> >
> >       usbcore.quirks=
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index b7f66dcd1fe0..c5c695886424 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -2788,6 +2788,27 @@ static unsigned hub_is_wusb(struct usb_hub *hub)
> >  #define HUB_LONG_RESET_TIME  200
> >  #define HUB_RESET_TIMEOUT    800
> >
> > +/* define retry time for port reset */
> > +static int port_reset_tries = PORT_RESET_TRIES;
> > +module_param(port_reset_tries, int, S_IRUGO|S_IWUSR);
> > +MODULE_PARM_DESC(port_reset_tries, "retry times of port reset for each port initialization");
>
> Please no.  Module parameters are from the 1990's, let us never add new
> ones if at all possible.
>
> These are global options, for all devices in the system.  Instead, use
> per-device settings if you really need to change these values.

Sorry for the late reply.
Since the driver is using define macro to decide the retry time
currently, we can't
modify the value directly. Do you mean setting by device tree for
per-device settings? or other methods?

> But I would even push back on that and ask why these values need to be
> changed at all.  What hardware is broken so badly that our timeout
> settings do not work properly?  Can we modify them gracefully to "just
> work" without any need for tweaking or requiring any modification by a
> user at all?  That would be the better solution instead of requiring
> users to do this on their own when confronted by misbehaving hardware.

I got some reports from end users, but I couldn't see the hardware
information due to
enumeration not being complete. There are too many hardwares owned by end users.
It is hard to make work for all of them. In addition, some users just
tried to reboot the Host device
when they found their connected hardware not working. It would cause
the device reset or hang
due to the retry mechanism. This is why I want to modify the retry times.

> thanks,
>
> greg k-h

Thanks,
Ray
