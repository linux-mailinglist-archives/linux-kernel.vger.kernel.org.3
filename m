Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7155034AD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 09:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiDPHns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 03:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiDPHnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 03:43:47 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449A6F8EEC
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 00:41:13 -0700 (PDT)
Received: from kwepemi100011.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KgQ8w0Gnyz1HBsJ;
        Sat, 16 Apr 2022 15:40:32 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100011.china.huawei.com (7.221.188.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 15:41:11 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 15:41:10 +0800
Message-ID: <6252f076-b74a-8dc8-9bc9-93aa70e844c5@huawei.com>
Date:   Sat, 16 Apr 2022 15:41:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC PATCH -next V3 4/6] arm64: add copy_{to, from}_user to
 machine check safe
To:     Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>
References: <20220412072552.2526871-1-tongtiangen@huawei.com>
 <20220412072552.2526871-5-tongtiangen@huawei.com>
 <38c6d4b5-a3db-5c3e-02e7-39875edb3476@arm.com>
 <306b1b09-487a-9ccd-4a63-8c78889492c6@arm.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <306b1b09-487a-9ccd-4a63-8c78889492c6@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/4/13 1:17, Robin Murphy 写道:
> On 12/04/2022 6:08 pm, Robin Murphy wrote:
> [...]
>>> @@ -62,7 +63,11 @@ SYM_FUNC_START(__arch_copy_from_user)
>>>       ret
>>>       // Exception fixups
>>> -9997:    cmp    dst, dstin
>>> +9997:    mrs esr, esr_el1            // Check exception first
>>> +    and esr, esr, #ESR_ELx_FSC
>>> +    cmp esr, #ESR_ELx_FSC_EXTABT
>>
>> Should we be checking EC to make sure it's a data abort - and thus FSC 
>> is valid - in the first place? I'm a little fuzzy on all the possible 
>> paths into fixup_exception(), and it's not entirely obvious whether 
>> this is actually safe or not.
> 
> In fact, thinking some more about that, I don't think there should be 
> any need for this sort of logic in these handlers at all. The 
> fixup_exception() machinery should already know enough about the 
> exception that's happened and the extable entry to figure this out and 
> not bother calling the handler at all.
> 
> Thanks,
> Robin.
> .

Hi Robin:
As you said, it seems that it's not good to judge esr here, how about 
using the following method, i need your suggestion :)

+#define FIXUP_TYPE_NORMAL	0
+#define FIXUP_TYPE_MC		1

arch/arm64/mm/extable.c
static bool ex_handler_fixup(const struct exception_table_entry *ex,
-	struct pt_regs *regs)
+	struct pt_regs *regs, int fixuptype)
{
+	regs->regs[16] = fixuptype;
	[...]
}

bool fixup_exception(struct pt_regs *regs)
{
	[...]
	switch(ex->type) {
	case EX_TYPE_UACCESS_MC:
-		return ex_handler_fixup(ex, regs)
+		return ex_handler_fixup(ex, regs, FIXUP_TYPE_NORMAL)
	break;
	}
	[...]
}

bool fixup_exception_mc(struct pt_regs *regs)
{
	[...]
	switch(ex->type) {
	case EX_TYPE_UACCESS_MC:
-		return ex_handler_fixup(ex, regs)
+		return ex_handler_fixup(ex, regs, FIXUP_TYPE_MC)
	break;
	}
	[...]
}

arch/arm64/lib/copy_from_user.S
arch/arm64/lib/copy_to_user.S

+fixup_type      .req    x16

// Exception fixups
//x16: fixup type written by ex_handler_fixup
-9997:  cmp     dst, dstin
+9997:	cmp fixup_type, #FIXUP_TYPE_MC
+	b.eq 9998f
+ 	cmp     dst, dstin
  	b.ne    9998f

Thanks,
Tong.
