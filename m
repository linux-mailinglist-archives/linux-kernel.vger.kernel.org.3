Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2B048F4AB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 05:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiAOEOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 23:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiAOEOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 23:14:05 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AEBC06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 20:14:04 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so24122090pjf.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 20:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mfIrzj6cPcGzWR/gN8R7LyeEpSY521Rk0SIcNjAgQwo=;
        b=D4zpVPRtkIQYIqolRPih/thQZjac99N1tHrhrQcT4NLSu6zjJXH4rmRWaNBUL6gGa0
         2McD+Nc+1QM0Nu586VyP4uNHqGirwrAj4JTypaa/zSdMaac6wmocNYLr/pOUsC1KtWQw
         x/6LRvnryvaGPECwPHL7/hu/JGK/oBFCuipqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mfIrzj6cPcGzWR/gN8R7LyeEpSY521Rk0SIcNjAgQwo=;
        b=CHgvlnzgEkFVYyGP/bhoSz5cCnVbmQWPVTNrFjpJxH06/nFzc+E8BZ1p5noRnVHsBy
         n7yQK/9O14GsbyKuQNF62UjB2n67oRWwY4xmIW+4EUUcUu3hczqaVFQnsf2HKcZLqbGQ
         0lvPwXoexpEVis4BHmuI3vqhb4KIhgllKrXCUhkBDDb37QuT3UPkVgE2UxL4Db4q/AQv
         Mz3WwIKvf/BeQKpPurihzQCKdTfxi2mxlQXoUxgeOYGkhd3jfjPbbeLOOQTd9r1c4G5Z
         YB+ZrueBNr936R7TYmk2PJ46Ki4AVxrJYoSFOfxb1Uq5+uLm05ZsPYVOqPEnLL8iVfFo
         rlIw==
X-Gm-Message-State: AOAM532rxda2T5xpzj+QyIFIBIE1Dck2PkPEWksrXDxBkbim1Z/Dj5UH
        8SSs24OURCx6+AIptpeUGUnv1g==
X-Google-Smtp-Source: ABdhPJxUkgWJzQPhcFWbWuR/K659eJVHLeC9GLGXuxaI75I5X0fvvZfdu3tleS0bdLQyXvQPZxcrvg==
X-Received: by 2002:a17:902:6bc7:b0:149:9004:ca04 with SMTP id m7-20020a1709026bc700b001499004ca04mr12535270plt.43.1642220044226;
        Fri, 14 Jan 2022 20:14:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id oj6sm9671328pjb.18.2022.01.14.20.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 20:14:03 -0800 (PST)
Date:   Fri, 14 Jan 2022 20:14:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, Hans de Goede <hdegoede@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Marco Cesati <marcocesati@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Check for NULL header value
Message-ID: <202201141958.5864A3ABD@keescook>
References: <20220113002001.3498383-1-keescook@chromium.org>
 <Yd/tSpnpb4vWp6OP@kroah.com>
 <202201131027.FCAC3072E4@keescook>
 <YeB0rP7KXtbIKr6I@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeB0rP7KXtbIKr6I@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 07:51:24PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Jan 13, 2022 at 10:29:04AM -0800, Kees Cook wrote:
