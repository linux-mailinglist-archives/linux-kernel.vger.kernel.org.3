Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657C4509718
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383667AbiDUGEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbiDUGEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:04:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0CC64DD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650520878; x=1682056878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O7MKbuqHNRvjU+QrsuUcPlZPeoTt9r3lAbYwnQzZZ0U=;
  b=avtKaeZwKlBHniTjgWQp0Gl1AJJaGxhO5YktdbhGSiiD7iSkMKh1nh/a
   QtN1mH0oYZUlgTfVftxRPyOzt+4/j+KRgdPyHmYHbLeyVYuHVGVln/WJQ
   PNGupCidu0SysIocF3toAwNV+7jCfrZ/AeYlzLgx08OeWf25WRXBQij9o
   BhDask37cpluGRtOHu66rI2RaBNXfSLgPhSl8vhq6eM0NFlcU9qxG6bBq
   z7ZUmyVr7puEXEsdqhNnW3j3jedBXLcfbVkJJ223pqmKi9wrBETdm0t3I
   CGWDTM54KcKzcjqLbmb1dhrB0njp3DANXwn6IkCY37XFNMsbZ8ZwLmDLl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="261850469"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="261850469"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:00:58 -0700
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="555594587"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:00:54 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 21 Apr 2022 09:00:31 +0300
Date:   Thu, 21 Apr 2022 09:00:31 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Won Chung <wonchung@google.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] thunderbolt: Link USB4 ports to their USB Type-C
 connectors
Message-ID: <YmDy/xEsyktRS6D+@lahna>
References: <20220418175932.1809770-1-wonchung@google.com>
 <Yl/l7gjRXj41a93q@lahna>
 <CAOvb9yidpOZ4jCjme+u1a4fPTRnLmxUHSTO3yHPPuYtDbe1V0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOvb9yidpOZ4jCjme+u1a4fPTRnLmxUHSTO3yHPPuYtDbe1V0g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 20, 2022 at 09:39:25AM -0700, Won Chung wrote:
> On Wed, Apr 20, 2022 at 3:54 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi,
> >
> > On Mon, Apr 18, 2022 at 05:59:30PM +0000, Won Chung wrote:
> > > Currently, USB port is linked to Type C connector, using the component
> > > framework, if they share the same _PLD fields from ACPI table. Type C
> > > port-mapper searches for devices with the same _PLD values, and
> > > aggregate them as components.
> > >
> > > When there is another device that share the same _PLD but does not
> > > registers a component, Type C connector (component master) would never
> > > be bound due to a component match entry device without a component
> > > registered. There exists some cases where USB4 port also shares the same
> > > _PLD with USB port and Type C connector, so we need to register a
> > > component for USB4 ports too, linking USB4 port with Type C connector.
> > > Otherwise, link between USB port and Type C connector would not
> > > work either.
> > >
> > > Due to the nature of the component framework, all registered components
> > > are shared by all component match despite the relevance. MEI subsystems
> > > also use the component framework to bind to i915 driver, which try to
> > > match components registered by USB ports and USB4 ports. This can be
> > > problematic since MEI assumes that there is a driver bound to the
> > > component device, while USB4 port does not bind to any drivers. MEI's
> > > component match callback functions should handle such case to avoid NULL
> > > pointer dereference when USB4 port registers a component.
> > >
> > > In summary this patch series
> > > 1. Fixes MEI subsystem's component match callbacks to handle a component
> > > device without any driver bound
> > > 2. Registers a component for USB4 ports to link them to Type C
> > > connectors, similar to USB ports.
> > >
> > > Heikki Krogerus (1):
> > >   thunderbolt: Link USB4 ports to their USB Type-C connectors
> > >
> > > Won Chung (1):
> > >   misc/mei: Add NULL check to component match callback functions
> >
> > The Thunderbolt patch looks good to me. Do you want me to take the both
> > patches through the Thunderbolt tree or they can go separately? I need
> > an ack from the mei maintainer it goes through my tree.
> 
> Hi Mika,
> 
> I would prefer the two patches to go to the same tree since it can
> cause a crash with only the second patch (tbt). Would that sound okay?

Sounds good to me.
