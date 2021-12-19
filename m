Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D82479EE3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 03:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhLSCuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 21:50:24 -0500
Received: from netrider.rowland.org ([192.131.102.5]:33779 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229804AbhLSCuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 21:50:23 -0500
Received: (qmail 885118 invoked by uid 1000); 18 Dec 2021 21:50:22 -0500
Date:   Sat, 18 Dec 2021 21:50:22 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Julio Faracco <jcfaracco@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        axboe@kernel.dk, tglx@linutronix.de, damien.lemoal@wdc.com,
        dkadashev@gmail.com, paul.gortmaker@windriver.com,
        zhouyanjie@wanyeetech.com, niklas.cassel@wdc.com,
        macro@orcam.me.uk, caihuoqing@baidu.com
Subject: Re: [PATCH] usb: fixing some clang warnings inside usb host drivers
Message-ID: <Yb6d7tflQeJ+1Et2@rowland.harvard.edu>
References: <20211218042420.28466-1-jcfaracco@gmail.com>
 <Yb4i7LyYIlJi/9fb@rowland.harvard.edu>
 <7c5bbc97-b9dc-96bb-5764-58bebec0178d@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c5bbc97-b9dc-96bb-5764-58bebec0178d@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2021 at 10:41:02AM +0900, Tetsuo Handa wrote:
> On 2021/12/19 3:05, Alan Stern wrote:
> >> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
> >> index 2cbf4f85bff3..98cb44414e78 100644
> >> --- a/drivers/usb/host/ehci-q.c
> >> +++ b/drivers/usb/host/ehci-q.c
> >> @@ -64,7 +64,7 @@ qtd_fill(struct ehci_hcd *ehci, struct ehci_qtd *qtd, dma_addr_t buf,
> >>  		}
> >>  
> >>  		/* short packets may only terminate transfers */
> >> -		if (count != len)
> >> +		if (count != len && maxpacket > 0)
> >>  			count -= (count % maxpacket);
> > 
> > This is different.  But again, I do not think the extra check should be 
> > added.  If maxpacket is 0, we _want_ the code to fail in a highly 
> > visible manner -- it would mean there is a bug somewhere else in the 
> > kernel.
> 
> Some of the callers are passing the return value from usb_maxpacket(), and
> usb_maxpacket() can return 0. But division by 0 bug here becomes visible
> only when len < count in
> 
> 	count = 0x1000 - (buf & 0x0fff);	/* rest of that page */
> 	if (likely (len < count))		/* ... iff needed */
> 		count = len;
> 
> is false and count != len in
> 
> 		if (count != len)
> 			count -= (count % maxpacket);
> 
> is true, which may be quite difficult to trigger.
> 
> Maybe we should make sure that maxpacket > 0 on the caller side, for e.g.
> 
> 	/* qh makes control packets use qtd toggle; maybe switch it */
> 	if ((maxpacket & (this_qtd_len + (maxpacket - 1))) == 0)
> 		token ^= QTD_TOGGLE;
> 
> and
> 
> 	if (usb_pipecontrol (urb->pipe)) {
> 		one_more = 1;
> 		token ^= 0x0100;	/* "in" <--> "out"  */
> 		token |= QTD_TOGGLE;	/* force DATA1 */
> 	} else if (usb_pipeout(urb->pipe)
> 			&& (urb->transfer_flags & URB_ZERO_PACKET)
> 			&& !(urb->transfer_buffer_length % maxpacket)) {
> 		one_more = 1;
> 	}
> 
> are expecting that maxpacket > 0 ?

You should read this code in usb_submit_urb():

	max = usb_endpoint_maxp(&ep->desc);
	if (max <= 0) {
		dev_dbg(&dev->dev,
			"bogus endpoint ep%d%s in %s (bad maxpacket %d)\n",
			usb_endpoint_num(&ep->desc), is_out ? "out" : "in",
			__func__, max);
		return -EMSGSIZE;
	}

As far as I know, every code path leading to qtd_fill() has to pass this 
test.

Alan Stern