> > On Thu, Jan 13, 2022 at 10:13:46AM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Jan 12, 2022 at 04:20:01PM -0800, Kees Cook wrote:
> > > > When building with -Warray-bounds, the following warning is emitted:
> > > > 
> > > > In file included from ./include/linux/string.h:253,
> > > >                  from ./arch/x86/include/asm/page_32.h:22,
> > > >                  from ./arch/x86/include/asm/page.h:14,
> > > >                  from ./arch/x86/include/asm/thread_info.h:12,
> > > >                  from ./include/linux/thread_info.h:60,
> > > >                  from ./arch/x86/include/asm/preempt.h:7,
> > > >                  from ./include/linux/preempt.h:78,
> > > >                  from ./include/linux/rcupdate.h:27,
> > > >                  from ./include/linux/rculist.h:11,
> > > >                  from ./include/linux/sched/signal.h:5,
> > > >                  from ./drivers/staging/rtl8723bs/include/drv_types.h:17,
> > > >                  from drivers/staging/rtl8723bs/core/rtw_recv.c:7:
> > > > In function 'memcpy',
> > > >     inlined from 'wlanhdr_to_ethhdr' at drivers/staging/rtl8723bs/core/rtw_recv.c:1554:2:
> > > > ./include/linux/fortify-string.h:41:33: warning: '__builtin_memcpy' offset [0, 5] is out of the bounds [0, 0] [-Warray-bounds]
> > > >    41 | #define __underlying_memcpy     __builtin_memcpy
> > > >       |                                 ^
> > > > 
> > > > This is because the compiler sees it is possible for "ptr" to be a NULL
> > > > value, and concludes that it has zero size and attempts to copy to it
> > > > would overflow. Instead, detect the NULL return and error out early.
> > > > 
> > > > Cc: Larry Finger <Larry.Finger@lwfinger.net>
> > > > Cc: Phillip Potter <phil@philpotter.co.uk>
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: Michael Straube <straube.linux@gmail.com>
> > > > Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
> > > > Cc: linux-staging@lists.linux.dev
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > >  drivers/staging/rtl8723bs/core/rtw_recv.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> > > > index 41bfca549c64..61135c49322b 100644
> > > > --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> > > > +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> > > > @@ -1513,6 +1513,9 @@ static signed int wlanhdr_to_ethhdr(union recv_frame *precvframe)
> > > >  	u8 *ptr = get_recvframe_data(precvframe) ; /*  point to frame_ctrl field */
> > > >  	struct rx_pkt_attrib *pattrib = &precvframe->u.hdr.attrib;
> > > >  
> > > > +	if (!ptr)
> > > > +		return _FAIL;
> > > 
> > > This will never happen, so let's not paper over compiler issues with
> > > stuff like this please.
> > > 
> > > As the call to get_recvframe_data() is only done in one place in this
> > > driver (in all drivers that look like this as well), it can just be
> > > replaced with the real code instead of the nonsensical test for NULL and
> > > then the compiler should be happy.
> > > 
> > > I'll gladly take that fix instead of this one, as that would be the
> > > correct solution here.
> > 
> > I changed it around, but it doesn't help. I assume this is because we
> > build with -fno-delete-null-pointer-checks, so the compiler continues
> > to assume it's possible for the incoming argument to be NULL.
> 
> That's a broken compiler then.
> 
> > Should I rearrange this to do a NULL check for precvframe before all the
> > assignments in addition to removing get_recvframe_data()?
> 
> If you walk the call-chain back, you will see that precvframe can't ever
> be NULL here (which is why this code doesn't crash), so don't check for
> something that is impossible to ever hit please just because the
> compiler is broken.

I agree that the _original_ precvframe is always non-NULL, but the pointer
landing at memcpy() gets updated along the way. It seems the new problem
is that recvframe_pull() may return NULL and nothing is checking for that.
Adding this silences the warning:

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 49a02d6239d6..946e659ae97a 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -1223,10 +1223,14 @@ static int wlanhdr_to_ethhdr(struct recv_frame *precvframe)
 		eth_type = 0x8712;
 		/*  append rx status for mp test packets */
 		ptr = recvframe_pull(precvframe, (rmv_len - sizeof(struct ethhdr) + 2) - 24);
+		if (!ptr)
+			return _FAIL;
 		memcpy(ptr, get_rxmem(precvframe), 24);
 		ptr += 24;
 	} else {
 		ptr = recvframe_pull(precvframe, (rmv_len - sizeof(struct ethhdr) + (bsnaphdr ? 2 : 0)));
+		if (!ptr)
+			return _FAIL;
 	}
 
 	memcpy(ptr, pattrib->dst, ETH_ALEN);

> 
> thanks,
> 
> greg k-h

-- 
Kees Cook
