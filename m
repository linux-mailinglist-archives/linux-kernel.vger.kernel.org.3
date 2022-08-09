Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F18E58D793
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbiHIKoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiHIKoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:44:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EB932409D
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 03:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660041868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K0UDauW7jcnLQtitx4t4jJiAK2t9J+LTjI2mmV8bkCg=;
        b=X2ziIZc3pwKa2xpkiNdZ0I5+ECseg6ca6O31oWr6he9fvz0RIrCdj7pSiUvC8KwVek3Ve5
        CkgAx8aFxg3Zv3Dj6mTjDpG9NTGsjFiDEEDDsaccPSaia9ITBTSsWrUQFfjk7SBMJBgQ1a
        6J2Wtm2Xyc4Aa0pWC5yqueFr4om33g0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-ALzBXcu0OJWlUROdZBVZLQ-1; Tue, 09 Aug 2022 06:44:27 -0400
X-MC-Unique: ALzBXcu0OJWlUROdZBVZLQ-1
Received: by mail-ed1-f72.google.com with SMTP id b6-20020a056402278600b0043e686058feso7037482ede.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 03:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=K0UDauW7jcnLQtitx4t4jJiAK2t9J+LTjI2mmV8bkCg=;
        b=MhAMPl+WBayMs/qP/iUeSmFJz1MCbU9+0QXFnXaKeUvwCsh5AtB5xp91TKgHk6r/3q
         aT6CLW8Nia+JxozBsfnpgSlqHoeX4AGMHAz0R2/BGbD14UrkhttvonceUI+XwL9k5BzY
         68op665Dig8YbN/M53xJCIY8PUGjEpy7QVBz9fGslI6wYXLjqS13tmF4Mq3W3f2IqazZ
         Cw6bZPZUEqAkSFXoaMS0aXUE3jxAgwF2YrMT2XRuTQa62NYmG8DYzzE3GoSCG3UVtJRh
         4gjLGdGttijYzPWQqzGyWFfHAG1WjigUGpB9l+F+e1GVkKdpcBWkf06qtbLBSKiBlGuu
         WsIw==
X-Gm-Message-State: ACgBeo0yk5DWbc2/rX07lB6CQd4k3q7fbtIsPQsaeyI4bl116mRB2jSv
        LFcOe7unA5OSdscIFv0Gix/TDrfqH+tOdDs3fJiA2f7ksT6Ofcssjdiayhn0gz9kmKbFxMlmwJQ
        rtnRdSZDX/kCTuX45s1pnh8Ms
X-Received: by 2002:a05:6402:15a:b0:431:71b9:86f3 with SMTP id s26-20020a056402015a00b0043171b986f3mr21328926edu.249.1660041865810;
        Tue, 09 Aug 2022 03:44:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4UrYjETSBNDh179gY/Os++gHkuwZKCKYdlFGMoNu727HdgqYnD540bhW1EJZwjeBs/5VRWPw==
X-Received: by 2002:a05:6402:15a:b0:431:71b9:86f3 with SMTP id s26-20020a056402015a00b0043171b986f3mr21328907edu.249.1660041865601;
        Tue, 09 Aug 2022 03:44:25 -0700 (PDT)
Received: from redhat.com ([2.52.152.113])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906218200b0073156e6cd5csm1000743eju.3.2022.08.09.03.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 03:44:25 -0700 (PDT)
Date:   Tue, 9 Aug 2022 06:44:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kernel@openvz.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] Create debugfs file with virtio balloon usage
 information
Message-ID: <20220809064252-mutt-send-email-mst@kernel.org>
References: <55016ed9-7b3c-c4eb-f5f4-02cfce2191e4@redhat.com>
 <20220726140831.72816-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726140831.72816-1-alexander.atanasov@virtuozzo.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 02:08:27PM +0000, Alexander Atanasov wrote:
> Allow the guest to know how much it is ballooned by the host
> and how that memory is accounted.
> 
> It is useful when debugging out of memory conditions,
> as well for userspace processes that monitor the memory pressure
> and for nested virtualization.

Hmm. debugging is ok. monitoring/nested use-cases probably
call for sysfs/procfs.


> Depending on the deflate on oom flag memory is accounted in two ways.
> If the flag is set the inflated pages are accounted as used memory.
> If the flag is not set the inflated pages are substracted from totalram.
> To make clear how are inflated pages accounted sign prefix the value.
> Where negative means substracted from totalram and positive means
> they are accounted as used.
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  drivers/virtio/virtio_balloon.c | 59 +++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> V2:
>   - fixed coding style
>   - removed pretty print
> V3:
>   - removed dublicate of features
>   - comment about balooned_pages more clear
>   - convert host pages to balloon pages
> V4:
>   - added a define for BALLOON_PAGE_SIZE to make things clear
> V5:
>   - Made the calculatons work properly for both ways of memory accounting
>     with or without deflate_on_oom
>   - dropped comment
> V6:
>   - reduced the file to minimum
>   - unify accounting
> 
> I didn't understand if you agree to change the accounting to be the same
> so following part 2 is about it.
> 
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index f4c34a2a6b8e..97d3b29cb9f1 100644
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
> @@ -731,6 +732,59 @@ static void report_free_page_func(struct work_struct *work)
>  	}
>  }
>  
> +/*
> + * DEBUGFS Interface
> + */
> +#ifdef CONFIG_DEBUG_FS
> +
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
> +	struct virtio_balloon *vb = f->private;
> +	s64 num_pages = vb->num_pages << (VIRTIO_BALLOON_PFN_SHIFT - 10);
> +
> +	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> +		num_pages = -num_pages;
> +
> +	seq_printf(f, "inflated: %lld kB\n", num_pages);
> +
> +	return 0;
> +}

Can't we just have two attributes, without hacks like this one?

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
> +
>  #ifdef CONFIG_BALLOON_COMPACTION
>  /*
>   * virtballoon_migratepage - perform the balloon page migration on behalf of
> @@ -1019,6 +1073,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  
>  	if (towards_target(vb))
>  		virtballoon_changed(vdev);
> +
> +	virtio_balloon_debugfs_init(vb);
> +
>  	return 0;
>  
>  out_unregister_oom:
> @@ -1065,6 +1122,8 @@ static void virtballoon_remove(struct virtio_device *vdev)
>  {
>  	struct virtio_balloon *vb = vdev->priv;
>  
> +	virtio_balloon_debugfs_exit(vb);
> +
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
>  		page_reporting_unregister(&vb->pr_dev_info);
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -- 
> 2.25.1
> 
> 

