Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F0D4677A1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380938AbhLCMwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380929AbhLCMwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:52:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE82FC06173E;
        Fri,  3 Dec 2021 04:49:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83DAFB826B1;
        Fri,  3 Dec 2021 12:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1CDC53FC7;
        Fri,  3 Dec 2021 12:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638535761;
        bh=gp94SRYawnm+2OyVuYPvciRbORwhED6UQuA7fvk+mng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rrnhkgXG+JHJZrkhMzsKW6pcdjm64IJORZ170ZEnD0B1qJhscCgGMEC5kiuuNGVlf
         wIOWmELvcoXTQZTnps4wVOwo3W0Wj6rKWLbHToizoyJBoQ4nueu2nCNp6FOx8bXOBj
         PRz9KUlJ/Vwuo0X7IxQ/EGZ6VKiTiXICAFsvBy9w=
Date:   Fri, 3 Dec 2021 13:49:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] usb: Introduce Xen pvUSB frontend (xen hcd)
Message-ID: <YaoSTnkYyCFXOyvJ@kroah.com>
References: <20211123132048.5335-1-jgross@suse.com>
 <20211123132048.5335-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123132048.5335-3-jgross@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 02:20:47PM +0100, Juergen Gross wrote:
> Introduces the Xen pvUSB frontend. With pvUSB it is possible for a Xen
> domU to communicate with a USB device assigned to that domU. The
> communication is all done via the pvUSB backend in a driver domain
> (usually Dom0) which is owner of the physical device.
> 
> The pvUSB frontend is a USB hcd for a virtual USB host connector.
> 
> The code is taken from the pvUSB implementation in Xen done by Fujitsu
> based on Linux kernel 2.6.18.
> 
> Changes from the original version are:
> - port to upstream kernel
> - put all code in just one source file
> - move module to appropriate location in kernel tree
> - adapt to Linux style guide
> - minor code modifications to increase readability
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  drivers/usb/host/Kconfig   |   11 +
>  drivers/usb/host/Makefile  |    1 +
>  drivers/usb/host/xen-hcd.c | 1606 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 1618 insertions(+)
>  create mode 100644 drivers/usb/host/xen-hcd.c

This looks sane to me, but I don't know the HCD interface as well as
others on linux-usb do, like Alan Stern.

What tree do you want this to be merged through, my USB one?

thanks,

greg k-h
