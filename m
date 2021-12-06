Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B535F4691A3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbhLFIot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:44:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232168AbhLFIos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638780079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GWGpIh47snyALgTQHCz30lE3sTFpFQWexm7titSzVRI=;
        b=bFzzM5mVbExASWPES66Ywhq/LsxU+FdSvs9OnUcoo4uXFkzazPZ8gOHT/ffS8+TJLVKBV0
        +Fy+HrhCqBWvAlZj2EOBi+qAcLmBSNtnZJvjdABIvsoPJa8DxN4zVF0AUBiUfcckoI60vY
        Emvan2e3yc6Rf/NliGjnlneqgNenZmg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-9WWszUz1Psu3DEPugyf2hA-1; Mon, 06 Dec 2021 03:41:17 -0500
X-MC-Unique: 9WWszUz1Psu3DEPugyf2hA-1
Received: by mail-lj1-f200.google.com with SMTP id w16-20020a05651c103000b00218c9d46faeso3183266ljm.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 00:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GWGpIh47snyALgTQHCz30lE3sTFpFQWexm7titSzVRI=;
        b=jR5Vim7g9XU2RXyEosHwuJzzFldELnqG0NzBagQ5daKk0jlJ8ThMbDM7Ts1PAOsWJA
         AVkxnhGNBsi6WH//9Qu4P5brPQkRY3bGNojawFePKKLBWo7iEvzsbs3oH0rMyUUbfLHJ
         1YmOYWLLjH1/aC+XfwipEQcDo+KROUY2c05r4iHr0iTLNnqioYznidl7UBSrvvyBtJTD
         ltLoJHsGFAcA5psS2bwp77kuUh6exG23xKP9gnjUQsmsa2a4yJKrAyElBINKnuH6yYJp
         J2cDziQGK1sbD2KQea/2RdZLZ5kciL1e7XJM6dwd5nFl2+n4nf39JUYZlzcSBLmIoC9b
         fEnw==
X-Gm-Message-State: AOAM532TCyX2kqhNme2iCe8yGxhtSQ/SDd8m9kDk+t0agKzqW9F5HJa+
        ONswq7/7JptYEkr1409axqKo8LGHtYXAfzL3Iy20zJJdDVxISWM2Klbs5152IHMwC/hmquqgD6s
        hbHk/PnbUGBaM78ugPs1LdTfdx4UgE4cTjD73QwBT
X-Received: by 2002:a05:6512:3987:: with SMTP id j7mr6521990lfu.199.1638780076465;
        Mon, 06 Dec 2021 00:41:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxymmwV6ZMLUAEdWBv6GE+nuHZ0FknR8xBSnM6wo3F1m8O/VtZ+7SnlzVmzqgqKI9rgjdwSd/zbzIcRywJxbrc=
X-Received: by 2002:a05:6512:3987:: with SMTP id j7mr6521977lfu.199.1638780076299;
 Mon, 06 Dec 2021 00:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20211203185522.692489-1-arnd@kernel.org> <CACGkMEuv2HQxUyxL8hsAXGOKxhTFED5_AcnZ1dOALh2QsL7ZKQ@mail.gmail.com>
 <CAK8P3a1mRu=CRSShyx1UKwR+nPOOM2kN0ZjZBzKTu6Hw5wLF4Q@mail.gmail.com>
In-Reply-To: <CAK8P3a1mRu=CRSShyx1UKwR+nPOOM2kN0ZjZBzKTu6Hw5wLF4Q@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 6 Dec 2021 16:41:05 +0800
Message-ID: <CACGkMEs-Y=67owrS9f4Spg+y5qg3p6CQ-S+Bcu=nOHZ5d0BNbQ@mail.gmail.com>
Subject: Re: [PATCH] eni_vdpa: alibaba: select VIRTIO_PCI_LIB
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 4:14 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Mon, Dec 6, 2021 at 4:12 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Sat, Dec 4, 2021 at 2:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > When VIRTIO_PCI_LIB is not built-in but the alibaba driver is, the
> > > kernel runs into a link error:
> > >
> > > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_features':
> > > eni_vdpa.c:(.text+0x23f): undefined reference to `vp_legacy_set_features'
> > > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_state':
> > > eni_vdpa.c:(.text+0x2fe): undefined reference to `vp_legacy_get_queue_enable'
> > > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_address':
> > > eni_vdpa.c:(.text+0x376): undefined reference to `vp_legacy_set_queue_address'
> > > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_set_vq_ready':
> > > eni_vdpa.c:(.text+0x3b4): undefined reference to `vp_legacy_set_queue_address'
> > > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_free_irq':
> > > eni_vdpa.c:(.text+0x460): undefined reference to `vp_legacy_queue_vector'
> > > x86_64-linux-ld: eni_vdpa.c:(.text+0x4b7): undefined reference to `vp_legacy_config_vector'
> > > x86_64-linux-ld: drivers/vdpa/alibaba/eni_vdpa.o: in function `eni_vdpa_reset':
> >
> > Intersting, all those belongs to the legacy library.
> >
> > And I just have a try and I can complie alibaba eni without
> > VIRTIO_PCI_LIB is set.
>
> Ah, so the problem is in drivers/Makefile:
>
> obj-$(CONFIG_VIRTIO)            += virtio/
> obj-$(CONFIG_VIRTIO_PCI_LIB)    += virtio/
>
> We only enter this directory when one of these two symbols is set, but
> in my randconfig
> build, neither one is. I'll send a new patch.

Yes, we need to include when VIRTIO_PCI_LIB_LEGACY is set.

Thanks

>
>          Arnd
>

