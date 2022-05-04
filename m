Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A4B51AD52
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377408AbiEDSxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377389AbiEDSxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:53:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4922B1A073
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651690197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m4be0lUN3rLKvbTqi1ev9U0hEQDKuQCw8SDgLXDDtQ8=;
        b=ADS5cvZHJn9im/SO2nU2KnTP0yb8KzkQGbPba1IAk3b8Lka5abygMqMPrG5zFmtHi+PSKc
        +L8ba1HIk4h13dLNHJcGEXkBXxw2iS/GgEnHhQQIlcoewd0o0gWZ9X1OH4cqRgkqU5nmi4
        Mg/FyJ+xB3qJT1j6dgz+mgtpcmZ2b3s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-1cp0Ja-CPaKX74Do2pRx2A-1; Wed, 04 May 2022 14:49:56 -0400
X-MC-Unique: 1cp0Ja-CPaKX74Do2pRx2A-1
Received: by mail-qt1-f197.google.com with SMTP id v7-20020a05622a188700b002f3a65c8ab9so1693798qtc.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 11:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=m4be0lUN3rLKvbTqi1ev9U0hEQDKuQCw8SDgLXDDtQ8=;
        b=n4UeSnOwpgR46Cj2j8BiUY7qTL57TKVcnZJ19VbZlLEP+hdl73QAh5kV+THIhzFtSi
         Xy7AXy70t5Gq0P66QU4bWBPja9GzhXYb7nNbBy7pPnaTqZvJUn2r1mJqIHTmLpCzjkXe
         pK8jD9H3a3Rn4NiZMPxzwo6Wl1BKZoJDbRjWhacG+EndPzUD4BXvFUZCGcd3/POqaWBr
         LEXQLnUFzhrEK+Ka0/uqO2PPj9zwehrb5DYnlWdAlXee6t7mUqg5iN57lESs0N7OsftC
         52tm+y94ddD8TWKXKlEPVViMsdgASEIqUNlpupbZhpHP9cYkiuPPTjtybHPMg0iwtccA
         usVw==
X-Gm-Message-State: AOAM531KWistEUaaeIUsz+5QasTwyfz9gyft11ivA46dg8uiKy3Qm5SH
        W0nbwXcUP9ZTxwm5OibpsShB9pnof2WwHt3rW7TR6lmK6mXHBqwOgkzH4EvFU5ssGQG5MxBRBMD
        FLFvcuEH/oo0qRffyNNa5GsdA
X-Received: by 2002:ac8:4e8f:0:b0:2f3:83ef:f06b with SMTP id 15-20020ac84e8f000000b002f383eff06bmr20138269qtp.344.1651690194833;
        Wed, 04 May 2022 11:49:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxG+YEE9640XC9Q0TxKXIOu4OYQRb9HIa17dkwYt7i3SPR51ROIyeLOHCH0GKjio7e5whfd8A==
X-Received: by 2002:ac8:4e8f:0:b0:2f3:83ef:f06b with SMTP id 15-20020ac84e8f000000b002f383eff06bmr20138250qtp.344.1651690194570;
        Wed, 04 May 2022 11:49:54 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id o26-20020ac872da000000b002f39b99f6afsm7565524qtp.73.2022.05.04.11.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 11:49:53 -0700 (PDT)
Message-ID: <8c3592767ac4c3d4c3bcb0294d97aff5a7375319.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/subdev/bus: Ratelimit logging for fault
 errors
From:   Lyude Paul <lyude@redhat.com>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 04 May 2022 14:49:52 -0400
In-Reply-To: <CACO55ttsBxe6V88CTtGZgUj8k+gT+ne+FD_9FD_OxowF1XG5Bg@mail.gmail.com>
References: <20220429195350.85620-1-lyude@redhat.com>
         <CACO55ttsBxe6V88CTtGZgUj8k+gT+ne+FD_9FD_OxowF1XG5Bg@mail.gmail.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-03 at 21:23 +0200, Karol Herbst wrote:
> not able to hit any error on my machine, but regardless:
> 
> Reviewed-by: Karol Herbst <kherbst@redhat.com>
> 
> I suspect there are more places where we could put it, but we can add
> those later.
> 
> Anyway, I think it's valuable to push it through fixes, not sure how
> far back we want to CC stable though.

JFYI - dim fixes can figure this out if you just give it the commit that
introduced the issue.

Anyway, will push this upstream in a moment

