Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2787546E470
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbhLIIqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbhLIIqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:46:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E04C061746;
        Thu,  9 Dec 2021 00:42:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 77DCECE2503;
        Thu,  9 Dec 2021 08:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6EAC004DD;
        Thu,  9 Dec 2021 08:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639039346;
        bh=qLJoD7xP6d6dBia73//xCvgafN7Nw2WpM96EQ0LwyS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lIve7QK79VRVUICM+OtiZeEvfmGUzxzsqIIBbz2m0hQ8ZW/FfLBGYeXm4M+MRMUMY
         cuhhLdftqQdf2QmMTbLPZUeDrv8kvU4K/FYEUox1kHW+kneWwehxbHnlXRVtPRETKw
         s+CTkMwYKB0Qks7qLVspa9TymzxSusX628rpK1HM=
Date:   Thu, 9 Dec 2021 09:42:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     wigin zeng <wigin.zeng@dji.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH] serial: 8250: add
 lock for dma rx
Message-ID: <YbHBb2uB9JRP0tWc@kroah.com>
References: <20211209073339.21694-1-wigin.zeng@dji.com>
 <YbGygPtkz6ihyW51@kroah.com>
 <674707a0388c4a3a9bb25676c61e1737@MAIL-MBX-cwP12.dji.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674707a0388c4a3a9bb25676c61e1737@MAIL-MBX-cwP12.dji.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Dec 09, 2021 at 08:15:00AM +0000, wigin zeng wrote:
> We encountered this issue when UART transfer very intensive.

What issue exactly?

> DMA irq-thread processed on CPU0 and serial irq-thread executing on CPU1, 
> In DMA irq-thread will invoke "tty_insert_filp_string" function to add the rx_buf into tty_buffer.
> In serial irq-thread also has chance to access tty_insert_flip_char(in serial8250_rx_chars ) to access tty_buffer.
> there is race condition, sometimes will cause panic.

But what data is being accessed at the same time to cause a crash?
How is data being added into the buffer at the same time in two
different places into the same queue?  What userspace programs are
causing this?

> We add the spin_lock to sync the tty_buffer operation, and the issue gone after applied the patch.

So all tty buffer accesses need to be protected by your new lock?

thanks,

greg k-h
