Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094C94677A5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380947AbhLCMxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380929AbhLCMxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:53:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A00C06173E;
        Fri,  3 Dec 2021 04:50:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D22AB81C9D;
        Fri,  3 Dec 2021 12:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A43DC53FCB;
        Fri,  3 Dec 2021 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638535828;
        bh=ue4TGh2bIFkgSrsHBm8mGODLZGWnSItupAQ/8azdNYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P14JTVZSL2QNuDDHFbTtqsmplg3PO1fi91BRbwR/i239Zn50gHU4eUb3+L6pUgqMD
         MYMV6XU/y3AX8CwED9yD0QR41RPLp0dfHSvreKKKvGZ2zBBl1mJVDFRmlxZm88MGpM
         ywr9ZDbTRj4oQB7l3Gba7p3zw2nPWIUudzKweviE=
Date:   Fri, 3 Dec 2021 13:50:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marian Postevca <posteuca@mutex.one>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: u_ether: fix race in setting MAC address in
 setup phase
Message-ID: <YaoSkbMBk90zr3N7@kroah.com>
References: <20211129221229.31845-1-posteuca@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129221229.31845-1-posteuca@mutex.one>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 12:12:29AM +0200, Marian Postevca wrote:
> When listening for notifications through netlink of a new interface being
> registered, sporadically, it is possible for the MAC to be read as zero.
> The zero MAC address lasts a short period of time and then switches to a
> valid random MAC address.
> 
> This causes problems for netd in Android, which assumes that the interface
> is malfunctioning and will not use it.
> 
> In the good case we get this log:
> InterfaceController::getCfg() ifName usb0
>  hwAddr 92:a8:f0:73:79:5b ipv4Addr 0.0.0.0 flags 0x1002
> 
> In the error case we get these logs:
> InterfaceController::getCfg() ifName usb0
>  hwAddr 00:00:00:00:00:00 ipv4Addr 0.0.0.0 flags 0x1002
> 
> netd : interfaceGetCfg("usb0")
> netd : interfaceSetCfg() -> ServiceSpecificException
>  (99, "[Cannot assign requested address] : ioctl() failed")
> 
> The reason for the issue is the order in which the interface is setup,
> it is first registered through register_netdev() and after the MAC
> address is set.
> 
> Fixed by first setting the MAC address of the net_device and after that
> calling register_netdev().
> 
> Signed-off-by: Marian Postevca <posteuca@mutex.one>
> ---
>  drivers/usb/gadget/function/u_ether.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)

What commit does this fix?  Should it go to stable kernel releases?

thanks,

greg k-h
