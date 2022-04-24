Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AA450D0CC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 11:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238855AbiDXJa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 05:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbiDXJa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 05:30:56 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE5CE90
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 02:27:56 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id e189so13985150oia.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 02:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGfh8EfUa/71STJGMxPbCQwj50vcBi6lUdptORUuTtU=;
        b=mOtSMeD38hB1Ln7QFmLgtxBBGD+oQPSf+iLUc0NLLkNszOpB4d6EIwNHyK6pMorfDG
         VlN6HWzqk/URRT4/BniBP4yYUJopdj+TaE7K3WxsvxyWPffaITFSDpBFo096T+gju3gM
         jOBHEQtSibpdc3wyHviWgCgWXnnDZegdNSA4QgAJq2tW0w4uHtwz+zXhTu7BSBq30P2A
         /VFuZ9ABGC2gJaxlaGEpQHjJFserKQJ4jw189wwQ6o12mD0VA5QrU4SCm/jKm2em4+py
         D7P24V1bYW1ktQJ4zFDUSr8FAo4grAZdXf1t/MDSuY2tagSVbrzoYARsr4MIEmTHY2Tk
         Hugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGfh8EfUa/71STJGMxPbCQwj50vcBi6lUdptORUuTtU=;
        b=nUm0ZXsegWUpl0MOoKTL1OgMiF+6vE5ADux2TPotlZ/IlIfXhvGTRYQqsAbhHcbbLB
         P5kc1MeWwpO7Cg8SHOtEL7sz6JZeje7GOHoEP3bnD+gmFGLxHJ9Q5tSqMBZixL7FUdT3
         jE15coEh31wC78dFbTSv0CF5esLhQcrZF33X1ZN5loDpX4K3ULMrvotJYGT2cQPD4zRi
         LARzVYKohDlEyIfsAN5EXtRZuAFaipmhiyA8plw4qfobn8NnjgHS+opVXDZ2Ab4pPw8g
         3og815R05kcu9twHmchXNhC7juhok+Tbks8FRlLw4pBBkaXltjdhgQiporULewb3V4w/
         N4rg==
X-Gm-Message-State: AOAM5304flYoTFX6QM5fPqK2hj6vOK0nEbr0u0aLN3VIolrxnbhR8Zr7
        F8fyiFOOWC9f0remZXcuGGAajaR256QQOCuIGv8=
X-Google-Smtp-Source: ABdhPJxIgM5ZYlj0ri3lZjBQqBO255sXOTD9eqpLJg58/ifArO33kJJn4O9Ihzjqf7GCRyRX6ude2mgb8KMuEc2T3BA=
X-Received: by 2002:aca:1306:0:b0:322:9104:6cf9 with SMTP id
 e6-20020aca1306000000b0032291046cf9mr5701436oii.112.1650792476305; Sun, 24
 Apr 2022 02:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220423184745.21134-1-makvihas@gmail.com> <3607997.MHq7AAxBmi@leap>
In-Reply-To: <3607997.MHq7AAxBmi@leap>
From:   Vihas Makwana <makvihas@gmail.com>
Date:   Sun, 24 Apr 2022 14:57:45 +0530
Message-ID: <CAH1kMwSZbogptqDdiJVoiLcZamY_PmX_p0oXPZguoAnY=dibug@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: fix a potential NULL pointer dereference
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 5:17 AM Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> On sabato 23 aprile 2022 20:47:48 CEST Vihas Makwana wrote:
> > recvframe_chk_defrag() performs a NULL check on psta, but if that check
> > fails then it dereferences it, which it shouldn't do as psta is NULL.
> >
> > Set pdefrag_q to NULL if above check fails and let the code after it
> handle
> > that case.
> >
> > Fixes: 1cc18a22b96b ("staging: r8188eu: Add files for new driver - part
> 5")
> > Signed-off-by: Vihas Makwana <makvihas@gmail.com>
> > ---
> >  drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/
> r8188eu/core/rtw_recv.c
> > index c1005ddaa..db54bceff 100644
> > --- a/drivers/staging/r8188eu/core/rtw_recv.c
> > +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> > @@ -1244,7 +1244,7 @@ struct recv_frame *recvframe_chk_defrag(struct
> adapter *padapter, struct recv_fr
> >                       pdefrag_q = NULL;
> >               }
> >       } else {
> > -             pdefrag_q = &psta->sta_recvpriv.defrag_q;
> > +             pdefrag_q = NULL;
>
> Hi Vihas,
>
> To me the code looks like this...
>
>         struct sta_info *psta;
>         ...
>         psta = rtw_get_stainfo(pstapriv, psta_addr);
>         /* The code is about to test if "psta" is a valid pointer */
>         if (!psta) {
>                 /* "psta" is NULL */
>                 ...
>         } else {
>                 /* "psta" is not NULL */
>                 ...
>
> >       }
> >
>
> Also, even if "psta" were NULL (but it isn't), your change would still be
> no good.
>
> Please be very careful with these types of changes next time :)
>
> Thanks,
>
> Fabio M. De Francesco
>
> >       if ((ismfrag == 0) && (fragnum == 0))
> > --
Oh yea, sorry about this. I don't know how I missed this.
Thanks for clarification Fabio. Will take care next time.


-- 
Thanks,
Vihas
