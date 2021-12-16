Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BD7476F57
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbhLPK7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:59:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236325AbhLPK7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639652378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s76g13VAQrDlOMeq5fB7a7dvYqJ8oE5IJBNwESalkaA=;
        b=eVPJcYRk0Z3PASzRU7HM+Ctufu9McwkH3ZsKQFt258TH1BlXrC178HrLlgmi8+rTcvadst
        h87tMQsj8Bp9kyYhjwQgw6OI5B7Qzj7GhxhankbekAbkVo/WoB3ltIzclO2T42teCEem7a
        bCx0NdFZSfryqrG6oddhRtiyV9L0tzo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-3qA_JUl-MryVcDrenOhRHA-1; Thu, 16 Dec 2021 05:59:37 -0500
X-MC-Unique: 3qA_JUl-MryVcDrenOhRHA-1
Received: by mail-wm1-f69.google.com with SMTP id j25-20020a05600c1c1900b00332372c252dso10142881wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:59:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=s76g13VAQrDlOMeq5fB7a7dvYqJ8oE5IJBNwESalkaA=;
        b=v+P0SlTRxrl1Zv37g4W/IlCk/KXDQerYFRDDVH/MYda3wr455isotpvTviiHn/F8QO
         2NjLf/fmY9uo46gv/x9hGBiG/1GIC6Y1d+zHwzdxfYmf7h0qNdAUSlC9YzXU6w9Z5SyT
         c2VlfvHKy+C6yzdOq+AE/W61zUK9oBzPv5YK39LXuEwee34WJUw/VY04idPrYERsAQpS
         7s4DM9KNC4HxoFYomM//C/29RrLGFjzGRbqtdy4XzCj3mND+j1gEz28sthG2MVWb5IeZ
         RJC20PAU86Ljx0d4ma5nYSh+MmIuWowQtrRJoRa4AO+xWLLF8s3MPgVLCgz6Vy1BVtPG
         u4iA==
X-Gm-Message-State: AOAM5308IRprTMWwMKV/f5ZdOvVZjRniMcqOaNWHWQEcGIbhc38IFguE
        wsIDlPXt50s8ExQlx8oMbNR8/fh0FmOF9m5RB2n43P1fHLIY+0XJiuFS/Urtp5bP2OIeuRDFh6M
        WqMKBATt+QolDnGdTl5dJD7Ae
X-Received: by 2002:a5d:668a:: with SMTP id l10mr2800111wru.654.1639652375992;
        Thu, 16 Dec 2021 02:59:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVTM3ooac/KjBJvvCxDuZNDeVAKjan8Vqxw5Yp4wLCioEnSjfh+evTOVB8nPQn7Y58gOBl/Q==
X-Received: by 2002:a5d:668a:: with SMTP id l10mr2800100wru.654.1639652375774;
        Thu, 16 Dec 2021 02:59:35 -0800 (PST)
Received: from [192.168.3.132] (p4ff23dcd.dip0.t-ipconnect.de. [79.242.61.205])
        by smtp.gmail.com with ESMTPSA id a198sm4254051wmd.42.2021.12.16.02.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 02:59:35 -0800 (PST)
Message-ID: <9652ae2a-2b40-36f9-4668-4c0cbd89862d@redhat.com>
Date:   Thu, 16 Dec 2021 11:59:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mm/page_alloc: Modify the comment section for
 alloc_contig_pages()
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1639545478-12160-1-git-send-email-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1639545478-12160-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.12.21 06:17, Anshuman Khandual wrote:
> Just clarify, that the alloc_contig_pages() allocated range will always be
> aligned to the requested nr_pages.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  mm/page_alloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c5952749ad40..0d74ea524dd4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -9214,8 +9214,8 @@ static bool zone_spans_last_pfn(const struct zone *zone,
>   * for allocation requests which can not be fulfilled with the buddy allocator.
>   *
>   * The allocated memory is always aligned to a page boundary. If nr_pages is a
> - * power of two then the alignment is guaranteed to be to the given nr_pages
> - * (e.g. 1GB request would be aligned to 1GB).
> + * power of two, then allocated range is also guaranteed to be aligned to same
> + * nr_pages (e.g. 1GB request would be aligned to 1GB).
>   *
>   * Allocated pages can be freed with free_contig_range() or by manually calling
>   * __free_page() on each allocated page.
> 

To me new vs. old express exactly the same. But it might be an
improvement so I won't object :)

-- 
Thanks,

David / dhildenb

