Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420DF4DCE4C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbiCQTBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbiCQTBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:01:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D23916BCF7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 12:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED87D617B7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4176C340E9;
        Thu, 17 Mar 2022 19:00:08 +0000 (UTC)
Date:   Thu, 17 Mar 2022 19:00:04 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH -next 3/4] arm64: mm: add support for page table check
Message-ID: <YjOFNEvj7EfBasCI@arm.com>
References: <20220317141203.3646253-1-tongtiangen@huawei.com>
 <20220317141203.3646253-4-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317141203.3646253-4-tongtiangen@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 02:12:02PM +0000, Tong Tiangen wrote:
> @@ -628,6 +647,25 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>  #define pud_leaf(pud)		pud_sect(pud)
>  #define pud_valid(pud)		pte_valid(pud_pte(pud))
>  
> +#ifdef CONFIG_PAGE_TABLE_CHECK
> +static inline bool pte_user_accessible_page(pte_t pte)
> +{
> +	return (pte_val(pte) & PTE_VALID) && (pte_val(pte) & PTE_USER);
> +}

There is another class of user mappings, execute-only, that have both
PTE_USER and PTE_UXN cleared. So this logic should be:

	pte_valid(pte) && (pte_user(pte) || pte_user_exec(pte))

with pte_user() as:

#define pte_user(pte)	(!!(pte_val(pte) & PTE_USER))

Do we care about PROT_NONE mappings here? They have the valid bit
cleared but pte_present() is true.

> +static inline bool pmd_user_accessible_page(pmd_t pmd)
> +{
> +	return pmd_leaf(pmd) && (pmd_val(pmd) & PTE_VALID) &&
> +		(pmd_val(pmd) & PTE_USER);
> +}

pmd_leaf() implies valid, so you can skip it if that's the aim.

Similar comment to the pte variant on execute-only and PROT_NONE
mappings.

-- 
Catalin
