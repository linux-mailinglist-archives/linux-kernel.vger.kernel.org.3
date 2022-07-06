Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED77F567CE8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 06:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiGFEAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 00:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiGFEAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 00:00:41 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BD901EC7F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 21:00:39 -0700 (PDT)
Received: from [198.18.0.1] (unknown [192.168.200.1])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Axn+LhCMViZP0LAA--.36560S3;
        Wed, 06 Jul 2022 12:00:33 +0800 (CST)
Message-ID: <c824b9ca-c9c4-1912-7845-99a0989277a4@loongson.cn>
Date:   Wed, 6 Jul 2022 12:00:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] LoongArch: Clean useless vcsr in loongarch_fpu.
Content-Language: en-US
To:     Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
References: <20220704153612.314112-1-huqi@loongson.cn>
 <4273e104-8392-6a06-5d18-a1933978d8c3@xen0n.name>
 <22a1ba993e298ce12a374decefebeca484240883.camel@xry111.site>
 <16c9ccaa5e5a2ffd39272cff6f66e487c659b571.camel@xry111.site>
 <CAAhV-H5+qd1ZrOqE8fgRmWshXy57AfEFpyKSK8ZstZZEQ53owQ@mail.gmail.com>
 <ac46f5cb4c8d1154cfc3e862fb5211e869839c9a.camel@xry111.site>
From:   Qi Hu <huqi@loongson.cn>
In-Reply-To: <ac46f5cb4c8d1154cfc3e862fb5211e869839c9a.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Axn+LhCMViZP0LAA--.36560S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWUurWDJw45KrWUurWkXrb_yoW8Gw17pF
        4xWw4fAF4kArnIva1kAw4rKa13W348WayUKwsIvr1jkrn2q343KrWrXFs5GFyfGr1SyF45
        Xr4qqryxZ3yDZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pkxtxqxorr0wxvrqhubq/1tbiAQATCV3QvPxRrAABsq
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/7/6 10:51, Xi Ruoyao wrote:
> On Wed, 2022-07-06 at 10:35 +0800, Huacai Chen wrote:
>
>> Maybe Xuerui and Ruoyao have some misunderstanding. LSX/LASX will
>> surely be upstream, this has nothing to do with cleanup VCSR16.
>> Because FP/LSX/LASX share the same control bits in FCSR now.
> My guess:
>
> Almost all behavior of vector unit is controlled by FCSR (for example,
> the rounding of both FPU and vector unit should be controlled by FCSR
> altogether), except one bit similar to the bit 24 of MSACSR ("flush to
> zero") is in VCSR [^1].  And "flush to zero" is not really useful so it
> will be removed in 3A6000, and we'll not use it for 3A5000.
Actually, flush to zero has been removed in 3A5000.
>
> [^1]: A more bold guess: the hardware engineers could have just said
> "let's wire this register called MSACSR in GS464V as FCSR16/VCSR in
> LA464, maybe it will be useful and who knows?"  But now in practice it's
> not useful.
>
> Am I correct?
The hardware(LA464) has removed the vcsr("has but not use" is 
incorrect), and here are some details:

- For all FP operations, including LSX/LASX, they are controlled by 
fcsr0/1/2/3.

- For LSX/LASX other operations, they are *not* controlled by any other 
CSR now. And fcsr16 to fcsr31 are reserved to control these operations 
(now they are *undefined*).

- Flush to zero(MSACSR.FS) is removed and not supported.

- If you use "movfcsr2gr" to read the fcsr16, the value is *UNDEFINED*.

