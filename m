Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5641D463F09
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343612AbhK3UNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:13:53 -0500
Received: from netrider.rowland.org ([192.131.102.5]:53183 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1343593AbhK3UNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:13:49 -0500
Received: (qmail 337320 invoked by uid 1000); 30 Nov 2021 15:10:28 -0500
Date:   Tue, 30 Nov 2021 15:10:28 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/4] Docs: usb: update usb_bulk_msg receiving example
Message-ID: <YaaFNO1t3GIaGFPI@rowland.harvard.edu>
References: <cover.1638152984.git.philipp.g.hortmann@gmail.com>
 <28a76eedad7027277754cef84ca34810b0cfe6f4.1638152984.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28a76eedad7027277754cef84ca34810b0cfe6f4.1638152984.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 09:21:41PM +0100, Philipp Hortmann wrote:
> Clarification that this example is not in the driver template anymore.
> Update code example so that it fits best to usb-skeleton.c
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
>  .../driver-api/usb/writing_usb_driver.rst     | 30 +++++++++----------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
> index b43e1ce49f0e..a9608ad18d77 100644
> --- a/Documentation/driver-api/usb/writing_usb_driver.rst
> +++ b/Documentation/driver-api/usb/writing_usb_driver.rst
> @@ -218,36 +218,36 @@ do very much processing at that time. Our implementation of
>  ``skel_write_bulk_callback`` merely reports if the urb was completed
>  successfully or not and then returns.
>  
> -The read function works a bit differently from the write function in
> +This read function works a bit differently from the write function in
>  that we do not use an urb to transfer data from the device to the
> -driver. Instead we call the :c:func:`usb_bulk_msg` function, which can be used
> +driver. Instead we call `usb_bulk_msg` function, which can be used
>  to send or receive data from a device without having to create urbs and
> -handle urb completion callback functions. We call the :c:func:`usb_bulk_msg`
> +handle urb completion callback functions. We call `usb_bulk_msg`
>  function, giving it a buffer into which to place any data received from

The reason for the last two changes above isn't clear.  You removed some of the 
markup indicators and made the text ungrammatical.  This does not seem like an 
improvement.

Alan Stern

>  the device and a timeout value. If the timeout period expires without
>  receiving any data from the device, the function will fail and return an
>  error message. This can be shown with the following code::
>  
>      /* do an immediate bulk read to get data from the device */
> -    retval = usb_bulk_msg (skel->dev,
> -			   usb_rcvbulkpipe (skel->dev,
> -			   skel->bulk_in_endpointAddr),
> -			   skel->bulk_in_buffer,
> -			   skel->bulk_in_size,
> -			   &count, 5000);
> +    rv = usb_bulk_msg(dev->udev,
> +		      usb_rcvbulkpipe (dev->udev,
> +		      dev->bulk_in_endpointAddr),
> +		      dev->bulk_in_buffer,
> +	              dev->bulk_in_size,
> +		      &len, 5000);
>      /* if the read was successful, copy the data to user space */
> -    if (!retval) {
> -	    if (copy_to_user (buffer, skel->bulk_in_buffer, count))
> -		    retval = -EFAULT;
> +    if (!rv) {
> +	    if (copy_to_user (buffer, dev->bulk_in_buffer, len))
> +		    rv = -EFAULT;
>  	    else
> -		    retval = count;
> +		    rv = len;
>      }
>  
>  
> -The :c:func:`usb_bulk_msg` function can be very useful for doing single reads
> +Function `usb_bulk_msg` can be very useful for doing single reads
>  or writes to a device; however, if you need to read or write constantly to
>  a device, it is recommended to set up your own urbs and submit them to
> -the USB subsystem.
> +the USB subsystem. The template uses urbs for read and write.
>  
>  When the user program releases the file handle that it has been using to
>  talk to the device, the release function in the driver is called. In
> -- 
> 2.25.1
> 
