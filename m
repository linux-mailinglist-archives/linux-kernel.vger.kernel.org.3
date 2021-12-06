Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37EA4690EB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 08:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbhLFHvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 02:51:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57328 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237150AbhLFHvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 02:51:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F51C6117B;
        Mon,  6 Dec 2021 07:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEDAC341C1;
        Mon,  6 Dec 2021 07:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638776868;
        bh=1tjNuHEY1D3f4gT+xgEa586VTk6XmE+eqdouKLZ1O7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M7mLgCm6BrAps0JqDF3QLloUkkK/2qsSBCWVCOxZ3GuNCd1EK5Z7JD8JOD/YrDHEO
         zfhq1z4IMOiEDXPitP7fwLwNJt6J93jcfW7BmDzXrOlGdnhsXQ1jOQkSrg23w2GR2y
         aY/btjL6KDNuCy281Xi0bUPLDB7Jf9GoKEsaeSD4=
Date:   Mon, 6 Dec 2021 08:47:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/4] Docs: usb: update usb_bulk_msg receiving example
Message-ID: <Ya3AHxw48/T3XnPv@kroah.com>
References: <cover.1638630342.git.philipp.g.hortmann@gmail.com>
 <0bd9336e18abad338b4967664a4667b96dae6be6.1638630342.git.philipp.g.hortmann@gmail.com>
 <Yayb6+SrQKUG4bDl@kroah.com>
 <f3a1b2ba-85fe-e829-0d11-07a4bc4d8756@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3a1b2ba-85fe-e829-0d11-07a4bc4d8756@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2021 at 06:04:48PM +0100, Philipp Hortmann wrote:
> On 12/5/21 12:00 PM, Greg KH wrote:
> > On Sat, Dec 04, 2021 at 05:35:11PM +0100, Philipp Hortmann wrote:
> > > Clarification that this example is not in the driver template anymore.
> > > Update code example so that it fits best to usb-skeleton.c
> > > Update format of function names
> > > 
> > > Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> > > ---
> > > V1 -> V2: Added "Update format of function names" to patch description
> > >            Corrected format of function names like the following example:
> > >            "`usb_bulk_msg` function" to "usb_bulk_msg()"
> > > ---
> > >   .../driver-api/usb/writing_usb_driver.rst     | 32 +++++++++----------
> > >   1 file changed, 16 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
> > > index b43e1ce49f0e..ed11398837e5 100644
> > > --- a/Documentation/driver-api/usb/writing_usb_driver.rst
> > > +++ b/Documentation/driver-api/usb/writing_usb_driver.rst
> > > @@ -218,36 +218,36 @@ do very much processing at that time. Our implementation of
> > >   ``skel_write_bulk_callback`` merely reports if the urb was completed
> > >   successfully or not and then returns.
> > > -The read function works a bit differently from the write function in
> > > +This read function works a bit differently from the write function in
> > >   that we do not use an urb to transfer data from the device to the
> > > -driver. Instead we call the :c:func:`usb_bulk_msg` function, which can be used
> > > +driver. Instead we call usb_bulk_msg(), which can be used
> > >   to send or receive data from a device without having to create urbs and
> > > -handle urb completion callback functions. We call the :c:func:`usb_bulk_msg`
> > > -function, giving it a buffer into which to place any data received from
> > > +handle urb completion callback functions. We call usb_bulk_msg(),
> > > +giving it a buffer into which to place any data received from
> > >   the device and a timeout value. If the timeout period expires without
> > >   receiving any data from the device, the function will fail and return an
> > >   error message. This can be shown with the following code::
> > >       /* do an immediate bulk read to get data from the device */
> > > -    retval = usb_bulk_msg (skel->dev,
> > > -			   usb_rcvbulkpipe (skel->dev,
> > > -			   skel->bulk_in_endpointAddr),
> > > -			   skel->bulk_in_buffer,
> > > -			   skel->bulk_in_size,
> > > -			   &count, 5000);
> > > +    rv = usb_bulk_msg(dev->udev,
> > 
> > Why are you changing the varible name?  That seems unnecessary.
> Reason is that retval does not exist in skel_read().

Neither does any call to usb_bulk_msg().  So this is not code that is
from that file at all.  "retval" is easier to understand than "rv".

> > Also, any reason you aren't cc:ing the USB maintainer on these changes?  :)
> According to:
> perl scripts/get_maintainer.pl --separator , --nokeywords --nogit
> --nogit-fallback --norolestats -f
> Documentation/driver-api/usb/writing_usb_driver.rst
> Jonathan Corbet
> <corbet@lwn.net>,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org
> you are not in charge.

Ah, documentation isn't added to the maintainers entry for USB, I'll go
fix that up...

But note, my name is at the top of that file still, right?

thanks,

greg k-h
