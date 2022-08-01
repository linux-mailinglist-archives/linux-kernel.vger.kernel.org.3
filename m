Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40B5586D89
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiHAPSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiHAPSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DED652A415
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659367101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qmwCfvO79GM4Sb0KX9aVjYyXH2nYh9vRvkB4m2BrJVg=;
        b=E9/jp+lZREdinMTgV6prVWrugiy6J9jHHRqX7KBtFYDWWM3A0W/HlAaaPtTK3/bDvpXPqB
        dzyNJdRprpmxyn6JRLC1SyO70YVwJpMfT6mJi7A2sBvoBNU7xGTe+asitHbW1wSZ0IQVpa
        grnC285P43AMb9Cj7cgdgzHlGjUZG2c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-Z9QfRpgBNTislNxIptnlRQ-1; Mon, 01 Aug 2022 11:18:18 -0400
X-MC-Unique: Z9QfRpgBNTislNxIptnlRQ-1
Received: by mail-wr1-f71.google.com with SMTP id j4-20020adfa544000000b0021ebac13bf3so2673516wrb.19
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 08:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=qmwCfvO79GM4Sb0KX9aVjYyXH2nYh9vRvkB4m2BrJVg=;
        b=ay5UoUyYJO0zcpf4JH+GyROwJTPQ5B6EzE55o4/APYFBP8HGI2dQNdo8hWi3RRuqz8
         ld1mPYImZYfaHvJ+0qLgd+QurD1dkbwtW4Hn4JbDI4G/zuR2B49gB17FzO+ELCGsKKyf
         1K7ndt2TlM1aSwB/lNgR6X8lbhTcOOr8Yf1Pr7/RmjTtd7M1iSeXla1HFxSHtIod93i9
         qrJnj+YNUrBCoeGxKsN6M9DIxpj6uDRwhwfAgxH7bhWycujqnb3Zka+9enifbdtIJp4I
         5CCc4qcndS2PrGoHS6ixN2M3y9ufhKwYNLacYvMr29s9ki8r28P/w2ZLs3/dcGjWLRDC
         n4jA==
X-Gm-Message-State: ACgBeo1PW5IVNmmXc5eIlhvZsje8HkXcV/6LBW2SuB7ziL4rw748DHVH
        2CyUmMw1WWvFnxW2iuuxmke3vHVfn/5CyHNlY35O3wiIdPCvEzJ5ox3X2EmD00n+RB/njVENbij
        WHIC76PBxWuLjUKsCPAxFYRtP
X-Received: by 2002:adf:ea03:0:b0:21f:151e:780e with SMTP id q3-20020adfea03000000b0021f151e780emr9228513wrm.25.1659367096764;
        Mon, 01 Aug 2022 08:18:16 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7CD+jmqLFTdLdFoaEGCeYOhayHo+uUEGsK0zaCWfH0H5Dwh4FurG3MWyM+NFtr+0DTi2WW0A==
X-Received: by 2002:adf:ea03:0:b0:21f:151e:780e with SMTP id q3-20020adfea03000000b0021f151e780emr9228501wrm.25.1659367096455;
        Mon, 01 Aug 2022 08:18:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6900:6d08:8df1:dd2c:bf00? (p200300cbc70469006d088df1dd2cbf00.dip0.t-ipconnect.de. [2003:cb:c704:6900:6d08:8df1:dd2c:bf00])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb07000000b0021e501519d3sm12211786wrr.67.2022.08.01.08.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 08:18:16 -0700 (PDT)
Message-ID: <2d0703da-ae89-7002-f500-300a4b5d206b@redhat.com>
Date:   Mon, 1 Aug 2022 17:18:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 1/2] Create debugfs file with virtio balloon usage
 information
Content-Language: en-US
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     kernel@openvz.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <55016ed9-7b3c-c4eb-f5f4-02cfce2191e4@redhat.com>
 <20220726140831.72816-1-alexander.atanasov@virtuozzo.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220726140831.72816-1-alexander.atanasov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.07.22 16:08, Alexander Atanasov wrote:
> Allow the guest to know how much it is ballooned by the host
> and how that memory is accounted.
> 
> It is useful when debugging out of memory conditions,
> as well for userspace processes that monitor the memory pressure
> and for nested virtualization.
> 
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

Superfluous empty line. Personally, I'd just get rid of this
(comparatively obvious) documentation completely.

> +static int virtio_balloon_debug_show(struct seq_file *f, void *offset)
> +{
> +	struct virtio_balloon *vb = f->private;
> +	s64 num_pages = vb->num_pages << (VIRTIO_BALLOON_PFN_SHIFT - 10);

Rather call this "inflated_kb" then, it's no longer "pages".

> +
> +	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> +		num_pages = -num_pages;

With VIRTIO_BALLOON_F_DEFLATE_ON_OOM this will now always report "0".

which would be the same as "num_pages = 0;" and would deserve a comment
explaining why we don't indicate that as "inflated: ".

Thanks.

-- 
Thanks,

David / dhildenb

