Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30C4476831
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhLPCh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:37:57 -0500
Received: from netrider.rowland.org ([192.131.102.5]:43291 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229811AbhLPCh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:37:56 -0500
Received: (qmail 802013 invoked by uid 1000); 15 Dec 2021 21:37:54 -0500
Date:   Wed, 15 Dec 2021 21:37:54 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Rajat Jain <rajatja@google.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: hub: Add delay for SuperSpeed hub resume to let
 links transit to U0
Message-ID: <YbqmglqFbiTp4bkz@rowland.harvard.edu>
References: <20211215120108.336597-1-kai.heng.feng@canonical.com>
 <YboN+GmeyeoypV1D@rowland.harvard.edu>
 <CAAd53p5thAHXdmmEn9VV7nrWGu7W6UaEsB7hx7k9WYTBMG2GqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p5thAHXdmmEn9VV7nrWGu7W6UaEsB7hx7k9WYTBMG2GqQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 08:23:29AM +0800, Kai-Heng Feng wrote:
> On Wed, Dec 15, 2021 at 11:47 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Wed, Dec 15, 2021 at 08:01:06PM +0800, Kai-Heng Feng wrote:

> > > --- a/drivers/usb/core/hub.c
> > > +++ b/drivers/usb/core/hub.c
> > > @@ -1110,7 +1110,10 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
> > >               } else {
> > >                       hub_power_on(hub, true);
> > >               }
> > > -     }
> > > +     /* Give some time on remote wakeup to let links to transit to U0 */
> > > +     } else if (hub_is_superspeed(hub->hdev))
> > > +             msleep(20);
> >
> > Where did the 20-ms number come from?  Is it mentioned in the spec as
> > the time required for a port to switch from U3 to U0?
> 
> The 20ms is the minimal time the device take to bring link back to U0 reliably.
> The spec mentioned device has to transit the link to U0 before
> signaling remote wakeup.
> So do you think this requires a new quirk?

No, I just wondered where you got the number from.  The patch looks fine; I 
can't think of any reasonable way to improve it.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
