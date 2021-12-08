Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F93C46CD3F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 06:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbhLHFri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 00:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhLHFrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 00:47:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2319C061574;
        Tue,  7 Dec 2021 21:44:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CA47FCE1F59;
        Wed,  8 Dec 2021 05:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF16C00446;
        Wed,  8 Dec 2021 05:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638942241;
        bh=6l8IIS+ZBKS+ywGfrSSiZHpPs+BouFC60URWQVIZZYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JkoO9JwLN5rEqJ0KgMcEdu0Zc0ZQSvFsPbdQWvB0PZMhPGsWnrRhewFSsxQ561p2b
         3QsH83ldWGy1DCwOlgkqr+bToOABs/NBDOv56a6iJ5qdvGjARfQjIUfMuR7bMPlQ+A
         KRSQUGkUkVXJNXswrwBlkwj5/7sKeRhh0qLmCLwA=
Date:   Wed, 8 Dec 2021 06:43:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Guo Zhengkui <guozhengkui@vivo.com>, Li Jun <jun.li@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Peter Chen <peter.chen@nxp.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@vivo.com
Subject: Re: [PATCH] usb: core: hcd: fix bug: application of sizeof to pointer
Message-ID: <YbBGGI9wQenI4kP7@kroah.com>
References: <20211207135401.5507-1-guozhengkui@vivo.com>
 <Ya9yZX3JsuO8OcVJ@kroah.com>
 <Ya/eUbdN1+ABFVWf@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya/eUbdN1+ABFVWf@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 05:21:05PM -0500, Alan Stern wrote:
> On Tue, Dec 07, 2021 at 03:40:37PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Dec 07, 2021 at 09:53:47PM +0800, Guo Zhengkui wrote:
> > > Fix following error:
> > > ./drivers/usb/core/hcd.c:1284:38-44: ERROR:
> > > application of sizeof to pointer.
> > 
> > What generated this error?
> > 
> > > 
> > > Use sizeof(*vaddr) instead.
> > > 
> > > Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> > > ---
> > >  drivers/usb/core/hcd.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> > > index 4d326ee12c36..996d5273cf60 100644
> > > --- a/drivers/usb/core/hcd.c
> > > +++ b/drivers/usb/core/hcd.c
> > > @@ -1281,7 +1281,7 @@ static int hcd_alloc_coherent(struct usb_bus *bus,
> > >  		return -EFAULT;
> > >  	}
> > >  
> > > -	vaddr = hcd_buffer_alloc(bus, size + sizeof(vaddr),
> > > +	vaddr = hcd_buffer_alloc(bus, size + sizeof(*vaddr),
> > 
> > I think you just broke the code.
> > 
> > Look at this closer and see what the function is doing with this buffer
> > and if you still think your patch is correct, please rewrite the
> > changelog text to explain why it is so (hint, just using the output of
> > coccinelle isn't ok.)
> 
> Although the patch is definitely wrong, the code could stand to be 
> improved.  The value stored at the end of the buffer is *vaddr_handle 
> converted to an unsigned long, but the space reserved for this value is 
> sizeof(vaddr) -- which doesn't make much sense since vaddr is a pointer 
> to unsigned char.  The code implicitly relies on the fact that unsigned 
> long takes up the same amount of space as a pointer.

Linux requires that an unsigned long is the same size as a pointer, so
this is not a new requirement that is unique to this function :)

thanks,

greg k-h
