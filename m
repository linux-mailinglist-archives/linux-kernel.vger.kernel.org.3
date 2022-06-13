Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C535548076
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239243AbiFMHZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiFMHZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:25:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43B691AD8B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655105153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kYksMca6fLoLxDb1myDJYCvlRb5ZJzdkaQdlRH2BiTc=;
        b=ezMEtHD42ipmADOGXA/325jg0hx0lmEuvi3t+/UacwRBjFZqeATzfckavcp+pE+V/kIRo7
        QbAPte7dkvtfBfXcUQSD1xRW4TC8Q2+igCrvvJfbRMYfdoyTJ8R7htfmiS0b5GdFgOiBGf
        z4um4ZBaNnNT0qpXIY51byqeZ1kSh5w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-1_rwEuRdNQKn56kWiDvEtQ-1; Mon, 13 Jun 2022 03:25:51 -0400
X-MC-Unique: 1_rwEuRdNQKn56kWiDvEtQ-1
Received: by mail-ed1-f69.google.com with SMTP id ee46-20020a056402292e00b0042dd4d6054dso3437951edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kYksMca6fLoLxDb1myDJYCvlRb5ZJzdkaQdlRH2BiTc=;
        b=3g3sTECLfU+hJ8Q5fy3IUjxukhz1mr8bHuWiDiUK3Z+7p2K6HjvjGvGdPEzkicDz31
         9rcElKsIlwaFQpBs/2qEDCl5R8qKVB+HIcYMCf9I+Br3ddOkwImWZ+ZER5cDCZ4bXxZn
         xG+R8OkPEqM8OV/tq2oIvvTmimKyUm+vcf04vstuYcZVoh05s807McDEhWnBQZsbgjFq
         yIzGyqwoigNREzsNEkzi1mevj1j5ZRAwQkz27yIYqyrLXba3QjJtIQHRpmGmQ4TuK3D7
         algYz7nBD4FMrJz9W2gDGLhWOKy+LAdFokHXVryyg7NhvRZBHWKuMWi0gCu2VOwO4zdD
         Updw==
X-Gm-Message-State: AOAM532ao+kQsxOq22ZsDoktHBmu8TpH9k/LupnJOjjmwuCpcmtu4uRc
        534ciTUIhnUd70bS+ydF58xAzwVZ3Z78pD2jWjgKAChCgQODNDo+zF0GfiExUxM1Tvf9rXApyv2
        aznAuzgPIxigR3WruI01zGILk
X-Received: by 2002:a17:907:f9c:b0:711:734d:a9a2 with SMTP id kb28-20020a1709070f9c00b00711734da9a2mr38702879ejc.690.1655105150274;
        Mon, 13 Jun 2022 00:25:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywq0RchuwuzP0AXkw36tNaeodcHz4xR5kOU96aazMEKAZvn9HC1ZY+djep7p2gq2GI3QYqnQ==
X-Received: by 2002:a17:907:f9c:b0:711:734d:a9a2 with SMTP id kb28-20020a1709070f9c00b00711734da9a2mr38702867ejc.690.1655105150094;
        Mon, 13 Jun 2022 00:25:50 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:107c:be5a:1a30:9f6d:4400:4adc])
        by smtp.gmail.com with ESMTPSA id my6-20020a1709065a4600b006f3ef214db9sm3471983ejc.31.2022.06.13.00.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 00:25:49 -0700 (PDT)
Date:   Mon, 13 Jun 2022 03:25:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>, kernel@axis.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-um@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] um: virt-pci: set device ready in probe()
Message-ID: <20220613032529-mutt-send-email-mst@kernel.org>
References: <20220610151203.3492541-1-vincent.whitchurch@axis.com>
 <CACGkMEsf5p=JvHHjd_jtEwtdQijTR7ZAwetEuSG-oprF6RBsVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEsf5p=JvHHjd_jtEwtdQijTR7ZAwetEuSG-oprF6RBsVA@mail.gmail.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:58:40PM +0800, Jason Wang wrote:
> On Fri, Jun 10, 2022 at 11:12 PM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> >
> > Call virtio_device_ready() to make this driver work after commit
> > b4ec69d7e09 ("virtio: harden vring IRQ"), since the driver uses the
> > virtqueues in the probe function.  (The virtio core sets the device
> > ready when probe returns.)
> >
> > Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > ---
> >  arch/um/drivers/virt-pci.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
> > index 5c092a9153ea..027847023184 100644
> > --- a/arch/um/drivers/virt-pci.c
> > +++ b/arch/um/drivers/virt-pci.c
> > @@ -544,6 +544,8 @@ static int um_pci_init_vqs(struct um_pci_device *dev)
> >         dev->cmd_vq = vqs[0];
> >         dev->irq_vq = vqs[1];
> >
> > +       virtio_device_ready(dev->vdev);
> > +
> >         for (i = 0; i < NUM_IRQ_MSGS; i++) {
> >                 void *msg = kzalloc(MAX_IRQ_MSG_SIZE, GFP_KERNEL);
> >
> > @@ -587,7 +589,7 @@ static int um_pci_virtio_probe(struct virtio_device *vdev)
> >         dev->irq = irq_alloc_desc(numa_node_id());
> >         if (dev->irq < 0) {
> >                 err = dev->irq;
> > -               goto error;
> > +               goto err_reset;
> >         }
> >         um_pci_devices[free].dev = dev;
> >         vdev->priv = dev;
> > @@ -604,6 +606,9 @@ static int um_pci_virtio_probe(struct virtio_device *vdev)
> >
> >         um_pci_rescan();
> >         return 0;
> > +err_reset:
> > +       virtio_reset_device(vdev);
> > +       vdev->config->del_vqs(vdev);
> 
> This part seems to be an independent fix.
> 
> Thanks


Yes good point. I merged as is, oh well.

> >  error:
> >         mutex_unlock(&um_pci_mtx);
> >         kfree(dev);
> > --
> > 2.34.1
> >

