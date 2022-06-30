Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF375560F5E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 04:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiF3CxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 22:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiF3Cw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 22:52:57 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CC6840919
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 19:52:56 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxL9f+D71immFlAA--.14179S3;
        Thu, 30 Jun 2022 10:52:47 +0800 (CST)
Subject: Re: [PATCH V13 09/13] irqchip/loongson-liointc: Add ACPI init support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1656329997-20524-1-git-send-email-lvjianmin@loongson.cn>
 <1656329997-20524-10-git-send-email-lvjianmin@loongson.cn>
 <87tu831ujy.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <cf275b58-69fc-3e05-8f67-3bc40a8170f3@loongson.cn>
Date:   Thu, 30 Jun 2022 10:52:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87tu831ujy.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxL9f+D71immFlAA--.14179S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GF4xAr43Ar43AFykAFWDArb_yoWkKrg_ur
        42v3ZrWrWUGFsrtw1Fvr4rAFy2qFyj9w1jkFWrZF1Syw12qwsrCrnxCrnagF48ta92yrs3
        JrWj9Fn7ZFy2qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb3AFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2
        jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzx
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



On 2022/6/29 下午9:13, Marc Zyngier wrote:
> On Mon, 27 Jun 2022 12:39:53 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>> From: Huacai Chen <chenhuacai@loongson.cn>
>>
>> We are preparing to add new Loongson (based on LoongArch, not compatible
>> with old MIPS-based Loongson) support. LoongArch use ACPI other than DT
>> as its boot protocol, so add ACPI init support.
>>
>> LIOINTC stands for "Legacy I/O Interrupts" that described in Section
>> 11.1 of "Loongson 3A5000 Processor Reference Manual". For more
>> information please refer Documentation/loongarch/irq-chip-model.rst.
> 
> This is what happens with this series while compiling for MIPS:
> 
> drivers/irqchip/irq-loongson-liointc.c: In function ‘liointc_domain_xlate’:
> drivers/irqchip/irq-loongson-liointc.c:170:28: error: ‘GSI_MIN_CPU_IRQ’ undeclared (first use in this function)
>    170 |  *out_hwirq = intspec[0] - GSI_MIN_CPU_IRQ;
>        |                            ^~~~~~~~~~~~~~~
> 
> I haven't bothered reviewing more patches, as this is a waste of my
> time.
> 

Sorry for wasting your time, Marc, I just test on my LoongArch machine, 
I'll fix them and test on both of LoongArch and MIPS machine in future.


> 	M.
> 

