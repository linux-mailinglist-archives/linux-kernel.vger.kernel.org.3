Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498FB48F21B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 22:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiANVtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 16:49:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229782AbiANVtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 16:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642196946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GUR+by35RD9Gl4oaWlStDXiPFR6+v6HcjEvlAlzL5kY=;
        b=KVnBGfdAkvpWFcYvcEuSy+FtQcHOy2N63nS1YOStdoBkPfPK4eW4T9wzXiuLYoQt5HXsh+
        UU1mfPsAC651VF9YPQwtjQ0f1MwYE9bocTSErlo/M+bqCMKI6wQllswrUnPmHUe70zmktH
        AXPQXD8Vyhvm+5RhjTgjymxgCfE59z8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-rSc8iK1GN4e-WWoCQ57F6A-1; Fri, 14 Jan 2022 16:49:05 -0500
X-MC-Unique: rSc8iK1GN4e-WWoCQ57F6A-1
Received: by mail-ed1-f69.google.com with SMTP id l10-20020a056402124a00b0040186fbe40dso696166edw.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 13:49:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GUR+by35RD9Gl4oaWlStDXiPFR6+v6HcjEvlAlzL5kY=;
        b=qboV30tZLwtBl3sRI7olEUf3EJYx9i2zNYXv90ptNWIS1JZg9XgwL14dMb32YWd4P7
         gtuwupmYQz7EpvpckS4nZAi+SD2i+87X1SRlAC7FCFIPAL+ZGNpXVAo5SN438j/Mk0p8
         rMc86kC/lI8gdQXcVD/I847AeM8FdFQtknnJ5UawBMFP5sAlh1iz+gfMvTS10qxsJWOh
         TiqetruS5BoxKJg8Xnwx5MenTa7s3mhps1EPGxsXwYrgiOPh1GVhd/RwyE8BfKOhBmY4
         7LvjYWSLMeiu+MhK9xl5WyTJBCOLlHbJ0exxCtQBxPQkBw7+A23lSWSZMJ6axFAMveau
         nmOw==
X-Gm-Message-State: AOAM532NUenqX9xVeQHYhDnfPA6nRh+tqN4cYvev4ZbSKIlCxu7YmPSH
        YN0eZzR1qxnIQjr6KC9l1OUF77NyVDusrRmeula0EO9nPuDirdxGmpXjfUJ/ZlXFG62r9WCcljV
        JlQjbH8KgqQELesTCyscFL7Tb
X-Received: by 2002:a17:906:2bc3:: with SMTP id n3mr9000679ejg.332.1642196944328;
        Fri, 14 Jan 2022 13:49:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+EhfKm9kr1Il/CwTLU+uemQRS1JNWhcH3W2jEzws+nrb27dmZUKUHTPk9Vhb37jnhOTC5gQ==
X-Received: by 2002:a17:906:2bc3:: with SMTP id n3mr9000665ejg.332.1642196944084;
        Fri, 14 Jan 2022 13:49:04 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
        by smtp.gmail.com with ESMTPSA id i16sm2770595edu.29.2022.01.14.13.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 13:49:02 -0800 (PST)
Date:   Fri, 14 Jan 2022 16:48:57 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Amit Shah <amit@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio_console: break out of buf poll on remove
Message-ID: <20220114164549-mutt-send-email-mst@kernel.org>
References: <20211005070354.265164-1-mst@redhat.com>
 <YVxUNudHGxURHH/4@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVxUNudHGxURHH/4@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 03:33:42PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 05, 2021 at 03:04:07AM -0400, Michael S. Tsirkin wrote:
> > A common pattern for device reset is currently:
> > vdev->config->reset(vdev);
> > .. cleanup ..
> > 
> > reset prevents new interrupts from arriving and waits for interrupt
> > handlers to finish.
> > 
> > However if - as is common - the handler queues a work request which is
> > flushed during the cleanup stage, we have code adding buffers / trying
> > to get buffers while device is reset. Not good.
> > 
> > This was reproduced by running
> > 	modprobe virtio_console
> > 	modprobe -r virtio_console
> > in a loop.
> 
> That's a pathological case that is not "in the field" except by people
> who want to abuse the system as root.  And they can do much worse things
> than that.
> 
> > Fixing this comprehensively needs some thought, and new APIs.
> > Let's at least handle the specific case of virtio_console
> > removal that was reported in the field.
> 
> Let's fix this correctly, don't just hack it up now.

Well I poked at it some more, and things are not as bad
as I thought. It's mostly just console and possibly virtio-mem.
Well and virtio-bt has a completely borken cleanup that
does not even bother to reset the device, but that's
a separate issue, discussing it with the maintainer.

So I wrote some patches to document the requirements better, added a
wrapper for reset and generally cleaned the API up a bit, and added a
patch for mem, but generally I no longer think we need a major API
change.


> > Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1786239
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/char/virtio_console.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index 7eaf303a7a86..c852ce0b4d56 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -1956,6 +1956,12 @@ static void virtcons_remove(struct virtio_device *vdev)
> >  	list_del(&portdev->list);
> >  	spin_unlock_irq(&pdrvdata_lock);
> >  
> > +	/* Device is going away, exit any polling for buffers */
> > +	virtio_break_device(vdev);
> > +	if (use_multiport(portdev))
> > +		flush_work(&portdev->control_work);
> > +	else
> > +		flush_work(&portdev->config_work);
> >  	/* Disable interrupts for vqs */
> 
> newline before comment?

sure

> thanks,
> 
> greg k-h

