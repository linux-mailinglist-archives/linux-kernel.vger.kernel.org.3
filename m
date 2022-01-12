Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161B348C0D9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351997AbiALJRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:17:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50612 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238051AbiALJRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641979072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e0KOzwrUqCbQH/o01fWrMq8CbrmFNeed7/005+0tTSM=;
        b=H59MAF8k/pVuuEPySGSp8cyqmuVoDAH4//yDHVVy8EQeNlH7NCcRSPbqbyK0CggISTdfEI
        leRKYNF2fM5kh3qYtYZ/On6GZVH90syIE8wToW3wMXoh4HeUECO9RKRWGQHlqjUh0UdP1o
        6LhPbzvD0myQ8sfbimckFOAh+uPuH7M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-Z8eCPqBmMeufg8GdZRWPIg-1; Wed, 12 Jan 2022 04:17:51 -0500
X-MC-Unique: Z8eCPqBmMeufg8GdZRWPIg-1
Received: by mail-ed1-f70.google.com with SMTP id z9-20020a05640240c900b003fea688a17eso1711578edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 01:17:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=e0KOzwrUqCbQH/o01fWrMq8CbrmFNeed7/005+0tTSM=;
        b=41GP4buNq7aa+ImzRB/tVjPW8DUZhHkezBYLNylY8JsY4t+00QJWtXP9z5+vE/fcbV
         U1kR+ovZGLFA0hpylywszqTqGj92SDQ79cDEsl2nGdzLsDhiv+kienyCiUhyXnCgHOMa
         ZtzLBxMTnkeVtcTCknSMP8YPFmSdZZtFoKB0mbFXx06vkVIQyr1dzN5lby8ACnuQXb5Q
         JfikQEq/Qbaac1bkiRq7qY1+6/c5JPoWazb0UsJnFdM+9E1JLMI03f1i23EIefkNvYcG
         BGVbajou+H4yKgXKNjMa0H8YFWvvphX0xzQCE8I1FVtDJ9QUzFW8fSSp0Y4Yz6NKrBBK
         HB1Q==
X-Gm-Message-State: AOAM532AjNx3rry/ZIkR45Wz9rFqrorE8bwvDjXirj6SH4NP0N3OxibH
        I9thtNHl3YEoSdTXKQ7riFri3q4wiePJGOrmFDNSsdKZOBCS2rIFtz60UkBbN+nWvCodX8c5ebS
        p3Dn2EEQ5hqYtDT8Ac9ilGXY3
X-Received: by 2002:a17:907:3f0c:: with SMTP id hq12mr6821389ejc.358.1641979069881;
        Wed, 12 Jan 2022 01:17:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOD9iPR7HXlJWokCcL1fccdXMM8E7I6wuS9gOcKt0Yc+oOkHcqTjYDlSTOto/CciTFEAMyvw==
X-Received: by 2002:a17:907:3f0c:: with SMTP id hq12mr6821377ejc.358.1641979069698;
        Wed, 12 Jan 2022 01:17:49 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:4700:e25f:39eb:3cb8:1dec? (p200300cbc7024700e25f39eb3cb81dec.dip0.t-ipconnect.de. [2003:cb:c702:4700:e25f:39eb:3cb8:1dec])
        by smtp.gmail.com with ESMTPSA id i22sm4360577ejw.75.2022.01.12.01.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 01:17:49 -0800 (PST)
Message-ID: <af52b95b-dab3-a5d5-0e31-f7e91b16e556@redhat.com>
Date:   Wed, 12 Jan 2022 10:17:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm/thp: Drop unused trace events
 hugepage_[invalidate|splitting]
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org
References: <1641546351-15109-1-git-send-email-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1641546351-15109-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.01.22 10:05, Anshuman Khandual wrote:
> The trace events hugepage_[invalidate|splitting], were added via the commit
> 9e813308a5c1 ("powerpc/thp: Add tracepoints to track hugepage invalidate").
> Afterwards their call sites i.e trace_hugepage_[invalidate|splitting] were
> just dropped off, leaving these trace points unused.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v5.16-rc8
> 
> trace_hugepage_splitting() dropped via the commit 7aa9a23c69ea
> trace_hugepage_invalidate() dropped via the commit 7900757ce1b4
> 
>  include/trace/events/thp.h | 36 ------------------------------------
>  1 file changed, 36 deletions(-)
> 
> diff --git a/include/trace/events/thp.h b/include/trace/events/thp.h
> index d7fbbe551841..ffa4b37d02a9 100644
> --- a/include/trace/events/thp.h
> +++ b/include/trace/events/thp.h
> @@ -8,24 +8,6 @@
>  #include <linux/types.h>
>  #include <linux/tracepoint.h>
>  
> -TRACE_EVENT(hugepage_invalidate,
> -
> -	    TP_PROTO(unsigned long addr, unsigned long pte),
> -	    TP_ARGS(addr, pte),
> -	    TP_STRUCT__entry(
> -		    __field(unsigned long, addr)
> -		    __field(unsigned long, pte)
> -		    ),
> -
> -	    TP_fast_assign(
> -		    __entry->addr = addr;
> -		    __entry->pte = pte;
> -		    ),
> -
> -	    TP_printk("hugepage invalidate at addr 0x%lx and pte = 0x%lx",
> -		      __entry->addr, __entry->pte)
> -);
> -
>  TRACE_EVENT(hugepage_set_pmd,
>  
>  	    TP_PROTO(unsigned long addr, unsigned long pmd),
> @@ -65,24 +47,6 @@ TRACE_EVENT(hugepage_update,
>  
>  	    TP_printk("hugepage update at addr 0x%lx and pte = 0x%lx clr = 0x%lx, set = 0x%lx", __entry->addr, __entry->pte, __entry->clr, __entry->set)
>  );
> -TRACE_EVENT(hugepage_splitting,
> -
> -	    TP_PROTO(unsigned long addr, unsigned long pte),
> -	    TP_ARGS(addr, pte),
> -	    TP_STRUCT__entry(
> -		    __field(unsigned long, addr)
> -		    __field(unsigned long, pte)
> -		    ),
> -
> -	    TP_fast_assign(
> -		    __entry->addr = addr;
> -		    __entry->pte = pte;
> -		    ),
> -
> -	    TP_printk("hugepage splitting at addr 0x%lx and pte = 0x%lx",
> -		      __entry->addr, __entry->pte)
> -);
> -
>  #endif /* _TRACE_THP_H */
>  
>  /* This part must be outside protection */

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

