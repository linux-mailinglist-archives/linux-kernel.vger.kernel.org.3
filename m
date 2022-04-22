Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C815350AF40
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 06:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443986AbiDVEsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 00:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiDVEsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 00:48:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0517183B6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 21:45:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 586821570;
        Thu, 21 Apr 2022 21:45:38 -0700 (PDT)
Received: from [10.163.40.48] (unknown [10.163.40.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEC4F3F5A1;
        Thu, 21 Apr 2022 21:45:30 -0700 (PDT)
Message-ID: <17625223-cc3d-d62a-57db-f7bb5274369f@arm.com>
Date:   Fri, 22 Apr 2022 10:16:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next v5 1/5] mm: page_table_check: using PxD_SIZE instead
 of PxD_PAGE_SIZE
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-riscv@lists.infradead.org, Guohanjun <guohanjun@huawei.com>
References: <20220421082042.1167967-1-tongtiangen@huawei.com>
 <20220421082042.1167967-2-tongtiangen@huawei.com>
 <CA+CK2bCWRL_vXW1BUhxb-zLiywXTCQdaa+9feEwQytYW=K46-g@mail.gmail.com>
 <bbd67c4e-6adf-dc1f-7104-427e3e598d9a@soleen.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <bbd67c4e-6adf-dc1f-7104-427e3e598d9a@soleen.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/22 00:10, Pasha Tatashin wrote:
> On 4/21/22 11:28, Pasha Tatashin wrote:
>> On Thu, Apr 21, 2022 at 4:02 AM Tong Tiangen <tongtiangen@huawei.com> wrote:
>>> Macro PUD_SIZE/PMD_SIZE is more general in various architectures. Using
>>> PUD_SIZE/PMD_SIZE instead of PUD_PAGE_SIZE/PMD_PAGE_SIZE can better
>>> support page table check in architectures other than x86 and it is no
>>> functional impact on x86.
>>>
>>> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
>> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> To avoid similar problems in the future, please also include the following patch after the current series:
> 
> ----------------8<-------------[ cut here ]------------------
>>From cccef7ba2433f8e97d1948f85e3bfb2ef5d32a0a Mon Sep 17 00:00:00 2001
> From: Pasha Tatashin <pasha.tatashin@soleen.com>
> Date: Thu, 21 Apr 2022 18:04:43 +0000
> Subject: [PATCH] x86: removed P*D_PAGE_MASK and P*D_PAGE_SIZE
> 
> Other architectures and the common mm/ use P*D_MASK, and P*D_SIZE.
> Remove the duplicated P*D_PAGE_MASK and P*D_PAGE_SIZE which are only
> used in x86/*.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Absolutely, helps in minimizing arch specific stuff wrt to page table mapping.
