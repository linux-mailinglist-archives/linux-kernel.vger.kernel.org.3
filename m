Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D324CCF2D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 08:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbiCDHkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 02:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbiCDHku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 02:40:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72390192E05;
        Thu,  3 Mar 2022 23:40:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06ED261DC8;
        Fri,  4 Mar 2022 07:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1870C340E9;
        Fri,  4 Mar 2022 07:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646379602;
        bh=iF00+VTLj0F97lveZdVtr3jeXZU8hN5zrFZ7CZRmu44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mTscX5e1x91/GynIboZbkqfGBogZ1mNux/d5YfpVmUL1qkdKebSGp/AMWxyzMNPLA
         4fjtBY+xoMb8nPzO4ypqn/Df27C5+HO5GvTWTOmh4gQ3/bGyM1iCe/LhJDqQP4b/kz
         T7M1E4eLJMYbDIjXMIclrFnE7KfFXjeXPuEZCETA=
Date:   Fri, 4 Mar 2022 08:39:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        "chihhao . chen" <chihhao.chen@mediatek.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
Subject: Re: [PATCH v1 0/4] support USB offload feature
Message-ID: <YiHCTgg5Ibv9YQvi@kroah.com>
References: <CGME20220304062609epcas2p1b9e2720d2d7d66438e1eab92546f46cc@epcas2p1.samsung.com>
 <1027007693.21646375403236.JavaMail.epsvc@epcpadp3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027007693.21646375403236.JavaMail.epsvc@epcpadp3>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 03:23:54PM +0900, Daehwan Jung wrote:
> This patchset is for USB offload feature, which makes Co-processor to use
> some memories of xhci. Especially it's useful for USB Audio scenario.
> Audio stream would get shortcut because Co-processor directly write/read
> data in xhci memories. It could get speed-up using faster memory like SRAM.
> That's why this also gives vendors flexibilty of memory management.
> Below pathches have been merged in AOSP kernel(android12-5.10) and I put
> together and split into 3 patches. Plus let me add user(xhci-exynos) module 
> to see how user could use it. 
> 
> To sum up, it's for providing xhci memories to Co-Processor.
> It would cover DCBAA, Device Context, Tranfer Ring, Event Ring, ERST.
> It needs xhci hooks and to export some xhci symbols.
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

What does that list of text mean?  You are only submitting 4 patches
here, not that many.

> 
> Below are owners of patches.
> 
> Howard Yen <howardyen@google.com>
> Jack Pham <jackp@codeaurora.org>
> Puma Hsu <pumahsu@google.com>
> J. Avila <elavila@google.com>
> chihhao.chen <chihhao.chen@mediatek.com>

What do you mean by this?  Did you loose authorship of the code you just
submitted?  That's not ok.  You always have to properly credit the
creators of the changes you submit to us for obvious legal reasons.

Please fix up and resend this series properly.

thanks,

greg k-h
