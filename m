Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016194902DB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbiAQHTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237505AbiAQHS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:18:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18676C061574;
        Sun, 16 Jan 2022 23:18:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA9D260F70;
        Mon, 17 Jan 2022 07:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9473DC36AE3;
        Mon, 17 Jan 2022 07:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642403936;
        bh=cEn/0oLDLwZ9AQXhtlYi5yCVnah2Qcl+il8XKFnV8cE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hainm2G0Z5lTZpIhzOJXBc8zI8KX9hMRAI3+GNeAY2x/okmuJ5oZDh5bLQVNTFixj
         qmsYT2z8tUGessLiMK2wCFbc+qszX+3JVTFZNUU41IvtpeDadQQftdAEeZjSnwHVy4
         QAyTn8Y+EQYPgOIRBY5KfjNAtmMnGEcBRBfVBBUI=
Date:   Mon, 17 Jan 2022 08:18:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     stern@rowland.harvard.edu, mathias.nyman@linux.intel.com,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Rajat Jain <rajatja@google.com>, Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: core: Bail out when port is stuck in reset loop
Message-ID: <YeUYXbIsZV1GY3wa@kroah.com>
References: <20211230052811.650191-1-kai.heng.feng@canonical.com>
 <CAAd53p6ev+yQT+jf32UrTMWQXwDPYtmZSrW0zCQnKuUaBbtXUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p6ev+yQT+jf32UrTMWQXwDPYtmZSrW0zCQnKuUaBbtXUg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 11:00:05AM +0800, Kai-Heng Feng wrote:
> On Thu, Dec 30, 2021 at 1:28 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > Unplugging USB device may cause an incorrect warm reset loop and the
> > port can no longer be used:
> > [  143.039019] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, portsc: 0x4202c0
> > [  143.039025] xhci_hcd 0000:00:14.0: handle_port_status: starting usb2 port polling.
> > [  143.039051] hub 2-0:1.0: state 7 ports 10 chg 0000 evt 0008
> > [  143.039058] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x4202c0, return 0x4102c0
> > [  143.039092] xhci_hcd 0000:00:14.0: clear port3 connect change, portsc: 0x4002c0
> > [  143.039096] usb usb2-port3: link state change
> > [  143.039099] xhci_hcd 0000:00:14.0: clear port3 link state change, portsc: 0x2c0
> > [  143.039101] usb usb2-port3: do warm reset
> > [  143.096736] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2b0, return 0x2b0
> > [  143.096751] usb usb2-port3: not warm reset yet, waiting 50ms
> > [  143.131500] xhci_hcd 0000:00:14.0: Can't queue urb, port error, link inactive
> > [  143.138260] xhci_hcd 0000:00:14.0: Port change event, 2-3, id 19, portsc: 0x2802a0
> > [  143.138263] xhci_hcd 0000:00:14.0: handle_port_status: starting usb2 port polling.
> > [  143.160756] xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2802a0, return 0x3002a0
> > [  143.160798] usb usb2-port3: not warm reset yet, waiting 200ms
> >
> > The port status is PP=1, CCS=0, PED=0, PLS=Inactive, which is Error
> > state per "USB3 Root Hub Port State Machine". It's reasonable to perform
> > warm reset several times, but if the port is still not enabled after
> > many attempts, consider it's gone and treat it as disconnected.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> A gentle ping...

It's the merge window, I can't do anything, sorry.  Please wait until
after 5.17-rc1 is out.

thanks,

greg k-h