> 
> On Fri, Apr 29, 2022 at 9:54 PM Lyude Paul <lyude@redhat.com> wrote:
> > 
> > There's plenty of ways to fudge the GPU when developing on nouveau by
> > mistake, some of which can result in nouveau seriously spamming dmesg with
> > fault errors. This can be somewhat annoying, as it can quickly overrun the
> > message buffer (or your terminal emulator's buffer) and get rid of
> > actually
> > useful feedback from the driver. While working on my new atomic only MST
> > branch, I ran into this issue a couple of times.
> > 
> > So, let's fix this by adding nvkm_error_ratelimited(), and using it to
> > ratelimit errors from faults. This should be fine for developers, since
> > it's nearly always only the first few faults that we care about seeing.
> > Plus, you can turn off rate limiting in the kernel if you really need to.
> > 
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h |  2 ++
> >  drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c    | 14 +++++++-------
> >  drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c     |  6 +++---
> >  drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c     |  6 +++---
> >  4 files changed, 15 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h
> > b/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h
> > index 1665738948fb..96113c8bee8c 100644
> > --- a/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h
> > +++ b/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h
> > @@ -62,4 +62,6 @@ void nvkm_subdev_intr(struct nvkm_subdev *);
> >  #define nvkm_debug(s,f,a...) nvkm_printk((s), DEBUG,   info, f, ##a)
> >  #define nvkm_trace(s,f,a...) nvkm_printk((s), TRACE,   info, f, ##a)
> >  #define nvkm_spam(s,f,a...)  nvkm_printk((s),  SPAM,    dbg, f, ##a)
> > +
> > +#define nvkm_error_ratelimited(s,f,a...) nvkm_printk((s), ERROR,
> > err_ratelimited, f, ##a)
> >  #endif
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c
> > b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c
> > index 53a6651ac225..80b5aaceeaad 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c
> > @@ -35,13 +35,13 @@ gf100_bus_intr(struct nvkm_bus *bus)
> >                 u32 addr = nvkm_rd32(device, 0x009084);
> >                 u32 data = nvkm_rd32(device, 0x009088);
> > 
> > -               nvkm_error(subdev,
> > -                          "MMIO %s of %08x FAULT at %06x [ %s%s%s]\n",
> > -                          (addr & 0x00000002) ? "write" : "read", data,
> > -                          (addr & 0x00fffffc),
> > -                          (stat & 0x00000002) ? "!ENGINE " : "",
> > -                          (stat & 0x00000004) ? "PRIVRING " : "",
> > -                          (stat & 0x00000008) ? "TIMEOUT " : "");
> > +               nvkm_error_ratelimited(subdev,
> > +                                      "MMIO %s of %08x FAULT at %06x [
> > %s%s%s]\n",
> > +                                      (addr & 0x00000002) ? "write" :
> > "read", data,
> > +                                      (addr & 0x00fffffc),
> > +                                      (stat & 0x00000002) ? "!ENGINE " :
> > "",
> > +                                      (stat & 0x00000004) ? "PRIVRING " :
> > "",
> > +                                      (stat & 0x00000008) ? "TIMEOUT " :
> > "");
> > 
> >                 nvkm_wr32(device, 0x009084, 0x00000000);
> >                 nvkm_wr32(device, 0x001100, (stat & 0x0000000e));
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c
> > b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c
> > index ad8da523bb22..c75e463f3501 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c
> > @@ -45,9 +45,9 @@ nv31_bus_intr(struct nvkm_bus *bus)
> >                 u32 addr = nvkm_rd32(device, 0x009084);
> >                 u32 data = nvkm_rd32(device, 0x009088);
> > 
> > -               nvkm_error(subdev, "MMIO %s of %08x FAULT at %06x\n",
> > -                          (addr & 0x00000002) ? "write" : "read", data,
> > -                          (addr & 0x00fffffc));
> > +               nvkm_error_ratelimited(subdev, "MMIO %s of %08x FAULT at
> > %06x\n",
> > +                                      (addr & 0x00000002) ? "write" :
> > "read", data,
> > +                                      (addr & 0x00fffffc));
> > 
> >                 stat &= ~0x00000008;
> >                 nvkm_wr32(device, 0x001100, 0x00000008);
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c
> > b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c
> > index 3a1e45adeedc..2055d0b100d3 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c
> > @@ -60,9 +60,9 @@ nv50_bus_intr(struct nvkm_bus *bus)
> >                 u32 addr = nvkm_rd32(device, 0x009084);
> >                 u32 data = nvkm_rd32(device, 0x009088);
> > 
> > -               nvkm_error(subdev, "MMIO %s of %08x FAULT at %06x\n",
> > -                          (addr & 0x00000002) ? "write" : "read", data,
> > -                          (addr & 0x00fffffc));
> > +               nvkm_error_ratelimited(subdev, "MMIO %s of %08x FAULT at
> > %06x\n",
> > +                                      (addr & 0x00000002) ? "write" :
> > "read", data,
> > +                                      (addr & 0x00fffffc));
> > 
> >                 stat &= ~0x00000008;
> >                 nvkm_wr32(device, 0x001100, 0x00000008);
> > --
> > 2.35.1
> > 
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

