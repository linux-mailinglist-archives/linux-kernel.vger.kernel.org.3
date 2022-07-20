Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB0757B0BA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 08:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbiGTGEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 02:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiGTGED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 02:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 249E36112A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658297041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gb38UKRNv1Myphpxhs54+k5qSqfN6ylFDcrNHcncVsE=;
        b=e3IQhYdRR7dsNK1Bm0KnxdHQQJqF40bbpauU2do1ReBBeuNvKYsbALi9VHWg6ZaHQvpJw+
        wIBEg6QRsAbYcLWCIP99wAT7TpisyVcgOJK0ZE5A2c38eYF758/Rxipk7ozeTBSrlOdoD5
        2N9pKiMmETkzLdxtlbI8Qp5VPxvFBAc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-_ZZPiJX_NSWkj-9MVdlkIQ-1; Wed, 20 Jul 2022 02:03:53 -0400
X-MC-Unique: _ZZPiJX_NSWkj-9MVdlkIQ-1
Received: by mail-lj1-f198.google.com with SMTP id t7-20020a2e9d07000000b0025dc0e59778so1184957lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gb38UKRNv1Myphpxhs54+k5qSqfN6ylFDcrNHcncVsE=;
        b=yi7318JGBfcBzGBJsHQFXRPyZF61oFhouwU0qfLj8X3gkAzqbH3qGjsHQGIbuSCvkS
         RF4KnVm0OmYCfL7wgF85jluYQyaXcOS6VVucRQyFAnOnwoUYWwBYOmntNCmv5P8706uy
         0kYq4UJJ58upwvjoq0LsBXczyn4BA5Wvg/SiDNttPBpu/aMrSgxHNCwM9iF/WW2cfmWF
         neBNiM9wi51yBwJyRhe/iBMX5yVnWRVpm8yGxo7cZpKcgmotSq3KSHLVcyaBCROAwDDt
         OvzxJHnKRabX5caA0y7IYt4Yer+IZquqlckTDWlq/TiKlwuAzPrFPjk3/KAtJ+Khqklj
         E9nQ==
X-Gm-Message-State: AJIora/R4+vIkiOxWEwsZaBcdqJGwwvtXn5CJu622DPx206B9LevArK5
        pN+/XtRpk1PPFgzZHPDf0RVXTwDAjq+fMA7bP7tE4wZmnN6eJSKUMp4jkDBomxv+c3+NVSj5eld
        ipSeDLntczqqc/378kZJXtpv6ydnhK5suxXJNz1iP
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id y14-20020a0565123f0e00b0048a5edd99b2mr613002lfa.124.1658297031388;
        Tue, 19 Jul 2022 23:03:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tiFBhubKd+yx90qUOeMnSEQR5UGF9w2hH/iwB1U/cT6rqs3h+jXVZCY6Jz3ePcSOoR/PkOYDO8cOG0TUVSkQw=
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr612996lfa.124.1658297031123; Tue, 19
 Jul 2022 23:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220720044144.90-1-xieyongji@bytedance.com> <20220720044144.90-4-xieyongji@bytedance.com>
