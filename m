Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FBD4FE600
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357734AbiDLQlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbiDLQld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:41:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5264210FDA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:39:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6399E1424;
        Tue, 12 Apr 2022 09:39:12 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 319403F5A1;
        Tue, 12 Apr 2022 09:39:10 -0700 (PDT)
Message-ID: <a58b640d-e12a-7b9d-2ab0-d95a3ae6950e@arm.com>
Date:   Tue, 12 Apr 2022 17:39:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH -next V3 6/6] arm64: add cow to machine check safe
Content-Language: en-GB
To:     Tong Tiangen <tongtiangen@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>
References: <20220412072552.2526871-1-tongtiangen@huawei.com>
 <20220412072552.2526871-7-tongtiangen@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220412072552.2526871-7-tongtiangen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 8:25 am, Tong Tiangen wrote:
[...]
> +100:	ldp	x2, x3, [x1]
> +101:	ldp	x4, x5, [x1, #16]
> +102:	ldp	x6, x7, [x1, #32]
> +103:	ldp	x8, x9, [x1, #48]
> +104:	ldp	x10, x11, [x1, #64]
> +105:	ldp	x12, x13, [x1, #80]
> +106:	ldp	x14, x15, [x1, #96]
> +107:	ldp	x16, x17, [x1, #112]
> +
> +	add	x0, x0, #256
> +	add	x1, x1, #128
> +1:
> +	tst	x0, #(PAGE_SIZE - 1)
> +
> +alternative_if ARM64_HAS_NO_HW_PREFETCH
> +	prfm	pldl1strm, [x1, #384]
> +alternative_else_nop_endif
> +
> +	stnp	x2, x3, [x0, #-256]
> +200:	ldp	x2, x3, [x1]
> +	stnp	x4, x5, [x0, #16 - 256]
> +201:	ldp	x4, x5, [x1, #16]
> +	stnp	x6, x7, [x0, #32 - 256]
> +202:	ldp	x6, x7, [x1, #32]
> +	stnp	x8, x9, [x0, #48 - 256]
> +203:	ldp	x8, x9, [x1, #48]
> +	stnp	x10, x11, [x0, #64 - 256]
> +204:	ldp	x10, x11, [x1, #64]
> +	stnp	x12, x13, [x0, #80 - 256]
> +205:	ldp	x12, x13, [x1, #80]
> +	stnp	x14, x15, [x0, #96 - 256]
> +206:	ldp	x14, x15, [x1, #96]
> +	stnp	x16, x17, [x0, #112 - 256]
> +207:	ldp	x16, x17, [x1, #112]
> +
> +	add	x0, x0, #128
> +	add	x1, x1, #128
> +
> +	b.ne	1b
> +
> +	stnp	x2, x3, [x0, #-256]
> +	stnp	x4, x5, [x0, #16 - 256]
> +	stnp	x6, x7, [x0, #32 - 256]
> +	stnp	x8, x9, [x0, #48 - 256]
> +	stnp	x10, x11, [x0, #64 - 256]
> +	stnp	x12, x13, [x0, #80 - 256]
> +	stnp	x14, x15, [x0, #96 - 256]
> +	stnp	x16, x17, [x0, #112 - 256]
> +
> +300:	ret
> +
> +_asm_extable_copy_page_mc 100b, 300b
> +_asm_extable_copy_page_mc 101b, 300b
> +_asm_extable_copy_page_mc 102b, 300b
> +_asm_extable_copy_page_mc 103b, 300b
> +_asm_extable_copy_page_mc 104b, 300b
> +_asm_extable_copy_page_mc 105b, 300b
> +_asm_extable_copy_page_mc 106b, 300b
> +_asm_extable_copy_page_mc 107b, 300b
> +_asm_extable_copy_page_mc 200b, 300b
> +_asm_extable_copy_page_mc 201b, 300b
> +_asm_extable_copy_page_mc 202b, 300b
> +_asm_extable_copy_page_mc 203b, 300b
> +_asm_extable_copy_page_mc 204b, 300b
> +_asm_extable_copy_page_mc 205b, 300b
> +_asm_extable_copy_page_mc 206b, 300b
> +_asm_extable_copy_page_mc 207b, 300b


Please add a USER_MC() macro to parallel the existing USER() one (we can 
worry about names and eventually consolidating things later), then use 
that to save all the label mess here.

Thanks,
Robin.
