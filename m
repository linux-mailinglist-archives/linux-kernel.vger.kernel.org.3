Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DE05745C2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbiGNHPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbiGNHPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:15:08 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B5FE1403D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:15:06 -0700 (PDT)
Received: from [10.90.50.23] (unknown [10.90.50.23])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxSeFzws9iU4odAA--.62026S3;
        Thu, 14 Jul 2022 15:15:00 +0800 (CST)
Message-ID: <8f3d86e4-f051-2cf8-d5ec-f1046632bbda@loongson.cn>
Date:   Thu, 14 Jul 2022 15:14:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] LoongArch: Fix missing fcsr in ptrace's fpr_set
Content-Language: en-US
To:     Conor.Dooley@microchip.com, chenhuacai@kernel.org,
        kernel@xen0n.name, oleg@redhat.com
Cc:     lixu@loongson.cn, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220714062550.4934-1-huqi@loongson.cn>
 <6bc55cd5-bb6e-8d4a-79ec-4555c0b7765b@microchip.com>
From:   Qi Hu <huqi@loongson.cn>
In-Reply-To: <6bc55cd5-bb6e-8d4a-79ec-4555c0b7765b@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9AxSeFzws9iU4odAA--.62026S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWfuF4DuryxAFWrKw17Jrb_yoW8Cw1xpr
        ZxAas5WFW8JFWfCr1qqrsY9r1qqwn2gFySg3s3t3WrAwnrXrs8GryqyrWIvFs2y348G3yx
        Zr909Fs0yFsrAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
        twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU56c_DUUUUU==
X-CM-SenderInfo: pkxtxqxorr0wxvrqhubq/1tbiAQAHCV3QvP1HFQABsQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/14 14:51, Conor.Dooley@microchip.com wrote:
> On 14/07/2022 07:25, Qi Hu wrote:
>> In file ptrace.c, function fpr_set does not copy fcsr data from ubuf
>> to kbuf. That's the reason why fcsr cannot be modified by ptrace.
>>
>> This patch fixs this problem and allows users using ptrace to modify
>> the fcsr.
>>
>> Signed-off-by: Qi Hu <huqi@loongson.cn>
>> Signed-off-by: Xu Li <lixu@loongson.cn>
> Hey Qi Hu,
>
> Why does this have Xu Li's SoB if they're neither the author nor listed
> as a Co-developed-by:?
>
> As submitter, your SoB should be last anyway.
> Thanks,
> Conor.
>
Ops. I realize using SoB here is incorrect. I will change it into 
Co-developed-by.

Thanks.

Qi.

>> ---
>>    arch/loongarch/kernel/ptrace.c | 12 +++++++-----
>>    1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrace.c
>> index e6ab87948e1d..dc2b82ea894c 100644
>> --- a/arch/loongarch/kernel/ptrace.c
>> +++ b/arch/loongarch/kernel/ptrace.c
>> @@ -193,7 +193,7 @@ static int fpr_set(struct task_struct *target,
>>    		   const void *kbuf, const void __user *ubuf)
>>    {
>>    	const int fcc_start = NUM_FPU_REGS * sizeof(elf_fpreg_t);
>> -	const int fcc_end = fcc_start + sizeof(u64);
>> +	const int fcsr_start = fcc_start + sizeof(u64);
>>    	int err;
>>    
>>    	BUG_ON(count % sizeof(elf_fpreg_t));
>> @@ -209,10 +209,12 @@ static int fpr_set(struct task_struct *target,
>>    	if (err)
>>    		return err;
>>    
>> -	if (count > 0)
>> -		err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
>> -					  &target->thread.fpu.fcc,
>> -					  fcc_start, fcc_end);
>> +	err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
>> +				  &target->thread.fpu.fcc, fcc_start,
>> +				  fcc_start + sizeof(u64));
>> +	err |= user_regset_copyin(&pos, &count, &kbuf, &ubuf,
>> +				  &target->thread.fpu.fcsr, fcsr_start,
>> +				  fcsr_start + sizeof(u32));
>>    
>>    	return err;
>>    }

