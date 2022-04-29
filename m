Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F555158C8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 01:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348919AbiD2XHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 19:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiD2XHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 19:07:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F02F82FFED
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651273467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4DG5k7BAzkTCilt7w3+yZz+mLZhkxC8TdQc8ihe/QE=;
        b=bRXO+DgdmSqTNB0EMCbjAs3XbqAJjKa2bEyEh9lqz/Rye8CQtX+QVm8lKfM/ls1WxZQM/Q
        xuH0L1OfyZq6HddqJlPqGEt7iF+vjMsE3l7yU5wBS6YZgt7WPz/OOap+NYI2ISdIZZXCKJ
        kTE2JK6aIdc39uuymsFVEMa52jOokOM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-ABVkWhtxMq-qrTE0qxlvFA-1; Fri, 29 Apr 2022 19:04:26 -0400
X-MC-Unique: ABVkWhtxMq-qrTE0qxlvFA-1
Received: by mail-qk1-f198.google.com with SMTP id j12-20020ae9c20c000000b0069e8ac6b244so6204934qkg.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=P4DG5k7BAzkTCilt7w3+yZz+mLZhkxC8TdQc8ihe/QE=;
        b=qMDls71B+v/5RiRQk45Bqzid4A15ohV8QPXgYgrt/39jbtIpY9yF3G64xr6hS0OLVk
         gBs0lx6gPXJkz8xf2cnbQdF1eZXgg0r6hFTGexC8C2GWCCszv/DUBRoxx7QeopwSIx+A
         iFUsRzN0jbW6wSFCBAqMNu6cX+t/8E6zMxOcT2PVl7rX91xuwlyPaoZuBNpIDPADS3DT
         Ktj3vCL84IdjdqjB4UPpsSBt0W+M2ZBjyDy4E3Tl1jTSw10eFEAayuuhAaApbxo1XAgP
         3tlnRXheA9OdYg4fOomdvWErSpD6TDXZgGyMVydYXKhJubquNdoS33i6l/p2H8TbfEUn
         BDjw==
X-Gm-Message-State: AOAM531cDOiTUBXhGF2Mk7kkv9QIJof1IX1Aa2kX0Y8mS2SWaavzUVCj
        1jVaX/t0wM2HDOhZrZXxTvbV02zFuiKx/y1scNonkDMsplGgLuR6fdXcYdx7SoygorSot8GOJRg
        YjmvU5hRgLv7YzqUB+OsjOOfV
X-Received: by 2002:a05:620a:270d:b0:69e:bfab:6455 with SMTP id b13-20020a05620a270d00b0069ebfab6455mr1098635qkp.360.1651273465332;
        Fri, 29 Apr 2022 16:04:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjyTtWGxFWkywX29LJU3vdElYL7Z7LeKNxBjx+Ua2YNeiggKBgD3lab+S7LtyztkQjnq3puw==
X-Received: by 2002:a05:620a:270d:b0:69e:bfab:6455 with SMTP id b13-20020a05620a270d00b0069ebfab6455mr1098617qkp.360.1651273465023;
        Fri, 29 Apr 2022 16:04:25 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id b24-20020ac86bd8000000b002f39b99f67esm320893qtt.24.2022.04.29.16.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 16:04:24 -0700 (PDT)
Message-ID: <a16299814fbbb4cad99f7c7bc9b83c7c31b63a69.camel@redhat.com>
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
Date:   Fri, 29 Apr 2022 19:04:23 -0400
In-Reply-To: <CACO55tuY6ACoW5jgRk8jCVZ_ZZDEBXczkaiTSpFDvw2h81r=xA@mail.gmail.com>
References: <20220429195350.85620-1-lyude@redhat.com>
         <CACO55tuY6ACoW5jgRk8jCVZ_ZZDEBXczkaiTSpFDvw2h81r=xA@mail.gmail.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-04-30 at 00:56 +0200, Karol Herbst wrote:
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
> 
> good idea :)
> 
> Although I think we ultimately need a detection of "GPU state is
> trashed" where we cease to do anything and disable interrupts as some
> of those issues actually cause the kernel to get DOSed by nouveau
> spamming/handling interrupts. Not sure if we should go with this patch
> in the meantime, or if we should just go straight ahead and disable
> interrupts, which would also stop the spam.
> 
> Do you know if this patch here is enough to get the system to reboot
> normally or is it only spamming less?

I'd have to try to come up with a setup that can hit this again, although it
might not be that hard - last time I hit this it was because I was programming
the wrong PBN values for MST payloads into nvidia's hardware.

So I can't remember for sure if I could reboot, but I do know I could actually
log into the system easily and do stuff with ratelimiting applied so it's
definitely better then the current situation.

> 
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

