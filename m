Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E19A4F11A2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349305AbiDDJGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbiDDJGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:06:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B8DF14001
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:04:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A66521FB;
        Mon,  4 Apr 2022 02:04:47 -0700 (PDT)
Received: from [10.163.37.159] (unknown [10.163.37.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02B453F718;
        Mon,  4 Apr 2022 02:04:41 -0700 (PDT)
Message-ID: <a4df1a4d-79b6-5a69-77a2-df9a36653c89@arm.com>
Date:   Mon, 4 Apr 2022 14:35:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/2] mm: hugetlb_vmemmap: introduce
 ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, will@kernel.org,
        akpm@linux-foundation.org, david@redhat.com, bodeddub@amazon.com,
        osalvador@suse.de, mike.kravetz@oracle.com, rientjes@google.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, james.morse@arm.com,
        21cnbao@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com
References: <20220331065640.5777-1-songmuchun@bytedance.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220331065640.5777-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/22 12:26, Muchun Song wrote:
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

Better to have platforms subscribe via ARCH_HAS/WANTS_ method instead
of direct dependency in the config itself.

LGTM.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
