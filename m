Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854E9469150
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbhLFISX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:18:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39442 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239072AbhLFISV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:18:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A606DB8100F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E643C341D1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638778491;
        bh=THfRn7a2JovhIntYuiPXT6Vgso3P5wCsDJLMba8ppNA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pLSZ3cBGS2wEKnXgau9/aMQ3TTHvktdv0t5uMHtWSuN56CRkCeYJmUdEN04VtIDoc
         Ogz+ME3k4rXUrOVShkEVvkdHSBIC3p4AFXCKUOKL15yxIZufF+RqFHycJSBNz2q2nB
         JsdCDgkAEE1OxEm7zrqRwlhIuYsnMnTT9CA7ERgwkBWPRvc7kiBOyXBIpFuvkMGkhr
         ZiwdlcyQcKWpDcrbBntk3T3obAgJOwXHXyPBlsc4NLNBemFOud8NrrenGFqHpHuyAJ
         rRigvWSUIA0EIH1Y1S5ZJ8dnJstkFnPVfFIGHV5yWqc7Z1rDpZcJuHzGaS4OcYc4Ze
         Npe9LMK8i21PA==
Received: by mail-wm1-f44.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so9802514wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 00:14:51 -0800 (PST)
X-Gm-Message-State: AOAM5339pC4KIMq9kHrO47oKLDM8oOKvR5M1Op0EmTSMZ5A/wKVuaCcW
        HgXp+ihL4bL+aO2Air52LRO9/rO2N+MEX2ZzQIw=
X-Google-Smtp-Source: ABdhPJwtmtOxIj+u87zU1ovigcp0t9aQlHc+oBK9rG8VfMe6Ea7m4Bg2CKOZ6IXtLmjBmDFjJACWQQ8QmdSi4ovavGk=
X-Received: by 2002:a1c:1c1:: with SMTP id 184mr37071464wmb.1.1638778489682;
 Mon, 06 Dec 2021 00:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20211203185522.692489-1-arnd@kernel.org> <CACGkMEuv2HQxUyxL8hsAXGOKxhTFED5_AcnZ1dOALh2QsL7ZKQ@mail.gmail.com>
In-Reply-To: <CACGkMEuv2HQxUyxL8hsAXGOKxhTFED5_AcnZ1dOALh2QsL7ZKQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 6 Dec 2021 09:14:33 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1mRu=CRSShyx1UKwR+nPOOM2kN0ZjZBzKTu6Hw5wLF4Q@mail.gmail.com>
Message-ID: <CAK8P3a1mRu=CRSShyx1UKwR+nPOOM2kN0ZjZBzKTu6Hw5wLF4Q@mail.gmail.com>
Subject: Re: [PATCH] eni_vdpa: alibaba: select VIRTIO_PCI_LIB
To:     Jason Wang <jasowang@redhat.com>
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

On Mon, Dec 6, 2021 at 4:12 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Sat, Dec 4, 2021 at 2:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
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
>
> Intersting, all those belongs to the legacy library.
>
> And I just have a try and I can complie alibaba eni without
> VIRTIO_PCI_LIB is set.

Ah, so the problem is in drivers/Makefile:

obj-$(CONFIG_VIRTIO)            += virtio/
obj-$(CONFIG_VIRTIO_PCI_LIB)    += virtio/

We only enter this directory when one of these two symbols is set, but
in my randconfig
build, neither one is. I'll send a new patch.

         Arnd
