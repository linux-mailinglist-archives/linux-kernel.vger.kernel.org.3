Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650E658681C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiHAL2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiHAL2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:28:48 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1B63226
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:28:46 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxAM_ruOdiVSoAAA--.951S3;
        Mon, 01 Aug 2022 19:28:44 +0800 (CST)
Subject: Re: [PATCH v4 0/4] LoongArch: Support new relocation types
To:     Jinyang He <hejinyang@loongson.cn>
References: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
 <ec52fd49-4a30-15d9-3d32-fd7bc6d8b3f0@loongson.cn>
 <0179679b736aea7258981dec2d83107cce74dfc1.camel@xry111.site>
 <a139a8475fe295ac9f17064269cd0312dca6f96e.camel@xry111.site>
 <6b5d2188f93ed72b67a4bbb7116113f833fe1ee5.camel@xry111.site>
 <d7670b60-2782-4642-995b-7baa01779a66@loongson.cn>
 <7cad6e78014168a8906e130e1cf3809077d2bda7.camel@xry111.site>
 <1d0783b87bda3e454a111862fcc5b5faffcb16b0.camel@xry111.site>
 <00eede4b1380888a500f74b1e818bb25a550632b.camel@xry111.site>
 <7512ae16-b171-d072-674f-a6b9a5e764d6@loongson.cn>
 <CAAhV-H5wSJZ2X46ySqoaJd7Z2soGcYKRNixnghmE3f3zEzyS+w@mail.gmail.com>
 <10751c9af5d45fea741e0bbed6c818ddb9db3ac3.camel@xry111.site>
 <7b1f9813-85fc-acfd-8e24-7e01469ded3a@loongson.cn>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Lulu Cheng <chenglulu@loongson.cn>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <ba5e99de-0719-af88-4d94-8860787a4251@loongson.cn>
Date:   Mon, 1 Aug 2022 19:28:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <7b1f9813-85fc-acfd-8e24-7e01469ded3a@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxAM_ruOdiVSoAAA--.951S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF43Jr4ktF1kJry3CrW8tFb_yoWrAw4rpF
        ZrGFWUKr4DJr1Fyanrtw1Uua4jvws8JryxXw15tryUZFyqvrn3Kr47tw45uFy7Xr1kG3WU
        ZrWUA34xXrW5ZwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CEbIxv
        r21lc2xSY4AK67AK6r4kMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjfU0PEfUUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jinyang

