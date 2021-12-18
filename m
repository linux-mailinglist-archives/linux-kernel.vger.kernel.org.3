Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DC8479BEC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 19:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbhLRSFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 13:05:34 -0500
Received: from netrider.rowland.org ([192.131.102.5]:60419 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233731AbhLRSFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 13:05:33 -0500
Received: (qmail 878313 invoked by uid 1000); 18 Dec 2021 13:05:32 -0500
Date:   Sat, 18 Dec 2021 13:05:32 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Julio Faracco <jcfaracco@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, axboe@kernel.dk, tglx@linutronix.de,
        damien.lemoal@wdc.com, dkadashev@gmail.com,
        paul.gortmaker@windriver.com, zhouyanjie@wanyeetech.com,
        niklas.cassel@wdc.com, penguin-kernel@i-love.sakura.ne.jp,
        macro@orcam.me.uk, caihuoqing@baidu.com
Subject: Re: [PATCH] usb: fixing some clang warnings inside usb host drivers
Message-ID: <Yb4i7LyYIlJi/9fb@rowland.harvard.edu>
References: <20211218042420.28466-1-jcfaracco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218042420.28466-1-jcfaracco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 01:24:20AM -0300, Julio Faracco wrote:
> Clang is reporting some issues related variable values not used and
> other issues inside some USB host drivers. This commit removes some
> trashes and adds some strategies to mitigate those warnings.
> 
> The most important is the maxpacket not checking for zeros inside both
> functions qtd_fill(). Even if this variable is always higher than zero,
> it should be checked to avoid this kind of verbosity.
> 
> Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
> ---
>  drivers/usb/host/ehci-dbg.c     | 1 -
>  drivers/usb/host/ehci-q.c       | 2 +-
>  drivers/usb/host/ohci-dbg.c     | 1 -
>  drivers/usb/host/oxu210hp-hcd.c | 2 +-
>  4 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-dbg.c b/drivers/usb/host/ehci-dbg.c
> index 0b7f1edd9eec..70b4ff65295a 100644
> --- a/drivers/usb/host/ehci-dbg.c
> +++ b/drivers/usb/host/ehci-dbg.c
> @@ -903,7 +903,6 @@ static ssize_t fill_registers_buffer(struct debug_buffer *buf)
>  	temp = scnprintf(next, size, "complete %ld unlink %ld\n",
>  		ehci->stats.complete, ehci->stats.unlink);
>  	size -= temp;
> -	next += temp;

Like Joe said, this is a standard pattern (an idiom) and I don't think 
it should be changed.  Besides, the compiler ought to remove the 
unnecessary store automatically.

> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
> index 2cbf4f85bff3..98cb44414e78 100644
> --- a/drivers/usb/host/ehci-q.c
> +++ b/drivers/usb/host/ehci-q.c
> @@ -64,7 +64,7 @@ qtd_fill(struct ehci_hcd *ehci, struct ehci_qtd *qtd, dma_addr_t buf,
>  		}
>  
>  		/* short packets may only terminate transfers */
> -		if (count != len)
> +		if (count != len && maxpacket > 0)
>  			count -= (count % maxpacket);

This is different.  But again, I do not think the extra check should be 
added.  If maxpacket is 0, we _want_ the code to fail in a highly 
visible manner -- it would mean there is a bug somewhere else in the 
kernel.

> diff --git a/drivers/usb/host/ohci-dbg.c b/drivers/usb/host/ohci-dbg.c
> index 4f267dc93882..6fc9c46ffe3c 100644
> --- a/drivers/usb/host/ohci-dbg.c
> +++ b/drivers/usb/host/ohci-dbg.c
> @@ -561,7 +561,6 @@ static ssize_t fill_periodic_buffer(struct debug_buffer *buf)
>  
>  			} else {
>  				/* we've seen it and what's after */
> -				temp = 0;
>  				ed = NULL;
>  			}

This one is a good subject for removal.  If you separate this out into 
its own patch, I will Ack it.

> diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
> index e82ff2a49672..8a20d9d3c377 100644
> --- a/drivers/usb/host/oxu210hp-hcd.c
> +++ b/drivers/usb/host/oxu210hp-hcd.c
> @@ -1232,7 +1232,7 @@ static int qtd_fill(struct ehci_qtd *qtd, dma_addr_t buf, size_t len,
>  		}
>  
>  		/* short packets may only terminate transfers */
> -		if (count != len)
> +		if (count != len && maxpacket > 0)
>  			count -= (count % maxpacket);

This is essentially the same as the change to ehci-q.c.

In short, if the compiler produces warnings that are inappropriate, it's 
an indication that the warnings need to be disabled -- not that the 
code needs to be changed.

Alan Stern
