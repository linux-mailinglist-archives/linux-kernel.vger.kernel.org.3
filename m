Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A724BF0BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 05:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiBVD0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 22:26:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiBVDZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 22:25:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 375771D0F4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645500331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LxxD0HcoaZKzQBhxL2/4ZeGyUXomH65XBCY4hjiGwFA=;
        b=HcEbZn9zwNix+37/R6iqHbJGg4QMQJcD0UcmAud0qKHNi1JkEpTQXCeVovvwBb4RB55/P1
        QGz8mJSDRzbhD/PoAmnP7gyjilt9GMLKH9420KgQZgoaW4MzDLnEiaBcUaLjp2xhfA8M+G
        BXEU+BkLiTuAnvhNTtciDmiWOtDnGQE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-nFC5nErJO8aIACj7sMS2hg-1; Mon, 21 Feb 2022 22:25:29 -0500
X-MC-Unique: nFC5nErJO8aIACj7sMS2hg-1
Received: by mail-lf1-f69.google.com with SMTP id m24-20020a056512359800b00442b6ff7a0eso2663295lfr.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LxxD0HcoaZKzQBhxL2/4ZeGyUXomH65XBCY4hjiGwFA=;
        b=gVVI73cbjnSz82MgLxf0wQxqdLSHgq2FYYV36ziO/x2eedUiK6kZVHYfUHe3RpSBdb
         LAzwuwQ5gfjvyPuAn7qptikO97f5MxH6LF/UOCki2JETdRhBFJ9ruPm70sMl545uRxQN
         foIUEPEq77xZv/AYErJJPr5eUGmrH5tXLluOn8upm0/8i+84fWGzo/Xx7gmVDlLWo9kM
         lwjDn6wnso8AbIST1LSYUf90AxqXauowvGKmK/Wev1j+KpNTWywYnDDk5Jcag7/a7uiY
         MunQZQCeUi03ETD9hgFBnbbrjr8j/Z4vmrcCStJxEnsBOdptwsYDBquEJsGsssS7f4lA
         yiTA==
X-Gm-Message-State: AOAM532SaXX+gOkdaIT0slxuzK1U/r1AzjJuOMmkKlGbbDfU0PR+hpqT
        1JZ5AHDTNLpbeSRDxoS9YA2QPbHDRFrCnK+2gMGxH411ufVI+MDs4W5TgtKtP/5Pu6EDpP50g2f
        zttf6te7NnvsjIQ+AbFHNj7UXShSOFaMVdovPFe+i
X-Received: by 2002:ac2:5dc9:0:b0:443:5db1:244c with SMTP id x9-20020ac25dc9000000b004435db1244cmr16260344lfq.84.1645500328169;
        Mon, 21 Feb 2022 19:25:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgclXkZ4so+3pHZp3beg+SMuuvNf+mQCavH/1HthOChAx9iEQFRetN/+EmIDBrnSE47bn8vJcbii0Wu+Z0MDg=
X-Received: by 2002:ac2:5dc9:0:b0:443:5db1:244c with SMTP id
 x9-20020ac25dc9000000b004435db1244cmr16260331lfq.84.1645500327952; Mon, 21
 Feb 2022 19:25:27 -0800 (PST)
MIME-Version: 1.0
References: <c1895bcc240d413ff067f982b6e653996ace9887.camel@infradead.org>
In-Reply-To: <c1895bcc240d413ff067f982b6e653996ace9887.camel@infradead.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 22 Feb 2022 11:25:16 +0800
Message-ID: <CACGkMEuXOuXqJPouDkGSm=4uZTSQf6cA+W+vPeM8gEDSKGiP5Q@mail.gmail.com>
Subject: Re: [PATCH] tools/virtio: Test virtual address range detection
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 12:17 AM David Woodhouse <dwmw2@infradead.org> wrote:
>
> As things stand, an application which wants to use vhost with a trivial
> 1:1 mapping of its virtual address space is forced to jump through hoops
> to detect what the address range might be. The VHOST_SET_MEM_TABLE ioctl
> helpfully doesn't fail immediately; you only get a failure *later* when
> you attempt to set the backend, if the table *could* map to an address
> which is out of range, even if no out-of-range address is actually
> being referenced.
>
> Since userspace is growing workarounds for this lovely kernel API, let's
> ensure that we have a regression test that does things basically the same
> way as https://gitlab.com/openconnect/openconnect/-/commit/443edd9d8826
> does.

I wonder if it's useful to have a small library that wraps vhost
kernel uAPI somewhere.

(In the future, we may want to let the kernel accept 1:1 mapping by
figuring out the illegal range by itself?)

Thanks

