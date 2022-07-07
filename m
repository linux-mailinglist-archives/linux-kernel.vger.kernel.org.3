Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5C95699FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbiGGFnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGGFnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:43:08 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A028B31207
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 22:43:06 -0700 (PDT)
Received: from [198.18.0.1] (unknown [192.168.200.1])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxj9JjcsZi224OAA--.1647S3;
        Thu, 07 Jul 2022 13:43:00 +0800 (CST)
Message-ID: <6b501500-793f-5ba5-e21e-47c18342c21f@loongson.cn>
Date:   Thu, 7 Jul 2022 13:42:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] LoongArch: Clean useless vcsr in loongarch_fpu.
Content-Language: en-US
To:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
References: <20220704153612.314112-1-huqi@loongson.cn>
 <4273e104-8392-6a06-5d18-a1933978d8c3@xen0n.name>
 <22a1ba993e298ce12a374decefebeca484240883.camel@xry111.site>
 <16c9ccaa5e5a2ffd39272cff6f66e487c659b571.camel@xry111.site>
 <CAAhV-H5+qd1ZrOqE8fgRmWshXy57AfEFpyKSK8ZstZZEQ53owQ@mail.gmail.com>
 <ac46f5cb4c8d1154cfc3e862fb5211e869839c9a.camel@xry111.site>
 <c824b9ca-c9c4-1912-7845-99a0989277a4@loongson.cn>
 <9d064771-9402-4e84-96f8-4713cddf42f2@www.fastmail.com>
 <730cb4c4-a6a3-783e-3e4c-7c2bdc35c088@loongson.cn>
 <0583a335-72f7-55cf-3cd9-4dbd8109a440@xen0n.name>
From:   Qi Hu <huqi@loongson.cn>
In-Reply-To: <0583a335-72f7-55cf-3cd9-4dbd8109a440@xen0n.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxj9JjcsZi224OAA--.1647S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrykJrW8uF1xtr13Jw45trb_yoW8Kr13pF
        4fGa10kF4kJr1Fvw4vvw4vka4YkryxG3yUXw4vqr10ywnrtw13WrWrZrs8CFyxGr18tF4Y
        qr4jqr97Z34DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pkxtxqxorr0wxvrqhubq/1tbiAQAACV3QvPyIzAABsA
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/7 11:05, WANG Xuerui wrote:
> On 2022/7/7 09:29, Qi Hu wrote:
>>
>> On 2022/7/7 04:49, Jiaxun Yang wrote:
>>>
>>> 在2022年7月6日七月 上午5:00，Qi Hu写道：
>>>> On 2022/7/6 10:51, Xi Ruoyao wrote:
>>>>> On Wed, 2022-07-06 at 10:35 +0800, Huacai Chen wrote:
>>>>>
>>>>>> Maybe Xuerui and Ruoyao have some misunderstanding. LSX/LASX will
>>>>>> surely be upstream, this has nothing to do with cleanup VCSR16.
>>>>>> Because FP/LSX/LASX share the same control bits in FCSR now.
>>>>> My guess:
>>>>>
>>>>> Almost all behavior of vector unit is controlled by FCSR (for 
>>>>> example,
>>>>> the rounding of both FPU and vector unit should be controlled by FCSR
>>>>> altogether), except one bit similar to the bit 24 of MSACSR 
>>>>> ("flush to
>>>>> zero") is in VCSR [^1].  And "flush to zero" is not really useful 
>>>>> so it
>>>>> will be removed in 3A6000, and we'll not use it for 3A5000.
>>>> Actually, flush to zero has been removed in 3A5000.
>>>>> [^1]: A more bold guess: the hardware engineers could have just said
>>>>> "let's wire this register called MSACSR in GS464V as FCSR16/VCSR in
>>>>> LA464, maybe it will be useful and who knows?"  But now in 
>>>>> practice it's
>>>>> not useful.
>>>>>
>>>>> Am I correct?
>>>> The hardware(LA464) has removed the vcsr("has but not use" is
>>>> incorrect), and here are some details:
>>>>
>>>> - For all FP operations, including LSX/LASX, they are controlled by
>>>> fcsr0/1/2/3.
>>>>
>>>> - For LSX/LASX other operations, they are *not* controlled by any 
>>>> other
>>>> CSR now. And fcsr16 to fcsr31 are reserved to control these operations
>>>> (now they are *undefined*).
>>> Sorry but what do you meant by “these” here?
>> "These operations" means "LSX/LASX other operations", except its 
>> floating-point operations.
>
> This is getting hard to follow. Assuming the expression "LSX/LASX 
> other operations" is Chinglish (it's certainly not proper English), I 
> think you mean "the non-FP operations belonging to LSX/LASX" here right?
That's right.
>
> And it's strange, that these ops do exist in LSX/LASX, hence also 
> present in 3A5000, but the control bits are undefined. How come this 
> is even possible?
The code is redundant, actually. Reading or writing the fcsr16 do not 
have any effect on LSX/LASX.

