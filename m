Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65F447B856
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 03:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhLUCWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 21:22:52 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:52100 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230060AbhLUCWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 21:22:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V.Hh30R_1640053368;
Received: from 30.22.113.117(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0V.Hh30R_1640053368)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Dec 2021 10:22:50 +0800
Message-ID: <582ad344-7b89-f43f-e8e9-e2d19f7b41b3@linux.alibaba.com>
Date:   Tue, 21 Dec 2021 10:22:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH 1/4] x86/entry: Make paranoid_exit() callable
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20211213150340.9419-1-jiangshanlai@gmail.com>
 <20211213150340.9419-2-jiangshanlai@gmail.com> <YcDR92+JFkVAZi5c@zn.tnic>
From:   Lai Jiangshan <laijs@linux.alibaba.com>
In-Reply-To: <YcDR92+JFkVAZi5c@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/21 02:56, Borislav Petkov wrote:
> On Mon, Dec 13, 2021 at 11:03:37PM +0800, Lai Jiangshan wrote:
>> From: Lai Jiangshan <laijs@linux.alibaba.com>
>>
>> Move the last JMP out of paranoid_exit() and make it callable.
>>
>> It will allow asm_exc_nmi() to call it and avoid duplicated code.
>>
>> No functional change intended.
>>
>> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
>> ---
>>   arch/x86/entry/entry_64.S | 18 +++++++++++-------
>>   1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>> index 44dadea935f7..3dc3cec03425 100644
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -439,7 +439,8 @@ SYM_CODE_START(\asmsym)
>>   
>>   	call	\cfunc
>>   
>> -	jmp	paranoid_exit
>> +	call	paranoid_exit
>> +	jmp	restore_regs_and_return_to_kernel
> 
> I guess but I don't like the glueing of the CALL to paranoid_exit with
> the JMP to the restore_regs_and_return_to_kernel label. That reads
> to me as, "if you're calling paranoid_exit() you must jump to the
> restore_regs_and_return_to_kernel label but not always."
> 
> So I'm thinking you should leave the jump to that label inside
> paranoid_exit() and use its %rbx argument to control when to jump to it
> and when not.

Hello

Thank you for reviewing it.

This patch is a part of the job converting some ASM code to C code.  The
changelog of it in the original big patchset reads:

   Allow paranoid_exit() to be re-written in C later and also allow
   asm_exc_nmi() to call it to avoid duplicated code.

And this smaller patchset doesn't include the work of converting ASM code,
so I removed "Allow paranoid_exit() to be re-written in C later" because I
thought "allowing asm_exc_nmi() to call it and avoiding duplicated code" is
enough to justify the value of this change.

When paranoid_exit() is ready to be converted to C, it can't have jump to
any label that is not in paranoid_exit() itself.

I'm sorry to not have put all of the intents in the changelog:

-It will allow asm_exc_nmi() to call it and avoid duplicated code.
+It will allow asm_exc_nmi() to call it and avoid duplicated code and allow
+future work to convert paranoid_exit() to C code.

Thanks
Lai

