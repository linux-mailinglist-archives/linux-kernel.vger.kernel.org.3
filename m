Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D087581F69
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 07:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiG0FUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 01:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiG0FUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 01:20:09 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAE538A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 22:20:07 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31e623a4ff4so163859837b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 22:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e1XaWllZ4VWSveoLSOzRoa564aJjg0+qopyBxzu00FY=;
        b=QsFXqQa2VT6MewzWLDl1p7LqWLp/GZjqMN5nIwW0W6SPQFQwiK3DdfS40mVVtTda7k
         6CYbPEyF1wteuz4TzLFwXyBzsVQF0Rpr9GOr7BTxvO4a28VUQpgKFGQm49VrdlGrH5nN
         gg6i2chrLsMYY2l7Zs2LIx8fY3r+AAFCLVxhOzX8xvROOj9Fx+ymHrQWDR4f/ZS/5uwn
         ph+2eAqslL/SwmrWVkI1bGNMGSq2V9I5DHWajwJ4AIArkSSMn6TncTIQJmTMR9fgnguR
         OpKd/BXR3fJUUiTRMuyBy21YkeeFuVmNYT6F5FZpiJJbDsJMqmZVgig2BXSX9CNcmVz4
         HWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e1XaWllZ4VWSveoLSOzRoa564aJjg0+qopyBxzu00FY=;
        b=z5dSOLEnZcoVodFBaYu/wgAXLaHjzRcQ7nK9FZPrRsqsZqLTuejm5Df8G+Mffl8ek/
         WjIcmTqv1u+A/13iuRiE2pY6bCfRFPBhKZVe469Ber52q4N4cd8Y+bIMdRKLWKm7yajZ
         ij+nu5RpZetUtL9lyRI+0bEvcv1RCgO4W+P8omtUfza0ooZTdHTVVt+Srm7b2RULjOBj
         anz3lnB56TjdWWZhONJNzG3Gf3yDgL0d21B95O60C0OzVHRHNVUjMcigcrFifHwJdj7c
         VJLgXOq2Hz/hh+Cd4q8yovJnWwU5RnOHDlaN2euBsD69/B1L9OYNUdvCtNHKujVexOi5
         QJhg==
X-Gm-Message-State: AJIora+fpUUtXtgNua5kqamNl0F/aD2cavA9h+9AjKzv7U7L4nLMPznX
        l+FyeM6im9gRPBNe5ElcTkCZdxgArWSOLHvlRjU=
X-Google-Smtp-Source: AGRyM1t+dYFVbS4kNLO07ivSV2tGuNi9LrX6P+qozwdKPT5IOrVEFjBt5nHfYpnsT9o6aQhfUg21WAhvZ/JdBpY33xU=
X-Received: by 2002:a0d:cb03:0:b0:31f:49a2:3470 with SMTP id
 n3-20020a0dcb03000000b0031f49a23470mr5466300ywd.386.1658899206837; Tue, 26
 Jul 2022 22:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220726131135.146912-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20220726131135.146912-1-wangkefeng.wang@huawei.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 27 Jul 2022 07:19:56 +0200
Message-ID: <CAM9Jb+jmJxT1FdF5yxTqUb8ObCZExeDZiejB0QxV_rfvWuF13w@mail.gmail.com>
Subject: Re: [PATCH] mm: use is_zone_movable_page() helper
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Use is_zone_movable_page() helper to simplify code.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/virtio/virtio_mem.c | 6 ++----
>  mm/memory_hotplug.c         | 2 +-
>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index e07486f01999..0c2892ec6817 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -862,8 +862,7 @@ static void virtio_mem_sbm_notify_online(struct virtio_mem *vm,
>                                          unsigned long mb_id,
>                                          unsigned long start_pfn)
>  {
> -       const bool is_movable = page_zonenum(pfn_to_page(start_pfn)) ==
> -                               ZONE_MOVABLE;
> +       const bool is_movable = is_zone_movable_page(pfn_to_page(start_pfn));
>         int new_state;
>
>         switch (virtio_mem_sbm_get_mb_state(vm, mb_id)) {
> @@ -1158,8 +1157,7 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
>   */
>  static int virtio_mem_fake_offline(unsigned long pfn, unsigned long nr_pages)
>  {
> -       const bool is_movable = page_zonenum(pfn_to_page(pfn)) ==
> -                               ZONE_MOVABLE;
> +       const bool is_movable = is_zone_movable_page(pfn_to_page(pfn));
>         int rc, retry_count;
>
>         /*
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 1213d0c67a53..0f5914964a32 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -936,7 +936,7 @@ static struct zone *auto_movable_zone_for_pfn(int nid,
>                         if (!page)
>                                 continue;
>                         /* If anything is !MOVABLE online the rest !MOVABLE. */
> -                       if (page_zonenum(page) != ZONE_MOVABLE)
> +                       if (!is_zone_movable_page(page))
>                                 goto kernel_zone;
>                         online_pages += PAGES_PER_SECTION;
>                 }

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
