Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26DF58A7DB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 10:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240457AbiHEINC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 04:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237564AbiHEINA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 04:13:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4522E2AE0
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 01:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659687178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=as/n7r4z5i1iM4Pft8QmQl+bGCIIYNqWmf7qVGfhe6E=;
        b=dRjmdVjy16Sb/JMRSiYLVukolMjl1wzb6UMQsh+LbeA+PS1ekMBHkFsV3rj+WKhpMfKOEM
        buiU5lOF1Ws5tpFodotIyEbTMPk1ilj1FD0z1vCZZTRAYCj/t2ozlXVObLd5aQxcMjFQeA
        79lbYf0pH2NoJmPz4nZJGzVcaR43PZ4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-vGU6CdtBPX2MQW-H9XFY7w-1; Fri, 05 Aug 2022 04:12:55 -0400
X-MC-Unique: vGU6CdtBPX2MQW-H9XFY7w-1
Received: by mail-wr1-f69.google.com with SMTP id t13-20020adfe10d000000b0021bae3def1eso307031wrz.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 01:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=as/n7r4z5i1iM4Pft8QmQl+bGCIIYNqWmf7qVGfhe6E=;
        b=jf6yROa9kM3830nyEq7G6zjo+apP6Wtu1QCA5kWgLx7n9p8vGIUsFp7fTHyd6Ri6zg
         IfjHjGCUJcDGiK4k8hPHCVYLprWOVzZLzag7Tt23N14bfadJzdt07qPHX6nrhFcRrVxw
         A7Rk6zw99f3963CBOLM5ilzKBog2kPDgspV2YaHC6jCeLJlPjjBTm4DzaDqrRXJS6ynG
         n6Sx52P9Z5stiPHnbIHF2BVYG1R+uI6f4R/gNgrmILDQhEk0WVNkIg98/08BqijtstMw
         L5xkTxSwR7uxC84dX+h8sF75C4K3xvk4QYr2EqErDNebOAIHRjsNxIm+bOQYtRfPXPQc
         seRg==
X-Gm-Message-State: ACgBeo0ER5ihS9ZFVxozzjYRhuiuWZ9s3RsV5zvhJf+VMNqKwLfYo6Sf
        RXCQlZUeajxy/gX5wAzYDzdGscPD1ZRNTlqT/CYHB2Dx1k9JqLECz6003EWnaDOphP++wwEmlWm
        mVbu+1WcEnZe0mBno925lvWGQ
X-Received: by 2002:a05:6000:18a1:b0:21d:b2bd:d6e2 with SMTP id b1-20020a05600018a100b0021db2bdd6e2mr3693470wri.53.1659687174241;
        Fri, 05 Aug 2022 01:12:54 -0700 (PDT)
X-Google-Smtp-Source: AA6agR46raQoCDvwe82DtC9IZSGDKoMH2lCAJw0BBbc7Z5ISLtoobz5PNvdLREjVs0vgJBHjFtLzlw==
X-Received: by 2002:a05:6000:18a1:b0:21d:b2bd:d6e2 with SMTP id b1-20020a05600018a100b0021db2bdd6e2mr3693455wri.53.1659687173988;
        Fri, 05 Aug 2022 01:12:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fb00:f5c3:24b2:3d03:9d52? (p200300cbc706fb00f5c324b23d039d52.dip0.t-ipconnect.de. [2003:cb:c706:fb00:f5c3:24b2:3d03:9d52])
        by smtp.gmail.com with ESMTPSA id i29-20020a1c541d000000b003a5125049c9sm4466446wmb.9.2022.08.05.01.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 01:12:53 -0700 (PDT)
Message-ID: <ec0d45f9-6dc0-95ab-f0ff-7d6744d24668@redhat.com>
Date:   Fri, 5 Aug 2022 10:12:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] mm/gup.c: Refactor
 check_and_migrate_movable_pages()
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Ralph Campbell <rcampbell@nvidia.com>
References: <3e20a542e756bbc0f66435c9344ff674f3ff7ac7.1659680600.git-series.apopple@nvidia.com>
 <3f6d04570907ee80f030ffaa85e8f506b3d31fc1.1659680600.git-series.apopple@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3f6d04570907ee80f030ffaa85e8f506b3d31fc1.1659680600.git-series.apopple@nvidia.com>
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

On 05.08.22 08:29, Alistair Popple wrote:
> When pinning pages with FOLL_LONGTERM check_and_migrate_movable_pages()
> is called to migrate pages out of zones which should not contain any
> longterm pinned pages.
> 
> When migration succeeds all pages will have been unpinned so pinning
> needs to be retried. Migration can also fail, in which case the pages
> will also have been unpinned but the operation should not be retried. If
> all pages are in the correct zone nothing will be unpinned and no retry
> is required.
> 
> The logic in check_and_migrate_movable_pages() tracks unnecessary state
> and the return codes for each case are difficult to follow. Refactor the
> code to clean this up. No behaviour change is intended.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> Changes for v2:
> 
>  - Split into different functions as suggested by John.
>  - Made error handling more conventional as requested by Jason.
> 
> Personally I'm not entirely convinced the conventional approach to error
> handling is easier to follow here but have left it in for feedback as I
> might be getting too familiar with the code.
> 
> Originally posted as "mm/gup.c: Simplify and fix
> check_and_migrate_movable_pages() return codes"[1].
> 
> Changes from that version:
> 
>  - Restore the original isolation failure behaviour and don't fail the
>    pup. Instead retry indefinitely.
>  - Unpin all pages on retry or failure rather than just failure.
> 
> [1] https://lore.kernel.org/linux-mm/814dee5d3aadd38c3370eaaf438ba7eee9bf9d2b.1659399696.git-series.apopple@nvidia.com/
> ---
>  mm/gup.c | 159 ++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 88 insertions(+), 71 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index e26ccc0..60cb30a 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1900,20 +1900,14 @@ struct page *get_dump_page(unsigned long addr)
>  #endif /* CONFIG_ELF_CORE */
>  
>  #ifdef CONFIG_MIGRATION
> -/*
> - * Check whether all pages are pinnable, if so return number of pages.  If some
> - * pages are not pinnable, migrate them, and unpin all pages. Return zero if
> - * pages were migrated, or if some pages were not successfully isolated.
> - * Return negative error if migration fails.
> - */
> -static long check_and_migrate_movable_pages(unsigned long nr_pages,
> -					    struct page **pages)
> +static int collect_unpinnable_pages(struct list_head *movable_page_list,


If we're already renaming stuff, can we make it clearer, that we are
dealing with *longterm* unpinnable pages?


-- 
Thanks,

David / dhildenb

