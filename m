Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857054D3F62
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 03:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbiCJCtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 21:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbiCJCtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 21:49:49 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9DED3D4BB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 18:48:48 -0800 (PST)
Received: from localhost.localdomain (unknown [10.20.42.95])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx7xMJZyliUCUGAA--.1221S3;
        Thu, 10 Mar 2022 10:48:42 +0800 (CST)
Subject: Re: [PATCH 1/1] mm/page_alloc: add scheduling point to
 free_unref_page_list
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, vbabka@suse.cz
References: <20220302013825.2290315-1-wangjianxing@loongson.cn>
 <YieCFVMJOgT7es6E@casper.infradead.org>
 <20220309170517.05facf4a2d183cc9aac9196d@linux-foundation.org>
From:   wangjianxing <wangjianxing@loongson.cn>
Message-ID: <3713cb82-9596-9916-9830-c2827d6a6fe4@loongson.cn>
Date:   Thu, 10 Mar 2022 10:48:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20220309170517.05facf4a2d183cc9aac9196d@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf9Dx7xMJZyliUCUGAA--.1221S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4UtryrKw4DCr43tr1fZwb_yoW8Xr1xpF
        WkJasayF1UWw1rJanrZ3W09Fn7Cwn0gFWxCrWkCr1rJr1akr9xKrnayrya9F1Y9r40yrna
        yrs0gFyfZF1jyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
        6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU5PpnJUUUUU==
X-CM-SenderInfo: pzdqwyxldq5xtqj6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spin_lock will preempt_disable(), interrupt context will 
__irq_enter/local_bh_disable and also add preempt count with offset.

cond_resched check whether if preempt_count == 0 in first and won't 
schedule in previous context.

Is this right?


With another way, could we add some condition to avoid call cond_resched 
in interrupt context or spin_lock()?

+ if (preemptible())
+       cond_resched();

On 03/10/2022 09:05 AM, Andrew Morton wrote:
> On Tue, 8 Mar 2022 16:19:33 +0000 Matthew Wilcox <willy@infradead.org> wrote:
>
>> On Tue, Mar 01, 2022 at 08:38:25PM -0500, wangjianxing wrote:
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 3589febc6..1b96421c8 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -3479,6 +3479,9 @@ void free_unref_page_list(struct list_head *list)
>>>   		 */
>>>   		if (++batch_count == SWAP_CLUSTER_MAX) {
>>>   			local_unlock_irqrestore(&pagesets.lock, flags);
>>> +
>>> +			cond_resched();
>> This isn't safe.  This path can be called from interrupt context
>> (otherwise we'd be using local_unlock_irq() instead of irqrestore()).
> What a shame it is that we don't document our interfaces :(
>
> I can't immediately find such callers, but I could imagine
> put_pages_list() (which didn't document its interface this way either)
> being called from IRQ.
>
> And drivers/iommu/dma-iommu.c:fq_ring_free() calls put_pages_list()
> from inside spin_lock().

