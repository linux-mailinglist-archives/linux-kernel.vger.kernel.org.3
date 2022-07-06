Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84147568501
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiGFKQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiGFKQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:16:11 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF161AF3E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:16:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id li14so4333548ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 03:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8DPFziGiKNi5nRNQtYIFR0t52W/RWnWSC/Y3HjVJnk=;
        b=V2FipfaEWIhy+1g0Nw+5gBk2f2qeT0QGig0t1MJ6VEMEAun9a4+C18LvOFPGSN0AiH
         JtLYRK3F/VKzb17Lq1xfUyL9SHblOIIut5/aVlByVZNPHQ0Yg3z34b8SJUUIBjfOxNM0
         YU37suCqYrbMYeCh8j42UINO39Hg2IPHHkuvSH8dbS0SdjfQiRbZSgFYKSlfPGDz/Ctw
         5PcP0RhKwYiJ3kyVHxlkkymeHcBHpNOYH7EqDp6xXrXup7eqV/z8BkwYDfI57bDlyQ7/
         EtZRDFcTzkSOJhf2BtTBqXVGuBOSL9elztG7OqiDH+6PhVOY/nhmpLOVQZzAnZSRxuh6
         AQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8DPFziGiKNi5nRNQtYIFR0t52W/RWnWSC/Y3HjVJnk=;
        b=iqFR1yAFZxNwSdQYnw3436Sii31U1r3pkKOwEMT7DclAp7qh4JcJ/mcpCkEElJ8BpF
         HfiC9zF2Xa33c9mlx/T7AH8q/LmzjdO2fhrxRX9kANffPnVl3UGrLJ4bvl7/N0fW14tM
         3VmCfo3me+2QvgxfcD9Z8i+gL1zxhQOwnYlTjoRhEKMdvVmSVW4FPtY4Gg+IzUQLko9J
         L1/O85Sgr9G8jj991LicUPrsC9qiyOfXQoHZCTqkbqQI41ph0dVab/6cYeHv4xS2yhyf
         ECIaQsBlX1PTtNQbhFhAnny83AzsAaz2KUmgv+FBydrHLLYNT4WbBJzzKSKwncjlRixf
         aEOg==
X-Gm-Message-State: AJIora8HQvzlfozWc7NMHqnQgT2I0BSOUQiy0T0H8Ixu77Dhw9BT5KWl
        +7xWpC9y1JNvg5Bevr2aWcRpAs5ww34i9N38tGlq
X-Google-Smtp-Source: AGRyM1vFqq6tHuOPBaT9pqYUzBmlAKAzxPz8taUHx54478aY2ySGWo6h1lAi8x1HC58K/Qd+7WZ1grpwKwKCwRQuwZY=
X-Received: by 2002:a17:907:9715:b0:726:2a3b:9f84 with SMTP id
 jg21-20020a170907971500b007262a3b9f84mr37883629ejc.414.1657102568333; Wed, 06
 Jul 2022 03:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220706050503.171-1-xieyongji@bytedance.com> <CACGkMEv1tzenaGSUvYXEuxdmXyaZxQ24QspXRRA_95mMp4PWSg@mail.gmail.com>
In-Reply-To: <CACGkMEv1tzenaGSUvYXEuxdmXyaZxQ24QspXRRA_95mMp4PWSg@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 6 Jul 2022 18:15:57 +0800
Message-ID: <CACycT3u3kOzzQjKBYNAB5vtpgcmPg7FjJ5yTYMtQo0SJVrBmZg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] VDUSE: Support registering userspace memory as
 bounce buffer
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 5:30 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Jul 6, 2022 at 1:05 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> >
> > Hi all,
> >
> > This series introduces some new ioctls: VDUSE_IOTLB_GET_INFO,
> > VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM to support
> > registering and de-registering userspace memory for IOTLB
> > as bounce buffer in virtio-vdpa case.
> >
> > The VDUSE_IOTLB_GET_INFO ioctl can help user to query IOLTB
> > information such as bounce buffer size. Then user can use
> > those information on VDUSE_IOTLB_REG_UMEM and
> > VDUSE_IOTLB_DEREG_UMEM ioctls to register and de-register
> > userspace memory for IOTLB.
> >
> > During registering and de-registering, the DMA data in use
> > would be copied from kernel bounce pages to userspace bounce
> > pages and back.
> >
> > With this feature, some existing application such as SPDK
> > and DPDK can leverage the datapath of VDUSE directly and
> > efficiently as discussed before [1][2]. They can register
> > some preallocated hugepages to VDUSE to avoid an extra
> > memcpy from bounce-buffer to hugepages.
>
> This is really interesting.
>
> But a small concern on uAPI is that this seems to expose the VDUSE
> internal implementation (bounce buffer) to userspace. We tried hard to
> hide it via the GET_FD before. Anyway can we keep it?
>

Another way is changing GET_FD ioctl to add a flag or reuse 'perm'
field to indicate whether a IOVA region supports userspace memory
registration. Then userspace can use
VDUSE_IOTLB_REG_UMEM/VDUSE_IOTLB_DEREG_UMEM to register/deregister
userspace memory for this IOVA region. Any suggestions?

Thanks,
Yongji
