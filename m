Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232AA54DB90
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359274AbiFPHam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiFPHak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00E394FC6A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655364638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zuRC3QccXxRzfGRljGSr16hxfuV9e3Vmw7qffLvndzs=;
        b=RdNnR0O12rsEe4SFrq0Mq8bvhBnepTDm5mdA8f5qyMmWieaG7hv+Dml8lQvzCSpAiMqa+f
        3gA5rhLilR2mbQ3dGa4mKr/ZvoGIqTs4sAPNVuhsnyoFbXd9gFzpEQ9R/c/qNole29ek+S
        QRk8UCFs9t15LfA1vglMX/Lt9Kce99o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-nnT0Hl64OFWV2hUyrLTNuQ-1; Thu, 16 Jun 2022 03:30:37 -0400
X-MC-Unique: nnT0Hl64OFWV2hUyrLTNuQ-1
Received: by mail-wm1-f71.google.com with SMTP id i83-20020a1c3b56000000b0039db971c6d9so707185wma.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 00:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=zuRC3QccXxRzfGRljGSr16hxfuV9e3Vmw7qffLvndzs=;
        b=Yjk0VTAIYYQj3pW+id1g4FAZBZ91K/MFZHdSlUNrOdGOO/NDUDyiXrR/OnJDxvAWkA
         xoL9cjUPlC+Nco2fF1Ix3boRW0kmpd4lAwJuCm87WnNpsr3KgXdwwNqj+nVPhcavrrf0
         1CD9GbLBjpIMAJ7CS0YRCtpyCbWVDDmN+05KtH4uhUCjaOo59UJ4g1i5mzko5+toEfTB
         PJjLyUC9toV9OYAEVwg31Rncu58jxDtmpz2xEZ7a510zTQh6NSnRj7WY1Q/O2nrpcTwe
         6OicDWmQRUt+ocbHjnGJV6Irv0MpWYFJK9xqFSMzQeKcpzRhmpdLXAv+Lj+PDTPx9OuB
         0oRw==
X-Gm-Message-State: AOAM53137vzI//NRmc/Cuf9PIlRhfvjeCC+3F17fxzZ7fv9gjE8IHUJA
        vTip0UqKp0LZBByePjDv0lev2EV6szyobyLhLPffARTDWkfs12an/RJ+clvzQqhFwMFgAfOwBxq
        rXNBMgLXrTMtaCXCLR2DKPXEO
X-Received: by 2002:a05:600c:3b0c:b0:39c:7d91:26d0 with SMTP id m12-20020a05600c3b0c00b0039c7d9126d0mr13930619wms.40.1655364636012;
        Thu, 16 Jun 2022 00:30:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIqXcd+owz/Nw3PZPl47b6RVBaa+MlNHu4dEkb1E0vRUO+EQbYgm/GgBLVh8yOGJ5FIcuzEA==
X-Received: by 2002:a05:600c:3b0c:b0:39c:7d91:26d0 with SMTP id m12-20020a05600c3b0c00b0039c7d9126d0mr13930591wms.40.1655364635744;
        Thu, 16 Jun 2022 00:30:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:2d00:73d7:5fab:cc8a:e48c? (p200300cbc70b2d0073d75fabcc8ae48c.dip0.t-ipconnect.de. [2003:cb:c70b:2d00:73d7:5fab:cc8a:e48c])
        by smtp.gmail.com with ESMTPSA id s16-20020a5d4250000000b0020e5b4ebaecsm1057997wrr.4.2022.06.16.00.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 00:30:35 -0700 (PDT)
Message-ID: <24d5ec20-9c9e-93aa-11f4-c4619f51f7d1@redhat.com>
Date:   Thu, 16 Jun 2022 09:30:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mike.kravetz@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220520025538.21144-1-songmuchun@bytedance.com>
 <20220520025538.21144-3-songmuchun@bytedance.com>
 <53024884-0182-df5f-9ca2-00652c64ce36@redhat.com>
 <YqqqPjkh9r8ZrH0r@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/2] mm: memory_hotplug: introduce
 SECTION_CANNOT_OPTIMIZE_VMEMMAP
In-Reply-To: <YqqqPjkh9r8ZrH0r@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.22 05:57, Oscar Salvador wrote:
> On Wed, Jun 15, 2022 at 11:51:49AM +0200, David Hildenbrand wrote:
>> An easier/future-proof approach might simply be flagging the vmemmap
>> pages as being special. We reuse page flags for that, which don't have
>> semantics yet (i.e., PG_reserved indicates a boot-time allocation via
>> memblock).
> 
> The first versions of memmap_on_memory [1] introduced a new page type
> to represent such pages, not sure if that is what you mean, e.g:
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index f91cb8898ff0..75f302a532f9 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -708,6 +708,7 @@  PAGEFLAG_FALSE(DoubleMap)
>  #define PG_kmemcg	0x00000200
>  #define PG_table	0x00000400
>  #define PG_guard	0x00000800
> +#define PG_vmemmap     0x00001000
>  
>  #define PageType(page, flag)						\
>  	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
> @@ -764,6 +765,24 @@  PAGE_TYPE_OPS(Table, table)
>   */
>  PAGE_TYPE_OPS(Guard, guard)
>  
> +/*
> + * Vmemmap pages refers to those pages that are used to create the memmap
> + * array, and reside within the same memory range that was hotppluged, so
> + * they are self-hosted. (see include/linux/memory_hotplug.h)
> + */
> +PAGE_TYPE_OPS(Vmemmap, vmemmap)
> +static __always_inline void SetPageVmemmap(struct page *page)
> +{
> +	__SetPageVmemmap(page);
> +	__SetPageReserved(page);
> +}
> +
> +static __always_inline void ClearPageVmemmap(struct page *page)
> +{
> +	__ClearPageVmemmap(page);
> +	__ClearPageReserved(page);
> +}
> 
> [1] https://patchwork.kernel.org/project/linux-mm/patch/20190725160207.19579-3-osalvador@suse.de/

IIRC, that was used to skip these patches on the offlining path before
we provided the ranges to offline_pages().

I'd not mess with PG_reserved, and give them a clearer name, to not
confuse them with other, ordinary, vmemmap pages that are not
self-hosted (maybe in the future we might want to flag all vmemmap pages
with a new type?).

I'd just try reusing the flag PG_owner_priv_1. And eventually, flag all
(v)memmap pages with a type PG_memmap. However, the latter would be
optional and might not be strictly required


So what think could make sense is

/* vmemmap pages that are self-hosted and cannot be optimized/freed. */
PG_vmemmap_self_hosted = PG_owner_priv_1,

-- 
Thanks,

David / dhildenb

