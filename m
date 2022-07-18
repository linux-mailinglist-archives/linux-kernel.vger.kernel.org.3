Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F08A5780E0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbiGRLfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiGRLf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBA23E0E3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658144126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9JCm/b/mjt4LZBLzHear3EHHnOGBIPoSaVrBJk+/RAA=;
        b=jU8ozOf4jlCSqUr4kt+26hSpIth925czULg299gJYG4APmgdIy3S0JfWr40cPBRKn0xwbp
        +Ae+t1NhA/k5u1mpaQFAOxAANsUusOCZGskdPx+9s+Yrg0GweAIhFiP6eQr/0R2domdv/6
        KkBPcD0wCN6EK1scQrgxHjljJHr0vVc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-QAVXVFGpOu-N42C6kYuzRg-1; Mon, 18 Jul 2022 07:35:24 -0400
X-MC-Unique: QAVXVFGpOu-N42C6kYuzRg-1
Received: by mail-wm1-f72.google.com with SMTP id n21-20020a7bc5d5000000b003a2ff4d7a9bso4125208wmk.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=9JCm/b/mjt4LZBLzHear3EHHnOGBIPoSaVrBJk+/RAA=;
        b=EzxyyPNzjYibNhpdHHfbPfCNjq6aeX5glNm4tQkV3R2ut8VSTVyUDOW3oOJD0+Rf1n
         Hk5pNoxkdH1byDR6Ug+4aDCqDqPFhgkjLKp6FohcPmHTXF0QGBBXwaIovMEYq26TF6VM
         C6M71TA/1ff+x6rqG4+jc8sOXThdCdjHyqMgomafadDy03/rpzU/cv8PomlNnWNFjcUX
         PWs4lmsY23yFnGohEYCRxU6N5QB3xZE4tNZfAyaFaKEm3BJWCBZ7lrMN9kda/ZBnTkZa
         Wi8YontADuRurLLQkCL4lTtNm9cos53MjN/w3gosC3LFkge7tcp+iJ6G4c78Hh8gRbNx
         HdPg==
X-Gm-Message-State: AJIora8T6YTFURngQdRxVlsuonPceRTmKIQgHbGdXxtbN2vs9lgI8GyJ
        S2ML3LXD59gZ2xcgCkXiUlAVWLur04i+auq/k/FBMta7HkoLZYx5CeY8bd+ult5IhthmdnE2pE1
        eyTwCs2KqMz0oRgwsQ+jZ8DU5
X-Received: by 2002:a7b:c381:0:b0:3a2:fe96:2ce4 with SMTP id s1-20020a7bc381000000b003a2fe962ce4mr23293118wmj.70.1658144123658;
        Mon, 18 Jul 2022 04:35:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1viP2cnS2guKXxZTHu+eZiJoLsbXgWsbMOQJGktyyp94smBfBZj8OyeafS+IH7srVRiUt/CHQ==
X-Received: by 2002:a7b:c381:0:b0:3a2:fe96:2ce4 with SMTP id s1-20020a7bc381000000b003a2fe962ce4mr23293097wmj.70.1658144123376;
        Mon, 18 Jul 2022 04:35:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7400:6b3a:a74a:bd53:a018? (p200300cbc70574006b3aa74abd53a018.dip0.t-ipconnect.de. [2003:cb:c705:7400:6b3a:a74a:bd53:a018])
        by smtp.gmail.com with ESMTPSA id m24-20020a056000181800b0021d68e1fd42sm10736132wrh.89.2022.07.18.04.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 04:35:23 -0700 (PDT)
Message-ID: <0b660226-28dc-1f1d-e22e-34805dc5b25d@redhat.com>
Date:   Mon, 18 Jul 2022 13:35:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel@openvz.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <7fd5e645-3892-6e0d-de80-08728e29b150@redhat.com>
 <20220714132053.56323-1-alexander.atanasov@virtuozzo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 1/1] Create debugfs file with virtio balloon usage
 information
