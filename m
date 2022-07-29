Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72245584B3D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 07:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbiG2Fi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 01:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiG2Fi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 01:38:56 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 661CB1F62E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 22:38:54 -0700 (PDT)
Received: from [10.130.0.63] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz9JmcuNiJipBAA--.27572S3;
        Fri, 29 Jul 2022 13:38:47 +0800 (CST)
Subject: Re: [PATCH 2/3] LoongArch: Add prologue unwinder support
To:     Youling Tang <tangyouling@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn
References: <20220728140519.5420-1-zhangqing@loongson.cn>
 <20220728140519.5420-2-zhangqing@loongson.cn>
 <ef9a03ee-6fdf-3968-de04-057cafc7c7c7@loongson.cn>
From:   zhangqing <zhangqing@loongson.cn>
Message-ID: <fd01dabd-4ba2-ff7a-0dee-c99b1478be03@loongson.cn>
Date:   Fri, 29 Jul 2022 13:38:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ef9a03ee-6fdf-3968-de04-057cafc7c7c7@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxz9JmcuNiJipBAA--.27572S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4rXFy3Xr47CF4DWF1Dtrb_yoW8Zr1xpr
        4ktFWDtFyDKrn3ur1UJr4kuF98ArWkGw1DtFZ5XF4UGr1DXw1Iqrya9w1v93Z7Jr4kGr18
        Ar15Zr9ruF1DWFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxkIecxEwVAFwVW8WwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUjivttUUUUU==
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/29 上午10:03, Youling Tang wrote:
> 
> 
> On 07/28/2022 10:05 PM, Qing Zhang wrote:
>> It unwind the stack frame based on prologue code analyze.
>> CONFIG_KALLSYMS is needed, at least the address and length
>> of each function.
>>
>> Three stages when we do unwind,
>>   (1)unwind_start(), the prapare of unwinding, fill unwind_state.
>>   (2)unwind_done(), judge whether the unwind process is finished or not.
>>   (3)unwind_next_frame(), unwind the next frame.
>>
>> Dividing unwinder helps to add new unwinders in the future, eg:
>> unwind_frame, unwind_orc .etc
>>
>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>>
>> +
>> +    while (ip < ip_end) {
>> +        if (is_ra_save_ins(ip)) {
>> +            frame_ra = ip->reg2i12_format.immediate;
> Because the immediate member in struct reg2i12_format is defined as an
> unsigned type, the value obtained by frame_ra here can only be a
> positive number.
> 
>> +            break;
>> +        }
>> +        if (is_branch_insn(*ip))
>> +            break;
>> +        ip++;
>> +    }
>> +
>> +    if (frame_ra < 0) {
> In addition to judging whether the initial value of frame_ra is
> negative, we also want to judge whether the previously assigned
> frame_ra is negative.
> 
> Save the ra value to the stack in the prologue, offset must be a
> positive number, so we can add another judgment to is_ra_save_ins, the
> code is as follows:
> +static inline bool is_ra_save_ins(union loongarch_instruction *ip)
> +{
> +    /* st.d $ra, $sp, offset */
> +    return ip->reg2i12_format.opcode == std_op &&
> +        ip->reg2i12_format.rj == LOONGARCH_GPR_SP &&
> +        ip->reg2i12_format.rd == LOONGARCH_GPR_RA &&
> +        !(ip->reg2i12_format.immediate & (1 << 11));
> +}

Hi,
youling

you are right and I will send v2.

Thanks,
Qing

