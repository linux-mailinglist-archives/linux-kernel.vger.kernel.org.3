Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BCE4EBF0F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245521AbiC3KpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245524AbiC3KpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:45:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89BC0DFCE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648637011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BF3xhFCyLrxCQP5ABQE0ta5feJB/SrzL4G5wThcA57E=;
        b=LdIl4BW2ZYWtSh7iVvGvUTwokcrspFVLgcfEEK21iI67SQcsw4di/IS22EX4sd2fr2gUNd
        J+NVnv0zUmGOll3xsd2+dv34vdOy7bWdqhnCanE98vHyvJSvNkZgPr42l1ahnZ6q1Kd9uW
        YHuj6y823iSPtQjGKznIciotTOUglL8=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-Nkuyn6JIOm6TJs8E57oEvA-1; Wed, 30 Mar 2022 06:43:30 -0400
X-MC-Unique: Nkuyn6JIOm6TJs8E57oEvA-1
Received: by mail-oo1-f71.google.com with SMTP id z5-20020a4a8705000000b00324936534b6so12789460ooh.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BF3xhFCyLrxCQP5ABQE0ta5feJB/SrzL4G5wThcA57E=;
        b=h1+0vnIwpCUvFeCtD0JlGPo4SzkKj49doXJwypqCMwbyABruCcScWPAdov6W9o5qIo
         wYhIID0cTO8VP8IJwcGoHlJMtznljg6dHyNkfmOxLGgOHxnHEl6J8fpccyyZFPONIGw2
         qGRFCPGw2fZXx5WgolWvgoS58n90zTMy72a4ksnjoaEwB0bPT8duTRPISfqyv5LxtDHo
         4kfpLIKPa8eA4/OVowKk2CwhlLOug3wDKPx3gOSFzYSeWC5/1DNvSerF5mncF7I1AagG
         wid+0ziEp0zmFEIJbpyjaE4mh1DBLvkG6y7ztKdG3Uk4svmFRTOfPUna1TkwE+Y6j/9K
         uiUg==
X-Gm-Message-State: AOAM531Cosojach2a0OoTAL3cHUUTBJ9COJ8gWn94prr6QbSsz8YgYnM
        yJfRZgL/6wbTuNsTrz03a85ZOMO4N8r5lwxbT6QmY3ucmQoPkhAXVywqt6y/jQQTe0plB+5VGpm
        uYEPuVss71kbk3Hxcxqx2gzAMCavDla3YKQ0tA65M
X-Received: by 2002:a05:6870:1714:b0:dd:a30e:d23e with SMTP id h20-20020a056870171400b000dda30ed23emr1742732oae.85.1648637009386;
        Wed, 30 Mar 2022 03:43:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaEBKXl6GGXGtVuocZYplGp6rtO1QKwBVCHAaEWlTJ5cnjGCD6V7uPD2eiQ9au5HJ6l3QhAGAyP9E6jI3nR6A=
X-Received: by 2002:a05:6870:1714:b0:dd:a30e:d23e with SMTP id
 h20-20020a056870171400b000dda30ed23emr1742723oae.85.1648637009168; Wed, 30
 Mar 2022 03:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <12eba824-ee80-0aac-56ed-e13084c9cae7@amd.com> <20220324104928.2959545-1-liucong2@kylinos.cn>
 <982d233d-7e30-f44e-f49d-473c3c41721e@amd.com> <a1ceefb7-32d8-9ce3-e56f-7684e6d3ee58@kylinos.cn>
In-Reply-To: <a1ceefb7-32d8-9ce3-e56f-7684e6d3ee58@kylinos.cn>
From:   David Airlie <airlied@redhat.com>
Date:   Wed, 30 Mar 2022 20:43:18 +1000
Message-ID: <CAMwc25r3ER2Mi4jo2W=VtZcusNhpsyhQ0Mjx+qHhmZAK-fSjZQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/qxl: fix qxl can't use in arm64
To:     Cong Liu <liucong2@kylinos.cn>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        airlied <airlied@linux.ie>, "Hoffmann, Gerd" <kraxel@redhat.com>,
        robin.murphy@arm.com,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        "Vetter, Daniel" <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>, ray.huang@amd.com,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to make sure this has no side effects on x86 guests, it
