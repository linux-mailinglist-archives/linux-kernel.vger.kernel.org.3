Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B890754D207
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347348AbiFOTwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343917AbiFOTwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:52:33 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529A7D81;
        Wed, 15 Jun 2022 12:52:31 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id v22so22372101ybd.5;
        Wed, 15 Jun 2022 12:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mL9akpVVZ4tEzNekwbjZgLIJgiBmLezCfn7/cgOspMQ=;
        b=WTt/+ZRr+Mm+q7tKoJiaPW2HT4+9IFUK0PZFU1rbiY2QdpZwke6Ek9VilKanhUhVVs
         1MUV+ALCpnC0Mp9202mcsVOSDetHm+bTKA40ZNi91AgARWHiTpHMGUOHT8/FnIN31SIV
         OAq5B3kpi9HDf+5DCzQ7KkLQ5sVV3jEEu1rcRpHQ5mmVSvEWlEFhUlDgtedEY9SgyJmQ
         rbq+XolDRdo5fRmRJFQEZ64NEYK28kMpaFC6kFWka9N+VUpJohwINIdc3wnfOeZxhAx+
         TZAv2gRDB3iKVbXCwrFIHpmPJHTskok6R1qAdqvz6hi8Zf2M2l27VkOutYgUVqMWCfES
         1y4g==
X-Gm-Message-State: AJIora/JsnsH/s6kVF7bTKq/tGOJxTbm8r9t4yMIj1D+JYG0HHcxFkTl
        DT+zHf4sQlVpShtGH7QQNzeqhOQx5byE5nDbFOA=
X-Google-Smtp-Source: AGRyM1sF+FBhgh0k43sS5ry6Ox06fy9vYOfaKhwdj6kn6fPKiE+CPeLL04/IuPY068Cde/SdzOSdQg3fFpFDF6iy/GU=
X-Received: by 2002:a25:d748:0:b0:65c:6b00:55af with SMTP id
 o69-20020a25d748000000b0065c6b0055afmr1534149ybg.365.1655322750507; Wed, 15
 Jun 2022 12:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <1843211.tdWV9SEqCh@kreacher> <2653857.mvXUDI8C0e@kreacher>
 <2851774.e9J7NaK4W3@kreacher> <YqglkQZxAagb8ln/@lahna> <CAJZ5v0jBLNpXpVn=WBm1rLxDkPFNo=UqsfDnuWS9hD=CRDPbsQ@mail.gmail.com>
 <Yql74qs6nYwRaQYf@lahna>
In-Reply-To: <Yql74qs6nYwRaQYf@lahna>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Jun 2022 21:52:19 +0200
Message-ID: <CAJZ5v0jM=cUEmABWeV2=v8etXRWLT=GE_FhV1CYRfNrv72CkkA@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] thunderbolt: ACPI: Replace tb_acpi_find_port()
 with acpi_find_child_by_adr()
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Wed, Jun 15, 2022 at 8:27 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, Jun 14, 2022 at 08:25:53PM +0200, Rafael J. Wysocki wrote:
> > Hi Mika,
> >
> > On Tue, Jun 14, 2022 at 8:07 AM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On Mon, Jun 13, 2022 at 08:11:36PM +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Use acpi_find_child_by_adr() to find the child matching a given bus
> > > > address instead of tb_acpi_find_port() that walks the list of children
> > > > of an ACPI device directly for this purpose and drop the latter.
> > > >
> > > > Apart from simplifying the code, this will help to eliminate the
> > > > children list head from struct acpi_device as it is redundant and it
> > > > is used in questionable ways in some places (in particular, locking is
> > > > needed for walking the list pointed to it safely, but it is often
> > > > missing).
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >
> > > > v1 -> v2:
> > > >    * Drop tb_acpi_find_port() (Heikki, Andy).
> > > >    * Change the subject accordingly
> > > >
> > > > ---
> > > >  drivers/thunderbolt/acpi.c |   27 ++++-----------------------
> > > >  1 file changed, 4 insertions(+), 23 deletions(-)
> > > >
> > > > Index: linux-pm/drivers/thunderbolt/acpi.c
> > > > ===================================================================
> > > > --- linux-pm.orig/drivers/thunderbolt/acpi.c
> > > > +++ linux-pm/drivers/thunderbolt/acpi.c
> > > > @@ -301,26 +301,6 @@ static bool tb_acpi_bus_match(struct dev
> > > >       return tb_is_switch(dev) || tb_is_usb4_port_device(dev);
> > > >  }
> > > >
> > > > -static struct acpi_device *tb_acpi_find_port(struct acpi_device *adev,
> > > > -                                          const struct tb_port *port)
> > > > -{
> > > > -     struct acpi_device *port_adev;
> > > > -
> > > > -     if (!adev)
> > > > -             return NULL;
> > > > -
> > > > -     /*
> > > > -      * Device routers exists under the downstream facing USB4 port
> > > > -      * of the parent router. Their _ADR is always 0.
> > > > -      */
> > > > -     list_for_each_entry(port_adev, &adev->children, node) {
> > > > -             if (acpi_device_adr(port_adev) == port->port)
> > > > -                     return port_adev;
> > > > -     }
> > > > -
> > > > -     return NULL;
> > > > -}
> > > > -
> > > >  static struct acpi_device *tb_acpi_switch_find_companion(struct tb_switch *sw)
> > > >  {
> > > >       struct acpi_device *adev = NULL;
> > > > @@ -331,7 +311,8 @@ static struct acpi_device *tb_acpi_switc
> > > >               struct tb_port *port = tb_port_at(tb_route(sw), parent_sw);
> > > >               struct acpi_device *port_adev;
> > > >
> > > > -             port_adev = tb_acpi_find_port(ACPI_COMPANION(&parent_sw->dev), port);
> > > > +             port_adev = acpi_find_child_by_adr(ACPI_COMPANION(&parent_sw->dev),
> > > > +                                                port->port);
> > > >               if (port_adev)
> > > >                       adev = acpi_find_child_device(port_adev, 0, false);
> > > >       } else {
> > > > @@ -364,8 +345,8 @@ static struct acpi_device *tb_acpi_find_
> > > >       if (tb_is_switch(dev))
> > > >               return tb_acpi_switch_find_companion(tb_to_switch(dev));
> > > >       else if (tb_is_usb4_port_device(dev))
> > > > -             return tb_acpi_find_port(ACPI_COMPANION(dev->parent),
> > > > -                                      tb_to_usb4_port_device(dev)->port);
> > >
> > > Can you move the above comment here too?
> >
> > Do you mean to move the comment from tb_acpi_find_port() right here or
> > before the if (tb_is_switch(dev)) line above?
> >
> > I think that tb_acpi_switch_find_companion() would be a better place
> > for that comment.  At least it would match the code passing 0 to
> > acpi_find_child_device() in there.
>
> Yes, I agree (as long as the comment stays somewhere close ;-))

OK, I'll move it to tb_acpi_switch_find_companion() then.

Thanks!
