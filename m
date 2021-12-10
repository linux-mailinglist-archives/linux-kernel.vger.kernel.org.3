Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946D64705A9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243588AbhLJQbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:31:21 -0500
Received: from netrider.rowland.org ([192.131.102.5]:51849 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S243159AbhLJQbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:31:04 -0500
Received: (qmail 643782 invoked by uid 1000); 10 Dec 2021 11:27:28 -0500
Date:   Fri, 10 Dec 2021 11:27:28 -0500
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
Message-ID: <YbN/8AOHHR7fNFGd@rowland.harvard.edu>
References: <20211208070835.8877-1-kai.heng.feng@canonical.com>
 <YbEnf2NUr/BCV4Gb@rowland.harvard.edu>
 <CAAd53p61w-AHBxy05Hx-gwae1rUxZxsaVfmH=--bQUkPxYj8Nw@mail.gmail.com>
 <YbIo/ZBRgK5NDZJb@rowland.harvard.edu>
 <CAAd53p5HfGz-D-QvYvPuDY4qLe0nYncY077=n-gvnYym4A8E0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p5HfGz-D-QvYvPuDY4qLe0nYncY077=n-gvnYym4A8E0w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 02:06:10PM +0800, Kai-Heng Feng wrote:
> On Fri, Dec 10, 2021 at 12:04 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Thu, Dec 09, 2021 at 09:19:24AM +0800, Kai-Heng Feng wrote:
> > > On Thu, Dec 9, 2021 at 5:45 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > >
> > > > On Wed, Dec 08, 2021 at 03:08:33PM +0800, Kai-Heng Feng wrote:
> > > > > When a new USB device gets plugged to nested hubs, the affected hub,
> > > > > which connects to usb 2-1.4-port2, doesn't report there's any change,
> > > > > hence the nested hubs go back to runtime suspend like nothing happened:
> > > >
> > > > That's a bug in the hub.  When there's a change in the connection status
> > > > of one of its ports, it should report this change to the kernel.
> > >
> > > I think it should, but when I searched through the USB spec and I
> > > can't find anywhere specify hub requires to report it in change
> > > status.
> >
> > USB-2.0 spec, section 11.24.2.7.2.1 (C_PORT_CONNECTION):
> >
> >         This bit is set when the PORT_CONNECTION bit changes because of an
> >         attach or detach detect event (see Section 7.1.7.3). This bit will be
> >         cleared to zero by a ClearPortFeature(C_PORT_CONNECTION) request or
> >         while the port is in the Powered-off state.
> 
> It's indeed set for the hub's downstream facing port, and that's why
> wake up the hub and check its ports can still find connect event.
> But I can't find anywhere stats how hub's upstream facing port should be set.

It looks like the port status-change bits don't get set in response to a 
wakeup signal, for SuperSpeed links.  Section C.1.2.3 in the USB-3.1 
spec says:

	Note that C_PORT_LINK_STATE is not asserted in the event of a 
	remote wakeup. As discussed previously, in the event of a
	Remote Wakeup the associated function sends the host a Function
	Wake device notification packet.

I don't know if we receive those Function Wake notification packets, or 
what we do with them.

In any case, section C.1.4.5 says that during remote wakeup, all of the 
links from the remote wakeup device up to the controlling hub transition 
to U0.  But your log extract showed:

[  281.110147] usb 2-1.4-port2: status 0263 change 0000

So even though the 2-1.4.2 hub originated a wakeup signal, the upstream 
link to the 2-1.4 hub remained in U3 according to these status bits.  
Could it be that we need to include an extra delay, so the link has 
enough time to get into the U0 state?

Maybe Mathias can help investigate this issue.

Alan Stern
