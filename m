Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67FA4A9BA3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357165AbiBDPHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:07:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:19976 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232560AbiBDPHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:07:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643987254; x=1675523254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h/9khmtg2t68pwXtFE8VZDwdVbkQjmJgc0X80tEipNI=;
  b=jDsv5vYmAJrItxxCVe8bX9z/mMBlLAycuMc0K/WnkX355tUWzynV3hnD
   bIAKOK/sw/pgzntlxAXSNHQAwnbrrRgF09NkXbODM989SoNuZX8C9mfrh
   JyvPwWTjKbskrN4DqhYFMdUwLPtQX6JWREK1Q9ERyB+RBqBB/Ru5JIu0V
   3l/i1backYydFsUks9eSuhe84VuYeBv/wfoqXapyQXkaOOpRJRGTx3Pya
   KUEBPY41Iq9Wsifq4/sc3ZUvX1lnfsvY7TYy1L9E5MuBZQyqARpuxnK8D
   qHOaf0FCjbjUUYh8kg93N4xk2Ykx9QatbTj88OhO0DYcpzwaiVKTQrapb
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="235780881"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="235780881"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 07:07:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="677119496"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 04 Feb 2022 07:07:31 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 04 Feb 2022 17:07:30 +0200
Date:   Fri, 4 Feb 2022 17:07:30 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        Jameson Thies <jthies@google.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] usb: typec: Separate USB Power Delivery from USB
 Type-C
Message-ID: <Yf1BMhFp7XYYyCx+@kuha.fi.intel.com>
References: <20220203144657.16527-1-heikki.krogerus@linux.intel.com>
 <20220203144657.16527-2-heikki.krogerus@linux.intel.com>
 <Yfvs13vpsWULIVWu@kroah.com>
 <Yfz6OUbDBXVtQzrb@kuha.fi.intel.com>
 <Yf0xPr957MxtaqBn@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yf0xPr957MxtaqBn@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 02:59:26PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Feb 04, 2022 at 12:04:41PM +0200, Heikki Krogerus wrote:
