Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D95512AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243025AbiD1FeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiD1FeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:34:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5455DA59;
        Wed, 27 Apr 2022 22:30:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A188B818FC;
        Thu, 28 Apr 2022 05:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D72C385A0;
        Thu, 28 Apr 2022 05:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651123854;
        bh=4vVupsHwZEdBJbK2AUWJd2oNVBxUPTJJBfndmRLUxlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OfJQTHhPEYGWLEwrZNxTxRUgjfXK2kiHsqgSgshrfA/QnFDCoj32FyFs44k6D9T3B
         yQA9ZgMUnxJUo8eF5QnmWAZ9FIOX4BEbZVuKo06MnHCPmJn6h5q4Au6GtAP1FcQvDI
         ex8DLBTOx23ZEF6z5+WhCZTC4mypbq9N68CCbtXM=
Date:   Thu, 28 Apr 2022 07:30:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jung Daehwan <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v4 2/5] usb: host: add xhci hooks for xhci-exynos
Message-ID: <YmomhKI7QQeVEiJF@kroah.com>
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220426092021epcas2p1a8d41039d9b3226f4e00f7d4bded833a@epcas2p1.samsung.com>
 <1650964728-175347-3-git-send-email-dh10.jung@samsung.com>
 <YmfHJYu9lIwz8JT5@kroah.com>
 <20220427090617.GA145620@ubuntu>
 <YmkKnQEhJzk84fHj@kroah.com>
 <20220428032354.GB151827@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428032354.GB151827@ubuntu>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 12:23:54PM +0900, Jung Daehwan wrote:
> On Wed, Apr 27, 2022 at 11:19:25AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 27, 2022 at 06:06:17PM +0900, Jung Daehwan wrote:
> > > On Tue, Apr 26, 2022 at 12:19:17PM +0200, Greg Kroah-Hartman wrote:
> > > > On Tue, Apr 26, 2022 at 06:18:45PM +0900, Daehwan Jung wrote:
> > > > > To enable supporting for USB offload, define "offload" in usb controller
> > > > > node of device tree. "offload" value can be used to determine which type
> > > > > of offload was been enabled in the SoC.
> > > > > 
> > > > > For example:
> > > > > 
> > > > > &usbdrd_dwc3 {
> > > > > 	...
> > > > > 	/* support usb offloading, 0: disabled, 1: audio */
> > > > > 	offload = <1>;
> > > > > 	...
> > > > > };
> > > > > 
> > > > > There are several vendor_ops introduced by this patch:
> > > > > 
> > > > > struct xhci_vendor_ops - function callbacks for vendor specific operations
> > > > > {
> > > > > 	@vendor_init:
> > > > > 		- called for vendor init process during xhci-plat-hcd
> > > > > 		  probe.
> > > > > 	@vendor_cleanup:
> > > > > 		- called for vendor cleanup process during xhci-plat-hcd
> > > > > 		  remove.
> > > > > 	@is_usb_offload_enabled:
> > > > > 		- called to check if usb offload enabled.
> > > > > 	@alloc_dcbaa:
> > > > > 		- called when allocating vendor specific dcbaa during
> > > > > 		  memory initializtion.
> > > > > 	@free_dcbaa:
> > > > > 		- called to free vendor specific dcbaa when cleanup the
> > > > > 		  memory.
> > > > > 	@alloc_transfer_ring:
> > > > > 		- called when vendor specific transfer ring allocation is required
> > > > > 	@free_transfer_ring:
> > > > > 		- called to free vendor specific transfer ring
> > > > > 	@sync_dev_ctx:
> > > > > 		- called when synchronization for device context is required
> > > > > }
> > > > > 
> > > > > The xhci hooks with prefix "xhci_vendor_" on the ops in xhci_vendor_ops.
> > > > > For example, vendor_init ops will be invoked by xhci_vendor_init() hook,
> > > > > is_usb_offload_enabled ops will be invoked by
> > > > > xhci_vendor_is_usb_offload_enabled(), and so on.
> > > > > 
> > > > > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > > > > Signed-off-by: J. Avila <elavila@google.com>
> > > > > Signed-off-by: Puma Hsu <pumahsu@google.com>
> > > > > Signed-off-by: Howard Yen <howardyen@google.com>
> > > > > ---
> > > > >  drivers/usb/host/xhci-hub.c  |   5 ++
> > > > >  drivers/usb/host/xhci-mem.c  | 131 +++++++++++++++++++++++++++++++----
> > > > >  drivers/usb/host/xhci-plat.c |  44 +++++++++++-
> > > > >  drivers/usb/host/xhci-plat.h |   8 +++
> > > > >  drivers/usb/host/xhci.c      |  80 ++++++++++++++++++++-
> > > > >  drivers/usb/host/xhci.h      |  46 ++++++++++++
> > > > >  6 files changed, 296 insertions(+), 18 deletions(-)
> > > > 
> > > > Why do you need to "override" anything?  Why can't these just be added
> > > > to the current xhci_plat_priv structure and used that way like the
> > > > current xhci platform interface works?
> > > > 
> > > 
> > > "override" means above xhci hooks? Above hooks are for ring management.
> > > In fact, xhci platform doesn't care ring management. That's why I've added hooks
> > > not used xhci_plat_priv.
> > 
> > Why not add ring management ability to the platform interface instead?
> > That's what you want to control here, in your platform driver, right?
> >
> 
> I think xhci platform driver is separated from ring management. I don't
> want to disturb current design.

You are adding platform-specific changes to the driver, that seems like
it would belong in the platform interface instead of requiring another
api/interface to be created within the same driver, right?

Anyway, just trying to make it simpler overall.

thanks,

greg k-h
