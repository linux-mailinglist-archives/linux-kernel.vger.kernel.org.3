Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0A4539A8F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 02:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348865AbiFAAzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 20:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiFAAzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 20:55:19 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A22F93989;
        Tue, 31 May 2022 17:55:17 -0700 (PDT)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxD0_tuJZivdEKAA--.2819S3;
        Wed, 01 Jun 2022 08:55:09 +0800 (CST)
Subject: Re: [PATCH] MIPS: fix pmd_mkinvalid
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Zhaolong Zhang <zhangzl2013@126.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1653971769-14152-1-git-send-email-zhanghongchen@loongson.cn>
 <e8cca5c1-2db1-840e-609b-4ae98791ba80@flygoat.com>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <a87c5693-a26c-a6a9-7149-74e94425703e@loongson.cn>
Date:   Wed, 1 Jun 2022 08:55:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e8cca5c1-2db1-840e-609b-4ae98791ba80@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxD0_tuJZivdEKAA--.2819S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr45Jr18Cr4kAF4UJr1kZrb_yoW8WrW5pa
        n3CFW8CFZ8KFn7Cay3JrWSgFyaywsxKFZ5trn8G34DJas8KFykJFn3Kr4Yq34kXF4vyF4r
        ZrWagr4UuF4Iy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvFb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
        xU2rcTDUUUU
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/31 下午11:40, Jiaxun Yang wrote:
> 
> 
> 在 2022/5/31 5:36, Hongchen Zhang 写道:
>> pmd_mkinvalid should not clear dirty flag,otherwise the pmd
>> dirty flag,it's ok to just clear _PAGE_VALID.
> Hi Hongcheng,
> 
> Sorry, what is meant by "otherwise the pmd dirty flag"? Could you please
> elaborate?
> In my humble opinion _PAGE_PRESENT must be cleared in mkinvalid as it
> nolonger present here. And thus it lose the dirty status.
> 
> Thanks
> - Jiaxun
> 
>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>> ---
>>   arch/mips/include/asm/pgtable.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/include/asm/pgtable.h 
>> b/arch/mips/include/asm/pgtable.h
>> index 374c632..d30a186 100644
>> --- a/arch/mips/include/asm/pgtable.h
>> +++ b/arch/mips/include/asm/pgtable.h
>> @@ -698,7 +698,7 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t 
>> newprot)
>>   static inline pmd_t pmd_mkinvalid(pmd_t pmd)
>>   {
>> -    pmd_val(pmd) &= ~(_PAGE_PRESENT | _PAGE_VALID | _PAGE_DIRTY);
>> +    pmd_val(pmd) &= ~_PAGE_VALID;
>>       return pmd;
>>   }
Hi Jiaxun,

Refer to [ https://lkml.org/lkml/2018/10/17/231 ],Andrea said "
The clear of the real present bit during pmd (virtual) splitting is
done with pmdp_invalidate, that is created specifically to keeps
pmd_trans_huge=true, pmd_present=true despite the present bit is not
set. ". So it's wrong to clear _PAGE_PRESENT,because this will make 
pmd_present=false.

On the other hand, There is no need to clear dirty flag too.

Thanks.

