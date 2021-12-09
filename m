Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBDD46EC7E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbhLIQHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:07:48 -0500
Received: from netrider.rowland.org ([192.131.102.5]:58491 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S236633AbhLIQHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:07:47 -0500
Received: (qmail 607420 invoked by uid 1000); 9 Dec 2021 11:04:13 -0500
Date:   Thu, 9 Dec 2021 11:04:13 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        Rajat Jain <rajatja@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: hub: Resume hubs to find newly connected device
Message-ID: <YbIo/ZBRgK5NDZJb@rowland.harvard.edu>
References: <20211208070835.8877-1-kai.heng.feng@canonical.com>
 <YbEnf2NUr/BCV4Gb@rowland.harvard.edu>
 <CAAd53p61w-AHBxy05Hx-gwae1rUxZxsaVfmH=--bQUkPxYj8Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p61w-AHBxy05Hx-gwae1rUxZxsaVfmH=--bQUkPxYj8Nw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 09:19:24AM +0800, Kai-Heng Feng wrote:
> On Thu, Dec 9, 2021 at 5:45 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Wed, Dec 08, 2021 at 03:08:33PM +0800, Kai-Heng Feng wrote:
> > > When a new USB device gets plugged to nested hubs, the affected hub,
> > > which connects to usb 2-1.4-port2, doesn't report there's any change,
> > > hence the nested hubs go back to runtime suspend like nothing happened:
> >
> > That's a bug in the hub.  When there's a change in the connection status
> > of one of its ports, it should report this change to the kernel.
> 
> I think it should, but when I searched through the USB spec and I
> can't find anywhere specify hub requires to report it in change
> status.

USB-2.0 spec, section 11.24.2.7.2.1 (C_PORT_CONNECTION):

	This bit is set when the PORT_CONNECTION bit changes because of an 
	attach or detach detect event (see Section 7.1.7.3). This bit will be 
	cleared to zero by a ClearPortFeature(C_PORT_CONNECTION) request or 
	while the port is in the Powered-off state.

> > So because of this buggy hub, you now want to wake up _every_ hub in the
> > system whenever any wakeup event occurs?  Is this really a good idea?
> > Is there a better way to solve the problem, such as a special quirk
> > flag?
> 
> If there's no other activities, the USB hub should go back to suspend
> immediately, so the impact is minimal.

Not immediately, but after a few seconds.  However your patch will affect every 
hub, not just the one that the new device was plugged into.

> I've seen several similar bug reports so I think this solution should
> be applied for all hubs.

Maybe those bug reports all had something in common, such as the type of hub or 
the bus speed they were running at.  Did you check?

Alan Stern
