Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9D7465305
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243645AbhLAQom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238010AbhLAQoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:44:39 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBCDC061574;
        Wed,  1 Dec 2021 08:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=UcsZNFJ29LeSfPD1DvV+HXT2vn7e0UO+Ekn6RYipnT8=; b=ooC8t
        H6bSMSLw8D8WZF9q5yorIyTFuzcyqVttg7rVykgQmNQc35kxZHVhHvJGC5Awa5sVJwzZYLjAxty+e
        CZHwFaxvs/v7SyyjGm5fLQvbjwb9jE0IwIvCvW6kPXlGek5xXZRcgNNHzTo0Qn+P32vtjVIQMb5Yw
        Mz58OSqxYQe6HSe0CP/DbPqTEJuiP8pKyHvJKUFiaROP8r1lnmRAUv6iiuuKrUNKch3R2qO9L0x9X
        j0DM11NlZF2iqsJV0CB6dgLjBpeZdz12iCjr5i4RPevWZOxHmnKq08iryo+YZM3Hq2FjheO5Pg2G+
        9Wi5Nh8hITIw3/M08p4wuoigvjVaA==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1msSfP-0000kl-F6; Wed, 01 Dec 2021 16:41:11 +0000
Date:   Wed, 1 Dec 2021 16:41:10 +0000
From:   John Keeping <john@metanate.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_jackp@quicinc.com
Subject: Re: [PATCH] usb: gadget: f_fs: Wake up IO thread during disconnect
Message-ID: <YaelpmsJXmhTY4A0@donbot>
References: <20211201100205.25448-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201100205.25448-1-quic_wcheng@quicinc.com>
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 02:02:05AM -0800, Wesley Cheng wrote:
> During device disconnect or composition unbind, applications should be
> notified that the endpoints are no longer enabled, so that it can take
> the proper actions to handle its IO threads.  Otherwise, they can be
> left waiting for endpoints until EPs are re-enabled.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  drivers/usb/gadget/function/f_fs.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index 3c584da9118c..0b0747d96378 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -957,10 +957,12 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
>  		if (file->f_flags & O_NONBLOCK)
>  			return -EAGAIN;
>  
> -		ret = wait_event_interruptible(
> -				epfile->ffs->wait, (ep = epfile->ep));
> +		ret = wait_event_interruptible(epfile->ffs->wait,
> +				(ep = epfile->ep) || !epfile->ffs->func);
>  		if (ret)
>  			return -EINTR;
> +		if (!epfile->ffs->func)
> +			return -ENODEV;

This seems strange - we are inside the case where the endpoint is not
initially enabled, if we're returning ENODEV here shouldn't that happen
in all cases?

Beyond that, there is no locking for accessing ffs->func here;
modification happens in gadget callbacks so it's guarded by the gadget
core (the existing case in ffs_ep0_ioctl() looks suspicious as well).

But I can't see why this change is necessary - there are event
notifications through ep0 when this happens, as can be seen in the hunk
below from the ffs_event_add(ffs, FUNCTIONFS_DISABLE) line.  If
userspace cares about this, then it can read the events from ep0.

>  	}
>  
>  	/* Do we halt? */
> @@ -3292,6 +3294,7 @@ static int ffs_func_set_alt(struct usb_function *f,
>  	if (alt == (unsigned)-1) {
>  		ffs->func = NULL;
>  		ffs_event_add(ffs, FUNCTIONFS_DISABLE);
> +		wake_up_interruptible(&ffs->wait);
>  		return 0;
>  	}
>  
