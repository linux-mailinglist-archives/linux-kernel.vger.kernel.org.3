Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9955046DDA3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 22:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbhLHVe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 16:34:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50836 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbhLHVe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 16:34:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FB63B822FE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 21:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFEEC341CE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 21:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638999081;
        bh=6XBnKoC5nqR11hibVrczqUO0Uxy6l5KZRjY9OhYpg4c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=prIwCC+/O1sFTAJWCI8/q6KNjAZPagdWM1NmPyUaTrj4wIfBDlNEnibMEKyX1ROkU
         CXc28Hz1NmWKGGPVV6VzDd501EH876L52Ci1xOtIsY3GFQ+RNYqDxRhD1Nxhl8vnLU
         nbgdl7FrdWlBH9Y9+iTcP5vIdbqxIoHQrxFJgHhoVO81d4L7xtwrvpjs9nzVtbm8to
         Zl0TUsyIl+wRYRGBky30uy1RdqjTMCJKAqApYuje8IIApjByW6wcuKWqVIUH018LOv
         ZelqwRLvhcG4pq2tc5kbU8GVIPb2bzTnGZulMxMmHixpXXelMABUV1uyPAqKHu8zxW
         moTSq/ufegFRQ==
Received: by mail-wr1-f52.google.com with SMTP id a9so6375667wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 13:31:21 -0800 (PST)
X-Gm-Message-State: AOAM531SE+2Xf9mMJexats6LJBvE3Si/dG+cGIKJsYqbXzGUfmOfBgeX
        YWjaIIl3VcolMQeoEjPX0/rbgE5De0IJoDZY/zk=
X-Google-Smtp-Source: ABdhPJytFx8I48ZNDiX+cztgCoMtIU4EAKTHmXM4DEmRacV0/gPKKjZACO1c62jMM5BBgTlqfxTAyTJB+4hu2rTYrYk=
X-Received: by 2002:adf:d091:: with SMTP id y17mr1533492wrh.418.1638999079933;
 Wed, 08 Dec 2021 13:31:19 -0800 (PST)
MIME-Version: 1.0
References: <20211203185522.692489-1-arnd@kernel.org> <20211208144916-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211208144916-mutt-send-email-mst@kernel.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 8 Dec 2021 22:31:03 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0w9ij80Ww7rkaxutXFynOnC6=gEBQZ-X0Va+dx5jxfPg@mail.gmail.com>
Message-ID: <CAK8P3a0w9ij80Ww7rkaxutXFynOnC6=gEBQZ-X0Va+dx5jxfPg@mail.gmail.com>
Subject: Re: [PATCH] eni_vdpa: alibaba: select VIRTIO_PCI_LIB
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 8:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Dec 03, 2021 at 07:55:14PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > When VIRTIO_PCI_LIB is not built-in but the alibaba driver is, the
> > kernel runs into a link error:
> >
> > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_features':
> > eni_vdpa.c:(.text+0x23f): undefined reference to `vp_legacy_set_features'
> > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_state':
> > eni_vdpa.c:(.text+0x2fe): undefined reference to `vp_legacy_get_queue_enable'
> > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_address':
> > eni_vdpa.c:(.text+0x376): undefined reference to `vp_legacy_set_queue_address'
> > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_ready':
> > eni_vdpa.c:(.text+0x3b4): undefined reference to `vp_legacy_set_queue_address'
> > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_free_irq':
> > eni_vdpa.c:(.text+0x460): undefined reference to `vp_legacy_queue_vector'
> > x86_64-linux-ld: eni_vdpa.c:(.text+0x4b7): undefined reference to `vp_legacy_config_vector'
> > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_reset':
> >
> > Selecting VIRTIO_PCI_LIB_LEGACY is not sufficient here since that is
> > only part of the VIRTIO_PCI_LIB support.
> >
> > Fixes: e85087beedca ("eni_vdpa: add vDPA driver for Alibaba ENI")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
>
> Confused. These are all part of
> drivers/virtio/virtio_pci_legacy_dev.c
>
> and
> obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
>
> what gives?

The patch was wrong, see

https://lore.kernel.org/lkml/20211206085034.2836099-1-arnd@kernel.org/

for the correct fix.

        Arnd
