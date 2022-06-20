Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCD955143F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240628AbiFTJZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240581AbiFTJZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:25:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC2801180E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655717152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i5pHq1YJn02jwqVwFglHH5bGljBBluABJ3Mmj5OSWs4=;
        b=ab7m5866d9iJB2b2nY/hx1AKaLPv62sCudrJ/kE7puQZR06npaCy1pfIxx9Bca7yqMdP5H
        1PUnWJXlkdtmZ2DzcqkUX2JIshqkqfr7dYgTg6zIh+/M1EfrpdsWEOrlH2V62A+t5pj8uT
        hwSmAYbzAefnkYVz2Ma03RDimJdn/lY=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-X_SgVu4hOICmw_uk6jE8xQ-1; Mon, 20 Jun 2022 05:25:49 -0400
X-MC-Unique: X_SgVu4hOICmw_uk6jE8xQ-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-317bfb7aaacso22515477b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i5pHq1YJn02jwqVwFglHH5bGljBBluABJ3Mmj5OSWs4=;
        b=D9x7NoCpXkGitZJiRhNP5lcRO2pINnANPKcOwQjDIMX8M9Fz/50N0Q4vKYlbNTYj08
         wuEtjM6Y8G5sCd9dbptyvzq4yvXuxWK4e20M5zifk2zYyjyqyNHC5///lwN5DPQvgio5
         m1kkuc8Vx/HmiMfWcO9aTHKSu2qACDkjfiBwa4wwxmUJL58h1OV4tlMHSDv1eQhuluyf
         a6ETwgwHi76UJPgMB0jqooTAotzo6S8gUgtVwFXRnTlXZ0GCsZPDqMGXjI4G6vdbOaCQ
         MphK/+6yQvVaxPRetDnrQ23gEsjjq2Na38j5Pye7icefrOUDVnvTRwJFPuTKBJzHwpXS
         t+gg==
X-Gm-Message-State: AJIora9fPX87/vNWvHHe+neA2Nsq8NQupJvJi6FnAJ32DkiazHB8Is/k
        saClLy6KSW4kUBT6xxTgWTIRcOlq5d/UVu73GLI00T+1+KwfuNOjCdVg/auYO+uujjBWibftW2F
        i70HnbWkB1s0zVLxYmSjFrhzlSuGA2PWsp/OcgBhR
X-Received: by 2002:a5b:149:0:b0:668:3bd8:bf64 with SMTP id c9-20020a5b0149000000b006683bd8bf64mr23329575ybp.61.1655717148581;
        Mon, 20 Jun 2022 02:25:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sh/8GidoHOVYA2YAWBUWhUwDGgU4rpBIC7unfczj/DlJLg0x1w1ZE/o4EabOurM35KV1Ce7PiU/EmuznecO00=
X-Received: by 2002:a5b:149:0:b0:668:3bd8:bf64 with SMTP id
 c9-20020a5b0149000000b006683bd8bf64mr23329553ybp.61.1655717148295; Mon, 20
 Jun 2022 02:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220620085413.948265-1-hpa@redhat.com> <YrA3RffyR9VT0DjN@kroah.com>
In-Reply-To: <YrA3RffyR9VT0DjN@kroah.com>
From:   Kate Hsuan <hpa@redhat.com>
Date:   Mon, 20 Jun 2022 17:25:37 +0800
Message-ID: <CAEth8oGSOXpEN883QMxU9b++GB27pG8tbCjvdg9GaZkUOzFwWw@mail.gmail.com>
Subject: Re: [PATCH v1] staging: r8188eu: an incorrect return value made the
 function always return fail
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 5:01 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 20, 2022 at 04:54:13PM +0800, Kate Hsuan wrote:
> > Since _SUCCESS (1) and _FAIL (0) are used to indicate the status of the
> > functions. The previous commit 8ae7bf782eacad803f752c83a183393b0a67127b
>
> In the future, please reference commit ids as the documentation asks, as
> it's a much nicer way to understand things.  Also this commit id is not
> in Linus's tree or any tree that I can see, where did it come from?

Sorry about this. I'll improve this in my v2 patch.

>
> > fixed and prevented dereferencing a NULL pointer through checking the
> > return pointer. The NULL pointer check work properly but the return
> > values (-ENOMEM on fail and 0 on success). This work fixed the return
> > values to make sure the caller function will return the correct status.
> >
> > BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=2097526
> > Signed-off-by: Kate Hsuan <hpa@redhat.com>
> > ---
> >  drivers/staging/r8188eu/core/rtw_xmit.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> > index f4e9f6102539..2f8720db21d9 100644
> > --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> > +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> > @@ -180,10 +180,8 @@ s32      _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
> >       pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
> >
> >       res = rtw_alloc_hwxmits(padapter);
> > -     if (res) {
> > -             res = _FAIL;
> > +     if (res == _FAIL)
> >               goto exit;
> > -     }
> >
> >       rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
> >
> > @@ -1510,7 +1508,7 @@ int rtw_alloc_hwxmits(struct adapter *padapter)
> >
> >       pxmitpriv->hwxmits = kzalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry, GFP_KERNEL);
> >       if (!pxmitpriv->hwxmits)
> > -             return -ENOMEM;
> > +             return _FAIL;
>
> No, please let's fix up the callers to properly detect normal kernel
> error values and get rid of all of the crazy _FAIL and _SUCCESS values
> in this driver.

Okay.

>
> >
> >       hwxmits = pxmitpriv->hwxmits;
> >
> > @@ -1528,7 +1526,7 @@ int rtw_alloc_hwxmits(struct adapter *padapter)
> >       } else {
> >       }
> >
> > -     return 0;
> > +     return _SUCCESS;
>
> Same here, fix up the callers if they are checking this incorrectly.
>
> thanks,
>
> greg k-h
>

Thank you :)

-- 
BR,
Kate

