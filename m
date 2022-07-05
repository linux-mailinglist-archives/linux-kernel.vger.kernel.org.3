Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB00A5665C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiGEJDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiGEJCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:02:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F97C12D03
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 01:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657011596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+UC/vpAZ24B41yJaSERUjpzXj/4P7BrqzPeTPZNYUSk=;
        b=SuWhVu/wRNBUdO4mUoWnzeZ6rBZMpU4PAN5xO8NBZJpKNNrhJHt6P/LYiIoV/Bgj1RvWeQ
        97OgCGTWwjhgMbQu4kMZVwempcBtUMrV8/M5grQ4nuyggjUv4e7sQfVD6TI4BIOARMKeFJ
        0+wXn2TR/uk3JhJ/fhyf6UdzHIFksaw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-Gqhan04_PGSl4aDqHJ_Klg-1; Tue, 05 Jul 2022 04:59:47 -0400
X-MC-Unique: Gqhan04_PGSl4aDqHJ_Klg-1
Received: by mail-ej1-f69.google.com with SMTP id go10-20020a1709070d8a00b00722e8ee15b4so2540360ejc.22
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 01:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+UC/vpAZ24B41yJaSERUjpzXj/4P7BrqzPeTPZNYUSk=;
        b=CdqbuJhJUHoAZuPnipQTZmqNlpJGArLd2PSJ8sFHjcwj6Ln/eKApc/f8pSVJrEjtO+
         ZonLrnEPYO24k/z71VNtqpyOH10Nmnf+DOmLoxfcp2Uaf+UmxtDuYDRBc7SHOpLyDLbh
         cn4swLCTd9K1qjdLOBq7fklOs/87qt1Mj0T0JGbH9gifJbR1zhbVQa61xUvYNTlF2K/5
         0Rv8f2AOZuquhOhBMZLzBTVl2pYH5HeXP6DgzaBFj6I3Ux2cyBDI/O+lWgT6KVG5p11Q
         jQjXyU+Mq2hvMP5FnathxKIqurR66iEslXAQuJ1dYD+/+OSAMO1cdx7PsA4naA8s5G0V
         OHdw==
X-Gm-Message-State: AJIora8bcH9g6dx45r948buqdc2clTeuFLcMViIfqNxRj+LD9QdD9/ln
        r6GzFryRWBT0WyA4J7DpogtKZqf2f7bIi1ByCUa6DYDUcX3uJ8CY2UVcaOmiulk6cEQXx8v3vMp
        Y6nrLW76f1NGD3UeFfXQlo31+
X-Received: by 2002:a17:907:6d1d:b0:726:363e:cca3 with SMTP id sa29-20020a1709076d1d00b00726363ecca3mr32657355ejc.713.1657011586766;
        Tue, 05 Jul 2022 01:59:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t8yxRBy3xDLi7w7e5LNzTm1PgIo8eoKRWrZOilTxJAHABYZhdkwvgHvAIzrmk1L4W21Ao6Wg==
X-Received: by 2002:a17:907:6d1d:b0:726:363e:cca3 with SMTP id sa29-20020a1709076d1d00b00726363ecca3mr32657342ejc.713.1657011586452;
        Tue, 05 Jul 2022 01:59:46 -0700 (PDT)
Received: from redhat.com ([2.54.184.191])
        by smtp.gmail.com with ESMTPSA id uz12-20020a170907118c00b00711aed17047sm15357907ejb.28.2022.07.05.01.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 01:59:45 -0700 (PDT)
Date:   Tue, 5 Jul 2022 04:59:41 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kernel@openvz.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] Create debugfs file with virtio balloon usage
 information
Message-ID: <20220705045912-mutt-send-email-mst@kernel.org>
References: <20220705083638.29669-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705083638.29669-1-alexander.atanasov@virtuozzo.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 08:36:37AM +0000, Alexander Atanasov wrote:
> Allow the guest to know how much it is ballooned by the host.
> It is useful when debugging out of memory conditions.
> 
> When host gets back memory from the guest it is accounted
> as used memory in the guest but the guest have no way to know
> how much it is actually ballooned.
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  drivers/virtio/virtio_balloon.c     | 77 +++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_balloon.h |  1 +
>  2 files changed, 78 insertions(+)
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
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index b9737da6c4dd..dc4ad584b947 100644
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
> @@ -731,6 +732,77 @@ static void report_free_page_func(struct work_struct *work)
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
> +	u32 num_pages;
> +	struct sysinfo i;
> +
> +	si_meminfo(&i);
> +
> +	seq_printf(f, "%-22s: %d\n", "page_size", VIRTIO_BALLOON_PAGE_SIZE);
> +
> +	virtio_cread_le(b->vdev, struct virtio_balloon_config, actual,
> +			&num_pages);
> +	/*
> +	 * Pages allocated by host from the guest memory.
> +	 * Host inflates the balloon to get more memory.
> +	 * Guest needs to deflate the balloon to get more memory.
> +	 */
> +	seq_printf(f, "%-22s: %u\n", "ballooned_pages", num_pages);
> +
> +	/* Total Memory for the guest from host */
> +	seq_printf(f, "%-22s: %lu\n", "total_pages",
> +			guest_to_balloon_pages(i.totalram));
> +
> +	/* Current memory for the guest */
> +	seq_printf(f, "%-22s: %lu\n", "current_pages",
> +			guest_to_balloon_pages(i.totalram) - num_pages);
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
> @@ -1019,6 +1091,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  
>  	if (towards_target(vb))
>  		virtballoon_changed(vdev);
> +
> +	virtio_balloon_debugfs_init(vb);
> +
>  	return 0;
>  
>  out_unregister_oom:
> @@ -1065,6 +1140,8 @@ static void virtballoon_remove(struct virtio_device *vdev)
>  {
>  	struct virtio_balloon *vb = vdev->priv;
>  
> +	virtio_balloon_debugfs_exit(vb);
> +
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
>  		page_reporting_unregister(&vb->pr_dev_info);
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index ddaa45e723c4..f3ff7c4e5884 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -40,6 +40,7 @@
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> +#define VIRTIO_BALLOON_PAGE_SIZE (1<<VIRTIO_BALLOON_PFN_SHIFT)
>  #define VIRTIO_BALLOON_CMD_ID_STOP	0
>  #define VIRTIO_BALLOON_CMD_ID_DONE	1

Did you run checkpatch on this?

> -- 
> 2.25.1

