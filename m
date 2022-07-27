Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB3E581F5C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 07:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbiG0FAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 01:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiG0FAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 01:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0618D2663
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 22:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658898009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=328C7t/lfMBTNWuslbDt6MRb5wfKGX7Nq000FG5WAWM=;
        b=ArZNzZg/XZA9GwTHQgFoTatrPXYX+X+Ssq6wmX9IUV6AJs023WTTwiZEzB5n0SE653ybGr
        Z3YZm1geN1TFYyR6MUkzk2VGZdzvOGMwtOxLOPqkarSdrwblcc+MXijFAHSR9678RnXPbg
        TKeTEHb0BD5rIPZ6XQ8OEwrL8Ma/tEQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-wekvP2ldOY2KLkCZ7a3MZw-1; Wed, 27 Jul 2022 01:00:04 -0400
X-MC-Unique: wekvP2ldOY2KLkCZ7a3MZw-1
Received: by mail-lf1-f69.google.com with SMTP id k25-20020a195619000000b00489e6a6527eso4899851lfb.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 22:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=328C7t/lfMBTNWuslbDt6MRb5wfKGX7Nq000FG5WAWM=;
        b=s242MO8pM0szcmq/S5sMUnbpVMuQQxE2WhDSqczrO9MqBqjf6X2mvae9F6ruR+NpG1
         7Pt9/gt5kbPWRYvy+OLj9HcG3B5B6Pu2tlu/Kci+WGXdpQ1EZXVm1G9kP+Sx4dHYSBFn
         f7JT0x/XLOY2Up5MKIbu+Ogv18Wb/rbwIn57UCtvg6TsSEU+bxaMA+NUW+m50DVEejq4
         244lg8auiMgyfnf1f2O5WqLdeSRw8kMLnca5ETzVMCEt11fA0kCkJkYE//cZFv4H0Jqz
         uSXDfDe4l+sG4dRingeYr/J+cZJrZu3qcaJRvA28b7XU1gS1bpCrLbUi0Z+gEC0sGTao
         pRBA==
X-Gm-Message-State: AJIora+X8iiNAGHQWYbB3jdYsNtxPaGZ4mMB5GETRepIohMpa+OYPnhs
        4q5qEuQZ5wy0cA0pvGyg3SazZvOCUG3QYElzOR26W7X4+Ch4u5SHCGIvEu1H4aJBpGQ/yh5N49z
        BBX+1tLScwO7bxRV4G4o8hPUUi3wTqR7PL8X3pvh4
X-Received: by 2002:a05:6512:b0d:b0:481:5cb4:cf1e with SMTP id w13-20020a0565120b0d00b004815cb4cf1emr7237915lfu.442.1658898002517;
        Tue, 26 Jul 2022 22:00:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vPZY8nVY+qvmUV4ThmrrYh3uP7ne096VDRSFkv/b1xcj8u86DgdUtULwU3n9XG1Cd3R8XLqLMox4qIi7Z0n3o=
X-Received: by 2002:a05:6512:b0d:b0:481:5cb4:cf1e with SMTP id
 w13-20020a0565120b0d00b004815cb4cf1emr7237901lfu.442.1658898002007; Tue, 26
 Jul 2022 22:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220726131135.146912-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20220726131135.146912-1-wangkefeng.wang@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 27 Jul 2022 12:59:50 +0800
Message-ID: <CACGkMEvZDfxt97_GfE6oYwj6mQX95zUAz-B2k2FaedBeDUe9bw@mail.gmail.com>
Subject: Re: [PATCH] mm: use is_zone_movable_page() helper
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 9:05 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> Use is_zone_movable_page() helper to simplify code.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Jason Wang <jasowang@redhat.com>

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
> --
> 2.35.3
>

