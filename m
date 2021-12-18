Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84ADC479846
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 03:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhLRC6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 21:58:17 -0500
Received: from mx-lax3-2.ucr.edu ([169.235.156.37]:26113 "EHLO
        mx-lax3-2.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhLRC6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 21:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1639796297; x=1671332297;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=KziBpYYiI76v0rTQKZkMxGcmjJMQJL/2X+fDliRgTY8=;
  b=tPc+aFdt7Gj+Jfikf7QGa+cWEPmNXbDz5ScutfhOao9EUebvZ1gV4CHs
   4VGRs/oGNsyS+Em4immhAkzMYKtUeWQAJqOuzbVE7SQu/N/IKds5HDQ2n
   3aVjwd/AhpGQcYA5G0bk0jn9z9pDiX0aQWc5fePk8q60aujZb5GXY4PEy
   sfhweaRnfmlsUQPIEO3s6p/1s27Q13c5ZIF2BIRJcQ3Z3LF4XD/9YHJSm
   J0KnUEfO6a5DGv8HXrBdJp59YQhVlcoDUKv/4BBRHHgkKhgms1KGsqn70
   9EfEeFPrr2jZVI+gre1knoPOuXuPCxgSl6ubl6+e/L7S/UlamO9Jkx6sx
   g==;
IronPort-SDR: fVlJjV/CsAQ2E+G493RsXoVPuSsY3gnItVRowPgPQB3ROtVETPl6fpy+OTofETM07EziIFHCo/
 kzDc+X1RvEZjyl7sRo37gomJ1Nx0LDBKCudjqvouvzChwSKzS9iRKzGSfJ62qy8vdNgZekadNl
 TyuesrMQ1OpagqxzD6HiAhuMS/jv+Bnoqy6bN8UL6aLsK8tr3pfFL6mL2fgPF+xTNs0tf9D9ZX
 00OTK/3pkrYcYb3tFJbCxOB6kZ+6Jx2l5bYjPj7No/xRGlOwBODoC5py/pjM5K9M2a88OZrj1S
 wh9oTmHG1wP43GF9p3b4PPpQ
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="91926350"
Received: from mail-yb1-f197.google.com ([209.85.219.197])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2021 18:58:16 -0800
Received: by mail-yb1-f197.google.com with SMTP id r18-20020a25ac52000000b005c9047c420bso8616012ybd.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 18:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8vmmsxncbFQ/2xzccVTZIkFvvP7ArQ13zGZOkstUsL4=;
        b=sTD11NtvmH1Wv1kqJu2D8MlUjyJcoEmt2d7+XfYXMulaWxXKuc6ajV7X/2OwVhFI22
         5/uGolBmOKVtUn/vvXD3Et12z1EV98H3MUEL6OMaXJqq+IJaDfnYYa0vcB5dumi3YJGf
         y6SMwAQXEgrG9URbzO7R3PgY7j0vTkxDElUZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vmmsxncbFQ/2xzccVTZIkFvvP7ArQ13zGZOkstUsL4=;
        b=k2Nei2TvBTsGKKj/5HrIe7vtjKbDa3PcilEtyntueepoy6ST/zyPR6OpC4WDMKge79
         VpyAkqVfhg6V4AgRCqLSjokKfENsGyZzj07cFFs6jPxaOEs3T6YN6dg8Ne73+en3QPJH
         Y5jyuHEJWj5nF/zIavHSSlW8xYwk2vFbRFNxse52VEOSOZntJ29lp5oM1L8B+1jvWkoh
         HbvrYM7f4tYr1XsRdT5s4Nx+HALPkHNngJ7MS+xGjFPOLCPlZUlc3D8xbqFHUMG4qPL4
         Sd/yc2nGy6MlczIPBl3XhQtAFdk1ipNJCt8HhSAKWWXbd9vpdVfZWoHj2jwnIvdV9sYw
         qmXg==
X-Gm-Message-State: AOAM533idlHJRxMEnf/seGWzSbabw2HG2LmNIs8BfBcug6URH7CmIQaC
        3HMDjLJAH6g7tCibIAl8A+Rcmeknv7cNRA6prdd+Gs1vpQ8pZ6jACA4gbzfEo61xyX1UwsPohv/
        quwmRaY6W0gBjA3LjhhCMKbEgNjgOe4dMg2Ai6WNKAw==
X-Received: by 2002:a25:a2c1:: with SMTP id c1mr8726863ybn.473.1639796295340;
        Fri, 17 Dec 2021 18:58:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxp6oA3pKkoWsKv1T0ej6zGhz3AR1ptfd0MFDEzORS1I7HWhSsr8wqxEJJfoR4dKLFSYf+Key6yqyGe/HuR3xk=
X-Received: by 2002:a25:a2c1:: with SMTP id c1mr8726855ybn.473.1639796295099;
 Fri, 17 Dec 2021 18:58:15 -0800 (PST)
MIME-Version: 1.0
References: <20211116070708.429432-1-yzhai003@ucr.edu> <6a79eef26121afa9190de5a021f4edef53fc9651.camel@redhat.com>
In-Reply-To: <6a79eef26121afa9190de5a021f4edef53fc9651.camel@redhat.com>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Fri, 17 Dec 2021 18:58:04 -0800
Message-ID: <CABvMjLQky6Xe80oJ9pPALjQ_SgMmp-Crp4z-Y08SiRo4TNTPSg@mail.gmail.com>
Subject: Re: [PATCH] In function nvkm_ioctl_map(), the variable "type" could
 be uninitialized if "nvkm_object_map()" returns error code, however, it does
 not check the return value and directly use the "type" in the if statement,
 which is potentially unsafe.
To:     Lyude Paul <lyude@redhat.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lyude:
I appreciate your feedback and I misplaced the commit message to the
title, I have modified it and resend the patch.
I made my linux development tree a mess, so I sent a brandly new one
and cc you. Thanks again for your help: )


On Tue, Nov 16, 2021 at 1:18 PM Lyude Paul <lyude@redhat.com> wrote:
>
> This is a very long patch name, it should probably be shorter and the
> details in the patch title moved into the actual commit description
> instead. Also a couple of things aren't formatted correctly:
>
> * Cc tag for stable is missing, see
>   https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> * Fixes tag isn't formatted properly
>
> I generally recommend using `dim fixes` from
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> in order to get the correct stable kernel CC tag and Fixes: tag (you can
> drop any of the Ccs it gives you beyond the one to stable at vger dot
> kernel dot org.
>
> Also, if you could try to Cc: me on the next version - will help me
> respond faster :).
>
> On Mon, 2021-11-15 at 23:07 -0800, Yizhuo Zhai wrote:
> > Fixes:01326050391ce("drm/nouveau/core/object: allow arguments to
> > be passed to map function")
> > Signed-off-by: Yizhuo Zhai <yzhai003@ucr.edu>
> > ---
> >  drivers/gpu/drm/nouveau/nvkm/core/ioctl.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
> > b/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
> > index 735cb6816f10..4264d9d79783 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/core/ioctl.c
> > @@ -266,6 +266,8 @@ nvkm_ioctl_map(struct nvkm_client *client,
> >                 ret = nvkm_object_map(object, data, size, &type,
> >                                       &args->v0.handle,
> >                                       &args->v0.length);
> > +               if (ret)
> > +                       return ret;
> >                 if (type == NVKM_OBJECT_MAP_IO)
> >                         args->v0.type = NVIF_IOCTL_MAP_V0_IO;
> >                 else
>
> --
> Cheers,
>  Lyude Paul (she/her)
>  Software Engineer at Red Hat
>


--
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
