Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2779146C75D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbhLGWYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:24:38 -0500
Received: from netrider.rowland.org ([192.131.102.5]:47385 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233310AbhLGWYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:24:37 -0500
Received: (qmail 553011 invoked by uid 1000); 7 Dec 2021 17:21:05 -0500
Date:   Tue, 7 Dec 2021 17:21:05 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guo Zhengkui <guozhengkui@vivo.com>, Li Jun <jun.li@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Peter Chen <peter.chen@nxp.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@vivo.com
Subject: Re: [PATCH] usb: core: hcd: fix bug: application of sizeof to pointer
Message-ID: <Ya/eUbdN1+ABFVWf@rowland.harvard.edu>
References: <20211207135401.5507-1-guozhengkui@vivo.com>
 <Ya9yZX3JsuO8OcVJ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya9yZX3JsuO8OcVJ@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 03:40:37PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Dec 07, 2021 at 09:53:47PM +0800, Guo Zhengkui wrote:
> > Fix following error:
> > ./drivers/usb/core/hcd.c:1284:38-44: ERROR:
> > application of sizeof to pointer.
> 
> What generated this error?
> 
> > 
> > Use sizeof(*vaddr) instead.
> > 
> > Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> > ---
> >  drivers/usb/core/hcd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> > index 4d326ee12c36..996d5273cf60 100644
> > --- a/drivers/usb/core/hcd.c
> > +++ b/drivers/usb/core/hcd.c
> > @@ -1281,7 +1281,7 @@ static int hcd_alloc_coherent(struct usb_bus *bus,
> >  		return -EFAULT;
> >  	}
> >  
> > -	vaddr = hcd_buffer_alloc(bus, size + sizeof(vaddr),
> > +	vaddr = hcd_buffer_alloc(bus, size + sizeof(*vaddr),
> 
> I think you just broke the code.
> 
> Look at this closer and see what the function is doing with this buffer
> and if you still think your patch is correct, please rewrite the
> changelog text to explain why it is so (hint, just using the output of
> coccinelle isn't ok.)

Although the patch is definitely wrong, the code could stand to be 
improved.  The value stored at the end of the buffer is *vaddr_handle 
converted to an unsigned long, but the space reserved for this value is 
sizeof(vaddr) -- which doesn't make much sense since vaddr is a pointer 
to unsigned char.  The code implicitly relies on the fact that unsigned 
long takes up the same amount of space as a pointer.

Readers wouldn't have to stop and figure this out if the amount of 
reserved space was simply set to sizeof(unsigned long) rather than 
sizeof(vaddr).

Alan Stern
