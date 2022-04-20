Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDF0507D96
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 02:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358305AbiDTA01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 20:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiDTA00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:26:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD582ED7F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 17:23:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9D3061492
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E10DC385A7;
        Wed, 20 Apr 2022 00:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650414221;
        bh=aTlM2Tp8RNtiGc5s4RUzm0VyJsCB1Pdx2yfO4cSCkdc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=tfupncDT0EfvO8f++UYSaFQrKMOzuqvCcrXXHy3SpGd7juEWTG4XFNQJORuBF3upn
         GTMddd7Y5y2fFufNEFcH4j4BL4JI/aqzp8egM0yZ47KZYFjiOZw7p00G/hJP1N3ofB
         ZvQitQoiSPjasTUwbirwIx+uIDRhABEsNPZhHEBIqW/gmTP+Vh0feQTzvOL1ZLksdZ
         yaGBY+od6Nem/JBq4HAeRXOv2Oaz8Oj+JqvheIGVy8l8g2W8Mv4GPeBcoo/q8zGZZE
         Osdo5mtijkzRKUtdnWM2P5ZqCXh/Rinoi/0+gXegn9qAhe8G9M0c/xeT4IxPXPTwjx
         xr5CBnUsA3jvQ==
Date:   Tue, 19 Apr 2022 17:23:40 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr <olekstysh@gmail.com>
cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 6/6] arm/xen: Assign xen-virtio DMA ops for virtio
 devices in Xen guests
In-Reply-To: <5afb9e61-4164-9cc9-278a-911fc21f4f6c@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204191717020.915916@ubuntu-linux-20-04-desktop>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com> <1649963973-22879-7-git-send-email-olekstysh@gmail.com> <alpine.DEB.2.22.394.2204151305050.915916@ubuntu-linux-20-04-desktop> <YlpdBHKT1bYzZe2e@infradead.org> <f879622e-5656-deb1-1930-f0cd180a4ab1@gmail.com>
 <alpine.DEB.2.22.394.2204181202080.915916@ubuntu-linux-20-04-desktop> <6a04cc34-fbb3-44d8-c1a4-03bda5b3deb1@gmail.com> <b68163be-ad43-7773-22ff-e83191886626@suse.com> <5afb9e61-4164-9cc9-278a-911fc21f4f6c@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-65868541-1650414142=:915916"
Content-ID: <alpine.DEB.2.22.394.2204191723180.915916@ubuntu-linux-20-04-desktop>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-65868541-1650414142=:915916
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2204191723181.915916@ubuntu-linux-20-04-desktop>

On Tue, 19 Apr 2022, Oleksandr wrote:
> On 19.04.22 17:48, Juergen Gross wrote:
> > On 19.04.22 14:17, Oleksandr wrote:
> > > 
> > > Hello Stefano, Juergen
> > > 
> > > 
> > > On 18.04.22 22:11, Stefano Stabellini wrote:
> > > > On Mon, 18 Apr 2022, Oleksandr wrote:
> > > > > On 16.04.22 09:07, Christoph Hellwig wrote:
> > > > > 
> > > > > Hello Christoph
> > > > > 
> > > > > > On Fri, Apr 15, 2022 at 03:02:45PM -0700, Stefano Stabellini wrote:
> > > > > > > This makes sense overall. Considering that the swiotlb-xen case
> > > > > > > and the
> > > > > > > virtio case are mutually exclusive, I would write it like this:
> > > > > > Curious question:  Why can't the same grant scheme also be used for
> > > > > > non-virtio devices?  I really hate having virtio hooks in the arch
> > > > > > dma code.  Why can't Xen just say in DT/ACPI that grants can be used
> > > > > > for a given device?
> > > > [...]
> > > > 
> > > > > This patch series tries to make things work with "virtio" devices in
> > > > > Xen
> > > > > system without introducing any modifications to code under
> > > > > drivers/virtio.
> > > > 
> > > > Actually, I think Christoph has a point.
> > > > 
> > > > There is nothing inherently virtio specific in this patch series or in
> > > > the "xen,dev-domid" device tree binding.
> > > 
> > > 
> > > Although the main intention of this series was to enable using virtio
> > > devices in Xen guests, I agree that nothing in new DMA ops layer
> > > (xen-virtio.c) is virtio specific (at least at the moment). Regarding the
> > > whole patch series I am not quite sure, as it uses
> > > arch_has_restricted_virtio_memory_access(). >
> > > >   Assuming a given device is
> > > > emulated by a Xen backend, it could be used with grants as well.
> > > > 
> > > > For instance, we could provide an emulated e1000 NIC with a
> > > > "xen,dev-domid" property in device tree. Linux could use grants with it
> > > > and the backend could map the grants. It would work the same way as
> > > > virtio-net/block/etc. Passthrough devices wouldn't have the
> > > > "xen,dev-domid" property, so no problems.
> > > > 
> > > > So I think we could easily generalize this work and expand it to any
> > > > device. We just need to hook on the "xen,dev-domid" device tree
> > > > property.
> > > > 
> > > > I think it is just a matter of:
> > > > - remove the "virtio,mmio" check from xen_is_virtio_device
> > > > - rename xen_is_virtio_device to something more generic, like
> > > >    xen_is_grants_device
> > 
> > xen_is_grants_dma_device, please. Normal Xen PV devices are covered by
> > grants, too, and I'd like to avoid the confusion arising from this.
> 
> 
> yes, this definitely makes sense as we need to distinguish
> 
> 
> > 
> > 
> > > > - rename xen_virtio_setup_dma_ops to something more generic, like
> > > >    xen_grants_setup_dma_ops
> > > > 
> > > > And that's pretty much it.
> > > 
> > > + likely renaming everything in that patch series not to mention virtio
> > > (mostly related to xen-virtio.c internals).
> > > 
> > > 
> > > Stefano, thank you for clarifying Christoph's point.
> > > 
> > > Well, I am not against going this direction. Could we please make a
> > > decision on this? @Juergen, what is your opinion?
> > 
> > Yes, why not.
> 
> 
> ok, thank you for confirming.
> 
> 
> > 
> > 
> > Maybe rename xen-virtio.c to grant-dma.c?
> 
> 
> Personally I don't mind.
> 
> 
> > 
> > I'd keep the XEN_VIRTIO related config option, as this will be the normal
> > use
> > case. grant-dma.c should be covered by a new hidden config option
> > XEN_GRANT_DMA
> > selected by XEN_VIRTIO.
> 
> 
> I got it, ok
> 
> 
> > 
> > 
> > CONFIG_XEN_VIRTIO should still guard
> > xen_has_restricted_virtio_memory_access().
> 
> 
> ok
> 
> 
> So a few questions to clarify:
> 
> 1. What is the best place to keep "xen,dev-domid" binding's description now? I
> think that proposed in current series place
> (Documentation/devicetree/bindings/virtio/) is not good fit now.

I would probably add it to the existing
Documentation/devicetree/bindings/arm/xen.txt.


> 2. I assume the logic in the current patch will remain the same, I mean we
> will still assign Xen grant DMA ops from xen_setup_dma_ops() here?

Yes I think so
--8323329-65868541-1650414142=:915916--
