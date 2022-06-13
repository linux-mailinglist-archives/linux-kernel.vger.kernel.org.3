Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E1D549B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343539AbiFMSfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245665AbiFMSet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12E2925DA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655135047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oeK3BFcDjZ1AnYOq+FMGXhylJkvr/lrSWSvcbsIlUS4=;
        b=gXCDzrnIkZgYSsj2V6aUCDCIlNq2L2WDV/sFvhn8rFclbM+SVcLq8nxkobpd8SotISp2TV
        8p8090hhyZHfhfUKnWG2QIEWuG/AhtbKn1NcSlnJhpuKt0z3mJt8nlt1p4k4JbM8hcjVCe
        zUSwQTznY70m57/LJe1co2UfQUQnlmQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-3hQRyorcO7OhJPm1kKzLrw-1; Mon, 13 Jun 2022 11:44:02 -0400
X-MC-Unique: 3hQRyorcO7OhJPm1kKzLrw-1
Received: by mail-wm1-f70.google.com with SMTP id k15-20020a7bc40f000000b0039c4b7f7d09so3385040wmi.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=oeK3BFcDjZ1AnYOq+FMGXhylJkvr/lrSWSvcbsIlUS4=;
        b=Z5vA5+ov1tZmj6Sgc1oTz/p3dGrKR9xzhB4DD8VglF3QYRvzg95H/bqOjtNUvPSG0g
         DY00EYOB0+b/RLlIfVB2c1vAQfBTqg8ZEXfLDPBEe8BEgP6EOuPxLHc13Vh6IKyQgVYL
         eqm6sS/RH8qsIRSP4hpi9aykVWg2O3ETSGzvaUa7oUlkuphpj4eoZBRuKg8vNtw7TRbL
         TNJ2rsWUx+GHkDhbDIQGGC+CpwtDVfiu3x4Vtw0O6YiDpp89aOK1o7UpXKKDCpGztCIh
         lLnJeeghBw+gSJdr+XtUUWghvIQeGGScVGlsVSAN4uHfKs2JmXy4pQanN0fYZQLTGr7T
         SXZQ==
X-Gm-Message-State: AJIora/PMUYT6SO8hvLfevMMd91v2xPH6hcuyJimwQJdVpdfrA1wkiw2
        8QYiCKDzmmYX+B/mkeQqpTxt7EY8iOmTBOXX6d4WhJSpDDPXMGKWGAmzH3KBNJ5ZurCO4DZsMfB
        xZLk45f2FtLkKJ4v7AvvcbNWQ
X-Received: by 2002:adf:ecce:0:b0:219:e5a7:64a8 with SMTP id s14-20020adfecce000000b00219e5a764a8mr493360wro.278.1655135040390;
        Mon, 13 Jun 2022 08:44:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tRjfskr6PEaDYRe4I9B1t8zXM5Oc3051P05GSjpoCuJIeMq5V5pHRA1qUCjTJC/99IbGcYyQ==
X-Received: by 2002:adf:ecce:0:b0:219:e5a7:64a8 with SMTP id s14-20020adfecce000000b00219e5a764a8mr493338wro.278.1655135040161;
        Mon, 13 Jun 2022 08:44:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:bd00:963c:5455:c10e:fa6f? (p200300cbc706bd00963c5455c10efa6f.dip0.t-ipconnect.de. [2003:cb:c706:bd00:963c:5455:c10e:fa6f])
        by smtp.gmail.com with ESMTPSA id o19-20020a1c4d13000000b0039c60e33702sm9697655wmh.16.2022.06.13.08.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 08:43:59 -0700 (PDT)
Message-ID: <96894c79-1201-e8b8-a49d-b83ae4765f9d@redhat.com>
Date:   Mon, 13 Jun 2022 17:43:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mm: Remove unwanted initialization in
 vmemmap_populate_compound_pages()
Content-Language: en-US
To:     Gautam Menghani <gautammenghani201@gmail.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220612182320.160651-1-gautammenghani201@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220612182320.160651-1-gautammenghani201@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.06.22 20:23, Gautam Menghani wrote:
> Remove unwanted initialization for the variable 'next'. This fixes the
> clang scan warning: Value stored to 'next' during its initialization is 
> never read [deadcode.DeadStores]
> 

Nit: s/unwanted/unnecessary/

Reviewed-by: David Hildenbrand <david@redhat.com>

> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> ---
>  mm/sparse-vmemmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index f4fa61dbbee3..3008aa7859e0 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -737,7 +737,7 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
>  
>  	size = min(end - start, pgmap_vmemmap_nr(pgmap) * sizeof(struct page));
>  	for (addr = start; addr < end; addr += size) {
> -		unsigned long next = addr, last = addr + size;
> +		unsigned long next, last = addr + size;
>  
>  		/* Populate the head page vmemmap page */
>  		pte = vmemmap_populate_address(addr, node, NULL, NULL);


-- 
Thanks,

David / dhildenb

