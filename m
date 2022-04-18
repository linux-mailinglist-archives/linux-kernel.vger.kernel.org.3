Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47568504C79
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 08:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiDRGOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 02:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiDRGOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 02:14:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483A217A8C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 23:12:14 -0700 (PDT)
Received: from kwepemi100002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Khc3B69nnzFptq;
        Mon, 18 Apr 2022 14:09:42 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100002.china.huawei.com (7.221.188.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 14:12:11 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 14:12:10 +0800
Message-ID: <0b023809-8138-a44f-83e2-db54a7446954@huawei.com>
Date:   Mon, 18 Apr 2022 14:12:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v4 0/4]mm: page_table_check: add support on arm64
 and riscv
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
References: <20220418034444.520928-1-tongtiangen@huawei.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20220418034444.520928-1-tongtiangen@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Catalin, Palmer:

This patch modifies the code related to the mm/x86/arm64/riscv, who can 
help me merge it if no object, Maybe Andrew is more appropriate?

Thanks,
Tong.

在 2022/4/18 11:44, Tong Tiangen 写道:
> Page table check performs extra verifications at the time when new
> pages become accessible from the userspace by getting their page
> table entries (PTEs PMDs etc.) added into the table. It is supported
> on X86[1].
> 
> This patchset made some simple changes and make it easier to support
> new architecture, then we support this feature on ARM64 and RISCV.
> 
> [1]https://lore.kernel.org/lkml/20211123214814.3756047-1-pasha.tatashin@soleen.com/
> 
> v3 -> v4:
>   1. Adapt to next-20220414
> 
> v2 -> v3:
>    1. Modify ptep_clear() in include/linux/pgtable.h, using IS_ENABLED
>       according to the suggestions of Pasha.
> 
> v1 -> v2:
>    1. Fix arm64's pte/pmd/pud_user_accessible_page() according to the
>       suggestions of Catalin.
>    2. Also fix riscv's pte_pmd_pud_user_accessible_page().
> 
> Kefeng Wang (2):
>    mm: page_table_check: move pxx_user_accessible_page into x86
>    arm64: mm: add support for page table check
> 
> Tong Tiangen (2):
>    mm: page_table_check: add hooks to public helpers
>    riscv: mm: add support for page table check
> 
>   arch/arm64/Kconfig               |  1 +
>   arch/arm64/include/asm/pgtable.h | 65 ++++++++++++++++++++++++---
>   arch/riscv/Kconfig               |  1 +
>   arch/riscv/include/asm/pgtable.h | 77 +++++++++++++++++++++++++++++---
>   arch/x86/include/asm/pgtable.h   | 29 +++++++-----
>   include/linux/pgtable.h          | 26 +++++++----
>   mm/page_table_check.c            | 25 ++++-------
>   7 files changed, 178 insertions(+), 46 deletions(-)
> 
