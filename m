Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3E754B88E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 20:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344371AbiFNS0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 14:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbiFNS0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:26:06 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B80721E0B;
        Tue, 14 Jun 2022 11:26:05 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id l204so16526149ybf.10;
        Tue, 14 Jun 2022 11:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3bUjyxSap3y6lIPj9ytySkmOS1GpalI5tmWzPEsu9ag=;
        b=DC+4dKe5gI9EkJhgNJJUNXh6F9DVO2diJYjjSh6mVHDKMJ0qudiHa8o/HvW7+b3y0k
         Zc0jS2Izz2TrqvctyZqWSzk2DKZf6VB38HeeZKMoKNV9w2g5vIc0KX6aSHECMSlWZMFI
         W2/cw3dStrNr5ZknvHtFSet6xKyq2MjECFJpahdhvc1TI3V+iMFuYoVMm2JZG/IbXC08
         lhhuzI3lxR0z1UAjoC0ejFjnVVdrZrA4BjMYDkqCIKHMFtpD/3RaTs/lrCAkDUfT/Qk2
         l6cHWEbFvV8ufmYWaTFJOlz96fc/gjYKS/sSr2mCZ/DINY9Ij8qPn+WQcplpLBXQJCjB
         bGsA==
X-Gm-Message-State: AJIora82wYXbZJQTKUSALzsTQQyoiyqqxK7UiGTHrJSrgE1dEILauZRJ
        ddo85ZuFs0Ii3VIe6YePcF2kiG631xT6N/7inxQ=
X-Google-Smtp-Source: AGRyM1skDC2r1shocFSg9+8XCc79NMLVJ5hHDYJ5RYwUStWzrU14+fty188+BvjEa4OrJ+GxDzIP3W7Z5JdrhfQszMg=
X-Received: by 2002:a25:84ca:0:b0:65c:b5a4:3d0a with SMTP id
 x10-20020a2584ca000000b0065cb5a43d0amr6399679ybm.137.1655231164485; Tue, 14
 Jun 2022 11:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <1843211.tdWV9SEqCh@kreacher> <2653857.mvXUDI8C0e@kreacher>
 <2851774.e9J7NaK4W3@kreacher> <YqglkQZxAagb8ln/@lahna>
In-Reply-To: <YqglkQZxAagb8ln/@lahna>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Jun 2022 20:25:53 +0200
Message-ID: <CAJZ5v0jBLNpXpVn=WBm1rLxDkPFNo=UqsfDnuWS9hD=CRDPbsQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] thunderbolt: ACPI: Replace tb_acpi_find_port()
 with acpi_find_child_by_adr()
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
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

Hi Mika,

On Tue, Jun 14, 2022 at 8:07 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Mon, Jun 13, 2022 at 08:11:36PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Use acpi_find_child_by_adr() to find the child matching a given bus
> > address instead of tb_acpi_find_port() that walks the list of children
> > of an ACPI device directly for this purpose and drop the latter.
> >
> > Apart from simplifying the code, this will help to eliminate the
> > children list head from struct acpi_device as it is redundant and it
> > is used in questionable ways in some places (in particular, locking is
> > needed for walking the list pointed to it safely, but it is often
> > missing).
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v1 -> v2:
> >    * Drop tb_acpi_find_port() (Heikki, Andy).
> >    * Change the subject accordingly
> >
> > ---
> >  drivers/thunderbolt/acpi.c |   27 ++++-----------------------
> >  1 file changed, 4 insertions(+), 23 deletions(-)
> >
> > Index: linux-pm/drivers/thunderbolt/acpi.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thunderbolt/acpi.c
> > +++ linux-pm/drivers/thunderbolt/acpi.c
> > @@ -301,26 +301,6 @@ static bool tb_acpi_bus_match(struct dev
> >       return tb_is_switch(dev) || tb_is_usb4_port_device(dev);
> >  }
> >
> > -static struct acpi_device *tb_acpi_find_port(struct acpi_device *adev,
> > -                                          const struct tb_port *port)
> > -{
> > -     struct acpi_device *port_adev;
> > -
> > -     if (!adev)
> > -             return NULL;
> > -
> > -     /*
> > -      * Device routers exists under the downstream facing USB4 port
> > -      * of the parent router. Their _ADR is always 0.
> > -      */
> > -     list_for_each_entry(port_adev, &adev->children, node) {
> > -             if (acpi_device_adr(port_adev) == port->port)
> > -                     return port_adev;
> > -     }
> > -
> > -     return NULL;
> > -}
> > -
> >  static struct acpi_device *tb_acpi_switch_find_companion(struct tb_switch *sw)
> >  {
> >       struct acpi_device *adev = NULL;
> > @@ -331,7 +311,8 @@ static struct acpi_device *tb_acpi_switc
> >               struct tb_port *port = tb_port_at(tb_route(sw), parent_sw);
> >               struct acpi_device *port_adev;
> >
> > -             port_adev = tb_acpi_find_port(ACPI_COMPANION(&parent_sw->dev), port);
> > +             port_adev = acpi_find_child_by_adr(ACPI_COMPANION(&parent_sw->dev),
> > +                                                port->port);
> >               if (port_adev)
> >                       adev = acpi_find_child_device(port_adev, 0, false);
> >       } else {
> > @@ -364,8 +345,8 @@ static struct acpi_device *tb_acpi_find_
> >       if (tb_is_switch(dev))
> >               return tb_acpi_switch_find_companion(tb_to_switch(dev));
> >       else if (tb_is_usb4_port_device(dev))
> > -             return tb_acpi_find_port(ACPI_COMPANION(dev->parent),
> > -                                      tb_to_usb4_port_device(dev)->port);
>
> Can you move the above comment here too?

Do you mean to move the comment from tb_acpi_find_port() right here or
before the if (tb_is_switch(dev)) line above?

I think that tb_acpi_switch_find_companion() would be a better place
for that comment.  At least it would match the code passing 0 to
acpi_find_child_device() in there.

> Otherwise looks good to me,
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> > +             return acpi_find_child_by_adr(ACPI_COMPANION(dev->parent),
> > +                                           tb_to_usb4_port_device(dev)->port->port);
> >       return NULL;
> >  }

Thanks!
