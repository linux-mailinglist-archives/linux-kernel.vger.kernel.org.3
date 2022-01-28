Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF8F4A012A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243047AbiA1TyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiA1TyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:54:10 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF54C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:54:09 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id m9so14295663oia.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dbB5bpgJl4M4esLVJEwWsrY33Y3h4Z6V9PbajaNn+YE=;
        b=CNlKJGYp51QoEQWW6xUac3uZY66AwrSyb601s/jQf3nN8SgClfYtlyGcWts8dW9TUf
         xgLOBfoZ3F6KTZePRAxbQWL/W66nd94CqJux/0P/uy8Hez4SiQe7XtvhKGRMa1523WvD
         LkgGhQ+NWSF+B++E6gJ6pHLk8vgfLmpF4gIxCapbvD3LuaWcQmmBybMw+6LkqvfLv8LX
         vBMUEPV4tq99jxeYKwIZGRlvfIFwEjQGrcQWFnPTMXXf9utUoE+zAATwqEs8F8zmJxAe
         dRgXixWo8LvTI8BKdVblRpqbQstZdWC3He3B6AAZzUwiKSnDniWTOrvYy1Z0k74xiaPm
         QOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dbB5bpgJl4M4esLVJEwWsrY33Y3h4Z6V9PbajaNn+YE=;
        b=jIBRPiYxRCuvD2TupXew/B1KuO38hW/TgL9Cskw2HzUIqxJ47ol2B08E7W4CLRCN9Q
         MUzJ+45OF9Vm4NbIIugKLZ5yi/4IiSgXUiz3niNZMAwXlKjXEZqMtHba81VZe0sNcE37
         amm66UBZRfC9kGd2GA1JGShZnvi5HJb72Mq1+8Y5zUikWEoU29OMw4P6NqPO8N4of0ja
         LayS53IjSk1KiYxqMyG8SRkVEz/f7jIReo4QaCDiY21Xe7AKPDPpnT0IQnRhhSKj3ioE
         xiO44oNrizaSxoxubVAbh7kzKKrPuie7c4MDvyyPGKImEUrN7AOKACtryciChP7xvyrv
         PAcw==
X-Gm-Message-State: AOAM533jHBPijMfpiR7dU2QjcLvAxIXaPR08zpY9CxZ9qnuNrEtBO4DM
        tcrkVSxC1GPA5YCeDWCGpQ4oWZJLpXtFBeGF2pYJeOx4
X-Google-Smtp-Source: ABdhPJyVkQJ8OvNjX1NkgBqXVFhUBaE59zpfuiYJJfsJUmqFXHuLHsR0mFw+lVA41cQxJq6mJX37kqVsagd10wLE6j4=
X-Received: by 2002:a05:6808:2189:: with SMTP id be9mr11235001oib.93.1643399648949;
 Fri, 28 Jan 2022 11:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20220124165856.57022-1-zhou1615@umn.edu> <YfPC3N+H9Fu/gqpz@kroah.com>
 <536c833413ccbe0b8ad653a50c5ea867bf975290.camel@redhat.com>
In-Reply-To: <536c833413ccbe0b8ad653a50c5ea867bf975290.camel@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 28 Jan 2022 14:53:57 -0500
Message-ID: <CADnq5_MtMPNHbs92OMHEzvPYSHGt=nPJMdrny6Siuvj3SYTAXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/acr: Fix undefined behavior in nvkm_acr_hsfw_load_bl()
To:     Lyude Paul <lyude@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Zhou Qingyang <zhou1615@umn.edu>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        Kangjie Lu <kjlu@umn.edu>, LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 2:20 PM Lyude Paul <lyude@redhat.com> wrote:
>
> Sigh-thank you for catching this - I had totally forgot about the umn.edu ban.
> I pushed this already but I will go ahead and send a revert for this patch.
> Will cc you on it as well.

This seems short-sighted.  If the patch is valid I see no reason to
not accept it.  I'm not trying to downplay the mess umn got into, but
as long as the patch is well scrutinized and fixes a valid issue, it
should be applied rather than leaving potential bugs in place.

Alex


>
> On Fri, 2022-01-28 at 11:18 +0100, Greg KH wrote:
> > On Tue, Jan 25, 2022 at 12:58:55AM +0800, Zhou Qingyang wrote:
> > > In nvkm_acr_hsfw_load_bl(), the return value of kmalloc() is directly
> > > passed to memcpy(), which could lead to undefined behavior on failure
> > > of kmalloc().
> > >
> > > Fix this bug by using kmemdup() instead of kmalloc()+memcpy().
> > >
> > > This bug was found by a static analyzer.
> > >
> > > Builds with 'make allyesconfig' show no new warnings,
> > > and our static analyzer no longer warns about this code.
> > >
> > > Fixes: 22dcda45a3d1 ("drm/nouveau/acr: implement new subdev to replace
> > > "secure boot"")
> > > Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> > > ---
> > > The analysis employs differential checking to identify inconsistent
> > > security operations (e.g., checks or kfrees) between two code paths
> > > and confirms that the inconsistent operations are not recovered in the
> > > current function or the callers, so they constitute bugs.
> > >
> > > Note that, as a bug found by static analysis, it can be a false
> > > positive or hard to trigger. Multiple researchers have cross-reviewed
> > > the bug.
> > >
> > >  drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> > > b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> > > index 667fa016496e..a6ea89a5d51a 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> > > @@ -142,11 +142,12 @@ nvkm_acr_hsfw_load_bl(struct nvkm_acr *acr, const
> > > char *name, int ver,
> > >
> > >         hsfw->imem_size = desc->code_size;
> > >         hsfw->imem_tag = desc->start_tag;
> > > -       hsfw->imem = kmalloc(desc->code_size, GFP_KERNEL);
> > > -       memcpy(hsfw->imem, data + desc->code_off, desc->code_size);
> > > -
> > > +       hsfw->imem = kmemdup(data + desc->code_off, desc->code_size,
> > > GFP_KERNEL);
> > >         nvkm_firmware_put(fw);
> > > -       return 0;
> > > +       if (!hsfw->imem)
> > > +               return -ENOMEM;
> > > +       else
> > > +               return 0;
> > >  }
> > >
> > >  int
> > > --
> > > 2.25.1
> > >
> >
> > As stated before, umn.edu is still not allowed to contribute to the
> > Linux kernel.  Please work with your administration to resolve this
> > issue.
> >
>
> --
> Cheers,
>  Lyude Paul (she/her)
>  Software Engineer at Red Hat
>
