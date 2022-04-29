Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F76514575
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356624AbiD2JeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353293AbiD2JeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:34:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2427DBC0E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651224643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jzfc0XR3HdzCO3e4oTB5rJCxt+7ycFW3KMJ+LBAdZdw=;
        b=fmKJ4AE8VO+U9YA3MJTVKpVMUVdk6apQCAl3ox4k16aJ0fMoQvGxbylsCO9QEQlymmWfH8
        KBK/iJNkL5PPDVBaHvgsAZWxSm+aIdvfVctxn5GnLknHbprk8JsAwR6HaHvIG8uV9WfHW3
        /xwKkyihf1t6HFssHTiIgVonxRlDBT0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-YVX4Lq8PNTugq5q7oQIaIA-1; Fri, 29 Apr 2022 05:30:39 -0400
X-MC-Unique: YVX4Lq8PNTugq5q7oQIaIA-1
Received: by mail-wr1-f69.google.com with SMTP id k29-20020adfb35d000000b0020adc94662dso2839461wrd.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=jzfc0XR3HdzCO3e4oTB5rJCxt+7ycFW3KMJ+LBAdZdw=;
        b=sK/C+eOSYXnEHu2S0l8hUGPASqQkDtr/XIOY8eWg38inpwKhWvHdEV4zASUDdQrw4q
         8jFIc4WbwYTeHqnhMYOif3WQxfZ2CJoCtR1zhR5IQVdctHWeGUvaeJXKc67xBjlCXNIo
         CXe2aJsUXciT0NA5beZVnZ4ozKmfgNH+xAQoCVJsehEoU3Hne4Wmk0q/8D7OjSRV7EJg
         Ow12blijpr0cJPXb/VKePzaLxI0N+vCLga9A4KSBO16AzXT92gFSz6CLo3Tc2SDRVKAe
         SNZBQd+JeivwRmfLsanCWx1oh9/hmeHg+vaGQa1yRsCIK2dsqqhGy5Zvvy6DTCrBK7iN
         /chw==
X-Gm-Message-State: AOAM5325SwQZmUrV2Lh7XnfZJKwM3ajEu5aJ1ljbB6/uoTEDlEJZdlW4
        ydilRWfvjeLSy/WA3iWo8PU9Cb8Jp7usitEKh2pkOdjecro13yKdtrzV+vGJ8PgvcoX4bxmgYGP
        HpTG2fa743ykoxRQGaZ3eiWNR
X-Received: by 2002:a05:6000:15ce:b0:20c:4c7f:56cf with SMTP id y14-20020a05600015ce00b0020c4c7f56cfmr852239wry.536.1651224637960;
        Fri, 29 Apr 2022 02:30:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlcacLFDn/yRxpghaRW3zVcqRWyeRTKqdDViQiVuFsJG7FG4KKoXl0lemFGmEAAvYif3fEZg==
X-Received: by 2002:a05:6000:15ce:b0:20c:4c7f:56cf with SMTP id y14-20020a05600015ce00b0020c4c7f56cfmr852214wry.536.1651224637670;
        Fri, 29 Apr 2022 02:30:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:fe00:bbeb:98e6:617a:dea1? (p200300cbc707fe00bbeb98e6617adea1.dip0.t-ipconnect.de. [2003:cb:c707:fe00:bbeb:98e6:617a:dea1])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b00393eaf94077sm2772472wmq.8.2022.04.29.02.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 02:30:37 -0700 (PDT)
Message-ID: <28b6c421-5050-2d6f-7188-bedfc7b31862@redhat.com>
Date:   Fri, 29 Apr 2022 11:30:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 2/4] hugetlb: Fix hugepages_setup when deal with
 pernode
Content-Language: en-US
To:     Peng Liu <liupeng256@huawei.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        baolin.wang@linux.alibaba.com, songmuchun@bytedance.com,
        liuyuntao10@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220413032915.251254-1-liupeng256@huawei.com>
 <20220413032915.251254-3-liupeng256@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220413032915.251254-3-liupeng256@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.22 05:29, Peng Liu wrote:
> Hugepages can be specified to pernode since "hugetlbfs: extend
> the definition of hugepages parameter to support node allocation",
> but the following problem is observed.
> 
> Confusing behavior is observed when both 1G and 2M hugepage is set
> after "numa=off".
>  cmdline hugepage settings:
>   hugepagesz=1G hugepages=0:3,1:3
>   hugepagesz=2M hugepages=0:1024,1:1024
>  results:
>   HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
>   HugeTLB registered 2.00 MiB page size, pre-allocated 1024 pages
> 
> Furthermore, confusing behavior can be also observed when an
> invalid node behind a valid node. To fix this, never allocate any
> typical hugepage when an invalid parameter is received.
> 
> Fixes: b5389086ad7b ("hugetlbfs: extend the definition of hugepages parameter to support node allocation")
> Signed-off-by: Peng Liu <liupeng256@huawei.com>
> ---
>  mm/hugetlb.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5b5a2a5a742f..1930b6341f7e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4116,6 +4116,20 @@ bool __init __weak hugetlb_node_alloc_supported(void)
>  {
>  	return true;
>  }
> +
> +static void __init hugepages_clear_pages_in_node(void)

I think the name is a bit imprecise, but I have no better suggestion
right now.

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

