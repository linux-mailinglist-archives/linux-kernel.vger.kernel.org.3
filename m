Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8294A7FB0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 08:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349335AbiBCHVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 02:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242617AbiBCHVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 02:21:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B51C061714;
        Wed,  2 Feb 2022 23:21:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BD57B83354;
        Thu,  3 Feb 2022 07:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820C0C340E4;
        Thu,  3 Feb 2022 07:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643872896;
        bh=Wc1U0tbe2ibHH0w4+Qtr585voPPI/RVu2gM/lTVVp30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCsO81bWXEyVOSsQDSn6r2rzxOR3JpBSoWjBg9sy1shtFudtP50cDmN5973rXbl2M
         WSotlCODFoun5BN4etxANerKTcAfUDtbSDwOcGdshWNp211MGoRUSFS9DlxRAmvgLl
         ei4hGgEBWHhAkhek4CQb3L7EFl2kflZY3ZSvAgaY=
Date:   Thu, 3 Feb 2022 08:21:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>, "J . Avila" <elavila@google.com>
Subject: Re: [PATCH 0/3] support USB offload feature
Message-ID: <YfuCdfClfxh9S2Np@kroah.com>
References: <CGME20220203030000epcas2p2a924a55a5ae60e8685cd62b66a5482f3@epcas2p2.samsung.com>
 <1643857054-112415-1-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643857054-112415-1-git-send-email-dh10.jung@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 11:57:31AM +0900, Daehwan Jung wrote:
> This patchset is for USB offload feature, which makes Co-processor to use
> some memories of xhci. Especially it's useful for USB Audio scenario.
> Audio stream would get shortcut because Co-processor directly write/read
> data in xhci memories. It could get speed-up using faster memory like SRAM.
> That's why this also gives vendors flexibilty of memory management.
> Below pathches have been merged in AOSP kernel(android12-5.10) and I put
> together and split into 3 patches.
> 
> ANDROID: usb: host: fix slab-out-of-bounds in xhci_vendor_get_ops
> ANDROID: usb: export built-in tracepoint functions
> ANDROID: usb: host: Use old init scheme when hook unavailable
> ANDROID: usb: host: free the offload TR by vendor hook
> ANDROID: usb: host: xhci: provide function prototype for xhci_address_device
> ANDROID: usb: host: add bus_suspend/bus_resume to xhci overrides
> ANDROID: usb: host: add address_device to xhci overrides
> ANDROID: usb: host: add max packet parameter on alloc_transfer_ring hook
> ANDROID: usb: host: add xhci hooks for vendor specific container context
> ANDROID: usb: host: export xhci symbols for ring management
> ANDROID: usb: host: export additional xhci symbols for ring management
> FROMLIST: usb: xhci-plat: add xhci_plat_priv_overwrite
> FROMLIST: usb: host: export symbols for xhci hooks usage
> FROMLIST: usb: host: add xhci hooks for USB offload
> 
> Below are owners of patches.
> 
> Howard Yen <howardyen@google.com>
> Jack Pham <jackp@codeaurora.org>
> Puma Hsu <pumahsu@google.com>
> J. Avila <elavila@google.com>
> chihhao.chen <chihhao.chen@mediatek.com>)
> 
> Daehwan Jung (3):
>   usb: host: export symbols for xhci hooks usage
>   usb: host: add xhci hooks for USB offload
>   usb: host: add some to xhci overrides for USB offload

We need a user for these offload hooks, can you also submit them at the
same time?  Otherwise for obvious reaons, I can not take these without
any user.

thanks,

greg k-h
