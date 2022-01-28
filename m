Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D7B4A00C5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350867AbiA1TUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:20:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37598 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbiA1TU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643397628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mig7DWzSwp/dgfKpPr73AnI1RojscQkVEm4yd9tasvQ=;
        b=Fqrs8gvO+p0CSNqGMCTXMWS60p9QH8mG5o9xPbGreM+ljZGWIGuumBxEukfeEhOsPmdIl+
        QBcyfAmJbpI0dNBC3quaHsNkBQt9Y7gVgoL3/IkWQ9Ya3FEVYDNgx5T53WamxWN+qY8BL/
        Vef/OIgmAteBimS+1V/yqd23rJvS1Vo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-lUVMkihNNnesHXVYvxPbYg-1; Fri, 28 Jan 2022 14:20:26 -0500
X-MC-Unique: lUVMkihNNnesHXVYvxPbYg-1
Received: by mail-qt1-f200.google.com with SMTP id a28-20020ac84d9c000000b002d05c958a84so5369490qtw.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=mig7DWzSwp/dgfKpPr73AnI1RojscQkVEm4yd9tasvQ=;
        b=NMb6ew9h0wqBpC5NABSwgL+LWU4+5Yy2QSBOs2SIr/Epd9F2FaDjj5LT299jriONZO
         wVGDg6gTNo2wd/oHh8IBFdxhzMFZPWxlfy8C3P4c3GUepmFRTAINR4SAP1GytDsCJnNA
         S1COZ5vHj+19wtnIYF8RNXuDWdBGKCDDFqL1heypK/gTxOfFC80atR+FfNkta4tf43aq
         0lI/B014Nx6Wxc01oeEAY16r0paj1kiIgIajopDNLzrEP7zYV4b+tpd8TMsAw8uTrjIx
         6iQNfz/MMMk9YsIN+GzYa+y/nwn5M/+tYA5le/HauYOZyG+YbsnP7sHcSu0Mwanu9zVK
         xz4Q==
X-Gm-Message-State: AOAM531yUDz2fGMknHDMeoGK/g91A9UwJWhR2V5UHlQT9a8Ear5EffUe
        Xy7iwJ3UagXMQCD5kgeBR+t0aEYYHARlHLPjK7mbPzWTgeKDyo8QB7gtokNwSoJQhdwnY0bJ7jZ
        voHbin063GfVArRVEdEqHogfl
X-Received: by 2002:ad4:5769:: with SMTP id r9mr8886864qvx.52.1643397626482;
        Fri, 28 Jan 2022 11:20:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+Z3FzcdHTo3905MS7g1gUVZTFQpk0hs9iapN/w42adkJFAEEkEGcoNse6Q6tOGh2WnkBPtg==
X-Received: by 2002:ad4:5769:: with SMTP id r9mr8886848qvx.52.1643397626259;
        Fri, 28 Jan 2022 11:20:26 -0800 (PST)
Received: from [192.168.8.138] (pool-98-118-105-43.bstnma.ftas.verizon.net. [98.118.105.43])
        by smtp.gmail.com with ESMTPSA id c14sm2243444qtc.31.2022.01.28.11.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 11:20:25 -0800 (PST)
Message-ID: <536c833413ccbe0b8ad653a50c5ea867bf975290.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/acr: Fix undefined behavior in
 nvkm_acr_hsfw_load_bl()
From:   Lyude Paul <lyude@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Jan 2022 14:20:24 -0500
In-Reply-To: <YfPC3N+H9Fu/gqpz@kroah.com>
References: <20220124165856.57022-1-zhou1615@umn.edu>
         <YfPC3N+H9Fu/gqpz@kroah.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sigh-thank you for catching this - I had totally forgot about the umn.edu ban.
I pushed this already but I will go ahead and send a revert for this patch.
Will cc you on it as well.

On Fri, 2022-01-28 at 11:18 +0100, Greg KH wrote:
> On Tue, Jan 25, 2022 at 12:58:55AM +0800, Zhou Qingyang wrote:
> > In nvkm_acr_hsfw_load_bl(), the return value of kmalloc() is directly
> > passed to memcpy(), which could lead to undefined behavior on failure
> > of kmalloc().
> > 
> > Fix this bug by using kmemdup() instead of kmalloc()+memcpy().
> > 
> > This bug was found by a static analyzer.
> > 
> > Builds with 'make allyesconfig' show no new warnings,
> > and our static analyzer no longer warns about this code.
> > 
> > Fixes: 22dcda45a3d1 ("drm/nouveau/acr: implement new subdev to replace
> > "secure boot"")
> > Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> > ---
> > The analysis employs differential checking to identify inconsistent 
> > security operations (e.g., checks or kfrees) between two code paths 
> > and confirms that the inconsistent operations are not recovered in the
> > current function or the callers, so they constitute bugs. 
> > 
> > Note that, as a bug found by static analysis, it can be a false
> > positive or hard to trigger. Multiple researchers have cross-reviewed
> > the bug.
> > 
> >  drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> > b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> > index 667fa016496e..a6ea89a5d51a 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> > @@ -142,11 +142,12 @@ nvkm_acr_hsfw_load_bl(struct nvkm_acr *acr, const
> > char *name, int ver,
> >  
> >         hsfw->imem_size = desc->code_size;
> >         hsfw->imem_tag = desc->start_tag;
> > -       hsfw->imem = kmalloc(desc->code_size, GFP_KERNEL);
> > -       memcpy(hsfw->imem, data + desc->code_off, desc->code_size);
> > -
> > +       hsfw->imem = kmemdup(data + desc->code_off, desc->code_size,
> > GFP_KERNEL);
> >         nvkm_firmware_put(fw);
> > -       return 0;
> > +       if (!hsfw->imem)
> > +               return -ENOMEM;
> > +       else
> > +               return 0;
> >  }
> >  
> >  int
> > -- 
> > 2.25.1
> > 
> 
> As stated before, umn.edu is still not allowed to contribute to the
> Linux kernel.  Please work with your administration to resolve this
> issue.
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

