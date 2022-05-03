Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AD55190F5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243492AbiECWIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 18:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243507AbiECWIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 18:08:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00B48427ED
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 15:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651615468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NCw2YbW2b06vdpfX9KTc0Sz/4kzxAVFUC7Z0+7uCYMw=;
        b=QV8SeB9u1oxu2AZzk6hjOS1LlKtUj2LpNBB5DLkROzHeqEfTakgB5/zp2s3Bd/4AEf4bJE
        orXaoq+FmnrdoK05RC6Wz/OgM+A64sto7wsFhpc+CLUM5uXBqDumNUE1VhTO5zpFdGu/gr
        tAnahlJciSAzmonKdlU1+uwL/hGM4ng=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-1pWux-LAMiOgjaI_OcHTsQ-1; Tue, 03 May 2022 18:01:47 -0400
X-MC-Unique: 1pWux-LAMiOgjaI_OcHTsQ-1
Received: by mail-wm1-f69.google.com with SMTP id c125-20020a1c3583000000b0038e3f6e871aso6285507wma.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 15:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NCw2YbW2b06vdpfX9KTc0Sz/4kzxAVFUC7Z0+7uCYMw=;
        b=HrRQusNDCfI8eJYT5sK5VtZ/Hu7fpLhAXzNDSCKhzhi9MUy30Zzoi59GuHr5rsljz/
         u2B9Loi+q8rVtiIxVJb++B2WtRoCh5iZqb8ly7r4UxcL/1q744sYIlnR1bCvycE/l44t
         SDBgPo9/f0XbAnO/S5VThYUgPFm9H/By3lYc7yOkx/nA8c8XkQz15jFDxV56xkGap3c/
         +WrANk0a8Zy98D/VhJ/RF02KhmtIyWch8O303QWhV0k4rjVJoDaXLnO2RtFqUvkQaNrX
         /V+wn039iEcRnwOVokYQHTjAHZpoD3VcH5oiVYPXVXD+r+ypVYYYPN/2pmII1gMugrs/
         7ECg==
X-Gm-Message-State: AOAM533U7J57vkaP68q6aPSm9SyfagF4oBDlpbEnwDU9ocouWXUN+rw4
        +e23VQohsmtuWMNgOcTAdEAsya0DsNVmbzXg7B5dBfKfKbL/BhshMneRAGDG3/IZGtA/vWO1Rxo
        YDs9WOjifXMcbJEK8/Y1DgBHd09AnnOJb+k++G+oa
X-Received: by 2002:a5d:4a81:0:b0:207:9abe:2908 with SMTP id o1-20020a5d4a81000000b002079abe2908mr14084331wrq.341.1651615305548;
        Tue, 03 May 2022 15:01:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDZF5QtU8eWm5iH5MBr3nBAiPSuIRf8s8hX0zAE2sJW3Opo+sznt5voV5+vjORprV7H4visxp4de0FdVUYT74=
X-Received: by 2002:a5d:4a81:0:b0:207:9abe:2908 with SMTP id
 o1-20020a5d4a81000000b002079abe2908mr14084317wrq.341.1651615305322; Tue, 03
 May 2022 15:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220429195350.85620-1-lyude@redhat.com> <CACO55ttsBxe6V88CTtGZgUj8k+gT+ne+FD_9FD_OxowF1XG5Bg@mail.gmail.com>
In-Reply-To: <CACO55ttsBxe6V88CTtGZgUj8k+gT+ne+FD_9FD_OxowF1XG5Bg@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 4 May 2022 00:01:34 +0200
Message-ID: <CACO55tv=u+HNKS9tH-ggy_O0YRiZQvAyb48gxRVqrz-fmWcvwA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/subdev/bus: Ratelimit logging for fault errors
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
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

Actually, there is another place we have to put this, we can spam
"SCHED_ERROR" things which are triggered within multiple
drivers/gpu/drm/nouveau/nvkm/engine/fifo/ files.

