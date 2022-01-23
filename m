Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8320B4972CC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 17:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238413AbiAWQIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 11:08:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60890 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238406AbiAWQIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 11:08:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21E9960F7E
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 16:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D919BC340E4;
        Sun, 23 Jan 2022 16:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642954122;
        bh=ExT9K/VARuNRP16/Jqu6RgZol1HI4WOkK1n71Pls1Pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+Z8K22c20bxkDXKfIvyvGrfgZNwTnUZit4yjFBSymkiHhs1yQctiN0dQOwiXlz8J
         uFs/coWsaH5Vmq8JHkz5BlqVJgY6MXJLUUY1KxqFe3RIyLHvBoznLsaixxqKwZdqE1
         GiSUH7BefJgSAZX0RIzIGc6woGBNZQaS0tDxh3Cc=
Date:   Sun, 23 Jan 2022 17:08:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>, Arnd Bergmann <arnd@arndb.de>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] habanalabs: Remove unused enum member DMA_SRAM_TO_SRAM
Message-ID: <Ye19hz9r0poT5wUe@kroah.com>
References: <20220111114724.7987-1-cai.huoqing@linux.dev>
 <CAFCwf10GWN_hdsvUf+7dFFK=CwjuGxXPZZt8c2dkVOb24VZxcQ@mail.gmail.com>
 <Ye1ua3ixuSfdhiRc@kroah.com>
 <CAFCwf12H4Nz-dPrYwJFyygWUn0tvoLKpHfmBCHmqpX6Fs02cSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf12H4Nz-dPrYwJFyygWUn0tvoLKpHfmBCHmqpX6Fs02cSw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 06:01:53PM +0200, Oded Gabbay wrote:
> On Sun, Jan 23, 2022 at 5:04 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Jan 23, 2022 at 04:43:15PM +0200, Oded Gabbay wrote:
> > > On Tue, Jan 11, 2022 at 1:47 PM Cai Huoqing <cai.huoqing@linux.dev> wrote:
> > > >
> > > > The driver don't support the SRAM-to-SRAM translation of DMA,
> > > > so remove 'DMA_SRAM_TO_SRAM'.
> > > >
> > > > Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> > > > ---
> > > >  drivers/misc/habanalabs/include/goya/goya_packets.h | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/drivers/misc/habanalabs/include/goya/goya_packets.h b/drivers/misc/habanalabs/include/goya/goya_packets.h
> > > > index ef54bad20509..25fbebdc6143 100644
> > > > --- a/drivers/misc/habanalabs/include/goya/goya_packets.h
> > > > +++ b/drivers/misc/habanalabs/include/goya/goya_packets.h
> > > > @@ -36,7 +36,6 @@ enum goya_dma_direction {
> > > >         DMA_SRAM_TO_HOST,
> > > >         DMA_DRAM_TO_HOST,
> > > >         DMA_DRAM_TO_DRAM,
> > > > -       DMA_SRAM_TO_SRAM,
> > > >         DMA_ENUM_MAX
> > > >  };
> > > >
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > This is a general spec file in our s/w stack, and therefore a change
> > > in it in the driver will cause our driver to be out of sync with our
> > > user-space stack. i.e. the value of DMA_ENUM_MAX will be different in
> > > the driver and in the user-space stack. I don't know if there will be
> > > any consequences but I prefer not to risk it.
> >
> > If this is synced to userspace, shouldn't it be in a uapi file with a
> > specific value associated with it?
> >
> > thanks,
> >
> > greg k-h
> 
> Yes, it was a mistake from day 1. A mistake we didn't repeat in future ASICs.
> I take great care of putting anything that is synced between driver
> and userspace in our uapi file.
> 
> Having said that, after almost 3 years of having this mistake, I feel
> it is not too disastrous to leave it as is.
> Our Goya s/w stack is pretty much stable and I don't want to make
> changes without good reason.

You should just move this to a uapi file to show that it is something
that can't be changed.  Can't you do that without breaking anything on
the kernel side?

Otherwise maintaining this is going to be hard as no one has a clue that
this is a value that userspace uses.

thanks,

greg k-h
