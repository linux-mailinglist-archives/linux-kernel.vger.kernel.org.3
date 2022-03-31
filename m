Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACE84ED5FD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiCaIoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiCaIoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60AEE1F1249
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648716136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8O7P4V32LmLKx1/fyryDQWDDIa4z/qPMVAMMY5dYyBQ=;
        b=fwSAFIkwTjUptP6NbC637pJcQbm8Pm8RR+QW6Woo0zvn5LOsB8zJ58RvomqWYR0fvDdL7b
        VTu0wvvRKDN+zHxvipl/XlQ0e1ke5izDtdytBZ5RmR5aMrap6P+AkgZ54HsFvAbJCx+eaw
        GdRdzUd4OQQb7z8orrM/bvoqmYNQNvo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-E2eYrzdiOXCxIATNAhTjQw-1; Thu, 31 Mar 2022 04:42:15 -0400
X-MC-Unique: E2eYrzdiOXCxIATNAhTjQw-1
Received: by mail-wr1-f70.google.com with SMTP id i64-20020adf90c6000000b00203f2b5e090so6279786wri.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=8O7P4V32LmLKx1/fyryDQWDDIa4z/qPMVAMMY5dYyBQ=;
        b=E/9rsJ2wyjhrh1I22qqmqa2jluyxjv4lrBpjVOFOxLgiRmpiZFxiQI7LNPOVO4yvKk
         jTnozjxefcZTF+g1Vy3BSu9no7nqKZdG7VsQxXAHypGEO4GnS8h4pattKS97HQlWOR6u
         UYBZED0f8vlxQzgsZGxgrt2pNWgLtKvJmwKK/fVzNav+sazShuBhquYfH3q9l0/APAhC
         cx2xgRqt/M/kjtQ7EZnGdSMwYKinz4TqNv7LvZNXt1a5nSpbVvfwiz13D8Wp33t0E9hc
         nJKttIMNg07w4ttqIu6scCLRt1cWHRyW7D8JZGdG/CWBC6Kvu/jb61uHc8zM6b5iS0k6
         5rPw==
X-Gm-Message-State: AOAM532w3tzE/rAWmG8bwfh/UUwV0vCZ7HTZi2o0f+xgEtYzjbqMctYk
        1JaOqPNxJBis4bw/W/ShBAUogD84eZYPcf3TFJN5udPgBDnK9KP3j8iJwP0PvEqU3wU2m2IAA/S
        /erdCi1Xw/GdtIaIg449LHrwO
X-Received: by 2002:adf:ef50:0:b0:204:3be:aaa0 with SMTP id c16-20020adfef50000000b0020403beaaa0mr3308615wrp.632.1648716133769;
        Thu, 31 Mar 2022 01:42:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzjvWfhy26tdh9LbPeR/3J64W85TY6O95IiKd5tQtgVqbXVualxL5wjcfLbfWcZcWN0wgW5Q==
X-Received: by 2002:adf:ef50:0:b0:204:3be:aaa0 with SMTP id c16-20020adfef50000000b0020403beaaa0mr3308583wrp.632.1648716133302;
        Thu, 31 Mar 2022 01:42:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:ac00:381c:2e8b:3b48:488e? (p200300cbc707ac00381c2e8b3b48488e.dip0.t-ipconnect.de. [2003:cb:c707:ac00:381c:2e8b:3b48:488e])
        by smtp.gmail.com with ESMTPSA id u11-20020a056000038b00b00203e5c9aa09sm28212335wrf.27.2022.03.31.01.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 01:42:12 -0700 (PDT)
Message-ID: <6c774e27-26d2-6c45-65f9-8a5b8acd6433@redhat.com>
Date:   Thu, 31 Mar 2022 10:42:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v4 1/2] mm: hugetlb_vmemmap: introduce
 ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, will@kernel.org,
        akpm@linux-foundation.org, bodeddub@amazon.com, osalvador@suse.de,
        mike.kravetz@oracle.com, rientjes@google.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, james.morse@arm.com, 21cnbao@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com
References: <20220331065640.5777-1-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220331065640.5777-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.03.22 08:56, Muchun Song wrote:
> The feature of minimizing overhead of struct page associated with each
> HugeTLB page is implemented on x86_64, however, the infrastructure of
> this feature is already there, we could easily enable it for other
> architectures.  Introduce ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP for other
> architectures to be easily enabled.  Just select this config if they
> want to enable this feature.
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/x86/Kconfig |  1 +
>  fs/Kconfig       | 10 +++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 9f5bd41bf660..e69d42528542 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -119,6 +119,7 @@ config X86
>  	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
>  	select ARCH_WANTS_NO_INSTR
>  	select ARCH_WANT_HUGE_PMD_SHARE
> +	select ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP	if X86_64
>  	select ARCH_WANT_LD_ORPHAN_WARN
>  	select ARCH_WANTS_THP_SWAP		if X86_64
>  	select ARCH_HAS_PARANOID_L1D_FLUSH
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 6c7dc1387beb..f6db2af33738 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -245,9 +245,17 @@ config HUGETLBFS
>  config HUGETLB_PAGE
>  	def_bool HUGETLBFS
>  
> +#
> +# Select this config option from the architecture Kconfig, if it is preferred
> +# to enable the feature of minimizing overhead of struct page associated with
> +# each HugeTLB page.
> +#
> +config ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
> +	bool
> +
>  config HUGETLB_PAGE_FREE_VMEMMAP
>  	def_bool HUGETLB_PAGE
> -	depends on X86_64
> +	depends on ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
>  	depends on SPARSEMEM_VMEMMAP
>  
>  config HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON


I think something like "HUGETLB_OPTIMIZE_VMEMMAP" might be more
expressive, but that would imply renaming the existing config knob.

Apart from that LGTM.

-- 
Thanks,

David / dhildenb

