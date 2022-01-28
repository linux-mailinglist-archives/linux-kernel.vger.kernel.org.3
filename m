Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27E54A0140
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351052AbiA1T5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:57:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60646 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351058AbiA1T5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643399861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gmGbmOUvK4yjDAJwMxxJBb4Z/xtyIfwX7CGR6Y/DpC0=;
        b=LwtsHgmimcQzxAdD9Mew9ArQv7lQvZSy6LtCABAqGORwQnODviIWvR29LB9wHAUaJSd+DD
        XrlMmJlSxPCmlYSVtR7rGCQrsPrOuLqTniplxnk3SjiwKaFa4yx1P+QLqOoaLRa6SQ4Fkx
        Kr+ZNkBcjneyoqJQEHiNn1vAWTV7dd4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-S2XvZ5JuOmu_2aWDHrssAQ-1; Fri, 28 Jan 2022 14:57:39 -0500
X-MC-Unique: S2XvZ5JuOmu_2aWDHrssAQ-1
Received: by mail-qt1-f197.google.com with SMTP id 4-20020ac85744000000b002b2f329efc2so5370802qtx.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=gmGbmOUvK4yjDAJwMxxJBb4Z/xtyIfwX7CGR6Y/DpC0=;
        b=Ef//lQod0CTt016XJ3zUs9fmOmA6jin0R4YOyWCzyUxbFdUsD4B8F9umqJCrmQic78
         9XB7cYbFfi0648RzZhyMX8xstcE7JeEm9G5wkVfhAKDSGeTVxCVRHREiSPtwsLvy2c8+
         TS7YiBHcVRWAibO4yZrS6JI1uONfNHH/fJFHUZ3+f/qm4hDlr5IDlcEXvO0w/pP/InDB
         SBOxmozDmclPStYBkgpYPLe4aNx+fri5soahH7HFrMY/3TMEdYULdcjwhtkdyBpwDRXK
         0ZaduSvyS/9V00U2s1TbschqlN+RsC5TdnCCZ9yUifBdBW+AJftgtk5NUHiNit5FHR4Y
         MWfQ==
X-Gm-Message-State: AOAM532tGtd/p2oQp6PyO3kTgwDLrj8Bt49brL79iaUVpjhzSIoYqbRw
        4hEIUI54uQdiWGVG5+fLMd7Pw4QqpAUF6y9JxiUywDePKc3C42DJiCK0d3cmQy4+fNzg4MG6a6s
        MKfQoWxmRKWsbEuP66HoH74Cl
X-Received: by 2002:a05:622a:34f:: with SMTP id r15mr7313868qtw.614.1643399859188;
        Fri, 28 Jan 2022 11:57:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqqqWZZnT4Gi792LqHhFNNSJChpEPsdTeaK71iFNML++Ifr0P0KAn1UTLen+GqF1t7TRUCOg==
X-Received: by 2002:a05:622a:34f:: with SMTP id r15mr7313857qtw.614.1643399858977;
        Fri, 28 Jan 2022 11:57:38 -0800 (PST)
Received: from [192.168.8.138] (pool-98-118-105-43.bstnma.ftas.verizon.net. [98.118.105.43])
        by smtp.gmail.com with ESMTPSA id bl1sm3880139qkb.16.2022.01.28.11.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 11:57:38 -0800 (PST)
Message-ID: <9457f3e139bdf3938e829e1affd01300c11c67dc.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/acr: Fix undefined behavior in
 nvkm_acr_hsfw_load_bl()
From:   Lyude Paul <lyude@redhat.com>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Zhou Qingyang <zhou1615@umn.edu>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        Kangjie Lu <kjlu@umn.edu>, LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>
Date:   Fri, 28 Jan 2022 14:57:36 -0500
In-Reply-To: <CADnq5_MtMPNHbs92OMHEzvPYSHGt=nPJMdrny6Siuvj3SYTAXQ@mail.gmail.com>
References: <20220124165856.57022-1-zhou1615@umn.edu>
         <YfPC3N+H9Fu/gqpz@kroah.com>
         <536c833413ccbe0b8ad653a50c5ea867bf975290.camel@redhat.com>
         <CADnq5_MtMPNHbs92OMHEzvPYSHGt=nPJMdrny6Siuvj3SYTAXQ@mail.gmail.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-01-28 at 14:53 -0500, Alex Deucher wrote:
> On Fri, Jan 28, 2022 at 2:20 PM Lyude Paul <lyude@redhat.com> wrote:
> > 
> > Sigh-thank you for catching this - I had totally forgot about the umn.edu
> > ban.
> > I pushed this already but I will go ahead and send a revert for this
> > patch.
> > Will cc you on it as well.
> 
> This seems short-sighted.  If the patch is valid I see no reason to
> not accept it.  I'm not trying to downplay the mess umn got into, but
> as long as the patch is well scrutinized and fixes a valid issue, it
> should be applied rather than leaving potential bugs in place.
> 

Yeah - I sent a revert for this, but that was mainly just to make sure I
didn't cause problems with Linus or something like that. If it's all the same
I'd much rather just leave this patch in, as looking at the code the fix seems
completely valid.

> Alex
> 
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
> > > >  drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c | 9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> > > > b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> > > > index 667fa016496e..a6ea89a5d51a 100644
> > > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> > > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> > > > @@ -142,11 +142,12 @@ nvkm_acr_hsfw_load_bl(struct nvkm_acr *acr,
> > > > const
> > > > char *name, int ver,
> > > > 
> > > >         hsfw->imem_size = desc->code_size;
> > > >         hsfw->imem_tag = desc->start_tag;
> > > > -       hsfw->imem = kmalloc(desc->code_size, GFP_KERNEL);
> > > > -       memcpy(hsfw->imem, data + desc->code_off, desc->code_size);
> > > > -
> > > > +       hsfw->imem = kmemdup(data + desc->code_off, desc->code_size,
> > > > GFP_KERNEL);
> > > >         nvkm_firmware_put(fw);
> > > > -       return 0;
> > > > +       if (!hsfw->imem)
> > > > +               return -ENOMEM;
> > > > +       else
> > > > +               return 0;
> > > >  }
> > > > 
> > > >  int
> > > > --
> > > > 2.25.1
> > > > 
> > > 
> > > As stated before, umn.edu is still not allowed to contribute to the
> > > Linux kernel.  Please work with your administration to resolve this
> > > issue.
> > > 
> > 
> > --
> > Cheers,
> >  Lyude Paul (she/her)
> >  Software Engineer at Red Hat
> > 
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

