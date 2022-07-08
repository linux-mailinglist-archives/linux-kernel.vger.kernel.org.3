Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AED756B0FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 05:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbiGHDVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 23:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbiGHDVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 23:21:37 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9B4960682
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 20:21:35 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxv9C5osdiNIoQAA--.4262S3;
        Fri, 08 Jul 2022 11:21:29 +0800 (CST)
Subject: Re: [PATCH V14 02/15] APCI: irq: Add support for multiple GSI domains
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1656837932-18257-1-git-send-email-lvjianmin@loongson.cn>
 <1656837932-18257-3-git-send-email-lvjianmin@loongson.cn>
 <877d4pmdm0.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <399fdd93-c346-ccff-5b94-596b080b9a1c@loongson.cn>
Date:   Fri, 8 Jul 2022 11:21:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <877d4pmdm0.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxv9C5osdiNIoQAA--.4262S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtFyDWr48Kr4UAw1rCFyrCrg_yoWDArX_uF
        W0yrn3Cw4DAFWxGF1kXr9I9r92gayUGr1rK3yUXwsxX34rta9xJFn7Crn3Zw4xJrykCrnx
        CF4Svrsavw18ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3AFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
        87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        GVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm
        -wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
        JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/7 下午6:16, Marc Zyngier wrote:
> On Sun, 03 Jul 2022 09:45:19 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> From: Marc Zyngier <maz@kernel.org>
>>
>> In an unfortunate departure from the ACPI spec, the LoongArch
>> architecture split its GSI space across multiple interrupt
>> controllers.
>>
>> In order to be able to reuse the core code and prevent
>> architectures from reinventing an already square wheel, offer
>> the arch code the ability to register a dispatcher function
>> that will return the domain fwnode for a given GSI.
>>
>> The ARM GIC drivers are updated to support this (with a single
>> domain, as intended).
>>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> Cc: Hanjun Guo <guohanjun@huawei.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> 
> This patch was reviewed and tested by Hanjun. Why aren't the tags
> included here?
> 

Ok, thanks for your guidance, I'll add them in next version.

> 	M.
> 

