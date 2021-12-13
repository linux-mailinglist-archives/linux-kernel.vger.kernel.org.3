Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9773472E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbhLMN6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:58:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34172 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238540AbhLMN6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:58:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCD6861016;
        Mon, 13 Dec 2021 13:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD12CC34601;
        Mon, 13 Dec 2021 13:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639403925;
        bh=yMuVyc4TVgRet2InLRY+bgIaO+2h9DW64nLLI7Las+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bkwud4Z4Makhy+9ZYkFe66k9/JDAvnckgNmbHULq1ycFzFIL7Of5hGfSWm1WDtcfk
         y2GcLA4riMUt9lyo78RXKGWbBgeEd4qd0YWMCz83/JVYkGVfB9Wal86I7MCdRXBQe8
         5FtwgpWM99YsYiZ5zl/bg7IgkRhFUNse+WsdDFho=
Date:   Mon, 13 Dec 2021 14:58:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] usb: Introduce Xen pvUSB frontend (xen hcd)
Message-ID: <YbdRkvW/hOH77liY@kroah.com>
References: <20211123132048.5335-1-jgross@suse.com>
 <20211123132048.5335-3-jgross@suse.com>
 <YaoSTnkYyCFXOyvJ@kroah.com>
 <b43c416e-d81a-7d21-5b92-7bc8329bb296@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b43c416e-d81a-7d21-5b92-7bc8329bb296@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 01:50:44PM +0100, Juergen Gross wrote:
> On 03.12.21 13:49, Greg Kroah-Hartman wrote:
> > On Tue, Nov 23, 2021 at 02:20:47PM +0100, Juergen Gross wrote:
> > > Introduces the Xen pvUSB frontend. With pvUSB it is possible for a Xen
> > > domU to communicate with a USB device assigned to that domU. The
> > > communication is all done via the pvUSB backend in a driver domain
> > > (usually Dom0) which is owner of the physical device.
> > > 
> > > The pvUSB frontend is a USB hcd for a virtual USB host connector.
> > > 
> > > The code is taken from the pvUSB implementation in Xen done by Fujitsu
> > > based on Linux kernel 2.6.18.
> > > 
> > > Changes from the original version are:
> > > - port to upstream kernel
> > > - put all code in just one source file
> > > - move module to appropriate location in kernel tree
> > > - adapt to Linux style guide
> > > - minor code modifications to increase readability
> > > 
> > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > ---
> > >   drivers/usb/host/Kconfig   |   11 +
> > >   drivers/usb/host/Makefile  |    1 +
> > >   drivers/usb/host/xen-hcd.c | 1606 ++++++++++++++++++++++++++++++++++++
> > >   3 files changed, 1618 insertions(+)
> > >   create mode 100644 drivers/usb/host/xen-hcd.c
> > 
> > This looks sane to me, but I don't know the HCD interface as well as
> > others on linux-usb do, like Alan Stern.
> > 
> > What tree do you want this to be merged through, my USB one?
> 
> Either that, or I can carry it through the Xen tree.
> 
> Its your choice. :-)

I've grabbed them now, thanks.

greg k-h