On 08/01/2022 06:08 PM, Jinyang He wrote:
> On 08/01/2022 05:55 PM, Xi Ruoyao wrote:
>
>> On Mon, 2022-08-01 at 10:34 +0800, Huacai Chen wrote:
>>> Hi, all,
>>>
>>> On Mon, Aug 1, 2022 at 10:16 AM Youling Tang <tangyouling@loongson.cn>
>>> wrote:
>>>> Hi, Ruoyao
>>>>
>>>> On 07/30/2022 10:52 AM, Xi Ruoyao wrote:
>>>>> On Sat, 2022-07-30 at 10:24 +0800, Xi Ruoyao wrote:
>>>>>> On Sat, 2022-07-30 at 01:55 +0800, Xi Ruoyao wrote:
>>>>>>> On Fri, 2022-07-29 at 20:19 +0800, Youling Tang wrote:
>>>>>>>
>>>>>>>> On 07/29/2022 07:45 PM, Xi Ruoyao wrote:
>>>>>>>>> Hmm... The problem is the "addresses" of per-cpu symbols
>>>>>>>>> are
>>>>>>>>> faked: they
>>>>>>>>> are actually offsets from $r21.  So we can't just load
>>>>>>>>> such an
>>>>>>>>> offset
>>>>>>>>> with PCALA addressing.
>>>>>>>>>
>>>>>>>>> It looks like we'll need to introduce an attribute for GCC
>>>>>>>>> to
>>>>>>>>> make
>>>>>>>>> an
>>>>>>>>> variable "must be addressed via GOT", and add the
>>>>>>>>> attribute into
>>>>>>>>> PER_CPU_ATTRIBUTES.
>>>>>>>> Yes, we need a GCC attribute to specify the per-cpu
>>>>>>>> variable.
>>>>>>> GCC patch adding "addr_global" attribute for LoongArch:
>>>>>>> https://gcc.gnu.org/pipermail/gcc-patches/2022-July/599064.html
>>>>>>>
>>>>>>> An experiment to use it:
>>>>>>> https://github.com/xry111/linux/commit/c1d5d70
>>>>>> Correction: https://github.com/xry111/linux/commit/c1d5d708
>>>>>>
>>>>>> It seems 7-bit SHA is not enough for kernel repo.
>>>>> If addr_global is rejected or not implemented (for example,
>>>>> building the
>>>>> kernel with GCC 12), *I expect* the following hack to work (I've
>>>>> not
>>>>> tested it because I'm AFK now).  Using visibility in kernel seems
>>>>> strange, but I think it may make some sense because the modules
>>>>> are some
>>>>> sort of similar to an ELF shared object being dlopen()'ed, and our
>>>>> way
>>>>> to inject per-CPU symbols is analog to ELF interposition.
>>>>>
>>>>> arch/loongarch/include/asm/percpu.h:
>>>>>
>>>>>     #if !__has_attribute(__addr_global__) && defined(MODULE)
>>>>>     /* Magically remove "static" for per-CPU variables.  */
>>>>>     # define ARCH_NEEDS_WEAK_PER_CPU
>>>>>     /* Force GOT-relocation for per-CPU variables.  */
>>>>>     # define PER_CPU_ATTRIBUTES
>>>>> __attribute__((__visibility__("default")))
>>>>>     #endif
>>>>>
>>>>> arch/loongarch/Makefile:
>>>>>
>>>>>     # Hack for per-CPU variables, see PER_CPU_ATTRIBUTES in
>>>>>     # include/asm/percpu.h
>>>>>     if (call gcc-does-not-support-addr-global)
>>>>>       KBUILD_CFLAGS_MODULE += -fPIC -fvisibility=hidden
>>>>>     endif
>>>>>
>>>> Using the old toolchain (GCC 12) can successfully load the
>>>> nf_tables.ko
>>>> module after applying the above patch.
>>> I don't like such a hack..., can we consider using old relocation
>>> types when building by old toolchains?
>>
>> I don't like the hack too.  I only developed it as an intellectual game.
>>
>> We need to consider multiple combinations:
>>
>> (1) Old GCC + old Binutils.  We need -mla-local-with-abs for
>> KBUILD_CFLAGS_MODULE.
>>
>> (2) Old GCC + new Binutils.  We need -mla-local-with-abs for
>> KBUILD_CFLAGS_MODULE, *and* adding the support for
>> R_LARCH_ABS{_HI20,_LO12,64_LO20,64_HI12} in the kernel module loader.
>>
>> (3) New GCC + old Binutils.  As new GCC should support our new attribute
>> (I now intend to send V2 patch to gcc-patches using "movable" as the
>> attribute name), no special action is needed.
>>
>> Basically, we need:
>>
>> (1) Handle R_LARCH_ABS{_HI20,_LO12,64_LO20,64_HI12} in the kernel module
>> loader.
>> (2) Add -Wa,-mla-local-with-abs into KBUILD_CFLAGS_MODULE if GCC version
>> is <= 12.
>
> Actually, I really hope kernel image is in the XKVRANGE, rather
> than being in XKPRANGE. So that we can limit kernel and modules
> be in 4GB range. I think it will make all work normally. :-(
>

Assuming that the kernel and modules are limited to 4G, the external
symbols will be accessed through pcrel32, which means that there is no
need to pass the GOT table entry, and there is no need for got support,
so there will be no percpu problem, and it will make all work normally?

Youling.

