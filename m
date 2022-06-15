Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FF554C1D3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352324AbiFOG2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbiFOG1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:27:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08E212A96;
        Tue, 14 Jun 2022 23:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655274473; x=1686810473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=paje04xnVGTi1OtyRY/hN0RZlL5eV183Z88/BdFFA5k=;
  b=GTCAFplGadcDK6uC0zovKEJz9L0sGMDZ4A1WvEBmxL2OhQ4drtubA3YJ
   auglswJ76BO6g0HO2/nF/ZgPnrYl0gFMTR+3y2+kmGLSRIpUeFt9U19++
   jwGLMIfbq0EW4dbsknQul0bzLYcZ0JMoPwFS3iW8gXkUDXBaM/poz3H0A
   Pij8UnHvaPgFG9Tjswc/xnOAY5BlCmVJpD4QMULgnCxsMq4ueZj+Dfpzk
   Naj4bobtDEjNyMIN8G85rNS/Co0x9VSQ4sLifduG+rk0Za1aasKHxw2Uq
   +Kep9JMh7CiaO3I2kcOiGEmT87PrYgyKGpn1InQy/i6WmdxVLEdOjU97m
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="342815606"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="342815606"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 23:27:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="762317135"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 23:27:49 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 15 Jun 2022 09:27:46 +0300
Date:   Wed, 15 Jun 2022 09:27:46 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
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
Subject: Re: [PATCH v2 04/16] thunderbolt: ACPI: Replace tb_acpi_find_port()
 with acpi_find_child_by_adr()
Message-ID: <Yql74qs6nYwRaQYf@lahna>
References: <1843211.tdWV9SEqCh@kreacher>
 <2653857.mvXUDI8C0e@kreacher>
 <2851774.e9J7NaK4W3@kreacher>
 <YqglkQZxAagb8ln/@lahna>
 <CAJZ5v0jBLNpXpVn=WBm1rLxDkPFNo=UqsfDnuWS9hD=CRDPbsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jBLNpXpVn=WBm1rLxDkPFNo=UqsfDnuWS9hD=CRDPbsQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 08:25:53PM +0200, Rafael J. Wysocki wrote:
> Hi Mika,
> 
> On Tue, Jun 14, 2022 at 8:07 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Mon, Jun 13, 2022 at 08:11:36PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Use acpi_find_child_by_adr() to find the child matching a given bus
> > > address instead of tb_acpi_find_port() that walks the list of children
> > > of an ACPI device directly for this purpose and drop the latter.
> > >
> > > Apart from simplifying the code, this will help to eliminate the
> > > children list head from struct acpi_device as it is redundant and it
> > > is used in questionable ways in some places (in particular, locking is
> > > needed for walking the list pointed to it safely, but it is often
> > > missing).
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > v1 -> v2:
> > >    * Drop tb_acpi_find_port() (Heikki, Andy).
> > >    * Change the subject accordingly
> > >
> > > ---
> > >  drivers/thunderbolt/acpi.c |   27 ++++-----------------------
> > >  1 file changed, 4 insertions(+), 23 deletions(-)
> > >
> > > Index: linux-pm/drivers/thunderbolt/acpi.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/thunderbolt/acpi.c
> > > +++ linux-pm/drivers/thunderbolt/acpi.c
> > > @@ -301,26 +301,6 @@ static bool tb_acpi_bus_match(struct dev
> > >       return tb_is_switch(dev) || tb_is_usb4_port_device(dev);
> > >  }
> > >
> > > -static struct acpi_device *tb_acpi_find_port(struct acpi_device *adev,
> > > -                                          const struct tb_port *port)
> > > -{
> > > -     struct acpi_device *port_adev;
> > > -
> > > -     if (!adev)
> > > -             return NULL;
> > > -
> > > -     /*
> > > -      * Device routers exists under the downstream facing USB4 port
> > > -      * of the parent router. Their _ADR is always 0.
> > > -      */
> > > -     list_for_each_entry(port_adev, &adev->children, node) {
> > > -             if (acpi_device_adr(port_adev) == port->port)
> > > -                     return port_adev;
> > > -     }
> > > -
> > > -     return NULL;
> > > -}
> > > -
> > >  static struct acpi_device *tb_acpi_switch_find_companion(struct tb_switch *sw)
> > >  {
> > >       struct acpi_device *adev = NULL;
> > > @@ -331,7 +311,8 @@ static struct acpi_device *tb_acpi_switc
> > >               struct tb_port *port = tb_port_at(tb_route(sw), parent_sw);
> > >               struct acpi_device *port_adev;
> > >
> > > -             port_adev = tb_acpi_find_port(ACPI_COMPANION(&parent_sw->dev), port);
> > > +             port_adev = acpi_find_child_by_adr(ACPI_COMPANION(&parent_sw->dev),
> > > +                                                port->port);
> > >               if (port_adev)
> > >                       adev = acpi_find_child_device(port_adev, 0, false);
> > >       } else {
> > > @@ -364,8 +345,8 @@ static struct acpi_device *tb_acpi_find_
> > >       if (tb_is_switch(dev))
> > >               return tb_acpi_switch_find_companion(tb_to_switch(dev));
> > >       else if (tb_is_usb4_port_device(dev))
> > > -             return tb_acpi_find_port(ACPI_COMPANION(dev->parent),
> > > -                                      tb_to_usb4_port_device(dev)->port);
> >
> > Can you move the above comment here too?
> 
> Do you mean to move the comment from tb_acpi_find_port() right here or
> before the if (tb_is_switch(dev)) line above?
> 
> I think that tb_acpi_switch_find_companion() would be a better place
> for that comment.  At least it would match the code passing 0 to
> acpi_find_child_device() in there.

Yes, I agree (as long as the comment stays somewhere close ;-))