On Tue, May 3, 2022 at 9:23 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> not able to hit any error on my machine, but regardless:
>
> Reviewed-by: Karol Herbst <kherbst@redhat.com>
>
> I suspect there are more places where we could put it, but we can add
> those later.
>
> Anyway, I think it's valuable to push it through fixes, not sure how
> far back we want to CC stable though.
>
> On Fri, Apr 29, 2022 at 9:54 PM Lyude Paul <lyude@redhat.com> wrote:
> >
> > There's plenty of ways to fudge the GPU when developing on nouveau by
> > mistake, some of which can result in nouveau seriously spamming dmesg with
> > fault errors. This can be somewhat annoying, as it can quickly overrun the
> > message buffer (or your terminal emulator's buffer) and get rid of actually
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
> >  drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h |  2 ++
> >  drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c    | 14 +++++++-------
> >  drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c     |  6 +++---
> >  drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c     |  6 +++---
> >  4 files changed, 15 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h b/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h
> > index 1665738948fb..96113c8bee8c 100644
> > --- a/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h
> > +++ b/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h
> > @@ -62,4 +62,6 @@ void nvkm_subdev_intr(struct nvkm_subdev *);
> >  #define nvkm_debug(s,f,a...) nvkm_printk((s), DEBUG,   info, f, ##a)
> >  #define nvkm_trace(s,f,a...) nvkm_printk((s), TRACE,   info, f, ##a)
> >  #define nvkm_spam(s,f,a...)  nvkm_printk((s),  SPAM,    dbg, f, ##a)
> > +
> > +#define nvkm_error_ratelimited(s,f,a...) nvkm_printk((s), ERROR, err_ratelimited, f, ##a)
> >  #endif
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c
> > index 53a6651ac225..80b5aaceeaad 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c
> > @@ -35,13 +35,13 @@ gf100_bus_intr(struct nvkm_bus *bus)
> >                 u32 addr = nvkm_rd32(device, 0x009084);
> >                 u32 data = nvkm_rd32(device, 0x009088);
> >
> > -               nvkm_error(subdev,
> > -                          "MMIO %s of %08x FAULT at %06x [ %s%s%s]\n",
> > -                          (addr & 0x00000002) ? "write" : "read", data,
> > -                          (addr & 0x00fffffc),
> > -                          (stat & 0x00000002) ? "!ENGINE " : "",
> > -                          (stat & 0x00000004) ? "PRIVRING " : "",
> > -                          (stat & 0x00000008) ? "TIMEOUT " : "");
> > +               nvkm_error_ratelimited(subdev,
> > +                                      "MMIO %s of %08x FAULT at %06x [ %s%s%s]\n",
> > +                                      (addr & 0x00000002) ? "write" : "read", data,
> > +                                      (addr & 0x00fffffc),
> > +                                      (stat & 0x00000002) ? "!ENGINE " : "",
> > +                                      (stat & 0x00000004) ? "PRIVRING " : "",
> > +                                      (stat & 0x00000008) ? "TIMEOUT " : "");
> >
> >                 nvkm_wr32(device, 0x009084, 0x00000000);
> >                 nvkm_wr32(device, 0x001100, (stat & 0x0000000e));
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c
> > index ad8da523bb22..c75e463f3501 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c
> > @@ -45,9 +45,9 @@ nv31_bus_intr(struct nvkm_bus *bus)
> >                 u32 addr = nvkm_rd32(device, 0x009084);
> >                 u32 data = nvkm_rd32(device, 0x009088);
> >
> > -               nvkm_error(subdev, "MMIO %s of %08x FAULT at %06x\n",
> > -                          (addr & 0x00000002) ? "write" : "read", data,
> > -                          (addr & 0x00fffffc));
> > +               nvkm_error_ratelimited(subdev, "MMIO %s of %08x FAULT at %06x\n",
> > +                                      (addr & 0x00000002) ? "write" : "read", data,
> > +                                      (addr & 0x00fffffc));
> >
> >                 stat &= ~0x00000008;
> >                 nvkm_wr32(device, 0x001100, 0x00000008);
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c
> > index 3a1e45adeedc..2055d0b100d3 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c
> > @@ -60,9 +60,9 @@ nv50_bus_intr(struct nvkm_bus *bus)
> >                 u32 addr = nvkm_rd32(device, 0x009084);
> >                 u32 data = nvkm_rd32(device, 0x009088);
> >
> > -               nvkm_error(subdev, "MMIO %s of %08x FAULT at %06x\n",
> > -                          (addr & 0x00000002) ? "write" : "read", data,
> > -                          (addr & 0x00fffffc));
> > +               nvkm_error_ratelimited(subdev, "MMIO %s of %08x FAULT at %06x\n",
> > +                                      (addr & 0x00000002) ? "write" : "read", data,
> > +                                      (addr & 0x00fffffc));
> >
> >                 stat &= ~0x00000008;
> >                 nvkm_wr32(device, 0x001100, 0x00000008);
> > --
> > 2.35.1
> >

