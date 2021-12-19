Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B84479FD9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 09:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbhLSIAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 03:00:16 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:58067 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbhLSIAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 03:00:12 -0500
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BJ7xkbl050163;
        Sun, 19 Dec 2021 16:59:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Sun, 19 Dec 2021 16:59:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BJ7xkWE050158
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 19 Dec 2021 16:59:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <0804469c-664a-219d-bb6a-b4e5f133edd9@i-love.sakura.ne.jp>
Date:   Sun, 19 Dec 2021 16:59:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] usb: fixing some clang warnings inside usb host drivers
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Julio Faracco <jcfaracco@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        axboe@kernel.dk, tglx@linutronix.de, damien.lemoal@wdc.com,
        dkadashev@gmail.com, paul.gortmaker@windriver.com,
        zhouyanjie@wanyeetech.com, niklas.cassel@wdc.com,
        macro@orcam.me.uk, caihuoqing@baidu.com
References: <20211218042420.28466-1-jcfaracco@gmail.com>
 <Yb4i7LyYIlJi/9fb@rowland.harvard.edu>
 <7c5bbc97-b9dc-96bb-5764-58bebec0178d@i-love.sakura.ne.jp>
 <Yb6d7tflQeJ+1Et2@rowland.harvard.edu>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <Yb6d7tflQeJ+1Et2@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/19 11:50, Alan Stern wrote:
> You should read this code in usb_submit_urb():
> 
> 	max = usb_endpoint_maxp(&ep->desc);
> 	if (max <= 0) {
> 		dev_dbg(&dev->dev,
> 			"bogus endpoint ep%d%s in %s (bad maxpacket %d)\n",
> 			usb_endpoint_num(&ep->desc), is_out ? "out" : "in",
> 			__func__, max);
> 		return -EMSGSIZE;
> 	}
> 
> As far as I know, every code path leading to qtd_fill() has to pass this 
> test.

Excuse me, but surely qtd_fill() is using the result from usb_maxpacket()

----------------------------------------
static struct list_head *
qh_urb_transaction (
	struct ehci_hcd		*ehci,
	struct urb		*urb,
	struct list_head	*head,
	gfp_t			flags
) {
(...snipped...)
	maxpacket = usb_maxpacket(urb->dev, urb->pipe, !is_input);

	/*
	 * buffer gets wrapped in one or more qtds;
	 * last one may be "short" (including zero len)
	 * and may serve as a control status ack
	 */
	for (;;) {
		int this_qtd_len;

		this_qtd_len = qtd_fill(ehci, qtd, buf, this_sg_len, token,
				maxpacket);
		this_sg_len -= this_qtd_len;
		len -= this_qtd_len;
		buf += this_qtd_len;
(...snipped...)
}
----------------------------------------

and usb_maxpacket() may return 0 ?

----------------------------------------
static inline __u16
usb_maxpacket(struct usb_device *udev, int pipe, int is_out)
{
	struct usb_host_endpoint	*ep;
	unsigned			epnum = usb_pipeendpoint(pipe);

	if (is_out) {
		WARN_ON(usb_pipein(pipe));
		ep = udev->ep_out[epnum];
	} else {
		WARN_ON(usb_pipeout(pipe));
		ep = udev->ep_in[epnum];
	}
	if (!ep)
		return 0;

	/* NOTE:  only 0x07ff bits are for packet size... */
	return usb_endpoint_maxp(&ep->desc);
}
----------------------------------------

If we don't need to care about the possibility of returning 0 (including
all possible race conditions taken into account), please explain it as a
comment block.
