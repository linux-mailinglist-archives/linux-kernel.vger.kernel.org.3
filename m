Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AA356796D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 23:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiGEVjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 17:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiGEVjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:39:45 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3036D186F6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:39:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id t17-20020a1c7711000000b003a0434b0af7so8003135wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 14:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uVq3SS5z0OOLu4Dz+fgC14BcaabN+0EvMUub15/aayE=;
        b=C94wUsjHGErDEFfla43eG5MzlsxSHvDnvrDe/Xrq4j16p0QUv7EPUUdY8qfT32N8PO
         AkNo/0UsK88y1OWqCBOYj46lR/3MdEhmM+drGL8ytyaLNB5DkDjEP00OCpzW+m2wAelp
         TCjJ7vUiUbhEC8mlleJNOTcqUVGV/ivrW9GKS7hh9oDIOodvDUlUbW4gWh8hHeIPGFRb
         GmN849Dm7RTsKEWdgUCm5Wtd0phCicceWYfNP3NI0E3rA+EjSvilom+GgarNgzMePkLI
         YUu9amjiRtd4qbZYzhVluqdxKr3YKYOQtRIAdp1MD6idcW/oD9wi9ffHBAtQrXAenSTI
         kDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uVq3SS5z0OOLu4Dz+fgC14BcaabN+0EvMUub15/aayE=;
        b=Mjx0HlRlzZYesqfTsPzKI3mtsaTN23Apdg8jjpAVrMgtAScnr7xqCMW7O4rf4WyH9y
         z5EpCrlceOwhGtJnPiiyrQVXeb5xkRUXxkol+xdceWjoME75dxM6iXwU0KYkcU01gRyq
         9bSvwLoywApj6bpKZHh2gy0fEcPoMflKGRyZP49yv5teqf4+zfMtIZWqh1BdQJe9y9AU
         BbaUhIGmTZAx3QmIkFaMhJ7fcoWVwX5yguvcNgGY0eMU8QITQKrHr70t+ONJIfUtfIBi
         YtEA6bkihhQpb0tN2Alpmi57Ah9H+wWFG4u+bOYZpI0wDBAO5BfJxClfHG2w/HH4Nwt+
         nG9g==
X-Gm-Message-State: AJIora+cCNepOdJnNnhaIG3AxVBQCml8C6PgAS7l3tNtE/HDTrKaFv0J
        bwKbZQI/L3f1p16GzcaWYNpFMdFE1JTqoIrX+nI=
X-Google-Smtp-Source: AGRyM1t4PnuQ4FyRFI1FjuAnfXAuz8RC8AR6+hfD0f99JNKIvcxLDBodEWidId40zCkDUWQDdpcm5SB+uKOKRjrDWac=
X-Received: by 2002:a05:600c:3ac3:b0:3a0:45b6:7efb with SMTP id
 d3-20020a05600c3ac300b003a045b67efbmr40084996wms.183.1657057182563; Tue, 05
 Jul 2022 14:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220630200726.1884320-1-dmitry.osipenko@collabora.com>
 <20220630200726.1884320-8-dmitry.osipenko@collabora.com> <20220705135323.emr4gdbcxoisdcxe@sirius.home.kraxel.org>
 <d2c64d09-c4bb-9aed-069d-a9b4d07a1f66@collabora.com> <20220705154507.67ovlun4m26xzppn@sirius.home.kraxel.org>
 <1380526d-17fb-6eb2-0fd5-5cddbdf0a92e@collabora.com>
In-Reply-To: <1380526d-17fb-6eb2-0fd5-5cddbdf0a92e@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 5 Jul 2022 14:39:54 -0700
Message-ID: <CAF6AEGtE+3AbaJnSZ07VY0xMOJMNz6BSQ+mPKmPYLi_Z-CLAig@mail.gmail.com>
Subject: Re: [PATCH v7 7/9] drm/virtio: Improve DMA API usage for shmem BOs
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 10:02 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 7/5/22 18:45, Gerd Hoffmann wrote:
> >   Hi,
> >
> >>> Also note that pci is not the only virtio transport we have.
> >>
> >> The VirtIO indeed has other transports, but only PCI is really supported
> >> in case of the VirtIO-GPU in kernel and in Qemu/crosvm, AFAICT. Hence
> >> only the PCI transport was tested.
> >
> > qemu -M microvm \
> >   -global virtio-mmio.force-legacy=false \
> >   -device virtio-gpu-device
> >
> > Gives you a functional virtio-gpu device on virtio-mmio.
> >
> > aarch64 virt machines support both pci and mmio too.
> > s390x has virtio-gpu-ccw ...
>
> Gerd, thank you very much! It's was indeed unclear to me how to test the
> MMIO GPU, but yours variant with microvm works! I was looking for trying
> aarch64 in the past, but it also was unclear how to do it since there is
> no DT support for the VirtIO-GPU, AFAICS.

just a drive-by note, IME on aarch64 kernels, at least with crosvm,
virtgpu is also a pci device.. the non-pci things in the guest kernel
use dt, but devices on discoverable busses like pci don't need dt
nodes (which is true also in the non-vm case)

BR,
-R


> I booted kernel with this patchset applied and everything is okay, Xorg
> works.
>
>  [drm] Initialized virtio_gpu 0.1.0 0 for LNRO0005:01 on minor 0
>  virtio-mmio LNRO0005:01: [drm] drm_plane_enable_fb_damage_clips() not
> called
>  virtio-mmio LNRO0005:01: [drm] fb0: virtio_gpudrmfb frame buffer device
>
> There is no virgl support because it's a virtio-gpu-device and not
> virtio-gpu-device-gl that is PCI-only in Qemu. Hence everything seems good.
>
> I'd appreciate if you could give s390x a test.. I never touched s390x
> and it will probably take some extra effort to get into it.
>
> --
> Best regards,
> Dmitry
