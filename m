Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1657E4A0144
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiA1T6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:58:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351132AbiA1T6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:58:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643399890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=coCa9J+GhEzNyejkCKSC7tpX70/70zSfnqE1h06XrJU=;
        b=OAzxeyOh9lXRGj+waujr8bQ9bbDXRFaD7t5n8HSVS4IkklLz6s7L6k8Z9eKwLI7O6glBwN
        j5JTxvJDSpf0FeOV6RYhkW7sgZdkz0XdhbjGheop3r3pJJBwn38eKAsfRZlncGUIqG6e22
        2M6+avLpDM3f8L0DNM3SuVANl1zJgQw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-V5uFpz1wM7-cgIgJmKDe8Q-1; Fri, 28 Jan 2022 14:58:08 -0500
X-MC-Unique: V5uFpz1wM7-cgIgJmKDe8Q-1
Received: by mail-wm1-f69.google.com with SMTP id s190-20020a1ca9c7000000b00347c6c39d9aso3406304wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:58:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=coCa9J+GhEzNyejkCKSC7tpX70/70zSfnqE1h06XrJU=;
        b=gJSUF540E00Lt4R/t+NRirpQ8/lXmSAXDSOHtM/ZJ3jN3v3Qs0wuf28CoM1EUEHPM6
         xJ3aIX1a5U+uROLwJdWGPUj0SuBPmdQYXbtBY1BrHKXRdjBiginwlOYo5MzhnOiZ4fuA
         YQXShLNo8pmO0iiGPuI8Mat20AoGYLw6px2uPvhPGTzmrkDDZFOJjkLScABwwAB2vgyO
         Fwfmkl1c+HiYlWu3dIDbz+480zRopkW8JPArx5sqr9dP005NjH7BUybHWZAKrmq7VPxo
         97dSs71qVLk8YHNPgrLRpVtrOtOZTJSB5WLyX8Qx0yRrup3PpvKPn71fEy2zHZyvp/Az
         e0dA==
X-Gm-Message-State: AOAM533zF/mKlSOUbswbXO1BNvey+p0VdGzE2vwf+8R+ClDcr1iCyGcP
        f5mZPDuV52Y18rGcfbDYgnalrrBX9VNaZ7gXlz1VGIzOqbAPUx/uf1nu3RqHlYqgd9muFVS90ES
        GBPydoR2MBzoBW1H66XLz4BBxePRHijwaCd4JRc2Q
X-Received: by 2002:a7b:c21a:: with SMTP id x26mr17301234wmi.74.1643399887596;
        Fri, 28 Jan 2022 11:58:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzO0BXUM+1aQ82/ST9VCeZw7PtSnkB3W5IUl/VvfjMagzhYYe6iU+54S1WO7PVXjD+mUK3GvsW3MVLGJienj1g=
X-Received: by 2002:a7b:c21a:: with SMTP id x26mr17301215wmi.74.1643399887368;
 Fri, 28 Jan 2022 11:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20220124165856.57022-1-zhou1615@umn.edu> <YfPC3N+H9Fu/gqpz@kroah.com>
 <536c833413ccbe0b8ad653a50c5ea867bf975290.camel@redhat.com> <CADnq5_MtMPNHbs92OMHEzvPYSHGt=nPJMdrny6Siuvj3SYTAXQ@mail.gmail.com>
In-Reply-To: <CADnq5_MtMPNHbs92OMHEzvPYSHGt=nPJMdrny6Siuvj3SYTAXQ@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 28 Jan 2022 20:57:56 +0100
Message-ID: <CACO55tt4P+beifvS=jcDsfwybFynngc8DHLR0n3BseeDJNrHyw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/acr: Fix undefined behavior in nvkm_acr_hsfw_load_bl()
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Zhou Qingyang <zhou1615@umn.edu>,
        David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        Kangjie Lu <kjlu@umn.edu>, LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 8:54 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Fri, Jan 28, 2022 at 2:20 PM Lyude Paul <lyude@redhat.com> wrote:
> >
> > Sigh-thank you for catching this - I had totally forgot about the umn.edu ban.
> > I pushed this already but I will go ahead and send a revert for this patch.
> > Will cc you on it as well.
>
> This seems short-sighted.  If the patch is valid I see no reason to
> not accept it.  I'm not trying to downplay the mess umn got into, but
> as long as the patch is well scrutinized and fixes a valid issue, it
> should be applied rather than leaving potential bugs in place.
>
> Alex
>

Even though knowing that malicious code can be introduced via
perfectly fine looking patches, and sometimes one will never spot the
problem, this patch isn't all that bad tbh.

So should we reject patches out of "policies" or should we just be
extra careful? But not addressing the concerns as Greg pointed out is
also kind of a bad move, but also not knowing what the state of
resolving this mess is anyway.

>
> >
> > On Fri, 2022-01-28 at 11:18 +0100, Greg KH wrote:
> > > On Tue, Jan 25, 2022 at 12:58:55AM +0800, Zhou Qingyang wrote:
> > > > In nvkm_acr_hsfw_load_bl(), the return value of kmalloc() is directly
> > > > passed to memcpy(), which could lead to undefined behavior on failure
> > > > of kmalloc().
> > > >
> > > > Fix this bug by using kmemdup() instead of kmalloc()+memcpy().
> > > >
> > > > This bug was found by a static analyzer.
> > > >
> > > > Builds with 'make allyesconfig' show no new warnings,
> > > > and our static analyzer no longer warns about this code.
> > > >
> > > > Fixes: 22dcda45a3d1 ("drm/nouveau/acr: implement new subdev to replace
> > > > "secure boot"")
> > > > Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> > > > ---
> > > > The analysis employs differential checking to identify inconsistent
> > > > security operations (e.g., checks or kfrees) between two code paths
> > > > and confirms that the inconsistent operations are not recovered in the
> > > > current function or the callers, so they constitute bugs.
> > > >
> > > > Note that, as a bug found by static analysis, it can be a false
> > > > positive or hard to trigger. Multiple researchers have cross-reviewed
> > > > the bug.
> > > >
> > > >  drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c | 9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> > > > b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> > > > index 667fa016496e..a6ea89a5d51a 100644
> > > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> > > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> > > > @@ -142,11 +142,12 @@ nvkm_acr_hsfw_load_bl(struct nvkm_acr *acr, const
> > > > char *name, int ver,
> > > >
> > > >         hsfw->imem_size = desc->code_size;
> > > >         hsfw->imem_tag = desc->start_tag;
> > > > -       hsfw->imem = kmalloc(desc->code_size, GFP_KERNEL);
> > > > -       memcpy(hsfw->imem, data + desc->code_off, desc->code_size);
> > > > -
> > > > +       hsfw->imem = kmemdup(data + desc->code_off, desc->code_size,
> > > > GFP_KERNEL);
> > > >         nvkm_firmware_put(fw);
> > > > -       return 0;
> > > > +       if (!hsfw->imem)
> > > > +               return -ENOMEM;
> > > > +       else
> > > > +               return 0;
> > > >  }
> > > >
> > > >  int
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > As stated before, umn.edu is still not allowed to contribute to the
> > > Linux kernel.  Please work with your administration to resolve this
> > > issue.
> > >
> >
> > --
> > Cheers,
> >  Lyude Paul (she/her)
> >  Software Engineer at Red Hat
> >
>

