Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F27464B12
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbhLAJ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:58:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:56666 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232736AbhLAJ66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:58:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="217119800"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="217119800"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 01:55:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="654706002"
Received: from kuha.fi.intel.com ([10.237.72.166])
  by fmsmga001.fm.intel.com with SMTP; 01 Dec 2021 01:55:13 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 01 Dec 2021 11:55:12 +0200
Date:   Wed, 1 Dec 2021 11:55:12 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        wonchung@google.com, bleung@chromium.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Rajat Jain <rajatja@google.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 0/4] usb: Use notifier for linking Type C ports.
Message-ID: <YadGgA4oh7wlZVAJ@kuha.fi.intel.com>
References: <20211124231028.696982-1-pmalani@chromium.org>
 <YaCrnMAEXnG+VO6d@kuha.fi.intel.com>
 <YaYFDwsw2hKdJrGj@kuha.fi.intel.com>
 <CACeCKafjOFvVaPBu7OQS-M30hWjooNBFL9-rzqTz3i1ZKEa7Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKafjOFvVaPBu7OQS-M30hWjooNBFL9-rzqTz3i1ZKEa7Ew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 11:27:12AM -0800, Prashant Malani wrote:
> Hi Heikki,
> 
> Thanks for taking a look at the series.
> 
> On Tue, Nov 30, 2021 at 3:03 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi Prashant,
> >
> > On Fri, Nov 26, 2021 at 11:40:49AM +0200, Heikki Krogerus wrote:
> > > On Wed, Nov 24, 2021 at 03:10:06PM -0800, Prashant Malani wrote:
> > > > This series resolves the cyclic dependency error which was introduced by
> > > > commit 63cd78617350 ("usb: Link the ports to the connectors they are
> > > > attached to") which lead to it being reverted. The approach here is to
> > > > use a notifier to link a new Type C port to pre-existing USB ports
> > > > instead of calling an iterator of usb ports from the Type C connector
> > > > class. This allows commit 63cd78617350 ("usb: Link the ports to the
> > > > connectors they are attached to") to then be submitted without any
> > > > depmod cyclic dependency error.
> > > >
> > > > The final patch removes the usb port iterator since it is no longer
> > > > needed.
> > >
> > > This is not enough. Build the Type-C Class as a module and the USB bus
> > > statically, and the links will not get created.
> > >
> 
> I see. I suppose it is academic now (given your follow up email about converting
> port-mapper to component framework), but would reversing where the
> notifier block is i.e,
> have usbcore expose the notifier registration API instead of
> typec-class, resolve
> the issue? That would mean the dependency is the same as what it is right now
> in the code, right (typec -> usbcore)

Well, then you would have the same issue if you build the Type-C class
statically and USB as a module, no?

I'm sure that if we though about this hard enough, we would find a way
to make the notifiers work, most likely by handling every possible
scenario separately, but it would still not remove the core problem.
There is the dependency between these components/drivers. The proper
solution does not create that dependency.

Although I'm not sure that the component framework is the best (it is
in the end just a workaround as well, but at least it's there
available for everybody), by taking advantage of the _PLD we can
create a solution where both components can live completely
independently - the order in which they are registered becomes
irrelevant as well as are they build as modules or not.

> > > I'm not sure you actually achieve much with this series, and I'm not
> > > sure this approach will ever fully solve the problem. As long as we
> > > have to declare API, we will have the circular dependency issue on our
> > > hands. But there are ways to avoid that.
> > >
> > > There is for example the component framework (drivers/base/component.c)
> > > that I've been thinking about using here. In this case it would work
> > > so that you declare the USB Type-C part as your aggregate driver, and
> > > everything that is connected to it (so USB ports, DisplayPorts, TBT,
> > > etc.) would then just declare themselves as general components. Could
> > > you take a look at that?
> >
> > I'm preparing a patch where I store all _PLDs in the ACPI tables, and
> > create list of devices that share it. I can convert port-mapper.c to
> > it and the component framework while at it.
> 
> Great, thanks. We can help with testing once you have a patch series
> to share.

OK, cool.

thanks,

-- 
heikki
