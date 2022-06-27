Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0A855D0E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239191AbiF0UnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbiF0UnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:43:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29DD821A4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656362585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FdFpjlfe7+cJrMqoUp1W/ykiOEhVBVxyL8rdJnP53N4=;
        b=Sxv5pHIu0JMgvflw/40N/rFh4PEmu4iaXbur/uDm1PVTxmn5kFN6UOqn16dhoh0FWwTVfT
        4UgLOMt/L69rCB9fWu1D49u+z1aFVsmmI08iMWHyiRf/FKR5e4kSrA8jpPblmLvwGyg9FD
        QaRJ3Y5XGKatnPfblP6ZBGLcGDQ4vsE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-lQFSIU2FMZGPSp06afr_eg-1; Mon, 27 Jun 2022 16:43:03 -0400
X-MC-Unique: lQFSIU2FMZGPSp06afr_eg-1
Received: by mail-ej1-f69.google.com with SMTP id qa41-20020a17090786a900b00722f313a60eso2834833ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FdFpjlfe7+cJrMqoUp1W/ykiOEhVBVxyL8rdJnP53N4=;
        b=wuJeLpiteacw33AhMh2VxvgtyBiflSYvTU3C6JeMiT7w/Wi7iTepCMA4ytaII04UdL
         wkZrPddsK/64fJAiIgnnVOWo8RYFmU3BgPPBEkcduN09l4baEr6Uomfw6gTIHbmjVkEx
         HHwzVap2FditLx3I0g++xG5b/+LrNlAFTbHnYdeqjD7BAUj5gnpWfvNvvZ5GxaQM9i2e
         vmBSMiQqV7LzrpapWr/wBSUKGf5d84dX0Jb73yGiM7pR2pZ2VobrlJp1kgZV5P79LOXw
         naoCklQ5bbSzSySRo19WjRqNjSXFQ1GRWn8yFDFbD3weJkEEAPNS710QCG6xQk+hFo7B
         4+EA==
X-Gm-Message-State: AJIora8dPpDwdpQW8uCiyf3IYstMfpxY8wqqQHgNpP94rDyTMUd3sVKh
        dbGERe/X7Qn76YIBE7kffrqPf4Yv8uod0syNwmWLiP7TCQASYsshI0FSY49F5YNB7e1uEKHWdQ4
        AFwxZ3QAUcHCivrvd6qevTf+b
X-Received: by 2002:a17:906:72cd:b0:722:d84b:30e3 with SMTP id m13-20020a17090672cd00b00722d84b30e3mr14587586ejl.726.1656362582131;
        Mon, 27 Jun 2022 13:43:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t0yWLqQdqcWsKIFcdF09hybrWah5p/9e091idZ1EyzP3waUwLnryCBkPyygZ9zPVtt/4AJsw==
X-Received: by 2002:a17:906:72cd:b0:722:d84b:30e3 with SMTP id m13-20020a17090672cd00b00722d84b30e3mr14587578ejl.726.1656362581922;
        Mon, 27 Jun 2022 13:43:01 -0700 (PDT)
Received: from redhat.com ([2.52.23.204])
        by smtp.gmail.com with ESMTPSA id bl24-20020a170906c25800b00704757b1debsm5410981ejb.9.2022.06.27.13.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:43:01 -0700 (PDT)
Date:   Mon, 27 Jun 2022 16:42:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kernel@openvz.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Create debugfs file with virtio balloon usage
 information
Message-ID: <20220627163714-mutt-send-email-mst@kernel.org>
References: <20220627085838-mutt-send-email-mst@kernel.org>
 <20220627191910.22734-1-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627191910.22734-1-alexander.atanasov@virtuozzo.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 07:19:09PM +0000, Alexander Atanasov wrote:
> Allow the guest to know how much it is ballooned by the host.
> It is useful when debugging out of memory conditions.
> 
> When host gets back memory from the guest it is accounted
> as used memory in the guest but the guest have no way to know
> how much it is actually ballooned.
> 
> No pretty printing and fixed as per coding style.
> 
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  drivers/virtio/virtio_balloon.c | 71 +++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> - Leave pretty print to userspace
> - Fixed coding style
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index b9737da6c4dd..1bb6a6d0e37b 100644
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
> @@ -731,6 +732,71 @@ static void report_free_page_func(struct work_struct *work)
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
> +	seq_printf(f, "%-22s: %llx\n", "capabilities", b->vdev->features);

why do we need this in debugfs? Isn't this available in sysfs already?

> +	seq_printf(f, "%-22s: %d\n", "page_size", 4096);

I suspect this function doesn't work properly when page size is not 4K.

> +
> +	virtio_cread_le(b->vdev, struct virtio_balloon_config, actual,
> +			&num_pages);
> +	/* Memory returned to host or amount we can inflate if possible */
> +	seq_printf(f, "%-22s: %u\n", "ballooned_pages", num_pages);

I don't really get the comment here.

> +
> +	/* Total Memory for the guest from host */
> +	seq_printf(f, "%-22s: %lu\n", "total_pages", i.totalram);
> +
> +	/* Current memory for the guest */
> +	seq_printf(f, "%-22s: %lu\n", "current_pages", i.totalram - num_pages);

Are you sure these are in units of 4Kbyte pages?

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
> @@ -1019,6 +1085,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  
>  	if (towards_target(vb))
>  		virtballoon_changed(vdev);
> +
> +	virtio_balloon_debugfs_init(vb);
> +
>  	return 0;
>  
>  out_unregister_oom:
> @@ -1065,6 +1134,8 @@ static void virtballoon_remove(struct virtio_device *vdev)
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

