Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B19247A7D3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhLTKkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 05:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhLTKkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:40:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9A4C061574;
        Mon, 20 Dec 2021 02:40:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B85C560F59;
        Mon, 20 Dec 2021 10:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86337C36AE9;
        Mon, 20 Dec 2021 10:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639996834;
        bh=VjJdoxtEfB0kqCJWH6U+s0OWdAK8IYbNpe3HSLovq8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bNbHfu0xJXPtoEREu5sedDkjoC8CPHoWqDacoHwAfifup7kAurWxO7B+TIjgO2vGn
         J7xvJSaR0MTHaffZrdFBNCu0yx/kj5NluPgomtzXe3xDAy6czLtYhlwwu+rZQlN4Iz
         doHvgiw+ftHMdyqv4tVYZYJ8csE0ICgZunM1JFmI=
Date:   Mon, 20 Dec 2021 11:40:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     wigin zeng <wigin.zeng@dji.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        First Light <xiaoguang.chen@dji.com>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiDnrZTlpI06IOetlOWkjQ==?= =?utf-8?Q?=3A?= [PATCH] serial:
 8250: add lock for dma rx
Message-ID: <YcBdnzfUceNqdVHb@kroah.com>
References: <YbGygPtkz6ihyW51@kroah.com>
 <674707a0388c4a3a9bb25676c61e1737@MAIL-MBX-cwP12.dji.com>
 <YbHBb2uB9JRP0tWc@kroah.com>
 <f2150f8a7b7242b48227e30e5550da0b@MAIL-MBX-cwP12.dji.com>
 <YbHVXwdCUCvmZrbS@kroah.com>
 <62dd5f2fedbb4332a4d04dea4970a347@MAIL-MBX-cwP12.dji.com>
 <YcBEy9zi2G7UYErE@kroah.com>
 <c35df81a176f418eb90e18563170de67@MAIL-MBX-cwP12.dji.com>
 <YcBT/Vf41PWUYdxT@kroah.com>
 <b9cdf44fe8064c6bb14d5e7aaec3d33a@MAIL-MBX-cwP12.dji.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9cdf44fe8064c6bb14d5e7aaec3d33a@MAIL-MBX-cwP12.dji.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 10:25:51AM +0000, wigin zeng wrote:
> On Mon, Dec 20, 2021 at 09:44:04AM +0000, wigin zeng wrote:
> > > >That makes no sense, as what orders the data coming in?  The 2 bytes could be added to the tty buffer before the 512 bytes, or the other way around.
> >
> > > >What hardware are you using that is mixing dma and irq data like this?
> > > >That feels very wrong.
> >
> > >It is not normal case, normally, the input size should smaller than DMA block size and DMA complete the whole copy.
> > >However, there are some abnormal situations. The external input is unexpectedly larger than the data length of the DMA configuration. This situation in my example will appear, and it may cause the kernel to panic.
> 
> >You did not answer my question about hardware type :(
> 
> >And again, how is this happening?  If you use DMA, all data should be coming through DMA and not the irq.  Otherwise crazy stuff like this will happen in any type of driver, your hardware can not mix this type of stuff up.
> 
> On our platform, UART connected to a MCU which will send data of variable length from time to time. There is no definition of a maximum transmission length.
> We configured DMA block size is 4096bytes, however, there are more than 4100 bytes input, DMA just handled 4096bytes and left bytes in FIFO cannot trigger next DMA 
> Transfer done interrupt(left bytes number < DMA block size ), so these data should be processed by UART IRQ.

That is a broken hardware design and will not work with any operating
system.

> In other word, if the external use UART "vulnerability" to attack the system, we need to ensure that the system not crash at least, right?

So you are saying that Linux now treat all hardware that has DMA
functionality as a potential threat?  That is not a model that Linux, or
any other operating system, has ever had to support before, please do
not make up new rules here and expect Linux to automatically support
them without a lot of redesign and work.

If you wish to protect Linux from this type of untrusted hardware,
please do the work to do so.  This patch is not that work.

> >How can flow control handle this at all?  Flow control is at the serial data stream level.  This is confusing the PCI data stream order.
> 
> I just think more logic is needed to control the order of data processing by DMA and UART IRQ to keep the integrity of serial data. 
> But the specific design, I haven't considered yet, the first goal is the keep the system alive.

Again, this is a broken hardware design, please fix that first.

thanks,

greg k-h
