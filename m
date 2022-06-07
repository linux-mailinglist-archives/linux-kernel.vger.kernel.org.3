Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8DF537363
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 03:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiE3Bop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 21:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiE3Bon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 21:44:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E019DEAB;
        Sun, 29 May 2022 18:44:42 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LBJ943d1tzjX4K;
        Mon, 30 May 2022 09:43:52 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 30 May 2022 09:44:40 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 30 May
 2022 09:44:40 +0800
Message-ID: <28642a99-0b59-a5dd-aea4-6c1db65c0934@huawei.com>
Date:   Mon, 30 May 2022 09:44:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v2 11/20] objtool: arm64: Walk instructions and
 compute CFI for each instruction
Content-Language: en-US
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        <jpoimboe@redhat.com>, <peterz@infradead.org>,
        <mark.rutland@arm.com>, <broonie@kernel.org>,
        <nobuta.keiya@fujitsu.com>, <sjitindarsingh@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <jamorris@linux.microsoft.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <live-patching@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <e81e773678f88f7c2ff7480e2eb096973ec198db>
 <20220524001637.1707472-1-madvenka@linux.microsoft.com>
 <20220524001637.1707472-12-madvenka@linux.microsoft.com>
 <767e814c-b3cc-73a1-d283-82dbc0287cde@huawei.com>
 <ad2368a3-17fd-ad7e-95e8-0b7fa9b59fec@linux.microsoft.com>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <ad2368a3-17fd-ad7e-95e8-0b7fa9b59fec@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/5/29 23:18, Madhavan T. Venkataraman wrote:
> 
> 
> On 5/24/22 08:45, Chen Zhongjin wrote:
>> Hi,
>>
>> On 2022/5/24 8:16, madvenka@linux.microsoft.com wrote:
>>> From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
>>>
>>> Implement arch_initial_func_cfi_state() to initialize the CFI for a
>>> function.
>>>
>>> Add code to fpv_decode() to walk the instructions in every function and
>>> compute the CFI information for each instruction.
>>>
>>> Implement special handling for cases like jump tables.
>>>
>>> Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
>>> ---
>>>  tools/objtool/arch/arm64/decode.c |  15 +++
>>>  tools/objtool/fpv.c               | 204 ++++++++++++++++++++++++++++++
>>>  2 files changed, 219 insertions(+)
>> ...
>>> +static void update_cfi_state(struct cfi_state *cfi, struct stack_op *op)
>>> +{
>>> +	struct cfi_reg *cfa = &cfi->cfa;
>>> +	struct cfi_reg *regs = cfi->regs;
>>> +
>>> +	if (op->src.reg == CFI_SP) {
>>> +		if (op->dest.reg == CFI_SP)
>>> +			cfa->offset -= op->src.offset;
>>> +		else
>>> +			regs[CFI_FP].offset = -cfa->offset + op->src.offset;
>> Seems wrong here, we don't have any op->src.offset for [mov x29, sp] so here we
>> get: fp->offset = -cfa->offset. The dumped info also proves this.
> 
> 
> See the example below.
> 
>>
>>> +	case UNWIND_HINT_TYPE_CALL:
>>> +		/* Normal call */
>>> +		frame->cfa += orc->sp_offset;
>>> +		fp = frame->cfa + orc->fp_offset;
>>> +		break;
>> Obviously this is not conform to the reliability check because we get
>> frame->cfa == fp here.
>>
> 
> See the example below:
> 
>> IIUC your sp_offset equals to stack length, and fp_offset is offset from next
>> x29 to next CFA. So maybe here we should have
>> regs[CFI_FP].offset = regs[CFI_SP].offset for [mov x29, sp].
>>
>> Anyway, in original objtool sp_offset and fp_offset both represents the offset
>> from CFA to REGs. I think it's better not spoiling their original meaning and
>> just extending.
>>
>>
> 
> I am not spoiling anything.
> 
> 
> Let us take an example:
> 
> ffff800008010000 <bcm2835_handle_irq>:
> ffff800008010000:       d503201f        nop
> ffff800008010004:       d503201f        nop
> ffff800008010008:       d503233f        paciasp
> ffff80000801000c:       a9be7bfd        stp     x29, x30, [sp, #-32]!
> ffff800008010010:       910003fd        mov     x29, sp
> ffff800008010014:       f9000bf3        str     x19, [sp, #16]
> 
> 
> The stack pointer is first moved by -32 and the FP and LR are stored there.
> At this point, SP is pointing to the frame. The CFA is:
> 
> 	CFA = SP + 32
> 
> The frame pointer has been stored at the location pointed to by the SP.
> So, FP should be:
> 
> 	FP = CFA - 32
> 
> Therefore, at instruction address ffff800008010014:
> 
> 	frame->cfa = SP + 32;
> 	frame->fp = frame->cfa - 32 = SP;
> 
> So, if a call/interrupt happens after this instruction, the frame pointer computed
> from the above data will match with the actual frame pointer.
> 
> I have verified this using the DWARF data generated by the compiler. It is correct.
> I have also verified that the stack trace through such code passes the reliability
> check. That is, it computes the frame pointer correctly which matches with the
> actual frame pointer
You are right, I think I mixed up frame of x86 and arm64.

Apologize for that and thanks for explaining!

Best,
Chen

