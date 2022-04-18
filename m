Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB365505E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241453AbiDRTNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiDRTNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:13:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD77F31225
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:11:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92ED7B81060
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80A8C385A7;
        Mon, 18 Apr 2022 19:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650309061;
        bh=FqMrB3LTVheJzBcEVjR9TRPvl3+5WxICePYJ9H+WYRE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=iaOMCyRQAZv6m5n78HaBURxK4NMMAN9CI4xs+oSzDJbyFRw0xw+JmtcXEZiLYs6f6
         sWQZINgA/mWWsVjHbXZpZgKYQBG/nbrRkzD9Ng31J6SrfwKPZnCBJ4uvKKloxPuIYU
         gmBsGOVzZg3RriB3VWqZ9plK2DvIAG+cH3w10+YrNfgRh2sngFmSSehrUFTciYqu7T
         zT5w8FDN0R3R3txesKnzG9aufRHfEwzLWhFmgeulNNrs5UcXMXLPapHGO/BNvf2NOf
         jC57LqnXClajT8Mqetp1AltnOuq2ME4B5BFkhuLGN6A/2//wMDcXj42G2e90kh+jIQ
         zqiUjbXtEVKYw==
Date:   Mon, 18 Apr 2022 12:11:00 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr <olekstysh@gmail.com>
cc:     Christoph Hellwig <hch@infradead.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 6/6] arm/xen: Assign xen-virtio DMA ops for virtio
 devices in Xen guests
In-Reply-To: <f879622e-5656-deb1-1930-f0cd180a4ab1@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204181202080.915916@ubuntu-linux-20-04-desktop>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com> <1649963973-22879-7-git-send-email-olekstysh@gmail.com> <alpine.DEB.2.22.394.2204151305050.915916@ubuntu-linux-20-04-desktop> <YlpdBHKT1bYzZe2e@infradead.org>
 <f879622e-5656-deb1-1930-f0cd180a4ab1@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2022, Oleksandr wrote:
> On 16.04.22 09:07, Christoph Hellwig wrote:
> 
> Hello Christoph
> 
> > On Fri, Apr 15, 2022 at 03:02:45PM -0700, Stefano Stabellini wrote:
> > > This makes sense overall. Considering that the swiotlb-xen case and the
> > > virtio case are mutually exclusive, I would write it like this:
> > Curious question:  Why can't the same grant scheme also be used for
> > non-virtio devices?  I really hate having virtio hooks in the arch
> > dma code.  Why can't Xen just say in DT/ACPI that grants can be used
> > for a given device?

[...]

> This patch series tries to make things work with "virtio" devices in Xen
> system without introducing any modifications to code under drivers/virtio.


Actually, I think Christoph has a point.

There is nothing inherently virtio specific in this patch series or in
the "xen,dev-domid" device tree binding. Assuming a given device is
emulated by a Xen backend, it could be used with grants as well.

For instance, we could provide an emulated e1000 NIC with a
"xen,dev-domid" property in device tree. Linux could use grants with it
and the backend could map the grants. It would work the same way as
virtio-net/block/etc. Passthrough devices wouldn't have the
"xen,dev-domid" property, so no problems.

So I think we could easily generalize this work and expand it to any
device. We just need to hook on the "xen,dev-domid" device tree
property.

I think it is just a matter of:
- remove the "virtio,mmio" check from xen_is_virtio_device
- rename xen_is_virtio_device to something more generic, like
  xen_is_grants_device
- rename xen_virtio_setup_dma_ops to something more generic, like
  xen_grants_setup_dma_ops

And that's pretty much it.
