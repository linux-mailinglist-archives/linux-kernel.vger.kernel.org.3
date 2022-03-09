Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0324D2C89
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbiCIJwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiCIJwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:52:31 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF20916EAAB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:51:32 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id w127so2056863oig.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 01:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2SlVsKKO93FzV+wyxvnSN8csGn56ANvACZsUIgue+Uw=;
        b=PWcjCYr3DRiNE77T78Li6ap2qkWuqGgRfxbbfPuOTZJtWEfvMfYnw94RVt59JAuWQ0
         xum4ppPaG13ENevZIAtYr5FobhL5M4d79ac0ncKXkXMDVmylIWVHbHi67Yc/eLTYatNk
         VU0V3XD1sCWR1Jzj9f4BxyTtjEW3JVF3K1RFbnEOYh0xG+f9yXBto1/8ICZIfEZJ1Vpe
         GgRlK88+/ABeBcdE74cEvGfa3UJIFSDL2fNwHDFGtHUuV9Oa2vDBD40WGuEeiead6Iw8
         dMUWYyB4jqC/DxnCBTIPp1xHHw+LRo9vPE41JpJ91illYfXHVTL/TWTTnv+xhQUQ+mia
         Ab2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2SlVsKKO93FzV+wyxvnSN8csGn56ANvACZsUIgue+Uw=;
        b=37Imj6+Q8qwwWEX1GWVt7r7J0DkTxCTEzh1h+m+NUXdCw2C78onJRq4GdynZ1wFvBZ
         qWo39tgUuAhlIfEWLVWdTtd+iyc9+lEp+ju/eRpOru3P5Pow1FU0KBwof/q+j6kTt7/k
         9y8nn0V4UplnXPuFZsQdb/W53ZCiOK1wB/PO+WMyEC9BNLZRoezkLebNq/z4tT+XkM9x
         AODb4Ire34kuJbfsWdDLON33G+R3NwyHFD/azpAyCXIw89Zz2aKGQtLC9NamyICtXhLl
         Ddhh8vTn4vLRegFV/Bn6yqh6YjImBip+X6yE9Ncc7dtf3EFehTFKIXdjTswPfjAa9Pbh
         b2oA==
X-Gm-Message-State: AOAM533WJGHk/Jcs3mpJK2zPuBsFJvR60nNqNmvaQ04fDT+rV8ATEajf
        XHhK9cQ/DS8OhNF06Zgj8tNTXZffenkllbPvT0A=
X-Google-Smtp-Source: ABdhPJxA5k739fTu/pU+zLmLBYNtcaEYvt/4FbUHVLSAjSrPAf+RF4+Sdywdtjg77nLHt4n+ZA+alwX1f7By03XwP/g=
X-Received: by 2002:a05:6808:ec5:b0:2da:350d:f9f6 with SMTP id
 q5-20020a0568080ec500b002da350df9f6mr2079718oiv.276.1646819491917; Wed, 09
 Mar 2022 01:51:31 -0800 (PST)
MIME-Version: 1.0
References: <20220308205510.48431-1-makvihas@gmail.com> <20220308205510.48431-2-makvihas@gmail.com>
 <20220309075951.GQ3315@kadam>
In-Reply-To: <20220309075951.GQ3315@kadam>
From:   Vihas Makwana <makvihas@gmail.com>
Date:   Wed, 9 Mar 2022 15:21:20 +0530
Message-ID: <CAH1kMwT67mVn=UvwjtK28PvWy2CBddVx=CwvWRvqSV8_E81usw@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: r8188eu: call _cancel_timer_ex from _rtw_free_recv_priv
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> *If* then timer_setup() belongs in _rtw_init_recv_priv() then this is
> where the _cancel_timer_ex() belongs, yes.  But what about if the devs
> hid it in a different wrong place?
>
> Right the del_timer is in rtw_cancel_all_timer(), which is called
> from rtw_usb_if1_deinit() when we remove the USB device.  So something
> more complicated is wrong.  I would prefer to just note this as a bug
> until we can investigate more completely.

Sounds fair.

>
> I believe we can del_timer() twice without creating a bug, but I'm not
> positive.

Yes, we can. I tried it yesterday and it didn't create any bug.

On Wed, Mar 9, 2022 at 1:30 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Mar 09, 2022 at 02:25:09AM +0530, Vihas Makwana wrote:
> > The _rtw_init_recv_priv() initializes precvpriv->signal_stat_timer and
> > sets it's timeout interval to 1000 ms. But _rtw_free_recv_priv()
> > doesn't cancel the timer and we need to explicitly call
> > _cancel_timer_ex() after we call _rtw_free_recv_priv() to cancel the
> > timer.
> > Call _cancel_timer_ex() from inside _rtw_free_recv_priv() as every init
> > function needs a matching free function.
> >
> >
> > Signed-off-by: Vihas Makwana <makvihas@gmail.com>
> > ---
> >  drivers/staging/r8188eu/core/rtw_recv.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> > index d77d98351..61308eb39 100644
> > --- a/drivers/staging/r8188eu/core/rtw_recv.c
> > +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> > @@ -103,6 +103,7 @@ void _rtw_free_recv_priv(struct recv_priv *precvpriv)
> >       vfree(precvpriv->pallocated_frame_buf);
> >
> >       rtl8188eu_free_recv_priv(padapter);
> > +     _cancel_timer_ex(&precvpriv->signal_stat_timer);
> >  }
>
> *If* then timer_setup() belongs in _rtw_init_recv_priv() then this is
> where the _cancel_timer_ex() belongs, yes.  But what about if the devs
> hid it in a different wrong place?
>
> Right the del_timer is in rtw_cancel_all_timer(), which is called
> from rtw_usb_if1_deinit() when we remove the USB device.  So something
> more complicated is wrong.  I would prefer to just note this as a bug
> until we can investigate more completely.
>
> I believe we can del_timer() twice without creating a bug, but I'm not
> positive.
>
> regards,
> dan carpenter
>


-- 
Thanks,
Vihas
