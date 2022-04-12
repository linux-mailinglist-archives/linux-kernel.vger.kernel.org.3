Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AD24FE6BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358065AbiDLRUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243106AbiDLRUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:20:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0598051E70
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:18:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EBE71424;
        Tue, 12 Apr 2022 10:18:01 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86DC33F5A1;
        Tue, 12 Apr 2022 10:17:59 -0700 (PDT)
Message-ID: <306b1b09-487a-9ccd-4a63-8c78889492c6@arm.com>
Date:   Tue, 12 Apr 2022 18:17:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH -next V3 4/6] arm64: add copy_{to, from}_user to
 machine check safe
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
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
 <20220412072552.2526871-5-tongtiangen@huawei.com>
 <38c6d4b5-a3db-5c3e-02e7-39875edb3476@arm.com>
In-Reply-To: <38c6d4b5-a3db-5c3e-02e7-39875edb3476@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 6:08 pm, Robin Murphy wrote:
[...]
>> @@ -62,7 +63,11 @@ SYM_FUNC_START(__arch_copy_from_user)
>>       ret
>>       // Exception fixups
>> -9997:    cmp    dst, dstin
>> +9997:    mrs esr, esr_el1            // Check exception first
>> +    and esr, esr, #ESR_ELx_FSC
>> +    cmp esr, #ESR_ELx_FSC_EXTABT
> 
> Should we be checking EC to make sure it's a data abort - and thus FSC 
> is valid - in the first place? I'm a little fuzzy on all the possible 
> paths into fixup_exception(), and it's not entirely obvious whether this 
> is actually safe or not.

In fact, thinking some more about that, I don't think there should be 
any need for this sort of logic in these handlers at all. The 
fixup_exception() machinery should already know enough about the 
exception that's happened and the extable entry to figure this out and 
not bother calling the handler at all.

Thanks,
Robin.
