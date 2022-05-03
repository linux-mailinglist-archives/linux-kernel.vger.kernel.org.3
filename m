Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433EC518D1E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbiECT1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241859AbiECT1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 155252AE37
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 12:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651605826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1/RCEqp6rD6C5bP4Oel+DuHsx3t6d/OQda58eNU9e8M=;
        b=K8EVvP3ciToKdjU920RvtaC7gpogB1E1NnPPWOFBTDSMjla1V+E0K8/CnoCJAJfZAoH6Jx
        W0tyZRm7FZSSYNQh3HjSHDEreSwTM6RXdrS0OB6FF9Zxg9R74S656H8kDGxTyGiAbsNIJs
        elnqGESkfkepRxscasXVI+S1NYeOqiA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-b62Wp6jLP6GgoyDEor9Rlg-1; Tue, 03 May 2022 15:23:44 -0400
X-MC-Unique: b62Wp6jLP6GgoyDEor9Rlg-1
Received: by mail-wr1-f69.google.com with SMTP id k20-20020adfc714000000b001e305cd1597so6693591wrg.19
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 12:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/RCEqp6rD6C5bP4Oel+DuHsx3t6d/OQda58eNU9e8M=;
        b=74PEuSN447+EieHU5lOA86JAdLPMwsC1wqIJzRDf0XcgOkGd17yBD5dDYFlBJPJCZy
         efFkYmyBuKEUAxJv7uiMDvHZPn6WpWpKf19FyuunnWe/on2ywuaKYXk3RqI66Z8AMXLl
         2Y3vU3IOi+0VtD1ZYeDcXXjXTRo4mPB2sdUP+QtQxUNDtrEjcvcdzvkZxUkubY86SEAm
         mhUGPJgtUAgWbMIsB7Qu/OJc4VnhK7rpiASRwY1sPmKyVj8Yl8vlun/TBjg4qmo5KBWO
         nYKLidWSpt+x4TMtpkXGwPZ/OKNJxKaN/4SOqXEsPSvuyhRCbMs8EkwlQ9mmJtxLPwLw
         OP2g==
X-Gm-Message-State: AOAM5327vnJaxkySQRmQu0nsxU7yxBAJHFzgaSmLlMSLyaeAAtFRBl4J
        zQPj4JKOg/e4k9LOZO1yGqvxirRnHm+Cc6FS0MgT9dsb12sW7f462SpO+cQ6/MC+VNNN2lwTvyT
        oF9cXtfvdxHQsO4mSQj+nmbTqRInyzbjVVa7SSdKl
X-Received: by 2002:a5d:64ea:0:b0:20c:5ca3:a0de with SMTP id g10-20020a5d64ea000000b0020c5ca3a0demr10508049wri.308.1651605821839;
        Tue, 03 May 2022 12:23:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzreDUrtXoyuE22Us65ZpjSyx6nFjemAk+h1WnCiSgoWNkBnpxUDaPb4LDmFrrMxNqjsNDyA6NW8ENNFbF1AEU=
X-Received: by 2002:a5d:64ea:0:b0:20c:5ca3:a0de with SMTP id
 g10-20020a5d64ea000000b0020c5ca3a0demr10508040wri.308.1651605821655; Tue, 03
 May 2022 12:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220429195350.85620-1-lyude@redhat.com>
In-Reply-To: <20220429195350.85620-1-lyude@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 3 May 2022 21:23:30 +0200
Message-ID: <CACO55ttsBxe6V88CTtGZgUj8k+gT+ne+FD_9FD_OxowF1XG5Bg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/subdev/bus: Ratelimit logging for fault errors
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
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

not able to hit any error on my machine, but regardless:

Reviewed-by: Karol Herbst <kherbst@redhat.com>

I suspect there are more places where we could put it, but we can add
those later.

Anyway, I think it's valuable to push it through fixes, not sure how
far back we want to CC stable though.

