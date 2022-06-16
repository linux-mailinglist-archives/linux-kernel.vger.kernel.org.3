Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD4354DF45
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 12:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiFPKlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 06:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiFPKk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:40:56 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B496C5B3EC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 03:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1655376055;
  x=1686912055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1GKHri+mfZWVis30jcLTBWUp0tWv6T1Jmj+OWDK8Xpk=;
  b=VHeFN9o6Y9lUpgq2z8I8uaV7IMb+vhWWrnSZaROm3eKNoRrFsQZWI01m
   Z++GB/HaTJI4KdaWmpdjE41R0Cbe/SpjA7U7OO1XIih98wrS9MsZ2ugIZ
   u5eGoEzQL81CbFTdAWZaKiywPOyzkYDGs48SnMKU+o8tG/AmNMBWO4W28
   va6IGZlCz/XTpv8z3z/A2wBV/sjlew3S9KoN8b7BF07/OiMq8LaxStd+R
   RQdpwQqAvAXCYsaybU1lJLh+HYxG0vS4Qn3DokXKpZLaIXt71E1miVhM7
   8bBzQCmLVLImQQBz8mB8TfmejNXMQGrU4AldqZ89fpyrkNkS6hHX/j06t
   A==;
Date:   Thu, 16 Jun 2022 12:40:52 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        kernel <kernel@axis.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] um: virt-pci: set device ready in probe()
Message-ID: <20220616104052.GA7518@axis.com>
References: <20220610151203.3492541-1-vincent.whitchurch@axis.com>
 <CACGkMEsf5p=JvHHjd_jtEwtdQijTR7ZAwetEuSG-oprF6RBsVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACGkMEsf5p=JvHHjd_jtEwtdQijTR7ZAwetEuSG-oprF6RBsVA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 08:58:40AM +0200, Jason Wang wrote:
> On Fri, Jun 10, 2022 at 11:12 PM Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
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

Yes, I guess that last line could have been added in a separate patch.
When adding the cleanup in the error path for the virtio_device_ready()
call added by the patch I noticed that this driver wasn't deleting its
virtqueues in the error path, unlike other virtio drivers I looked at.
