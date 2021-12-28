Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4810A480DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 23:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbhL1WtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 17:49:07 -0500
Received: from netrider.rowland.org ([192.131.102.5]:53919 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S237688AbhL1WtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 17:49:04 -0500
Received: (qmail 1083515 invoked by uid 1000); 28 Dec 2021 17:49:03 -0500
Date:   Tue, 28 Dec 2021 17:49:03 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     syzbot+e7d46eb426883fb97efd@syzkaller.appspotmail.com,
        glider@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        usb-storage@lists.one-eyed-alien.net,
        Kernel Janitors <kernel-janitors@vger.kernel.org>
Subject: Re: KMSAN: uninit-value in alauda_check_media
Message-ID: <YcuUX6BVo+HA1TcI@rowland.harvard.edu>
References: <0000000000007d25ff059457342d@google.com>
 <f78b974a-e36b-6d23-6977-fdf50c05600b@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f78b974a-e36b-6d23-6977-fdf50c05600b@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 08:47:15AM +0100, Christophe JAILLET wrote:
> Hi,
> 
> (2nd try - text only format - sorry for the noise)
> 
> 
> first try to use syzbot. I hope I do it right.
> Discussion about the syz report can be found at
> https://lore.kernel.org/linux-kernel/0000000000007d25ff059457342d@google.com/
> 
> This patch only test if alauda_get_media_status() (and its embedded
> usb_stor_ctrl_transfer()) before using the data.
> In case of error, it returns USB_STOR_TRANSPORT_ERROR as done elsewhere.
> 
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> master
> 
> CJ
> 

> diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
> index 20b857e97e60..6c486d964911 100644
> --- a/drivers/usb/storage/alauda.c
> +++ b/drivers/usb/storage/alauda.c
> @@ -318,7 +318,8 @@ static int alauda_get_media_status(struct us_data *us, unsigned char *data)
>  	rc = usb_stor_ctrl_transfer(us, us->recv_ctrl_pipe,
>  		command, 0xc0, 0, 1, data, 2);
>  
> -	usb_stor_dbg(us, "Media status %02X %02X\n", data[0], data[1]);
> +	if (rc == USB_STOR_XFER_GOOD)
> +		usb_stor_dbg(us, "Media status %02X %02X\n", data[0], data[1]);

Instead of adding this test, you could initialize data[0] and data[1] 
to zero before the call to usb_stor_ctrl_transfer.

>  
>  	return rc;
>  }
> @@ -453,8 +454,11 @@ static int alauda_check_media(struct us_data *us)
>  {
>  	struct alauda_info *info = (struct alauda_info *) us->extra;
>  	unsigned char status[2];
> +	int rc;
>  
> -	alauda_get_media_status(us, status);
> +	rc = alauda_get_media_status(us, status);
> +	if (rc != USB_STOR_TRANSPORT_GOOD)
> +		return USB_STOR_TRANSPORT_ERROR;
>  
>  	/* Check for no media or door open */
>  	if ((status[0] & 0x80) || ((status[0] & 0x1F) == 0x10)

In general this looks fine.  Let us know when you are ready to submit 
the patch.

Alan Stern
