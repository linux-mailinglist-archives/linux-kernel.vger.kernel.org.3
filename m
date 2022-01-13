Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FFC48D4E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiAMJPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:15:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58078 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbiAMJON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:14:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2240761ADE;
        Thu, 13 Jan 2022 09:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC344C36AE9;
        Thu, 13 Jan 2022 09:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642065251;
        bh=LJtbUSGwM4wxW/dO+RjsUM6nIXC1v7DVBzKecDlu4Vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XY0KuFTcfYqTV5fty2JXdq8KUdN6gESStr/sv1UmR0NHhCDXG0O/zfSEJjEZ8CjTj
         FwrphoeUjiaXAcVjYctGDsYwzi5jKH134tG6lWfdWVULI07yzYjV+1pBv0gR3OC1qF
         39rx5aQ6M26WivHGSvvAOr2i3dR3FNJKAgVGBn5w=
Date:   Thu, 13 Jan 2022 10:14:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, Martin Kaiser <martin@kaiser.cx>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Check for NULL header value
Message-ID: <Yd/tYOJZ3rhxsHBY@kroah.com>
References: <20220113001934.3455851-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113001934.3455851-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 04:19:34PM -0800, Kees Cook wrote:
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
>  drivers/staging/r8188eu/core/rtw_recv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index 51a13262a226..93b0aa5688e3 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -1191,6 +1191,9 @@ static int wlanhdr_to_ethhdr(struct recv_frame *precvframe)
>  	u8	*ptr = get_recvframe_data(precvframe); /*  point to frame_ctrl field */
>  	struct rx_pkt_attrib *pattrib = &precvframe->attrib;
>  
> +	if (!ptr)
> +		return _FAIL;

Same objection as on the other staging driver change, this is not the
correct way to solve this.

thanks,

greg k-h
