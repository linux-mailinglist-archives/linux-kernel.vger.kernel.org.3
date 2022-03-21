Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F224E2E42
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351328AbiCUQmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244448AbiCUQmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:42:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7CD6CA72
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:41:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6646EB818A0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22EFC340F0;
        Mon, 21 Mar 2022 16:41:03 +0000 (UTC)
Date:   Mon, 21 Mar 2022 16:40:59 +0000
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
Message-ID: <Yjiqm6tQB5To5Jd9@arm.com>
References: <20220317141203.3646253-1-tongtiangen@huawei.com>
 <20220317141203.3646253-4-tongtiangen@huawei.com>
 <YjOFNEvj7EfBasCI@arm.com>
 <cb91532b-c0cd-034c-2f93-4f76fabf5fc1@huawei.com>
 <YjS+2FVpq8D4Gx0S@arm.com>
 <d3006048-f737-439e-b985-cfbab69c4167@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3006048-f737-439e-b985-cfbab69c4167@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 02:15:36PM +0800, Tong Tiangen wrote:
> Considering all your suggestions, The final logic should be:
> 
> +#define pte_user(pte)          (!!(pte_val(pte) & PTE_USER))
> 
> +#define pmd_user(pmd)		pte_user(pmd_pte(pmd))
> +#define pmd_user_exec(pmd)	pte_user_exec(pmd_pte(pmd))
> 
> +#define pud_user(pud)          pte_user(pud_pte(pud))
> 
> +static inline bool pte_user_accessible_page(pte_t pte)
> +{
> +	return pte_present(pte) && (pte_user(pte)|| pte_user_exec(pte));
> +}

This is fine.

> +static inline bool pmd_user_accessible_page(pmd_t pmd)
> +{
> +	return pmd_present(pmd) && (pmd_user(pmd)|| pmd_user_exec(pmd));
> +}

That's fine as well assuming that the function is only called on the
set_pmd_at() path where we know that the pmd would be a block mapping
(huge page). I think that's the case from a quick look at the current
x86 implementation.

> +static inline bool pud_user_accessible_page(pud_t pud)
> +{
> +	return pud_present(pud) && pud_user(pud);
> +}

Same here.

-- 
Catalin
