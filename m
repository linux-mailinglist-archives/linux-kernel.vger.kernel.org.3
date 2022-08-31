Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9EB5A76F9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiHaG61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHaG6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:58:25 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88954BFC51
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:58:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxT+CLBg9jHoYNAA--.60052S3;
        Wed, 31 Aug 2022 14:58:21 +0800 (CST)
Subject: Re: [PATCH v7 0/5] LoongArch: Support toolchain with new relocation
 types
To:     Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
References: <20220830104806.128365-1-xry111@xry111.site>
 <CAAhV-H5bH7xZTWLhqcZ_Bmh=RNaEVBy9523hmj-gTmitqqc8ag@mail.gmail.com>
 <c0ba2e23-5be3-924d-554a-2f10272c05bc@xen0n.name>
 <CAAhV-H7Dz21qRgwkMcJ0SnA9FNDN19E6mpa7C25LUitrO9LGeA@mail.gmail.com>
 <5b87173faeef587a2ffaaa6f58d34e0940231067.camel@xry111.site>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Youling Tang <tangyouling@loongson.cn>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <c53303bf-a5d2-098f-8975-efadbe0b2f2e@loongson.cn>
Date:   Wed, 31 Aug 2022 14:58:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <5b87173faeef587a2ffaaa6f58d34e0940231067.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxT+CLBg9jHoYNAA--.60052S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4kKF4DAFWfuF43tw17Awb_yoW8ury8pF
        W5Kr95tF4UuFW8A3Z7tF1Iva4fXw1kA34agFy5Ka48Aan8uasaqrZYva17ZFyqywn5ur40
        gryrtry0kF18ZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUU
        U==
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2022 02:10 PM, Xi Ruoyao wrote:

> On Wed, 2022-08-31 at 13:44 +0800, Huacai Chen wrote:
>
>> With this series applied and ARCH_WANT_LD_ORPHAN_WARN enabled, we get
>> loongarch64-unknown-linux-gnu-ld: warning: orphan section `.got' from
>> `arch/loongarch/kernel/head.o' being placed in section `.got'
>> loongarch64-unknown-linux-gnu-ld: warning: orphan section `.got.plt'
>> from `arch/loongarch/kernel/head.o' being placed in section `.got.plt'
>>
>> I think we should add this lines in vmlinux.lds.S
>>          .got : { *(.got) }
>>          .got.plt : { *(.got.plt) }
>>
>> But put them to which patch? Patch 2 or Patch 5?
> In patch 2 IMO.  Because in patch 2 we already know "-Wa,-mla-global-
> with-pcrel" does not prevent the generation of GOT with new toolchain.
>
> If you need a v8 please tell me to send it, but I don't know how to
> handle -Woverride-init warnings (IMO the fix for this warning should be
> a standalone patch outside of the series).
>
> P. S. The ld warning message seems a little strange because "head.o"
> does not contain .got or .got.plt sections...  I guess there is a linker
> bug causing it outputs the very first input file in the message, instead
> of the first input file really containing an orphaned section.
>
> Another P. S.: the use of GOT is actually unneeded in main kernel image
> but we don't have something equivalent to "-Wa,-mla-global-with-pcrel"
> in the new toolchain.  Perhaps we can add this feature to GCC later.
>
That's right. Also I am wondering why new toolchain produce .got* in
kernel. It's unneeded. In the past, gcc create la.global and parsed
to la.pcrel by gas, and kernel works well. Now it seems we lost this
feature in gcc. I checked the x86 asm code just now. And some info
follows,

LoongArch64, ./net/ipv4/udp_diag.s, *have reloc hint*
         pcalau12i       $r4,%got_pc_hi20(udplite_table)
         ld.d    $r4,$r4,%got_pc_lo12(udplite_table)
         b       udp_dump

x86_64, ./net/ipv4/udp_diag.s
         movq    $udplite_table, %rdi
         jmp     udp_dump

It seems related to -fno-PIE and -cmodel=kernel on x86_64.
Hope new gcc with this feature now.

