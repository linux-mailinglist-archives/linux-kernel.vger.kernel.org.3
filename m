Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02054BF2C4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiBVHlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiBVHlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:41:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFD2128589
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 23:40:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 57F05CE12FE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440B9C340E8;
        Tue, 22 Feb 2022 07:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645515645;
        bh=W2j8A9jc87ifeEDwebVUMF/iX4lmFyZxax0K5tYjNFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qwOMP8C9Yl/c0BR6UKgAJY3K0w4qpyyt6OP7KB24Jsyt7yWSoi6jOhkUboKMNciqx
         Ha38MZheNrSAuJAyvIGwjNlKdvmZbydzySt3iKZG/qkwhV7DCsOoXzF0MtFqMwF5rd
         f0nlNzmoLPXYypP0UhJrJ4P5CxdI3TEEPZDtWTLY=
Date:   Tue, 22 Feb 2022 08:40:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: Free DMA range map when device is released
Message-ID: <YhSTelz4q2XW8man@kroah.com>
References: <20220216094128.4025861-1-marten.lindahl@axis.com>
 <CAL_JsqKQ2sZ1YnxGzBvVfHBAq7b34pT4=qs147RsFMjFuFJc+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKQ2sZ1YnxGzBvVfHBAq7b34pT4=qs147RsFMjFuFJc+Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 09:45:09AM -0600, Rob Herring wrote:
> On Wed, Feb 16, 2022 at 3:42 AM Mårten Lindahl <marten.lindahl@axis.com> wrote:
> >
> > When unbinding/binding a driver with DMA mapped memory, the DMA map is
> > not freed before the driver is reloaded. This leads to a memory leak
> > when the DMA map is overwritten when reprobing the driver.
> >
> > This can be reproduced with a platform driver having a dma-range:
> >
> > dummy {
> >         ...
> >         #address-cells = <0x2>;
> >         #size-cells = <0x2>;
> >         ranges;
> >         dma-ranges = <...>;
> >         ...
> > };
> >
> > and then unbinding/binding it:
> >
> > ~# echo soc:dummy >/sys/bus/platform/drivers/<driver>/unbind
> >
> > DMA map object 0xffffff800b0ae540 still being held by &pdev->dev
> >
> > ~# echo soc:dummy >/sys/bus/platform/drivers/<driver>/bind
> > ~# echo scan > /sys/kernel/debug/kmemleak
> > ~# cat /sys/kernel/debug/kmemleak
> > unreferenced object 0xffffff800b0ae540 (size 64):
> >   comm "sh", pid 833, jiffies 4295174550 (age 2535.352s)
> >   hex dump (first 32 bytes):
> >     00 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >     00 00 00 80 00 00 00 00 00 00 00 80 00 00 00 00  ................
> >   backtrace:
> >     [<ffffffefd1694708>] create_object.isra.0+0x108/0x344
> >     [<ffffffefd1d1a850>] kmemleak_alloc+0x8c/0xd0
> >     [<ffffffefd167e2d0>] __kmalloc+0x440/0x6f0
> >     [<ffffffefd1a960a4>] of_dma_get_range+0x124/0x220
> >     [<ffffffefd1a8ce90>] of_dma_configure_id+0x40/0x2d0
> >     [<ffffffefd198b68c>] platform_dma_configure+0x5c/0xa4
> >     [<ffffffefd198846c>] really_probe+0x8c/0x514
> >     [<ffffffefd1988990>] __driver_probe_device+0x9c/0x19c
> >     [<ffffffefd1988cd8>] device_driver_attach+0x54/0xbc
> >     [<ffffffefd1986634>] bind_store+0xc4/0x120
> >     [<ffffffefd19856e0>] drv_attr_store+0x30/0x44
> >     [<ffffffefd173c9b0>] sysfs_kf_write+0x50/0x60
> >     [<ffffffefd173c1c4>] kernfs_fop_write_iter+0x124/0x1b4
> >     [<ffffffefd16a013c>] new_sync_write+0xdc/0x160
> >     [<ffffffefd16a256c>] vfs_write+0x23c/0x2a0
> >     [<ffffffefd16a2758>] ksys_write+0x64/0xec
> >
> > To prevent this we should free the dma_range_map when the device is
> > released.
> >
> > Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Fixes: e0d072782c73 ("dma-mapping: introduce DMA range map,
> supplanting dma_pfn_offset")
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> I've got a follow-up patch to refactor the 3 occurrences of this same
> deinit code.

Now queued up, so feel free to send the follow-up patch too.

thanks,

greg k-h
