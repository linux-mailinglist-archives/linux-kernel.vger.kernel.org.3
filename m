Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC8949C982
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241207AbiAZMVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241194AbiAZMVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:21:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC71C06161C;
        Wed, 26 Jan 2022 04:21:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62381B81CBB;
        Wed, 26 Jan 2022 12:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CCBC340E6;
        Wed, 26 Jan 2022 12:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643199694;
        bh=EVVNFMBmRDZrmd8r75px+PJ5SYyURniMHufo4K/7jfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yhbbSDyHm6glrzoBDNTPUrFwriA2sJXg8gNGYLm+2xfigHsfOLVdcBC9/NGnxXtxS
         238VXm/GIWTCt6z1fnvw7loVpIFzFI10Ss/YSVtQ1dcYZcesIBx/HiWfqYZ0fJgymj
         FnN3AbPi735t1kZLZX2xe/W6ywu5qr4mJc2bhSYA=
Date:   Wed, 26 Jan 2022 13:21:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6Zmz5YGJ6YqY?= <jj251510319013@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        balbi@kernel.org,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Subject: Re: [PATCH] usb: gadget: function: Fix returning incorrect PNP string
Message-ID: <YfE8y8xpJIwC8Ojo@kroah.com>
References: <20220105040439.3182-1-jj251510319013@gmail.com>
 <Ydb+L+wXfKzXyma9@kroah.com>
 <CAJwFiG+caDOp48R+EMATi9W_hCt-SBoEeeeEK8XGuRWai=bYug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJwFiG+caDOp48R+EMATi9W_hCt-SBoEeeeEK8XGuRWai=bYug@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 10:37:19AM +0800, 陳偉銘 wrote:
> Greg KH <gregkh@linuxfoundation.org> 於 2022年1月6日 週四 下午10:35寫道：
> >
> > On Wed, Jan 05, 2022 at 12:04:39PM +0800, Wei Ming Chen wrote:
> > > There will be 2 leading bytes indicating the total length of
> > > the PNP string, so I think we should add value by 2, otherwise
> > > the PNP string copied to user will not contain the last 2 bytes
> > >
> > > Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
> > > ---
> > >  drivers/usb/gadget/function/f_printer.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
> > > index abec5c58f525..3fb00fd0b5ee 100644
> > > --- a/drivers/usb/gadget/function/f_printer.c
> > > +++ b/drivers/usb/gadget/function/f_printer.c
> > > @@ -1005,9 +1005,11 @@ static int printer_func_setup(struct usb_function *f,
> > >                               break;
> > >                       }
> > >                       value = strlen(dev->pnp_string);
> > > +                     memcpy(buf + 2, dev->pnp_string, value);
> > > +
> > > +                     value += 2;
> > >                       buf[0] = (value >> 8) & 0xFF;
> > >                       buf[1] = value & 0xFF;
> > > -                     memcpy(buf + 2, dev->pnp_string, value);
> > >                       DBG(dev, "1284 PNP String: %x %s\n", value,
> > >                           dev->pnp_string);
> > >                       break;
> > > --
> > > 2.25.1
> > >
> >
> > Are you sure this is correct?
> >
> > How is this related to this recent thread:
> >         https://lore.kernel.org/all/CAKjGFBUdjXcZoVV4jdrgTz4rKThTfZAK4CqreKmBZ4KHE+K1GA@mail.gmail.com/#t
> >
> > your change is different from what is proposed there, why?
> 
> I didn’t notice this thread before I send this patch, I think the
> concept of my change is similar to Volodymyr Lisivka’s change, he/she
> introduced a separate variable for the PNP string length, I think it
> may be clearer and more readable than just “value += 2”
> 
> 
> Another thing that I am not too sure whether I am correct is this line of code
> 
> DBG(dev, "1284 PNP String: %x %s\n", value,
>                              dev->pnp_string);
> 
> What Volodymyr Lisivka changed is like this
> 
> DBG(dev, "1284 PNP String: %x %s\n", pnp_length,
>                              dev->pnp_string);
> 
> In my change, “value” equals to “pnp_length + 2” in Volodymyr
> Lisivka’s change, and I think we should print “the PNP string length +
> 2” instead of “the PNP string length”?
> 

I do not know, I suggest you two work together to get the correct fix
submitted.

thanks,

greg k-h
