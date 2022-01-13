Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7B748D4DF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiAMJPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:15:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56368 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiAMJNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:13:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50A94B81EFB;
        Thu, 13 Jan 2022 09:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85ED7C36AE3;
        Thu, 13 Jan 2022 09:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642065229;
        bh=RW4DozPOxlNI92jF6lBPdvOqnuQ/ZzGN/UAe58oV+eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K4dL/XHGr472oceoPwK418OamfSTy6sXTEBZyBLOSUC9WDd1h15zxDee6x9Rx2KpK
         +M6uixytBwvn8wbTG7AQfc0Erao4AbQPXnSvij/3DQ8Nnlun1QeLIOKzezgeN2CQ0F
         7xMVsqVgszFZ1QSj94nA+z+FH0C9ogay5S6qgrSw=
Date:   Thu, 13 Jan 2022 10:13:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Marco Cesati <marcocesati@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Check for NULL header value
Message-ID: <Yd/tSpnpb4vWp6OP@kroah.com>
References: <20220113002001.3498383-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113002001.3498383-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 04:20:01PM -0800, Kees Cook wrote:
> When building with -Warray-bounds, the following warning is emitted:
> 
> In file included from ./include/linux/string.h:253,
>                  from ./arch/x86/include/asm/page_32.h:22,
>                  from ./arch/x86/include/asm/page.h:14,
>                  from ./arch/x86/include/asm/thread_info.h:12,
>                  from ./include/linux/thread_info.h:60,
>                  from ./arch/x86/include/asm/preempt.h:7,
>                  from ./include/linux/preempt.h:78,
>                  from ./include/linux/rcupdate.h:27,
>                  from ./include/linux/rculist.h:11,
>                  from ./include/linux/sched/signal.h:5,
>                  from ./drivers/staging/rtl8723bs/include/drv_types.h:17,
>                  from drivers/staging/rtl8723bs/core/rtw_recv.c:7:
> In function 'memcpy',
>     inlined from 'wlanhdr_to_ethhdr' at drivers/staging/rtl8723bs/core/rtw_recv.c:1554:2:
> ./include/linux/fortify-string.h:41:33: warning: '__builtin_memcpy' offset [0, 5] is out of the bounds [0, 0] [-Warray-bounds]
>    41 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> 
> This is because the compiler sees it is possible for "ptr" to be a NULL
> value, and concludes that it has zero size and attempts to copy to it
> would overflow. Instead, detect the NULL return and error out early.
> 
> Cc: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Michael Straube <straube.linux@gmail.com>
> Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
> Cc: linux-staging@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/staging/rtl8723bs/core/rtw_recv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> index 41bfca549c64..61135c49322b 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> @@ -1513,6 +1513,9 @@ static signed int wlanhdr_to_ethhdr(union recv_frame *precvframe)
>  	u8 *ptr = get_recvframe_data(precvframe) ; /*  point to frame_ctrl field */
>  	struct rx_pkt_attrib *pattrib = &precvframe->u.hdr.attrib;
>  
> +	if (!ptr)
> +		return _FAIL;

This will never happen, so let's not paper over compiler issues with
stuff like this please.

As the call to get_recvframe_data() is only done in one place in this
driver (in all drivers that look like this as well), it can just be
replaced with the real code instead of the nonsensical test for NULL and
then the compiler should be happy.

I'll gladly take that fix instead of this one, as that would be the
correct solution here.

thanks,

greg k-h