In-Reply-To: <20220714132053.56323-1-alexander.atanasov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.22 15:20, Alexander Atanasov wrote:
> Allow the guest to know how much it is ballooned by the host.
> It is useful when debugging out of memory conditions.
> 
> When host gets back memory from the guest it is accounted
> as used memory in the guest but the guest have no way to know
> how much it is actually ballooned.
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  drivers/virtio/virtio_balloon.c     | 79 +++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_balloon.h |  1 +
>  2 files changed, 80 insertions(+)
> 
> V2:
>  - fixed coding style
>  - removed pretty print
> V3:
>  - removed dublicate of features
>  - comment about balooned_pages more clear
>  - convert host pages to balloon pages
> V4:
>  - added a define for BALLOON_PAGE_SIZE to make things clear
> V5:
>  - Made the calculatons work properly for both ways of memory accounting
>    with or without deflate_on_oom
>  - dropped comment 
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index b9737da6c4dd..e17f8cc71ba4 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -10,6 +10,7 @@
>  #include <linux/virtio_balloon.h>
>  #include <linux/swap.h>
>  #include <linux/workqueue.h>
> +#include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -731,6 +732,79 @@ static void report_free_page_func(struct work_struct *work)
>  	}
>  }
>  
> +/*
> + * DEBUGFS Interface
> + */
> +#ifdef CONFIG_DEBUG_FS
> +
> +#define guest_to_balloon_pages(i) ((i)*VIRTIO_BALLOON_PAGES_PER_PAGE)
> +/**
> + * virtio_balloon_debug_show - shows statistics of balloon operations.
> + * @f: pointer to the &struct seq_file.
> + * @offset: ignored.
> + *
> + * Provides the statistics that can be accessed in virtio-balloon in the debugfs.
> + *
> + * Return: zero on success or an error code.
> + */
> +
> +static int virtio_balloon_debug_show(struct seq_file *f, void *offset)
> +{
> +	struct virtio_balloon *b = f->private;

Most other functions call this "vb".

> +	u32 num_pages, total_pages, current_pages;
> +	struct sysinfo i;
> +
> +	si_meminfo(&i);
> +
> +	seq_printf(f, "%-22s: %d\n", "page_size", VIRTIO_BALLOON_PAGE_SIZE);

Why? Either export all in ordinary page size or in kB. No need to
over-complicate the interface with a different page size that users
don't actually care about.

I'd just stick to /proc/meminfo and use kB.

> +
> +	virtio_cread_le(b->vdev, struct virtio_balloon_config, actual,
> +			&num_pages);

What's wrong with vb->num_pages? I'd prefer not doing config access, if
it can be avoided.

> +
> +	seq_printf(f, "%-22s: %u\n", "ballooned_pages", num_pages);
> +
> +	if (virtio_has_feature(b->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM)) {
> +		total_pages = guest_to_balloon_pages(i.totalram);
> +		current_pages = guest_to_balloon_pages(i.totalram) - num_pages;
> +	} else {
> +		total_pages = guest_to_balloon_pages(i.totalram) +  num_pages;
> +		current_pages = guest_to_balloon_pages(i.totalram);
> +	}
> +
> +	/* Total Memory for the guest from host */
> +	seq_printf(f, "%-22s: %u\n", "total_pages", total_pages);
> +
> +	/* Current memory for the guest */
> +	seq_printf(f, "%-22s: %u\n", "current_pages", current_pages);

The think I detest about that interface (total/current) is that it's
simply not correct -- because i.totalram for example doesn't include
things like (similar to MemTotal in /proc/meminfo)

a) crashkernel
b) early boot allocations (e.g., memmap)
c) any kind of possible memory (un)hotplug in the future

I'd really suggest to just KIS and not mess with i.totalram.

Exposing how much memory is inflated and some way to identify how that
memory is accounted in /proc/meminfo should be good enough.

E.g., the output here could simply be

"Inflated: 1024 kB"
"MemTotalReduced: 1024 kB"

That would even allow in the future for flexibility when it comes to how
much/what was actually subtracted from MemTotal.

> +
> +	return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(virtio_balloon_debug);
> +
> +static void  virtio_balloon_debugfs_init(struct virtio_balloon *b)
> +{
> +	debugfs_create_file("virtio-balloon", 0444, NULL, b,
> +			    &virtio_balloon_debug_fops);
> +}
> +
> +static void  virtio_balloon_debugfs_exit(struct virtio_balloon *b)
> +{
> +	debugfs_remove(debugfs_lookup("virtio-balloon", NULL));
> +}
> +
> +#else
> +
> +static inline void virtio_balloon_debugfs_init(struct virtio_balloon *b)
> +{
> +}
> +
> +static inline void virtio_balloon_debugfs_exit(struct virtio_balloon *b)
> +{
> +}
> +
> +#endif	/* CONFIG_DEBUG_FS */

[...]

> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index ddaa45e723c4..f3ff7c4e5884 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -40,6 +40,7 @@
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> +#define VIRTIO_BALLOON_PAGE_SIZE (1<<VIRTIO_BALLOON_PFN_SHIFT)

We prefer extra spacing

 (1 << VIRTIO_BALLOON_PFN_SHIFT)


-- 
Thanks,

David / dhildenb

