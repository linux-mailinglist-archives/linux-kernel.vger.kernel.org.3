Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CA6468723
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 19:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345997AbhLDSvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 13:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbhLDSvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 13:51:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B45C061751;
        Sat,  4 Dec 2021 10:47:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8F7E4CE0F02;
        Sat,  4 Dec 2021 18:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D0FC341C2;
        Sat,  4 Dec 2021 18:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638643663;
        bh=CnNRK5P/SuPxK21hCYDCHsvfDFSktd4FzF4FEV+llb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dAAYwCA2T4PYpohFXUEYgL11Hi6cJK4dTvtDu7VBCNzq+cjHQcSyaE22duvNMOIVZ
         L8+CLSzSqXq9hXZOLvck79WuTIa4+cGLAO7jXUosXyorlMe+qQzfg7YNDg+tai5Q2U
         6AjSiNixz8MqfsU1+QfEs6wuK9WYveq+e703y6BA=
Date:   Sat, 4 Dec 2021 19:47:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marian Postevca <posteuca@mutex.one>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: u_ether: fix race in setting MAC address in
 setup phase
Message-ID: <Yau3zDEdTiLZZkRp@kroah.com>
References: <20211129221229.31845-1-posteuca@mutex.one>
 <YaoSkbMBk90zr3N7@kroah.com>
 <87ee6sxlcj.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee6sxlcj.fsf@mutex.one>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2021 at 08:42:52PM +0200, Marian Postevca wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Tue, Nov 30, 2021 at 12:12:29AM +0200, Marian Postevca wrote:
> >> When listening for notifications through netlink of a new interface being
> >> registered, sporadically, it is possible for the MAC to be read as zero.
> >> The zero MAC address lasts a short period of time and then switches to a
> >> valid random MAC address.
> >> 
> >> This causes problems for netd in Android, which assumes that the interface
> >> is malfunctioning and will not use it.
> >> 
> >> In the good case we get this log:
> >> InterfaceController::getCfg() ifName usb0
> >>  hwAddr 92:a8:f0:73:79:5b ipv4Addr 0.0.0.0 flags 0x1002
> >> 
> >> In the error case we get these logs:
> >> InterfaceController::getCfg() ifName usb0
> >>  hwAddr 00:00:00:00:00:00 ipv4Addr 0.0.0.0 flags 0x1002
> >> 
> >> netd : interfaceGetCfg("usb0")
> >> netd : interfaceSetCfg() -> ServiceSpecificException
> >>  (99, "[Cannot assign requested address] : ioctl() failed")
> >> 
> >> The reason for the issue is the order in which the interface is setup,
> >> it is first registered through register_netdev() and after the MAC
> >> address is set.
> >> 
> >> Fixed by first setting the MAC address of the net_device and after that
> >> calling register_netdev().
> >> 
> >> Signed-off-by: Marian Postevca <posteuca@mutex.one>
> >> ---
> >>  drivers/usb/gadget/function/u_ether.c | 16 ++++++----------
> >>  1 file changed, 6 insertions(+), 10 deletions(-)
> >
> > What commit does this fix?  Should it go to stable kernel releases?
> >
> > thanks,
> >
> > greg k-h
> 
> This fixes bcd4a1c40bee885e ("usb: gadget: u_ether: construct with
> default values and add setters/getters").
> 
> I think it should go to stable kernel releases.
> 
> Should I send a second version of the patch with a Fixes tag?

Yes please, and a cc: stable on the line after the fixes tag.

thanks,

greg k-h
