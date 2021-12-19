Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2200547A133
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 16:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbhLSPqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 10:46:15 -0500
Received: from netrider.rowland.org ([192.131.102.5]:46101 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S236032AbhLSPqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 10:46:14 -0500
Received: (qmail 894690 invoked by uid 1000); 19 Dec 2021 10:46:13 -0500
Date:   Sun, 19 Dec 2021 10:46:13 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Julio Faracco <jcfaracco@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        axboe@kernel.dk, tglx@linutronix.de, damien.lemoal@wdc.com,
        dkadashev@gmail.com, paul.gortmaker@windriver.com,
        zhouyanjie@wanyeetech.com, niklas.cassel@wdc.com,
        macro@orcam.me.uk, caihuoqing@baidu.com
Subject: Re: [PATCH] usb: fixing some clang warnings inside usb host drivers
Message-ID: <Yb9TxT4Z57AN/lgm@rowland.harvard.edu>
References: <20211218042420.28466-1-jcfaracco@gmail.com>
 <Yb4i7LyYIlJi/9fb@rowland.harvard.edu>
 <7c5bbc97-b9dc-96bb-5764-58bebec0178d@i-love.sakura.ne.jp>
 <Yb6d7tflQeJ+1Et2@rowland.harvard.edu>
 <0804469c-664a-219d-bb6a-b4e5f133edd9@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0804469c-664a-219d-bb6a-b4e5f133edd9@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2021 at 04:59:44PM +0900, Tetsuo Handa wrote:
> On 2021/12/19 11:50, Alan Stern wrote:
> > You should read this code in usb_submit_urb():
> > 
> > 	max = usb_endpoint_maxp(&ep->desc);
> > 	if (max <= 0) {
> > 		dev_dbg(&dev->dev,
> > 			"bogus endpoint ep%d%s in %s (bad maxpacket %d)\n",
> > 			usb_endpoint_num(&ep->desc), is_out ? "out" : "in",
> > 			__func__, max);
> > 		return -EMSGSIZE;
> > 	}
> > 
> > As far as I know, every code path leading to qtd_fill() has to pass this 
> > test.
> 
> Excuse me, but surely qtd_fill() is using the result from usb_maxpacket()
> 
> ----------------------------------------
> static struct list_head *
> qh_urb_transaction (
> 	struct ehci_hcd		*ehci,
> 	struct urb		*urb,
> 	struct list_head	*head,
> 	gfp_t			flags
> ) {
> (...snipped...)
> 	maxpacket = usb_maxpacket(urb->dev, urb->pipe, !is_input);
> 
> 	/*
> 	 * buffer gets wrapped in one or more qtds;
> 	 * last one may be "short" (including zero len)
> 	 * and may serve as a control status ack
> 	 */
> 	for (;;) {
> 		int this_qtd_len;
> 
> 		this_qtd_len = qtd_fill(ehci, qtd, buf, this_sg_len, token,
> 				maxpacket);
> 		this_sg_len -= this_qtd_len;
> 		len -= this_qtd_len;
> 		buf += this_qtd_len;
> (...snipped...)
> }
> ----------------------------------------
> 
> and usb_maxpacket() may return 0 ?
> 
> ----------------------------------------
> static inline __u16
> usb_maxpacket(struct usb_device *udev, int pipe, int is_out)
> {
> 	struct usb_host_endpoint	*ep;
> 	unsigned			epnum = usb_pipeendpoint(pipe);
> 
> 	if (is_out) {
> 		WARN_ON(usb_pipein(pipe));
> 		ep = udev->ep_out[epnum];
> 	} else {
> 		WARN_ON(usb_pipeout(pipe));
> 		ep = udev->ep_in[epnum];
> 	}
> 	if (!ep)
> 		return 0;
> 
> 	/* NOTE:  only 0x07ff bits are for packet size... */
> 	return usb_endpoint_maxp(&ep->desc);
> }
> ----------------------------------------

You should also read this code in usb_submit_urb():

	ep = usb_pipe_endpoint(dev, urb->pipe);
	if (!ep)
		return -ENOENT;

together with the definition of usb_pipe_endpoint():

static inline struct usb_host_endpoint *
usb_pipe_endpoint(struct usb_device *dev, unsigned int pipe)
{
	struct usb_host_endpoint **eps;
	eps = usb_pipein(pipe) ? dev->ep_in : dev->ep_out;
	return eps[usb_pipeendpoint(pipe)];
}

As you can see, this carries out the same calculation that 
usb_maxpacket() makes, but it fails with an error if ep would be NULL.

> If we don't need to care about the possibility of returning 0 (including
> all possible race conditions taken into account), please explain it as a
> comment block.

You may write such a comment and submit it as a patch, if you like.  But 
keep in mind that the USB subsystem is full of potential race conditions 
like this one, kept in check by appropriate locking and synchronization.  
Writing a comment for each and every possible occurrence would be 
daunting and counterproductive.

Also, if you like, you may submit a patch that changes 
qh_urb_transaction() so that it calls usb_endpoint_maxp() rather than 
usb_maxpacket() (using &urb->ep->desc as the argument rather than 
urb->pipe), so that it more closely imitates the calculation in 
usb_submit_urb().  You can even add a WARN_ON(maxpacket == 0), but I 
do not expect it will ever be triggered.

Alan Stern
