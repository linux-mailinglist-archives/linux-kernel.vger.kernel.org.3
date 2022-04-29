Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47CF5140A9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 04:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiD2C1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 22:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiD2C0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 22:26:30 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66DC3BC86E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 19:23:13 -0700 (PDT)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxGtkMTGtilpcCAA--.12016S3;
        Fri, 29 Apr 2022 10:23:08 +0800 (CST)
Subject: Re: [PATCH] mm/swapops: make is_pmd_migration_entry more strict
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <1651131333-6386-1-git-send-email-zhanghongchen@loongson.cn>
 <YmrfynZf7bU0Uoys@xz-m1.local>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <752b59ff-3283-2360-5f16-d75d04c25a8b@loongson.cn>
Date:   Fri, 29 Apr 2022 10:23:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YmrfynZf7bU0Uoys@xz-m1.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxGtkMTGtilpcCAA--.12016S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4xCr13tF1rZrW3Xr48Xrb_yoW8ArW5pa
        95CFs5Ca1xtr18GFykX3y8tFy5Z3y5Wr42qrW8ury0yF9xtrn2qw1vqry2grykAr48CFWU
        ua13ta45Ca4DZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JV
        WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
        6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU86VbDUUUUU==
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/29 上午2:41, Peter Xu wrote:
> On Thu, Apr 28, 2022 at 03:35:33PM +0800, Hongchen Zhang wrote:
>> a pmd migration entry should first be a swap pmd,so
>> use is_swap_pmd(pmd) instead of !pmd_present(pmd).
>>
>> On the other hand, some architecture (MIPS for example)
>> may misjudge a pmd_none entry as a pmd migration entry.
>>
>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> 
> The change looks reasonable,
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> 
> Two more pure questions..
> 
>    (1) is there a real issue to be fixed with it?  Asked because I see most
>        calls to is_pmd_migration_entry() should already make sure it's not
>        none, and,
> 
>    (2) why it matters with MIPS?  Firstly this function is not used in arch
>        specific code, and iiuc thp migration is not enabled at all for mips.
> 
> Thanks,
> 
>> ---
>>   include/linux/swapops.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
>> index d356ab4..1d16569 100644
>> --- a/include/linux/swapops.h
>> +++ b/include/linux/swapops.h
>> @@ -304,7 +304,7 @@ static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
>>   
>>   static inline int is_pmd_migration_entry(pmd_t pmd)
>>   {
>> -	return !pmd_present(pmd) && is_migration_entry(pmd_to_swp_entry(pmd));
>> +	return is_swap_pmd(pmd) && is_migration_entry(pmd_to_swp_entry(pmd));
>>   }
>>   #else
>>   static inline void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
>> -- 
>> 1.8.3.1
>>
> 
Hello Peter,
   (1) the pmd passed to __split_huge_pmd_locked may be a none pmd,so it 
may be wrongly treated as a pmd migration entry.
   (2) we are preparing to support thp migration on MIPS.

Thanks.

