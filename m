Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820FA546730
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347822AbiFJNNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343655AbiFJNNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:13:06 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD505F25E;
        Fri, 10 Jun 2022 06:13:01 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-31336535373so120910617b3.2;
        Fri, 10 Jun 2022 06:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5TwvIVTMqopNaiCzMdLKY4BCaYsGWC/6OULeiLE74EY=;
        b=fANhcr0a7ik8bLkGhx2uqVO8Te9g/baiuawezulBmF5PjoHWDikBKUeMearYycHwSC
         w4DDb3i4pTa0VNoFeSaVGgWKQSb3Xo9MuWNjGBZ1MYH7aeTfa59wf1wukycj9ZM166Bs
         NcFc15q5TjqRO0vfcLPk+oy7RpH2u+YXeDgux+ATuxvXo/uQggLmw1YsgWfv6zBxqCVe
         lugHzEyUiNCjhtjbJjdJ/yK1Aex/78Yb4ig9iOPKPJ0TectnuwYxqgadKLFzBZtCcXmq
         ubCe3jwQ0hb0aTPcAvY2b67IY/GQvmyWXvReGPzybvSJf/LrYHH7i5u0jOQXGhdldymD
         E3Zw==
X-Gm-Message-State: AOAM53378tB0XVt/s16fMBGG5cERdCEVt7EdhxWaX00s/6eJsozK1/jH
        WInGLVBBXua/85UbUUOU6GmkYY+Bl/aZWPW0CwCLrXMUevg=
X-Google-Smtp-Source: ABdhPJz2fUkA8ABinu6LRH7T863T6NvkZspK9uW9DDJKKuxAi4msNhRobuJtjvP0orqpGiYf7//JVqwfmgxw+4lSiE4=
X-Received: by 2002:a81:3dc6:0:b0:313:cc8a:e39e with SMTP id
 k189-20020a813dc6000000b00313cc8ae39emr549995ywa.196.1654866780483; Fri, 10
 Jun 2022 06:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <1843211.tdWV9SEqCh@kreacher> <7414189.EvYhyI6sBW@kreacher> <YqLowrkmibyh56T+@kuha.fi.intel.com>
In-Reply-To: <YqLowrkmibyh56T+@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Jun 2022 15:12:49 +0200
Message-ID: <CAJZ5v0iRuOLWJOhetBxaEdAHkdNsW7qZkEF001066mxW=gG5Ew@mail.gmail.com>
Subject: Re: [PATCH v1 04/16] thunderbolt: ACPI: Use acpi_find_child_by_adr()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 8:46 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Thu, Jun 09, 2022 at 03:54:40PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Instead of walking the list of children of an ACPI device directly
> > in order to find the child matching a given bus address, use
> > acpi_find_child_by_adr() for this purpose.
> >
> > Apart from simplifying the code, this will help to eliminate the
> > children list head from struct acpi_device as it is redundant and it
> > is used in questionable ways in some places (in particular, locking is
> > needed for walking the list pointed to it safely, but it is often
> > missing).
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/thunderbolt/acpi.c |    9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> >
> > Index: linux-pm/drivers/thunderbolt/acpi.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thunderbolt/acpi.c
> > +++ linux-pm/drivers/thunderbolt/acpi.c
> > @@ -304,8 +304,6 @@ static bool tb_acpi_bus_match(struct dev
> >  static struct acpi_device *tb_acpi_find_port(struct acpi_device *adev,
> >                                            const struct tb_port *port)
> >  {
> > -     struct acpi_device *port_adev;
> > -
> >       if (!adev)
> >               return NULL;
> >
> > @@ -313,12 +311,7 @@ static struct acpi_device *tb_acpi_find_
> >        * Device routers exists under the downstream facing USB4 port
> >        * of the parent router. Their _ADR is always 0.
> >        */
> > -     list_for_each_entry(port_adev, &adev->children, node) {
> > -             if (acpi_device_adr(port_adev) == port->port)
> > -                     return port_adev;
> > -     }
> > -
> > -     return NULL;
> > +     return acpi_find_child_by_adr(adev, port->port);
> >  }
> >
> >  static struct acpi_device *tb_acpi_switch_find_companion(struct tb_switch *sw)
>
> I don't think you need tb_acpi_find_port() anymore. You can just call
> acpi_find_child_by_ard(ACPI_COMPANION(...), port->port) directly, no?

Technically I can, but I thought that the comment in
tb_acpi_find_port() was worth retaining.
