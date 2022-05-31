Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E806553914F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244080AbiEaNCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiEaNCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:02:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35D04255A8
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654002151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NJW3Gz4FQ808Nt60KoUmgg6+4HwOClSMi/4w1XUVHRw=;
        b=NUI3QN4QhutVg03eGBjUp14MTkaUnIaCL2s1ft4bIk0nQnzXQ7x/RoakfdEjPLaTcF9MSO
        jueoqaRj5DXYUX1suOKfneLt5UZTWRFhotCc0pkj0EDDnncOVMAqpA4SaGTcTiteCj5NvA
        Uwijt9XbrnLMDDvge3ZSzmB7VPhJe/0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-00gM4tioMhGDusCqKvhxRg-1; Tue, 31 May 2022 09:02:29 -0400
X-MC-Unique: 00gM4tioMhGDusCqKvhxRg-1
Received: by mail-wr1-f72.google.com with SMTP id e2-20020a5d65c2000000b0020d266653eeso2049354wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 06:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=NJW3Gz4FQ808Nt60KoUmgg6+4HwOClSMi/4w1XUVHRw=;
        b=pv2UMdZuUv5+olq7Ma6f7KhLyZHZk0Kdaxz5cHImAvR/ziflnJRBbb77wkGCmUrXE2
         8TxCUopWDO4kV+5+D9lxajZxA7VDbCjBKbz11DbJYfOie2CVc3Hds/JRtCzibobeTlzK
         5Ul8V32FYUNCjoZ0LVXCY08PXgTUGNUyvCAGV4Km/TX4PoSYTVt0BhN/5zqAew8MerjP
         yZGG30A5DZ5nssvMPjseRZ4E2BKiFvqfGflaWPxeZiBa1uSaEaz29E7pn8MVNrJUnbhQ
         N5awstzsu+TE2dma8wRla9SgU88Zliwxt0yEOfNxDP/OAZudelErksDvJNqjb3hRcie9
         CxrA==
X-Gm-Message-State: AOAM532HCkdgT9foaZfOc9YTrCOm4C0KHW1zF2C1uC/Uyuanjw0Z64uF
        kkB49Gf4yxPdZmrpBuqXa4acIWeADidcSkRZlAydrKVtsbVVoYM0/85we/2OYXPXsVgPHy+cZbB
        Pos846ELP3KGtCSq1RYNcYreB
X-Received: by 2002:a05:600c:3d11:b0:39c:1c62:cebc with SMTP id bh17-20020a05600c3d1100b0039c1c62cebcmr1904848wmb.147.1654002148594;
        Tue, 31 May 2022 06:02:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzw92wCIn96hBcTzJ1gTAHj5pZvWIJWhd7k8i5eEy/DDb2U5hxQJYTmPXy5qsjkilOneR155g==
X-Received: by 2002:a05:600c:3d11:b0:39c:1c62:cebc with SMTP id bh17-20020a05600c3d1100b0039c1c62cebcmr1904822wmb.147.1654002148373;
        Tue, 31 May 2022 06:02:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:f100:8096:9368:ba52:a341? (p200300cbc708f10080969368ba52a341.dip0.t-ipconnect.de. [2003:cb:c708:f100:8096:9368:ba52:a341])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c204600b003973d0a78casm2062244wmg.38.2022.05.31.06.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 06:02:26 -0700 (PDT)
Message-ID: <768fbb44-90c3-1f88-73a0-8765b2233226@redhat.com>
Date:   Tue, 31 May 2022 15:02:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] mm/swapfile: fix possible data races of inuse_pages
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220527092626.31883-1-linmiaohe@huawei.com>
 <20220527092626.31883-4-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220527092626.31883-4-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.05.22 11:26, Miaohe Lin wrote:
> si->inuse_pages could still be accessed concurrently now. The plain reads
> outside si->lock critical section, i.e. swap_show and si_swapinfo, which
> results in data races. But these should be ok because they're just used
> for showing swap info.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/swapfile.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index e033a53a99df..29d7ca9eaa3c 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2649,7 +2649,7 @@ static int swap_show(struct seq_file *swap, void *v)
>  	}
>  
>  	bytes = si->pages << (PAGE_SHIFT - 10);
> -	inuse = si->inuse_pages << (PAGE_SHIFT - 10);
> +	inuse = READ_ONCE(si->inuse_pages) << (PAGE_SHIFT - 10);
>  
>  	file = si->swap_file;
>  	len = seq_file_path(swap, file, " \t\n\\");
> @@ -3268,7 +3268,7 @@ void si_swapinfo(struct sysinfo *val)
>  		struct swap_info_struct *si = swap_info[type];
>  
>  		if ((si->flags & SWP_USED) && !(si->flags & SWP_WRITEOK))
> -			nr_to_be_unused += si->inuse_pages;
> +			nr_to_be_unused += READ_ONCE(si->inuse_pages);
>  	}
>  	val->freeswap = atomic_long_read(&nr_swap_pages) + nr_to_be_unused;
>  	val->totalswap = total_swap_pages + nr_to_be_unused;


AFAIKT, this makes sense

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