In-Reply-To: <20220720044144.90-4-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 20 Jul 2022 14:03:40 +0800
Message-ID: <CACGkMEsWs8vm9WeeHps5tj2wGGk-XRE95NNdJkPEuUbV794=zw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] vduse: Support using userspace pages as bounce buffer
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst <mst@redhat.com>, Liu Xiaodong <xiaodong.liu@intel.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        songmuchun@bytedance.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 12:42 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> Introduce two APIs: vduse_domain_add_user_bounce_pages()
> and vduse_domain_remove_user_bounce_pages() to support
> adding and removing userspace pages for bounce buffers.
> During adding and removing, the DMA data would be copied
> from the kernel bounce pages to the userspace bounce pages
> and back.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa_user/iova_domain.c | 96 +++++++++++++++++++++++++---
>  drivers/vdpa/vdpa_user/iova_domain.h |  8 +++
>  2 files changed, 96 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index 50d7c08d5450..e682bc7ee6c9 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -178,8 +178,9 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
>                             map->orig_phys == INVALID_PHYS_ADDR))
>                         return;
>
> -               addr = page_address(map->bounce_page) + offset;
> -               do_bounce(map->orig_phys + offset, addr, sz, dir);
> +               addr = kmap_local_page(map->bounce_page);
> +               do_bounce(map->orig_phys + offset, addr + offset, sz, dir);
> +               kunmap_local(addr);
>                 size -= sz;
>                 iova += sz;
>         }
> @@ -210,20 +211,23 @@ static struct page *
>  vduse_domain_get_bounce_page(struct vduse_iova_domain *domain, u64 iova)
>  {
>         struct vduse_bounce_map *map;
> -       struct page *page;
> +       struct page *page = NULL;
>
> +       read_lock(&domain->bounce_lock);
>         map = &domain->bounce_maps[iova >> PAGE_SHIFT];
> -       if (!map->bounce_page)
> -               return NULL;
> +       if (domain->user_bounce_pages || !map->bounce_page)
> +               goto out;
>
>         page = map->bounce_page;
>         get_page(page);
> +out:
> +       read_unlock(&domain->bounce_lock);
>
>         return page;
>  }
>
>  static void
> -vduse_domain_free_bounce_pages(struct vduse_iova_domain *domain)
> +vduse_domain_free_kernel_bounce_pages(struct vduse_iova_domain *domain)
>  {
>         struct vduse_bounce_map *map;
>         unsigned long pfn, bounce_pfns;
> @@ -243,6 +247,73 @@ vduse_domain_free_bounce_pages(struct vduse_iova_domain *domain)
>         }
>  }
>
> +int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
> +                                      struct page **pages, int count)
> +{
> +       struct vduse_bounce_map *map;
> +       int i, ret;
> +
> +       /* Now we don't support partial mapping */
> +       if (count != (domain->bounce_size >> PAGE_SHIFT))
> +               return -EINVAL;
> +
> +       write_lock(&domain->bounce_lock);
> +       ret = -EEXIST;
> +       if (domain->user_bounce_pages)
> +               goto out;
> +
> +       for (i = 0; i < count; i++) {
> +               map = &domain->bounce_maps[i];
> +               if (map->bounce_page) {
> +                       /* Copy kernel page to user page if it's in use */
> +                       if (map->orig_phys != INVALID_PHYS_ADDR)
> +                               memcpy_to_page(pages[i], 0,
> +                                              page_address(map->bounce_page),
> +                                              PAGE_SIZE);
> +                       __free_page(map->bounce_page);
> +               }
> +               map->bounce_page = pages[i];
> +               get_page(pages[i]);
> +       }
> +       domain->user_bounce_pages = true;
> +       ret = 0;
> +out:
> +       write_unlock(&domain->bounce_lock);
> +
> +       return ret;
> +}
> +
> +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
> +{
> +       struct vduse_bounce_map *map;
> +       unsigned long i, count;
> +
> +       write_lock(&domain->bounce_lock);
> +       if (!domain->user_bounce_pages)
> +               goto out;
> +
> +       count = domain->bounce_size >> PAGE_SHIFT;
> +       for (i = 0; i < count; i++) {
> +               struct page *page = NULL;
> +
> +               map = &domain->bounce_maps[i];
> +               if (WARN_ON(!map->bounce_page))
> +                       continue;
> +
> +               /* Copy user page to kernel page if it's in use */
> +               if (map->orig_phys != INVALID_PHYS_ADDR) {
> +                       page = alloc_page(GFP_ATOMIC | __GFP_NOFAIL);
> +                       memcpy_from_page(page_address(page),
> +                                        map->bounce_page, 0, PAGE_SIZE);
> +               }
> +               put_page(map->bounce_page);
> +               map->bounce_page = page;
> +       }
> +       domain->user_bounce_pages = false;
> +out:
> +       write_unlock(&domain->bounce_lock);
> +}
> +
>  void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain)
>  {
>         if (!domain->bounce_map)
> @@ -318,13 +389,18 @@ dma_addr_t vduse_domain_map_page(struct vduse_iova_domain *domain,
>         if (vduse_domain_init_bounce_map(domain))
>                 goto err;
>
> +       read_lock(&domain->bounce_lock);
>         if (vduse_domain_map_bounce_page(domain, (u64)iova, (u64)size, pa))
> -               goto err;
> +               goto err_unlock;
>
>         if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
>                 vduse_domain_bounce(domain, iova, size, DMA_TO_DEVICE);
>
> +       read_unlock(&domain->bounce_lock);
> +
>         return iova;
> +err_unlock:
> +       read_unlock(&domain->bounce_lock);
>  err:
>         vduse_domain_free_iova(iovad, iova, size);
>         return DMA_MAPPING_ERROR;
> @@ -336,10 +412,12 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
>  {
>         struct iova_domain *iovad = &domain->stream_iovad;
>
> +       read_lock(&domain->bounce_lock);
>         if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
>                 vduse_domain_bounce(domain, dma_addr, size, DMA_FROM_DEVICE);
>
>         vduse_domain_unmap_bounce_page(domain, (u64)dma_addr, (u64)size);
> +       read_unlock(&domain->bounce_lock);
>         vduse_domain_free_iova(iovad, dma_addr, size);
>  }
>
> @@ -447,7 +525,8 @@ static int vduse_domain_release(struct inode *inode, struct file *file)
>
>         spin_lock(&domain->iotlb_lock);
>         vduse_iotlb_del_range(domain, 0, ULLONG_MAX);
> -       vduse_domain_free_bounce_pages(domain);
> +       vduse_domain_remove_user_bounce_pages(domain);
> +       vduse_domain_free_kernel_bounce_pages(domain);
>         spin_unlock(&domain->iotlb_lock);
>         put_iova_domain(&domain->stream_iovad);
>         put_iova_domain(&domain->consistent_iovad);
> @@ -507,6 +586,7 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
>                 goto err_file;
>
>         domain->file = file;
> +       rwlock_init(&domain->bounce_lock);
>         spin_lock_init(&domain->iotlb_lock);
>         init_iova_domain(&domain->stream_iovad,
>                         PAGE_SIZE, IOVA_START_PFN);
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
> index 2722d9b8e21a..4e0e50e7ac15 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.h
> +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> @@ -14,6 +14,7 @@
>  #include <linux/iova.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/vhost_iotlb.h>
> +#include <linux/rwlock.h>
>
>  #define IOVA_START_PFN 1
>
> @@ -34,6 +35,8 @@ struct vduse_iova_domain {
>         struct vhost_iotlb *iotlb;
>         spinlock_t iotlb_lock;
>         struct file *file;
> +       bool user_bounce_pages;
> +       rwlock_t bounce_lock;
>  };
>
>  int vduse_domain_set_map(struct vduse_iova_domain *domain,
> @@ -61,6 +64,11 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
>
>  void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain);
>
> +int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
> +                                      struct page **pages, int count);
> +
> +void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain);
> +
>  void vduse_domain_destroy(struct vduse_iova_domain *domain);
>
>  struct vduse_iova_domain *vduse_domain_create(unsigned long iova_limit,
> --
> 2.20.1
>

