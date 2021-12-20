Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9F347AF13
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbhLTPIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:08:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53600 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbhLTPGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:06:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0C966118E;
        Mon, 20 Dec 2021 15:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C2DC36AEB;
        Mon, 20 Dec 2021 15:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640012813;
        bh=gNt6ThY9ZgIhJnBuQmrHuu+NtbB4OUU94J3W5o8S3vo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VubqUmYRv5ryI7KE2JX0JfH0GfrzOgmAeI5nUhWr8OLXMRTUdC8aSOTlZCYnCEymN
         C8C+DpAMLdDdQtwzZt1HAyZYXmrkq1RxhzXsKDe0FDDIBdMTlRII5JlGSxfMSY/uRG
         MYgmIoWZmU8G/2BX9LueRt6w+iToM1FxoDXDDe0M=
Date:   Mon, 20 Dec 2021 16:06:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: Re: earlyprintk=xdbc seems broken
Message-ID: <YcCcCjYcXw6T8LjG@kroah.com>
References: <YajkzwmWQua3Kh6A@hirez.programming.kicks-ass.net>
 <105f35d2-3c53-b550-bfb4-aa340d31128e@linux.intel.com>
 <88f466ff-a065-1e9a-4226-0abe2e71b686@linux.intel.com>
 <972a0e28-ad63-9766-88da-02743f80181b@intel.com>
 <Yao35lElOkwtBYEb@kroah.com>
 <c2b5c9bb-1b75-bf56-3754-b5b18812d65e@linux.intel.com>
 <YbyWuxoBSicFBGuv@hirez.programming.kicks-ass.net>
 <YbyqeE39vqE9pEDD@kroah.com>
 <YcCV0TECWE31fYV7@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcCV0TECWE31fYV7@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 03:40:17PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 17, 2021 at 04:19:20PM +0100, Greg KH wrote:
> > On Fri, Dec 17, 2021 at 02:55:07PM +0100, Peter Zijlstra wrote:
> > > On Fri, Dec 17, 2021 at 01:01:43PM +0200, Mathias Nyman wrote:
> > > > I can reproduce this.
> > > > Looks like problems started when driver converted to readl_poll_timeout_atomic() in:
> > > > 
> > > > 796eed4b2342 usb: early: convert to readl_poll_timeout_atomic()
> > > 
> > > I can confirm, reverting that solves the boot hang, things aren't quite
> > > working for me though.
> > > 
> > > > Seems to hang when read_poll_timeout_atomic() calls ktime_* functions.
> > > > Maybe  it's too early for ktime.
> > > 
> > > It certainly is, using ktime for delay loops sounds daft to me anyhow.
> > 
> > It was a "find a pattern and replace it with a function call" type of
> > cleanup series.  It's obviously wrong, I will go revert it now.
> 
> 796eed4b2342 is definitely wrong, but instead of a straight up revert,
> perhaps do something like this ?
> 
> ---
> Subject: usb: early: Revert from readl_poll_timeout_atomic()
> 
> Reverts commit 796eed4b2342 ("usb: early: convert to
> readl_poll_timeout_atomic()") and puts in a comment to avoid the same
> happening again.
> 
> Specifically that commit is wrong because readl_poll_timeout_atomic()
> relies on ktime() working while this earlyprintk driver should be usable
> long before that.
> 
> Fixes: 796eed4b2342 ("usb: early: convert to readl_poll_timeout_atomic()")
> Debugged-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradaed.org>
> ---
>  drivers/usb/early/xhci-dbc.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
> index 933d77ad0a64..ff279a830653 100644
> --- a/drivers/usb/early/xhci-dbc.c
> +++ b/drivers/usb/early/xhci-dbc.c
> @@ -14,7 +14,6 @@
>  #include <linux/pci_ids.h>
>  #include <linux/memblock.h>
>  #include <linux/io.h>
> -#include <linux/iopoll.h>
>  #include <asm/pci-direct.h>
>  #include <asm/fixmap.h>
>  #include <linux/bcd.h>
> @@ -136,9 +135,20 @@ static int handshake(void __iomem *ptr, u32 mask, u32 done, int wait, int delay)
>  {
>  	u32 result;
>  
> -	return readl_poll_timeout_atomic(ptr, result,
> -					 ((result & mask) == done),
> -					 delay, wait);
> +	/*
> +	 * This must not be readl_poll_timeout_atomic(), as this is used
> +	 * *early*, before ktime lives.
> +	 */
> +	do {
> +		result = readl(ptr);
> +		result &= mask;
> +		if (result == done)
> +			return 0;
> +		udelay(delay);
> +		wait -= delay;
> +	} while (wait > 0);
> +
> +	return -ETIMEDOUT;
>  }
>  
>  static void __init xdbc_bios_handoff(void)

Please see c4d936efa46d ("Revert "usb: early: convert to
readl_poll_timeout_atomic()"") in Linus's tree.  I already added a
comment much like yours.  If that's not sufficient, I'll be glad to
re-word it.

thanks,

greg k-h