On Fri, Apr 29, 2022 at 9:54 PM Lyude Paul <lyude@redhat.com> wrote:
>
> There's plenty of ways to fudge the GPU when developing on nouveau by
> mistake, some of which can result in nouveau seriously spamming dmesg with
> fault errors. This can be somewhat annoying, as it can quickly overrun the
> message buffer (or your terminal emulator's buffer) and get rid of actually
> useful feedback from the driver. While working on my new atomic only MST
> branch, I ran into this issue a couple of times.
>
> So, let's fix this by adding nvkm_error_ratelimited(), and using it to
> ratelimit errors from faults. This should be fine for developers, since
> it's nearly always only the first few faults that we care about seeing.
> Plus, you can turn off rate limiting in the kernel if you really need to.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h |  2 ++
>  drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c    | 14 +++++++-------
>  drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c     |  6 +++---
>  drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c     |  6 +++---
>  4 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h b/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h
> index 1665738948fb..96113c8bee8c 100644
> --- a/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h
> +++ b/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h
> @@ -62,4 +62,6 @@ void nvkm_subdev_intr(struct nvkm_subdev *);
>  #define nvkm_debug(s,f,a...) nvkm_printk((s), DEBUG,   info, f, ##a)
>  #define nvkm_trace(s,f,a...) nvkm_printk((s), TRACE,   info, f, ##a)
>  #define nvkm_spam(s,f,a...)  nvkm_printk((s),  SPAM,    dbg, f, ##a)
> +
> +#define nvkm_error_ratelimited(s,f,a...) nvkm_printk((s), ERROR, err_ratelimited, f, ##a)
>  #endif
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c
> index 53a6651ac225..80b5aaceeaad 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c
> @@ -35,13 +35,13 @@ gf100_bus_intr(struct nvkm_bus *bus)
>                 u32 addr = nvkm_rd32(device, 0x009084);
>                 u32 data = nvkm_rd32(device, 0x009088);
>
> -               nvkm_error(subdev,
> -                          "MMIO %s of %08x FAULT at %06x [ %s%s%s]\n",
> -                          (addr & 0x00000002) ? "write" : "read", data,
> -                          (addr & 0x00fffffc),
> -                          (stat & 0x00000002) ? "!ENGINE " : "",
> -                          (stat & 0x00000004) ? "PRIVRING " : "",
> -                          (stat & 0x00000008) ? "TIMEOUT " : "");
> +               nvkm_error_ratelimited(subdev,
> +                                      "MMIO %s of %08x FAULT at %06x [ %s%s%s]\n",
> +                                      (addr & 0x00000002) ? "write" : "read", data,
> +                                      (addr & 0x00fffffc),
> +                                      (stat & 0x00000002) ? "!ENGINE " : "",
> +                                      (stat & 0x00000004) ? "PRIVRING " : "",
> +                                      (stat & 0x00000008) ? "TIMEOUT " : "");
>
>                 nvkm_wr32(device, 0x009084, 0x00000000);
>                 nvkm_wr32(device, 0x001100, (stat & 0x0000000e));
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c
> index ad8da523bb22..c75e463f3501 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c
> @@ -45,9 +45,9 @@ nv31_bus_intr(struct nvkm_bus *bus)
>                 u32 addr = nvkm_rd32(device, 0x009084);
>                 u32 data = nvkm_rd32(device, 0x009088);
>
> -               nvkm_error(subdev, "MMIO %s of %08x FAULT at %06x\n",
> -                          (addr & 0x00000002) ? "write" : "read", data,
> -                          (addr & 0x00fffffc));
> +               nvkm_error_ratelimited(subdev, "MMIO %s of %08x FAULT at %06x\n",
> +                                      (addr & 0x00000002) ? "write" : "read", data,
> +                                      (addr & 0x00fffffc));
>
>                 stat &= ~0x00000008;
>                 nvkm_wr32(device, 0x001100, 0x00000008);
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c
> index 3a1e45adeedc..2055d0b100d3 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c
> @@ -60,9 +60,9 @@ nv50_bus_intr(struct nvkm_bus *bus)
>                 u32 addr = nvkm_rd32(device, 0x009084);
>                 u32 data = nvkm_rd32(device, 0x009088);
>
> -               nvkm_error(subdev, "MMIO %s of %08x FAULT at %06x\n",
> -                          (addr & 0x00000002) ? "write" : "read", data,
> -                          (addr & 0x00fffffc));
> +               nvkm_error_ratelimited(subdev, "MMIO %s of %08x FAULT at %06x\n",
> +                                      (addr & 0x00000002) ? "write" : "read", data,
> +                                      (addr & 0x00fffffc));
>
>                 stat &= ~0x00000008;
>                 nvkm_wr32(device, 0x001100, 0x00000008);
> --
> 2.35.1
>

