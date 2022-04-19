Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBDD5068A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350629AbiDSKY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbiDSKY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:24:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61163237FE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:22:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1555D23A;
        Tue, 19 Apr 2022 03:22:14 -0700 (PDT)
Received: from [10.163.40.223] (unknown [10.163.40.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4DDA3F73B;
        Tue, 19 Apr 2022 03:22:05 -0700 (PDT)
Message-ID: <073cb6a6-3dbc-75d4-dbfe-a5299a6b0510@arm.com>
Date:   Tue, 19 Apr 2022 15:52:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next v4 3/4] arm64: mm: add support for page table check
Content-Language: en-US
To:     Tong Tiangen <tongtiangen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
References: <20220418034444.520928-1-tongtiangen@huawei.com>
 <20220418034444.520928-4-tongtiangen@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220418034444.520928-4-tongtiangen@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/18/22 09:14, Tong Tiangen wrote:
> +#ifdef CONFIG_PAGE_TABLE_CHECK
> +static inline bool pte_user_accessible_page(pte_t pte)
> +{
> +	return pte_present(pte) && (pte_user(pte) || pte_user_exec(pte));
> +}
> +
> +static inline bool pmd_user_accessible_page(pmd_t pmd)
> +{
> +	return pmd_present(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
> +}
> +
> +static inline bool pud_user_accessible_page(pud_t pud)
> +{
> +	return pud_present(pud) && pud_user(pud);
> +}
> +#endif
Wondering why check for these page table entry states when init_mm
has already being excluded ? Should not user page tables be checked
for in entirety for all updates ? what is the rationale for filtering
out only pxx_user_access_page entries ?
