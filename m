Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C774FB922
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345164AbiDKKOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbiDKKOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:14:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2311A41FBE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:12:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAA64169C;
        Mon, 11 Apr 2022 03:12:28 -0700 (PDT)
Received: from [192.168.225.160] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C03F63F5A1;
        Mon, 11 Apr 2022 03:12:22 -0700 (PDT)
Message-ID: <5b27aa62-da2b-e19d-3378-be5102ebebb6@arm.com>
Date:   Mon, 11 Apr 2022 15:42:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] arm64: mm: hugetlb: Enable
 HUGETLB_PAGE_FREE_VMEMMAP for arm64
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
 <20220331065640.5777-2-songmuchun@bytedance.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220331065640.5777-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/22 12:26, Muchun Song wrote:
> --- a/arch/arm64/mm/flush.c
> +++ b/arch/arm64/mm/flush.c
> @@ -68,6 +68,19 @@ EXPORT_SYMBOL_GPL(__sync_icache_dcache);
>   */
>  void flush_dcache_page(struct page *page)
>  {
> +	/*
> +	 * Only the head page's flags of HugeTLB can be cleared since the tail
> +	 * vmemmap pages associated with each HugeTLB page are mapped with
> +	 * read-only when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is enabled (more
> +	 * details can refer to vmemmap_remap_pte()).  Although

Did you see real permission fault when flush_dcache_page() accessed remapped
tail pages, with readonly vmemmap ? OR this change is from code inspection ?

> +	 * __sync_icache_dcache() only set PG_dcache_clean flag on the head
> +	 * page struct, some tail page structs still can be seen the flag is

Sentence here needs restructuring ....               ^^^^^^^^^^^^^^^^^^
 
> +	 * set since the head vmemmap page frame is reused (more details can
> +	 * refer to the comments above page_fixed_fake_head()).
> +	 */
> +	if (hugetlb_free_vmemmap_enabled() && PageHuge(page))
> +		page = compound_head(page);

This should also be applicable to any other platform with both configs enabled
i.e ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE and ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP ?
If yes, then how to ensure that the platforms change flush_dcache_page() before
subscribing into ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP ?

> +
>  	if (test_bit(PG_dcache_clean, &page->flags))
>  		clear_bit(PG_dcache_clean, &page->flags);
>  }
