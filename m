Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804A44E621D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiCXLIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240446AbiCXLIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC8419A9BA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648120036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1T0yWbiZx8k6dMvysOvcdB5ykkIHbUMTZtgTTPZEYIg=;
        b=V3IVFZTupoQa7heVCz7mi8m6OofsNLmEvmVPXwr6nWM2ML4yo0ml26s9b6nrOxnLdjW5jx
        rzHCkdU4PUQed+fJn9PEv4v2nqnsD9wzTbL3Uttir7fqfvpIfNuVj3WzEUq/bQ5z/LpkEC
        V+1AIO8K+H9vFIRcRshvGTfoBI9ljuM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-kyGiqYT9Ob2ZkPiWlasrTA-1; Thu, 24 Mar 2022 07:07:15 -0400
X-MC-Unique: kyGiqYT9Ob2ZkPiWlasrTA-1
Received: by mail-wm1-f72.google.com with SMTP id f19-20020a7bcd13000000b0038c01defd5aso1457565wmj.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 04:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1T0yWbiZx8k6dMvysOvcdB5ykkIHbUMTZtgTTPZEYIg=;
        b=vw+6VirPX3NJEV3zp8XCjWXkYYrlpwpAQQB7re/eN9g5bU0Knxj0NwjWFtFNcWY8/M
         7H2yclGqEwTGAiRGp93+FTudJHZ7yHPXOFOb11GnRZU0G6VXo/6hPS6D+3CWuvPGEAVV
         jF70CEWs+HEGCWe/UoEL7GYSnt7R2MH7eWaO7UHeHuQLhMTWRNNZXkXvYvso3lhOjlF5
         oZcr6EJPdbosu/jDavAAZnk9IIxFpC9J6bcNTYFX0/oyRrK+VfmJCn/lwBNKrAN1lFps
         k0+0xycST7SNH1wD8Z7xf2PH6W7UeJeysM/7BeQ3pcc6YO3LhYky29U97gd7lebTImXf
         Mszw==
X-Gm-Message-State: AOAM530+Dm5kgcVaUCrlcsn5QwYQiIeLLClVQ/IK9cxaXVhr3X2HYo8G
        OsGx0hEbAcWmQGW3W5x4Ito3t9Qrit7/yTItDrM9F+ylEro919ylHPVkKbWoXokZIFnoUknkDqo
        uHHpHXdKv3mgbFLcUXqFANX+8
X-Received: by 2002:a05:600c:1989:b0:38c:b8b3:8fa8 with SMTP id t9-20020a05600c198900b0038cb8b38fa8mr13195866wmq.18.1648120034251;
        Thu, 24 Mar 2022 04:07:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwA0EZumo0j0KssEfmzzO7vlsnhjaOg1S762Lka3uCpCQVy1H8Qhey1LQHCTinjFhD77Ni4HQ==
X-Received: by 2002:a05:600c:1989:b0:38c:b8b3:8fa8 with SMTP id t9-20020a05600c198900b0038cb8b38fa8mr13195841wmq.18.1648120033977;
        Thu, 24 Mar 2022 04:07:13 -0700 (PDT)
Received: from redhat.com ([2.55.151.118])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d6d52000000b00203da94cf01sm2333203wri.14.2022.03.24.04.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 04:07:13 -0700 (PDT)
Date:   Thu, 24 Mar 2022 07:07:09 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, keirf@google.com
Subject: Re: [PATCH 1/3] virtio: use virtio_device_ready() in
 virtio_device_restore()
Message-ID: <20220324070612-mutt-send-email-mst@kernel.org>
References: <20220324084004.14349-1-jasowang@redhat.com>
 <20220324084004.14349-2-jasowang@redhat.com>
 <20220324064205-mutt-send-email-mst@kernel.org>
 <20220324110307.iizkdwuhc5c75noj@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324110307.iizkdwuhc5c75noj@sgarzare-redhat>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 12:03:07PM +0100, Stefano Garzarella wrote:
> On Thu, Mar 24, 2022 at 06:48:05AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Mar 24, 2022 at 04:40:02PM +0800, Jason Wang wrote:
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > 
> > > This avoids setting DRIVER_OK twice for those drivers that call
> > > virtio_device_ready() in the .restore
> > 
> > Is this trying to say it's faster?
> 
> Nope, I mean, when I wrote the original version, I meant to do the same
> things that we do in virtio_dev_probe() where we called
> virtio_device_ready() which not only set the state, but also called
> .enable_cbs callback.
> 
> Was this a side effect and maybe more compliant with the spec?


Sorry I don't understand the question. it says "avoids setting DRIVER_OK twice" -
why is that advantageous and worth calling out in the commit log?


> > If yes this one looks like a red herring. Yes we skip a write but we
> > replace it with a read which is not better performance-wise.
> > If we want to optimize this, it is better to just do that inside
> > virtio_add_status:
> > 
> > 
> > 
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index 75c8d560bbd3..cd943c31bdbb 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -161,8 +161,14 @@ static void virtio_config_enable(struct virtio_device *dev)
> > 
> > void virtio_add_status(struct virtio_device *dev, unsigned int status)
> > {
> > +	unsigned int device_status;
> > +
> > 	might_sleep();
> > -	dev->config->set_status(dev, dev->config->get_status(dev) | status);
> > +
> > +	device_status = dev->config->get_status(dev);
> > +
> > +	if (status & ~device_status)
> > +		dev->config->set_status(dev, device_status | status);
> > }
> > EXPORT_SYMBOL_GPL(virtio_add_status);
> 
> Could there be a case where we want to set the status again even though the
> device tells us it's already set?
> 
> I think not, so I guess it's okay.
> 
> > 
> > 
> > > and it will allows us to do
> > > extension on virtio_device_ready() without duplicating codes.
> > > 
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/virtio/virtio.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > index 22f15f444f75..75c8d560bbd3 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -526,8 +526,9 @@ int virtio_device_restore(struct virtio_device *dev)
> > >  			goto err;
> > >  	}
> > > 
> > > -	/* Finally, tell the device we're all set */
> > > -	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
> > > +	/* If restore didn't do it, mark device DRIVER_OK ourselves. */
> > 
> > I preferred the original comment, it said why we are doing this,
> > new one repeats what code is doing.
> 
> I agree, copy & paste from virtio_dev_probe().
> 
> Jason can you fix this patch or should I resend?
> 
> Thanks,
> Stefano

