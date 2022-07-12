Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B43571970
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiGLMIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiGLMIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:08:48 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E87A658F;
        Tue, 12 Jul 2022 05:08:45 -0700 (PDT)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxv9BLZM1iC0kZAA--.15930S3;
        Tue, 12 Jul 2022 20:08:43 +0800 (CST)
Subject: Re: [PATCH] MIPS: fix pmd_mkinvalid
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1657181495-33004-1-git-send-email-zhanghongchen@loongson.cn>
 <20220707092206.GA9894@alpha.franken.de>
 <bfb97f6b-7a39-8253-bc14-08f2f54ed312@loongson.cn>
 <0fd4e823-493f-07f0-08d5-f4a22491b602@loongson.cn>
 <20220712111917.GA10936@alpha.franken.de>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <b2e74ba2-b831-d300-92f6-c410673e72cc@loongson.cn>
Date:   Tue, 12 Jul 2022 20:08:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220712111917.GA10936@alpha.franken.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxv9BLZM1iC0kZAA--.15930S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar17XF15Ww1DCr18ury7GFg_yoW8tr47pF
        Z5tF1UtFWDtrn7Jr18Kr18JFyYyw15tw15Wrn5JF1UA392qr1Iqr4UX390934UXF4kGr1U
        tF45XasrZw1UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv0b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkI
        ecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1l
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5
        PpnJUUUUU==
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/12 下午7:19, Thomas Bogendoerfer wrote:
> On Tue, Jul 12, 2022 at 06:01:08PM +0800, Hongchen Zhang wrote:
>> On 2022/7/7 下午7:12, Hongchen Zhang wrote:
>>> On 2022/7/7 下午5:22, Thomas Bogendoerfer wrote:
>>>> On Thu, Jul 07, 2022 at 04:11:35PM +0800, Hongchen Zhang wrote:
>>>>> When a pmd entry is invalidated by pmd_mkinvalid,pmd_present should
>>>>> return true.
>>>>> So introduce a _PMD_PRESENT_INVALID_SHIFT bit to check if a pmd is
>>>>> present but invalidated by pmd_mkinvalid.
>>>>
>>>> What problem are you trying to fix ? What are the symptoms ?
>>>>
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> the test robot showed problems with your last version of the patch,
>>>> which hasn't been integrated into at least the MIPS tree, so no
>>>> need to that.
>>>>
>>>> Thomas.
>>>>
>>>
>>> Hi Thomas,
>>>     The idea come from the commit:
>>>     b65399f6111b(arm64/mm: Change THP helpers to comply with generic MM
>>>   semantics).
>>>     There is an problem now:
>>>           CPU 0        CPU 1
>>>       pmdp_invalidate        do_page_fault
>>>       ...              __handle_mm_fault
>>>                       is_swap_pmd == true
>>>                       trigger VM_BUG_ON() ?
>>>       set_pmd_at
>>>     the reason is that pmd_present return true,after this commit
>>>     pmd_present will return false,and the VM_BUG_ON will not be triggered.
>>>     Like arm64 does,we can introduce a new bit to fix this.
>>>
>>> Thanks.
>> Hi Thomas,
>>   Is there problem of this patch? What's your opinion of this patch?
> 
> I haven't dig deeper into it, but needing more page bits is a pain
> for 32bit kernel and would make it nearly impossible to get huge
> page support there. And the description you gave me, needs to be
> in the commit description.
> 
> Thomas.
> 
Hi Thomas,
  Thanks for your patiently review. For your question,
   1. I think there may be problem when compile 32bit kernel with huge 
page support,because _PAGE_HUGE_SHIFT is only defined for R4K now.
   2. I will modify the commit as you said and make a v2 patch.

Thanks.
Hongchen Zhang


