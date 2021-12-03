Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E5D467322
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379172AbhLCINV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379149AbhLCINI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:13:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AEAC06173E;
        Fri,  3 Dec 2021 00:09:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 486AFB825DC;
        Fri,  3 Dec 2021 08:09:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C1DC53FC7;
        Fri,  3 Dec 2021 08:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638518982;
        bh=9Rx71vzPyCgG8eYEQ4c4hGloHvhkoBbyRHY+REr7J8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SMn30GVO9YGmb8xZI6JOp4bRynAEzWxYsq2CPI3MtH4cZjoN2MybTcWGwSeZoKZMp
         2YDKKX8zm3CmlPlYZU5tfjXDFRTvcS1xomtWs5qzGOrqd40VeudEaUx4B0GswoWeGW
         vc6wNpbeEZXm3GHfcRG7F/Tpd7FsRzywn8hlFd2M=
Date:   Fri, 3 Dec 2021 09:09:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the hid tree
Message-ID: <YanQw3HVLzPud5gN@kroah.com>
References: <20211203180124.1721cbe4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203180124.1721cbe4@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 06:01:24PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the hid tree, today's linux-next build (sparc defconfig)
> failed like this:
> 
> hid-chicony.c:(.text+0x4): undefined reference to `usb_hid_driver'
> hid-chicony.c:(.text+0xc): undefined reference to `usb_hid_driver'
> 
> Caused by commit
> 
>   93020953d0fa ("HID: check for valid USB device for many HID drivers")
> 
> I have marked CONFIG_HID_CHICONY as BROKEN for now.

Patch for this is at:
	https://lore.kernel.org/r/20211203075927.2829218-1-gregkh@linuxfoundation.org

Looks like 0-day found another dependancy as well, in the prodikeys
hid driver, will send out a patch for that too...

thanks,

greg k-h
