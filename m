Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E262755E1A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiF0NBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbiF0NA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:00:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92ED3101DB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656334797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4z4+u6l8RM+f5xT0Nol3aJ6atxf8zDUCJYjlwIN4J+U=;
        b=TbcnuE/m5Zyjd/KEh787VhcchdubHd1sgpDQcwxsP6PLHDDOHJ+4kuK3VeVavUUbiiFtBM
        fSEnJABoVZupVcqooAy8pyod80isLog8NzOi0M9Y/HNhDjrbo0jV+NN07k56iL2zWXQixA
        KkJ19UMrjD5vQT15DidenN8esHF/ciU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-pGPgQ1WOPOGsCqdJFzQrFA-1; Mon, 27 Jun 2022 08:59:56 -0400
X-MC-Unique: pGPgQ1WOPOGsCqdJFzQrFA-1
Received: by mail-wr1-f71.google.com with SMTP id q6-20020adfea06000000b0021bad47edaeso1178875wrm.20
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4z4+u6l8RM+f5xT0Nol3aJ6atxf8zDUCJYjlwIN4J+U=;
        b=XShCrZIWzRVgaB70AnXAH9ghnRBQkdCKstmGgJ1ensJLGVZUwqOKHnKp4ZniGjkb3h
         8s1AK6FM0xjtTJEM0DFevf6NuMhpq9nepqTGGHjk19hesQp6ekHlMaG2VRUMSr+nxg+Q
         Fx9iSXrCI/A7TYfQ+ViZzNHw2mUk154MnC/8WjKaugKUy1uPbcOA03WG3Sob6wUe/kGg
         O0IwMBj0UqFNYMZ0TZczI21nqjDQdgKlnIyWcRGEik1ghmtvesXnX1smFEFlFUE9EMuH
         q3g7fBMRd7VzXdciUtd2+o1TeDD6kjuz0tmjXL7FYUnIxHLlsZCHPg8P5Ny4KOu5qvqV
         rBHQ==
X-Gm-Message-State: AJIora/E9okKG4ANl0DF00mtqZ2IqpamFabt/p8+ilobEzqXbNR93jnl
        zTTKs7vggzIBIU7fJDXDkiBXZxmLqOc+cg97AFzZn2dfeUVPxfktLQSTG53Iy/HEVyBOHnQ8njD
        wGEPTgxss+rDu14J/1O6LzQzo
X-Received: by 2002:adf:e801:0:b0:21b:873f:ed62 with SMTP id o1-20020adfe801000000b0021b873fed62mr12160820wrm.17.1656334795071;
        Mon, 27 Jun 2022 05:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uXFxO0sEwkc+5NtkEPfxEFPBlTqwgUpUXpWj9PWBu2TdukCMiQ0cpnMZcqOlExV1HFBRbNEw==
X-Received: by 2002:adf:e801:0:b0:21b:873f:ed62 with SMTP id o1-20020adfe801000000b0021b873fed62mr12160794wrm.17.1656334794837;
        Mon, 27 Jun 2022 05:59:54 -0700 (PDT)
Received: from redhat.com ([2.54.45.90])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d48c6000000b00212a83b93f3sm10459381wrs.88.2022.06.27.05.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 05:59:54 -0700 (PDT)
Date:   Mon, 27 Jun 2022 08:59:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     alexander.atanasov@virtuozzo.com
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kernel@openvz.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Create debugfs file with virtio balloon usage
 information
Message-ID: <20220627085838-mutt-send-email-mst@kernel.org>
References: <20220627122038.1921522-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627122038.1921522-1-alexander.atanasov@virtuozzo.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 12:20:38PM +0000, alexander.atanasov@virtuozzo.com wrote:
> From: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> 
> Allow the guest to know how much it is ballooned by the host.
> It is useful when debugging out of memory conditions.
> 
> When host gets back memory from the guest it is accounted
> as used memory in the guest but the guest have no way to know
> how much it is actually ballooned.
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  drivers/virtio/virtio_balloon.c | 91 +++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index b9737da6c4dd..a32a52c28a1f 100644
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
> @@ -731,6 +732,91 @@ static void report_free_page_func(struct work_struct *work)
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
> +static int virtio_balloon_debug_show(struct seq_file *f, void *offset)
> +{
> +	struct virtio_balloon *b = f->private;
> +	u32 num_pages;
> +	struct sysinfo i;
> +
> +	si_meminfo(&i);
> +
> +	seq_printf(f, "%-22s:", "capabilities");

why aren't features in sysfs sufficient for this? pretty printing
can be done in userspace ...

> +	if (virtio_has_feature(b->vdev, VIRTIO_BALLOON_F_MUST_TELL_HOST))
> +		seq_puts(f, " tell_host");
> +
> +	if (virtio_has_feature(b->vdev, VIRTIO_BALLOON_F_STATS_VQ))
> +		seq_puts(f, " stats");
> +
> +	if (virtio_has_feature(b->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> +		seq_puts(f, " deflate_on_oom");
> +
> +	if (virtio_has_feature(b->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> +		seq_puts(f, " free_page_hint");
> +
> +	if (virtio_has_feature(b->vdev, VIRTIO_BALLOON_F_PAGE_POISON))
> +		seq_puts(f, " page_poison");
> +
> +	if (virtio_has_feature(b->vdev, VIRTIO_BALLOON_F_REPORTING))
> +		seq_puts(f, " reporting");
> +
> +	seq_puts(f, "\n");
> +
> +	seq_printf(f, "%-22s: %d\n", "page_size", 4096);
> +
> +	virtio_cread_le(b->vdev, struct virtio_balloon_config, actual,
> +			&num_pages);
> +	/* Memory returned to host or amount we can inflate if possible */
> +	seq_printf(f, "%-22s: %u\n", "ballooned_pages", num_pages);
> +
> +	/* Total Memory for the guest from host */
> +	seq_printf(f, "%-22s: %lu\n", "total_pages", i.totalram);
> +
> +	/* Current memory for the guest */
> +	seq_printf(f, "%-22s: %lu\n", "current_pages", i.totalram-num_pages);

spaces around -

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
> +
>  #ifdef CONFIG_BALLOON_COMPACTION
>  /*
>   * virtballoon_migratepage - perform the balloon page migration on behalf of
> @@ -1019,6 +1105,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  
>  	if (towards_target(vb))
>  		virtballoon_changed(vdev);
> +
> +	virtio_balloon_debugfs_init(vb);
> +
>  	return 0;
>  
>  out_unregister_oom:
> @@ -1065,6 +1154,8 @@ static void virtballoon_remove(struct virtio_device *vdev)
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

