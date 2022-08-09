Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BE258D791
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbiHIKmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbiHIKmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57D97240A7
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 03:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660041761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2wU77kUCNeTkF1cn8B/etxN35pV2qrtvMIoXHK0vfB8=;
        b=axmr7EhwAW0qJIYpU4se6ZHDRLdar2G67AloX3hfI14R+NDB1YEVTzRun6F2W+zF01UK78
        3kItJduQ3VVx3Gfha3ohBOVKPPjITuubaQLzMeNjtl9I/sKD0X3ImwRItCG/OHPLaPnQqJ
        /Hsr5+/im8mgVe48p1oBmZK2w8AbPSQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-pw-hIko5OUWrNcQoz9oTiA-1; Tue, 09 Aug 2022 06:42:40 -0400
X-MC-Unique: pw-hIko5OUWrNcQoz9oTiA-1
Received: by mail-ej1-f72.google.com with SMTP id ho13-20020a1709070e8d00b00730a655e173so3294987ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 03:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=2wU77kUCNeTkF1cn8B/etxN35pV2qrtvMIoXHK0vfB8=;
        b=R7j5F04r5Eq7igINjfVIVwXNQKziBb+PQcydlTg1LrGdq7kLOzTv9gOAxvx7VlRqaz
         +vuvFL9VPIyvvD+6M+kuKU1B2k3Ugh5ZyhkfMCpMqSOrcu9G9I7oZNz3D4u9gOURKv9Q
         9+8KlaUWT1qNUXIoYUi0Firtnsq0AqYWzw1fvwDT+edwxhtzGu3D/e1+Y6e4qzrTiDd8
         /YPXxQxeVxjTL+eK5gZtcLMuffmL+xp7iO+i55vHqXTWf1QV9VxnFPhIXlUTKKKFDBE4
         JsoRRqo5ONwaUu11uU+OrO3G/n9yJo7nq97i6mUCbeCLOrYPbhJH4Oym5HRBIuQCa6Jj
         noVA==
X-Gm-Message-State: ACgBeo03qZI1DimWsm5ow8WGAeGNZJbv7SPq/eaeom27QhkGdkxi41RN
        orqh5rA5ryCf6eLyaMi4CVtAjdFtcwmelrcuSv4U8DH1kcat1pXVWirEJgjUA5aoI5jCoYcEDaf
        my4t5UM8X6z5OgLGzMP2vlUF9
X-Received: by 2002:a17:907:1c9d:b0:732:f9da:aa51 with SMTP id nb29-20020a1709071c9d00b00732f9daaa51mr1108826ejc.654.1660041759014;
        Tue, 09 Aug 2022 03:42:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4dwBXMrir1bhZ90knllSNXJ6IriUJkpeut7pGLGEfq3icbGS1zZfCNRRun+zm9ZUcJ60OBXg==
X-Received: by 2002:a17:907:1c9d:b0:732:f9da:aa51 with SMTP id nb29-20020a1709071c9d00b00732f9daaa51mr1108816ejc.654.1660041758814;
        Tue, 09 Aug 2022 03:42:38 -0700 (PDT)
Received: from redhat.com ([2.52.152.113])
        by smtp.gmail.com with ESMTPSA id p12-20020a1709066a8c00b0072af4af2f46sm998853ejr.74.2022.08.09.03.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 03:42:38 -0700 (PDT)
Date:   Tue, 9 Aug 2022 06:42:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kernel@openvz.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] Unify how inflated memory is accounted in virtio
 balloon driver
Message-ID: <20220809063624-mutt-send-email-mst@kernel.org>
References: <20220726140831.72816-1-alexander.atanasov@virtuozzo.com>
 <20220726141047.72913-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726141047.72913-1-alexander.atanasov@virtuozzo.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 02:10:47PM +0000, Alexander Atanasov wrote:
> Always account inflated memory as used for both cases - with and
> without deflate on oom. Do not change total ram which can confuse
> userspace and users.
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>

I only noticed this patch accidentally since it looked like
part of discussion on an older patch.
Please do not do this, each version should be its own thread,
if you want to link to previous discussion provide a
cover letter and do it there.

> ---
>  drivers/virtio/virtio_balloon.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 97d3b29cb9f1..fa6ddec45fc4 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -244,9 +244,6 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>  
>  		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
>  		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
> -		if (!virtio_has_feature(vb->vdev,
> -					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -			adjust_managed_page_count(page, -1);
>  		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
>  	}
>  
> @@ -265,9 +262,6 @@ static void release_pages_balloon(struct virtio_balloon *vb,
>  	struct page *page, *next;
>  
>  	list_for_each_entry_safe(page, next, pages, lru) {
> -		if (!virtio_has_feature(vb->vdev,
> -					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -			adjust_managed_page_count(page, 1);
>  		list_del(&page->lru);
>  		put_page(page); /* balloon reference */
>  	}

We adjusted total ram with balloon usage for many years.  I don't think
we can just drop this accounting using "can confuse userspace" as a
justification - any userspace that's confused by this has been confused
since approximately forever.

> @@ -750,12 +744,9 @@ static void report_free_page_func(struct work_struct *work)
>  static int virtio_balloon_debug_show(struct seq_file *f, void *offset)
>  {
>  	struct virtio_balloon *vb = f->private;
> -	s64 num_pages = vb->num_pages << (VIRTIO_BALLOON_PFN_SHIFT - 10);
> +	u64 num_pages = vb->num_pages << (VIRTIO_BALLOON_PFN_SHIFT - 10);
>  
> -	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -		num_pages = -num_pages;
> -
> -	seq_printf(f, "inflated: %lld kB\n", num_pages);
> +	seq_printf(f, "inflated: %llu kB\n", num_pages);
>  
>  	return 0;

I don't much like it when patch 1 adds code only for patch 2 to drop it.

>  }
> -- 
> 2.25.1

