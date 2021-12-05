Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C023D468A6E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 12:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhLELEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 06:04:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55192 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhLELEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 06:04:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 049A9B80D34;
        Sun,  5 Dec 2021 11:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3452CC341C7;
        Sun,  5 Dec 2021 11:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638702062;
        bh=w0MIhEc2aUBmc7ByVvn7xAJp4K+fQ2LTj/xcztnBI5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IJaYo5cvZVcToITKnWujVs7QAdMX86OtUVVKUYy/Dr/cEuud/0Sjn+f3SFztKCue2
         fBX9KG2gs+5BDzKltNqhk6DU677JTfJL4ADr5M5GCEZteU7rYrK0Ru7UqHrsacLaqt
         Q1HU5s7KnaWIVQrnw4snAZfe2TNUo/+BbD5FEafc=
Date:   Sun, 5 Dec 2021 12:00:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/4] Docs: usb: update usb_bulk_msg receiving example
Message-ID: <Yayb6+SrQKUG4bDl@kroah.com>
References: <cover.1638630342.git.philipp.g.hortmann@gmail.com>
 <0bd9336e18abad338b4967664a4667b96dae6be6.1638630342.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bd9336e18abad338b4967664a4667b96dae6be6.1638630342.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2021 at 05:35:11PM +0100, Philipp Hortmann wrote:
> Clarification that this example is not in the driver template anymore.
> Update code example so that it fits best to usb-skeleton.c
> Update format of function names
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
> V1 -> V2: Added "Update format of function names" to patch description
>           Corrected format of function names like the following example:
>           "`usb_bulk_msg` function" to "usb_bulk_msg()"
> ---
>  .../driver-api/usb/writing_usb_driver.rst     | 32 +++++++++----------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
> index b43e1ce49f0e..ed11398837e5 100644
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
> +driver. Instead we call usb_bulk_msg(), which can be used
>  to send or receive data from a device without having to create urbs and
> -handle urb completion callback functions. We call the :c:func:`usb_bulk_msg`
> -function, giving it a buffer into which to place any data received from
> +handle urb completion callback functions. We call usb_bulk_msg(),
> +giving it a buffer into which to place any data received from
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

Why are you changing the varible name?  That seems unnecessary.

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

Leaving the variable name alone keeps this patch much smaller.

>  
>  
> -The :c:func:`usb_bulk_msg` function can be very useful for doing single reads
> +usb_bulk_msg() can be very useful for doing single reads

You are doing different things in this patch, one is converting the
function style and one is updating the text.  How about doing just the
function name stuff first, all in one patch, and then the updates, as
that would make it much easier to read.

Also, any reason you aren't cc:ing the USB maintainer on these changes?  :)

thanks,

greg k-h
