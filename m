Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36B84D281D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 06:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiCIFPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 00:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiCIFPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 00:15:00 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABDCB15F087
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 21:14:01 -0800 (PST)
Received: from [10.20.42.25] (unknown [10.20.42.25])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxsM6XNyhiB38FAA--.25846S3;
        Wed, 09 Mar 2022 13:13:59 +0800 (CST)
Subject: Re: [PATCH] mm: reduce tlb flush range when changing vma protection
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <20220309025721.3051365-1-maobibo@loongson.cn>
 <87861C77-F203-40A5-814D-A3541081064E@gmail.com>
From:   maobibo <maobibo@loongson.cn>
Message-ID: <47b0425d-811e-aeae-3d3d-6b7e730540de@loongson.cn>
Date:   Wed, 9 Mar 2022 13:13:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87861C77-F203-40A5-814D-A3541081064E@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9BxsM6XNyhiB38FAA--.25846S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtr15tF45Jr4kWF4UCw45Jrb_yoWDJrXE9r
        9Fka97Cw1DZrZ7ta1IqF4rtrs5Xw1UAa15Zw4jqr9Fv3s0yaySvan2gr9Fka98CFW8Crnx
        WwnFqwsavr1avjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxxYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkI
        ecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcV
        WlDUUUU
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yeap, your patch is general and better than mine, it can solve the issue.
please drop my patch.

regards
bibo, mao

On 03/09/2022 12:14 PM, Nadav Amit wrote:
> 
> 
>> On Mar 8, 2022, at 6:57 PM, Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> numa worker will periodically change vma prot with PROT_NONE, by
>> default it will scan 256M vma memory size with pmd stepping size.
>> If there are fewer pages changed with PROT_NONE, tlb flush is called
>> with pmd size. This patch will calculate flush range for those
>> pages with pte prot changed, it will reduce size for tlb flush.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> 
> Hi Bibo,
> 
> I finally managed to make v3 of a patchiest, which I think does
> something similar to what you are looking for (without introducing
> yet another TLB batching mechanism).
> 
> Have a look at [1] and let me know if that would satisfy you.
> 
> 
> [1] https://lore.kernel.org/linux-mm/20220309041043.302261-4-namit@vmware.com/T/#u
> 