>
> This is untested as I can't actually get virtio_test to work at all; it
> just seems to deadlock on a spinlock. But it's getting the right answer
> for the virtio range on x86_64 at least.
>
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> ---
>
> Please, tell me I don't need to do this. But if I *do*, it needs a
> regression test in-kernel.
>
>  tools/virtio/virtio_test.c | 109 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 106 insertions(+), 3 deletions(-)
>
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index cb3f29c09aff..e40eeeb05b71 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -11,6 +11,7 @@
>  #include <sys/ioctl.h>
>  #include <sys/stat.h>
>  #include <sys/types.h>
> +#include <sys/mman.h>
>  #include <fcntl.h>
>  #include <stdbool.h>
>  #include <linux/virtio_types.h>
> @@ -124,6 +125,109 @@ static void vq_info_add(struct vdev_info *dev, int num)
>         dev->nvqs++;
>  }
>
> +/*
> + * This is awful. The kernel doesn't let us just ask for a 1:1 mapping of
> + * our virtual address space; we have to *know* the minimum and maximum
> + * addresses. We can't test it directly with VHOST_SET_MEM_TABLE because
> + * that actually succeeds, and the failure only occurs later when we try
> + * to use a buffer at an address that *is* valid, but our memory table
> + * *could* point to addresses that aren't. Ewww.
> + *
> + * So... attempt to work out what TASK_SIZE is for the kernel we happen
> + * to be running on right now...
> + */
> +
> +static int testaddr(unsigned long addr)
> +{
> +       void *res = mmap((void *)addr, getpagesize(), PROT_NONE,
> +                        MAP_FIXED|MAP_ANONYMOUS, -1, 0);
> +       if (res == MAP_FAILED) {
> +               if (errno == EEXIST || errno == EINVAL)
> +                       return 1;
> +
> +               /* We get ENOMEM for a bad virtual address */
> +               return 0;
> +       }
> +       /* It shouldn't actually succeed without either MAP_SHARED or
> +        * MAP_PRIVATE in the flags, but just in case... */
> +       munmap((void *)addr, getpagesize());
> +       return 1;
> +}
> +
> +static int find_vmem_range(struct vhost_memory *vmem)
> +{
> +       const unsigned long page_size = getpagesize();
> +       unsigned long top;
> +       unsigned long bottom;
> +
> +       top = -page_size;
> +
> +       if (testaddr(top)) {
> +               vmem->regions[0].memory_size = top;
> +               goto out;
> +       }
> +
> +       /* 'top' is the lowest address known *not* to work */
> +       bottom = top;
> +       while (1) {
> +               bottom >>= 1;
> +               bottom &= ~(page_size - 1);
> +               assert(bottom);
> +
> +               if (testaddr(bottom))
> +                       break;
> +               top = bottom;
> +       }
> +
> +       /* It's often a page or two below the boundary */
> +       top -= page_size;
> +       if (testaddr(top)) {
> +               vmem->regions[0].memory_size = top;
> +               goto out;
> +       }
> +       top -= page_size;
> +       if (testaddr(top)) {
> +               vmem->regions[0].memory_size = top;
> +               goto out;
> +       }
> +
> +       /* Now, bottom is the highest address known to work,
> +          and we must search between it and 'top' which is
> +          the lowest address known not to. */
> +       while (bottom + page_size != top) {
> +               unsigned long test = bottom + (top - bottom) / 2;
> +               test &= ~(page_size - 1);
> +
> +               if (testaddr(test)) {
> +                       bottom = test;
> +                       continue;
> +               }
> +               test -= page_size;
> +               if (testaddr(test)) {
> +                       vmem->regions[0].memory_size = test;
> +                       goto out;
> +               }
> +
> +               test -= page_size;
> +               if (testaddr(test)) {
> +                       vmem->regions[0].memory_size = test;
> +                       goto out;
> +               }
> +               top = test;
> +       }
> +       vmem->regions[0].memory_size = bottom;
> +
> + out:
> +       vmem->regions[0].guest_phys_addr = page_size;
> +       vmem->regions[0].userspace_addr = page_size;
> +       printf("Detected virtual address range 0x%lx-0x%lx\n",
> +              page_size,
> +              (unsigned long)(page_size + vmem->regions[0].memory_size));
> +
> +       return 0;
> +}
> +
> +
>  static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
>  {
>         int r;
> @@ -143,9 +247,8 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
>         memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
>                            sizeof dev->mem->regions[0]);
>         dev->mem->nregions = 1;
> -       dev->mem->regions[0].guest_phys_addr = (long)dev->buf;
> -       dev->mem->regions[0].userspace_addr = (long)dev->buf;
> -       dev->mem->regions[0].memory_size = dev->buf_size;
> +       r = find_vmem_range(dev->mem);
> +       assert(r >= 0);
>         r = ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
>         assert(r >= 0);
>  }
>
>