probably is safe, but keep an eye for regression reports.

Reviewed-by: Dave Airlie <airlied@redhat.com>
Dave.

On Wed, Mar 30, 2022 at 8:20 PM Cong Liu <liucong2@kylinos.cn> wrote:
>
> any suggestions or extra test I can do now?
>
> Regards,
> Cong
>
> On 2022/3/25 15:45, Christian K=C3=B6nig wrote:
> > Am 24.03.22 um 11:49 schrieb Cong Liu:
> >> qxl use ioremap to map ram_header and rom, in the arm64 implementation=
,
> >> the device is mapped as DEVICE_nGnRE, it can not support unaligned
> >> access. and qxl is a virtual device, it can be treated more like RAM
> >> than actual MMIO registers. use ioremap_wc() replace it.
> >>
> >> Signed-off-by: Cong Liu <liucong2@kylinos.cn>
> >
> > Looks sane to me, but I'm really not involved enough to fully judge.
> >
> > Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >
> >> ---
> >>   drivers/gpu/drm/qxl/qxl_kms.c | 4 ++--
> >>   drivers/gpu/drm/qxl/qxl_ttm.c | 4 ++--
> >>   2 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/qxl/qxl_kms.c
> >> b/drivers/gpu/drm/qxl/qxl_kms.c
> >> index 4dc5ad13f12c..a054e4a00fe8 100644
> >> --- a/drivers/gpu/drm/qxl/qxl_kms.c
> >> +++ b/drivers/gpu/drm/qxl/qxl_kms.c
> >> @@ -165,7 +165,7 @@ int qxl_device_init(struct qxl_device *qdev,
> >>            (int)qdev->surfaceram_size / 1024,
> >>            (sb =3D=3D 4) ? "64bit" : "32bit");
> >> -    qdev->rom =3D ioremap(qdev->rom_base, qdev->rom_size);
> >> +    qdev->rom =3D ioremap_wc(qdev->rom_base, qdev->rom_size);
> >>       if (!qdev->rom) {
> >>           pr_err("Unable to ioremap ROM\n");
> >>           r =3D -ENOMEM;
> >> @@ -183,7 +183,7 @@ int qxl_device_init(struct qxl_device *qdev,
> >>           goto rom_unmap;
> >>       }
> >> -    qdev->ram_header =3D ioremap(qdev->vram_base +
> >> +    qdev->ram_header =3D ioremap_wc(qdev->vram_base +
> >>                      qdev->rom->ram_header_offset,
> >>                      sizeof(*qdev->ram_header));
> >>       if (!qdev->ram_header) {
> >> diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c
> >> b/drivers/gpu/drm/qxl/qxl_ttm.c
> >> index b2e33d5ba5d0..95df5750f47f 100644
> >> --- a/drivers/gpu/drm/qxl/qxl_ttm.c
> >> +++ b/drivers/gpu/drm/qxl/qxl_ttm.c
> >> @@ -82,13 +82,13 @@ int qxl_ttm_io_mem_reserve(struct ttm_device *bdev=
,
> >>       case TTM_PL_VRAM:
> >>           mem->bus.is_iomem =3D true;
> >>           mem->bus.offset =3D (mem->start << PAGE_SHIFT) + qdev->vram_=
base;
> >> -        mem->bus.caching =3D ttm_cached;
> >> +        mem->bus.caching =3D ttm_write_combined;
> >>           break;
> >>       case TTM_PL_PRIV:
> >>           mem->bus.is_iomem =3D true;
> >>           mem->bus.offset =3D (mem->start << PAGE_SHIFT) +
> >>               qdev->surfaceram_base;
> >> -        mem->bus.caching =3D ttm_cached;
> >> +        mem->bus.caching =3D ttm_write_combined;
> >>           break;
> >>       default:
> >>           return -EINVAL;
> >
>

