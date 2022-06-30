Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6CB561542
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbiF3IiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiF3IiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:38:09 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1B07C17
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:38:07 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxX9flYL1iZvllAA--.13254S3;
        Thu, 30 Jun 2022 16:37:57 +0800 (CST)
Subject: Re: [PATCH V13 06/13] irqchip/loongson-pch-pic: Add ACPI init support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <1656329997-20524-1-git-send-email-lvjianmin@loongson.cn>
 <1656329997-20524-7-git-send-email-lvjianmin@loongson.cn>
 <87v8sj1zs9.wl-maz@kernel.org>
 <aa8321d5-9839-9ccf-6284-766719e980ea@loongson.cn>
 <87o7yaehtk.wl-maz@kernel.org>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <0aafcd57-9dc6-e061-a7c9-d86348dfe0d1@loongson.cn>
Date:   Thu, 30 Jun 2022 16:37:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87o7yaehtk.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxX9flYL1iZvllAA--.13254S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4fCw1DCF17XFyrtr4UCFg_yoW5GrWfpa
        yYqFWayF4DArWxCw1SgF4UZFyayw18Jr13uF95KryrA3s09r1xGFWktr1j9FykWr4kua12
        vw4YvF97Ka98AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU901xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        ACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE-syl
        42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/30 下午3:22, Marc Zyngier wrote:
> On Thu, 30 Jun 2022 05:36:40 +0100,
> Jianmin Lv <lvjianmin@loongson.cn> wrote:
>>
>>
> 
> [...]
> 
>>>> +static int __init pch_pic_acpi_init(void)
>>>> +{
>>>> +	acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC,
>>>
>>> Where is this defined? It only appears in the documentation, and
>>> nowhere else...
>>>
>>
>> It's defined in the patch to ACPICA(which has been merged, please to
>> see
>> https://github.com/acpica/acpica/commit/1dc530059a3e6202e941e6a9478cf30f092bfb47).
>> the patch will be synchronized to linux kernel by maintainer of ACPICA.
> 
> How can I take this patch upstream if it doesn't even compile? Please
> make this patch part of your series. There are tons of patches that
> need Acks from the ACPI maintainers, this is only one of them.
> 

Ok, I'll put the patch into my series.


>>
>>
>>>> +			      pchintc_parse_madt, 0);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +early_initcall(pch_pic_acpi_init);
>>>
>>> Why can't you use IRQCHIP_ACPI_DECLARE here? This is terribly fragile,
>>> and will eventually break. I really don't want to rely on this.
>>>
>>
>> In early time, the change here is implemented using
>> IRQCHIP_ACPI_DECLARE, but we found that calling order(during
>> irqchip_init) of the entry declared using IRQCHIP_ACPI_DECLARE is
>> depended on the compiling order(driver order in Makefile) of the
>> driver. For removing the dependency to the compiling order, the new
>> way here is used(I looked into ARM, it seems that GIC driver uses
>> IRQCHIP_ACPI_DECLARE, and ITS driver uses early_initcall too.).
> 
> It's not quite the same. The ITS part that uses early_initcall isn't
> an actual driver (it only registers a domain, and nothing else).
> 

Ok, thanks, I got it, I don't understand ARM's irqchips well.

> There is also no guarantee that the initcalls at the same priority
> will execute in any order, and you already have at least two such
> initcalls (pch_pic_acpi_init, pch_msi_acpi_init, and I haven't quite
> understood how the rest is probed yet).
> 

Yes, agree, but pch_pic and pch_msi are independent, and there is no
dependencies between them, so there is no requirement on calling order 
for the two entries.

> One possibility would be to drive the whole probing from the root
> interrupt controller, which is similar to what GICv3 does for the
> actual ITS driver. You already do this sort of stuff in the CPUINTC
> driver, so adding to this shouldn't be too hard.
> 

Ok, thanks for your suggestion, I'll try to change it as the way in the 
CPUINTC driver, it seems that way is better.

> 	M.
> 

