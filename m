Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD59E574C45
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbiGNLgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238996AbiGNLgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:36:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 302F95A474
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657798561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DMPu0+CsGQWhq38Z8l8Tmth890eIyaSGEU2tVPnMSXY=;
        b=S4oNJqSI/6sIyj72QRE8MwjlN0ycasaejqanR32D8bzoAN4DI714GulYPwUE9JjkGCPI4S
        c6EvAQCdOH9qzK0+U1auPKueDGdkdhJqAYYLXsmiemdIE4Ysm9pgTo2FWXLZMH1SQse7kY
        VAw3snbEoltNMEZVawJJpkiFEccrWsE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-yNXUy6_VN16AZHBYl3K1sA-1; Thu, 14 Jul 2022 07:35:58 -0400
X-MC-Unique: yNXUy6_VN16AZHBYl3K1sA-1
Received: by mail-wr1-f69.google.com with SMTP id w12-20020adf8bcc000000b0021d20a5b24fso494820wra.22
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=DMPu0+CsGQWhq38Z8l8Tmth890eIyaSGEU2tVPnMSXY=;
        b=blr6YkCAhmpU1x+RZAosckdCigqa+F8rBRPWgYcwyVNL3sD+fTDV3w1ukJnBnZUfqq
         b2oAOjltS7+FlgslbxbhPT+8ttgFetHCIMLHAF5jt9DLrqkYRHs7DdceslhU3PeWsdfo
         wfzVn1IBKVvaEsBiAdCdHKGogNdmE44G1XjiZhUK40jCe6A6ME91eiBWF1AbIOZoiDRc
         k5A5MXU2JvMIGnqGNivQNfn0T20Yb9mUoGQJ0/IXt3hS2si+iEuQ6DZ7TNNBHkV1tlze
         KC2xEyKNDLNpWuYartKXftkObKsq2qK8YL52lnr0vEluGMiP4ewDo0zr/zIBWD0xc1FI
         QvyA==
X-Gm-Message-State: AJIora/pjOoV7pHwiDZqqLJJ7eIQTAqpHM3xiaZQzY7z6THsqZVftrcQ
        d4isarwWYFB6bEZlEJRZ1eZLNsFsSWABqQkvIIf48JyyJVfFXpdXaZ9FdKtUE5e7MBK1XjVeqrj
        b0461H5w6CZGFW8azFcBFY/Id
X-Received: by 2002:a5d:5143:0:b0:21d:61b6:5225 with SMTP id u3-20020a5d5143000000b0021d61b65225mr7665197wrt.164.1657798556894;
        Thu, 14 Jul 2022 04:35:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vFLw/ilg8YddKegRKb5dsBkKEe/0ajWS/cmSAxw4ewN53wC5IMUv2obdftlGNr7i3D5y2NGA==
X-Received: by 2002:a5d:5143:0:b0:21d:61b6:5225 with SMTP id u3-20020a5d5143000000b0021d61b65225mr7665175wrt.164.1657798556581;
        Thu, 14 Jul 2022 04:35:56 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id o17-20020a05600c4fd100b003a305c0ab06sm616188wmq.31.2022.07.14.04.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 04:35:56 -0700 (PDT)
Message-ID: <7fd5e645-3892-6e0d-de80-08728e29b150@redhat.com>
Date:   Thu, 14 Jul 2022 13:35:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/1] Create debugfs file with virtio balloon usage
 information
Content-Language: en-US
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel@openvz.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220705083638.29669-1-alexander.atanasov@virtuozzo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220705083638.29669-1-alexander.atanasov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.22 10:36, Alexander Atanasov wrote:
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

Please drop that comment. This is basic virtio-balloon operation that
must not be explained at this point.

> +	seq_printf(f, "%-22s: %u\n", "ballooned_pages", num_pages);
> +
> +	/* Total Memory for the guest from host */
> +	seq_printf(f, "%-22s: %lu\n", "total_pages",
> +			guest_to_balloon_pages(i.totalram));

totalram is calculated from totalram_pages().

When we inflate/deflate, we adjust totalram as well via
adjust_managed_page_count().

Consequently, this doesn't calculate what you actually want?

Total memory would be totalram+inflated, current would be totalram.


But, TBH, only export num_pages. User space can just lookup the other
information (totalram) via /proc/meminfo.

-- 
Thanks,

David / dhildenb