> > Hi Greg,
> > 
> > On Thu, Feb 03, 2022 at 03:55:19PM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Feb 03, 2022 at 05:46:55PM +0300, Heikki Krogerus wrote:
> > > > +/* These additional details are only available with vSafe5V supplies */
> > > > +static struct kobj_attribute dual_role_power_attr = __ATTR_RO(dual_role_power);
> > > > +static struct kobj_attribute usb_suspend_supported_attr = __ATTR_RO(usb_suspend_supported);
> > > > +static struct kobj_attribute unconstrained_power_attr = __ATTR_RO(unconstrained_power);
> > > > +static struct kobj_attribute usb_communication_capable_attr = __ATTR_RO(usb_communication_capable);
> > > > +static struct kobj_attribute dual_role_data_attr = __ATTR_RO(dual_role_data);
> > > > +static struct kobj_attribute
> > > > +unchunked_extended_messages_supported_attr = __ATTR_RO(unchunked_extended_messages_supported);
> > > 
> > > Note, no 'struct device' should ever have a "raw" kobject hanging off of
> > > it.  If so, something went wrong.
> > > 
> > > If you do this, userspace will never be notified of the attributes and
> > > any userspace representation of the tree will be messed up.
> > > 
> > > Please, use an attribute directory with a name, or if you really need to
> > > go another level deep, use a real 'struct device'.  As-is here, I can't
> > > take it.
> > 
> > OK, got it. I don't think we can avoid the deeper levels, not without
> > making this really cryptic, and not really usable in all cases. These
> > objects are trying to represent (parts) of the protocol - the
> > messages, the objects in those messages, and later the responses to
> > those messages.
> > 
> > But I'm also trying to avoid having to claim that these objects are
> > "devices", because honestly, claiming that the packages used in
> > communication are devices is confusing, and just wrong. If we take
> > that road, then we really should redefine what struct device is
> > supposed to represent, and rename it also.
> 
> Fair enough, this isn't really a device, it's an "attribute" of your
> device you are wanting to show.  It's just that you are really "deep".
> 
> You asked for:
> 
> /sys/class/typec/port0/usb_power_delivery
> |-- revision
> |-- sink_capabilities/
> |   |-- 1:fixed_supply/
> |   |   |-- dual_role_data
> |   |   |-- dual_role_power
> |   |   |-- fast_role_swap_current
> |   |   |-- operational_current
> |   |   |-- unchunked_extended_messages_supported
> |   |   |-- unconstrained_power
> |   |   |-- usb_communication_capable
> |   |   |-- usb_suspend_supported
> |   |   `-- voltage
> |   |-- 2:variable_supply/
> |   |   |-- maximum_voltage
> |   |   |-- minimum_voltage
> |   |   `-- operational_current
> |   `-- 3:battery/
> |       |-- maximum_voltage
> |       |-- minimum_voltage
> |       `-- operational_power
> `-- source_capabilities/
>     `-- 1:fixed_supply/
>         |-- dual_role_data
>         |-- dual_role_power
>         |-- maximum_current
>         |-- unchunked_extended_messages_supported
>         |-- unconstrained_power
>         |-- usb_communication_capable
>         |-- usb_suspend_supported
>         `-- voltage
> 
> 
> To start with, your "attribute" is really "usb_power_delivery" here, so
> you can just use an attribute group name to get the "revision" file.
> 
> But then the later ones could be flat in that directory as well, using a
> ':' to split as you did already, and the above could turn into:
> 
> /sys/class/typec/port0/usb_power_delivery
> |-- revision
> |-- sink_capabilites:1:fixed_supply:dual_role_data
> |-- sink_capabilites:1:fixed_supply:dual_role_power
> |-- sink_capabilites:1:fixed_supply:fase_role_swap_current
> ....
> |-- sink_capabilites:2:variable_supply:maximum_voltage
> |-- sink_capabilites:2:variable_supply:minimum_voltage
> ...
> |-- source_capabilities:1:fixed_supply:dual_role_data
> |-- source_capabilities:1:fixed_supply:dual_role_power
> |-- source_capabilities:1:fixed_supply:maximum_current
> ...
> 
> But ick, that's also a mess as you are now forced to parse filenames in
> userspace in a different way than "normal".
> 
> Is there anything special about the number here?  It's the "position"
> which will be unique.  So make that position a device, as that's kind of
> what it is (like usb endpoints are devices)
> 
> Then you could make a bus for the positions and all would be good, and
> you could turn this into:
> 
> 
> /sys/class/typec/port0/usb_power_delivery
> |-- revision
> |-- sink_capabilities:1/
> |   `-- fixed_supply/
> |       |-- dual_role_data
> |       |-- dual_role_power
> |       |-- fast_role_swap_current
> |       |-- operational_current
> |       |-- unchunked_extended_messages_supported
> |       |-- unconstrained_power
> |       |-- usb_communication_capable
> |       |-- usb_suspend_supported
> |       `-- voltage
> |-- sink_capabilities:2/
> |   `-- variable_supply/
> |       |-- maximum_voltage
> |       |-- minimum_voltage
> |       `-- operational_current
> |-- sink_capabilities:3/
> |   `-- battery/
> |       |-- maximum_voltage
> |       |-- minimum_voltage
> |       `-- operational_power
> `-- source_capabilities:1/
>     `-- fixed_supply/
>         |-- dual_role_data
>         |-- dual_role_power
>         |-- maximum_current
>         |-- unchunked_extended_messages_supported
>         |-- unconstrained_power
>         |-- usb_communication_capable
>         |-- usb_suspend_supported
>         `-- voltage
> 
> Would that work?

Unfortunately the object position is only defined for these
capability messages, not for the other messages. It's not going to
work :-(

> > So would it be OK that, instead of registering these objects as
> > devices, we just introduce a kset where we can group them
> > (/sys/kernel/usb_power_delivery)?
> 
> You want to show this as attched to a specific port somehow, so that
> location is not going to work.

But the idea with that kset would be that you have a separate
directory for each port there for this stuff:

        /sys/kernel/usb_power_delivery/port0
        |-- revision
        ...

And those directories we could then link to the actual device:

        /sys/class/typec/port0/usb_power_delivery -> ../../../kernel/usb_power_delivery/port0

thanks,

-- 
heikki
