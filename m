Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958865ACD06
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbiIEHph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiIEHpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:45:34 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04A9718E0B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:45:31 -0700 (PDT)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnmsOqRVjvZoRAA--.59017S3;
        Mon, 05 Sep 2022 15:45:19 +0800 (CST)
Subject: Re: [PATCH 2/3] LoongArch: Add kdump support
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1661747823-23745-1-git-send-email-tangyouling@loongson.cn>
 <1661747823-23745-3-git-send-email-tangyouling@loongson.cn>
 <CAAhV-H6LkcnS4Z7YP=kfAkuDzKys57=6frsY0+T11ucKrWPuPw@mail.gmail.com>
 <ec447291-078f-d1ea-6c5a-21b092965e81@loongson.cn>
 <CAAhV-H4D60bGk7wr0oSw-5oJqTv_ntLtifHfdxLUdVA7ExDiLg@mail.gmail.com>
 <e76bcf5d-08c9-1d2f-8c04-149b17236929@loongson.cn>
 <CAAhV-H6fjumQesirDnOJYBMZoCQyK60WvviEw+QNnkd2wDJqdA@mail.gmail.com>
 <0e2640b5-58dc-f084-f0ff-ba277de8bd46@loongson.cn>
 <CAAhV-H68YjROzVWdECkSmMY7g_6ZrFSKJGV5RxJvFMw-5SX_PQ@mail.gmail.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kexec@lists.infradead.org, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <c4a222a6-2da0-5c9b-fa05-b572e08e1e14@loongson.cn>
Date:   Mon, 5 Sep 2022 15:45:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H68YjROzVWdECkSmMY7g_6ZrFSKJGV5RxJvFMw-5SX_PQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxnmsOqRVjvZoRAA--.59017S3
X-Coremail-Antispam: 1UD129KBjvAXoW3ZryrZr4xAw47tFWxJr4xZwb_yoW8Zry3Co
        WUJF1xJr18Gr1UJr1UJ34DZryjkw1Dtr17AryUJr4UGr1jyw17Ar1UJryUJrW7Gw1UXr4U
        Gry7Xr1jv3y7Xrn5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYQ7k0a2IF6w4kM7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0
        x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj4
        1l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0
        I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
        xwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUgVOJDUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Huacai

On 09/05/2022 03:32 PM, Huacai Chen wrote:
> Hi, Youling,
>
> On Mon, Sep 5, 2022 at 10:22 AM Youling Tang <tangyouling@loongson.cn> wrote:
>>
>>
>>
>> On 09/05/2022 10:14 AM, Huacai Chen wrote:
>>> On Mon, Sep 5, 2022 at 10:04 AM Youling Tang <tangyouling@loongson.cn> wrote:
>>>>
>>>> Hi, Huacai
>>>>
>>>> On 09/05/2022 09:38 AM, Huacai Chen wrote:
>>>>> Hi, Youling,
>>>>>
>>>>> On Mon, Sep 5, 2022 at 8:54 AM Youling Tang <tangyouling@loongson.cn> wrote:
>>>>>>
>>>>>> Hi, Huacai
>>>>>>
>>>>>> On 09/04/2022 08:21 PM, Huacai Chen wrote:
>>>>>>> Hi, Youling,
>>>>>>>
>>>>>>> I think crash.c can be merged into crash_dump.c
>>>>>>
>>>>>> Most architectures only implement copy_oldmem_page() in crash_dump.c,
>>>>>> I'm not sure if merging crash.c into crash_dump.c will break its
>>>>>> consistency?
>>>>>>
>>>>>> Thanks,
>>>>>> Youling
>>>>> Yes, you are right, crash.c cannot be merged into crash_dump.c, but it
>>>>> can be merged into machine_kexec.c, as arm64 and riscv do.
>>>>
>>>> For arm64, machine_crash_shutdown() is placed in machine_kexec.c, and
>>>> crash_smp_send_stop is placed in smp.c. If crash.c needs to be merged
>>>> into machine_kexec.c, should crash_shutdown_secondary and
>>>> crash_smp_send_stop be placed in smp.c?
>>> I don't want to touch smp.c, all merged into machine_kexec.c seems reasonable.
>>
>> Ok, I'll merge all into machine_kexec.c.
>>
>> Youling.
> Another problem, 0x9000000091000000 for PHYSICAL_START is too tricky.
> If you want to skip the "low memory", maybe we can use
> 0x9000000090000000 or 0x90000000a0000000?

Because there are many holes in our memory layout, if PHYSICAL_START is
set to 0x90000000a0000000, the largest reserved area of ​​the crashkernel
will be 512M, beyond which it will fail.

# cat /proc/iomem
90400000-bfffffff : System RAM
c0020000-f9efffff : System RAM
   f6810000-f6813fff : Reserved

The second System RAM starts at 0x90400000, so 0x9000000090000000 will
be too small.

Youling.

>
> Huacai
>>
>>>
>>> Huacai
>>>>
>>>> Youling.
>>>>>
>>>>> Huacai
>>>>>>
>>>>>>>
>>>>>>> Huacai
>>>>>>>
>>>>>>> On Mon, Aug 29, 2022 at 12:37 PM Youling Tang <tangyouling@loongson.cn> wrote:
>>>>>>>>
>>>>>>>> This patch adds support for kdump, the kernel will reserve a region
>>>>>>>> for the crash kernel and jump there on panic.
>>>>>>>>
>>>>>>>> Arch-specific functions are added to allow for implementing a crash
>>>>>>>> dump file interface, /proc/vmcore, which can be viewed as a ELF file.
>>>>>>>>
>>>>>>>> A user space tool, like kexec-tools, is responsible for allocating a
>>>>>>>> separate region for the core's ELF header within crash kdump kernel
>>>>>>>> memory and filling it in when executing kexec_load().
>>>>>>>>
>>>>>>>> Then, its location will be advertised to crash dump kernel via a new
>>>>>>>> device-tree property, "linux,elfcorehdr", and crash dump kernel preserves
>>>>>>>> the region for later use with fdt_reserve_elfcorehdr() at boot time.
>>>>>>>>
>>>>>>>> At the same time, it will also limit the crash kdump kernel to the
>>>>>>>> crashkernel area via a new device-tree property, "linux, usable-memory-range",
>>>>>>>> so as not to destroy the original kernel dump data.
>>>>>>>>
>>>>>>>> On crash dump kernel, /proc/vmcore will access the primary kernel's memory
>>>>>>>> with copy_oldmem_page().
>>>>>>>>
>>>>>>>> I tested this on  LoongArch 3A5000 machine and works as expected (Suggest
>>>>>>>> crashkernel parameter is "crashkernel=512M@2320M"), you may test it by
>>>>>>>> triggering a crash through /proc/sysrq_trigger:
>>>>>>>>
>>>>>>>>  $ sudo kexec -p /boot/vmlinux-kdump --reuse-cmdline --append="nr_cpus=1"
>>>>>>>>  # echo c > /proc/sysrq_trigger
>>>>>>>>
>>>>>>>> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
>>>>>>>> ---
>>>>>>>>  arch/loongarch/Kconfig                  |  22 ++++++
>>>>>>>>  arch/loongarch/Makefile                 |   4 +
>>>>>>>>  arch/loongarch/kernel/Makefile          |   3 +-
>>>>>>>>  arch/loongarch/kernel/crash.c           | 100 ++++++++++++++++++++++++
>>>>>>>>  arch/loongarch/kernel/crash_dump.c      |  19 +++++
>>>>>>>>  arch/loongarch/kernel/machine_kexec.c   |  12 ++-
>>>>>>>>  arch/loongarch/kernel/mem.c             |   6 ++
>>>>>>>>  arch/loongarch/kernel/relocate_kernel.S |   6 ++
>>>>>>>>  arch/loongarch/kernel/setup.c           |  49 ++++++++++++
>>>>>>>>  arch/loongarch/kernel/traps.c           |   4 +
>>>>>>>>  10 files changed, 217 insertions(+), 8 deletions(-)
>>>>>>>>  create mode 100644 arch/loongarch/kernel/crash.c
>>>>>>>>  create mode 100644 arch/loongarch/kernel/crash_dump.c
>>>>>>>>
>>>>>>>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>>>>>>>> index 903c82fa958d..7c1b07a5b5bd 100644
>>>>>>>> --- a/arch/loongarch/Kconfig
>>>>>>>> +++ b/arch/loongarch/Kconfig
>>>>>>>> @@ -420,6 +420,28 @@ config KEXEC
>>>>>>>>
>>>>>>>>           The name comes from the similarity to the exec system call.
>>>>>>>>
>>>>>>>> +config CRASH_DUMP
>>>>>>>> +       bool "Build kdump crash kernel"
>>>>>>>> +       help
>>>>>>>> +         Generate crash dump after being started by kexec. This should
>>>>>>>> +         be normally only set in special crash dump kernels which are
>>>>>>>> +         loaded in the main kernel with kexec-tools into a specially
>>>>>>>> +         reserved region and then later executed after a crash by
>>>>>>>> +         kdump/kexec.
>>>>>>>> +
>>>>>>>> +         For more details see Documentation/admin-guide/kdump/kdump.rst
>>>>>>>> +
>>>>>>>> +config PHYSICAL_START
>>>>>>>> +       hex "Physical address where the kernel is loaded"
>>>>>>>> +       default "0x9000000091000000" if 64BIT
>>>>>>>> +       depends on CRASH_DUMP
>>>>>>>> +       help
>>>>>>>> +         This gives the XKPRANGE address where the kernel is loaded.
>>>>>>>> +         If you plan to use kernel for capturing the crash dump change
>>>>>>>> +         this value to start of the reserved region (the "X" value as
>>>>>>>> +         specified in the "crashkernel=YM@XM" command line boot parameter
>>>>>>>> +         passed to the panic-ed kernel).
>>>>>>>> +
>>>>>>>>  config SECCOMP
>>>>>>>>         bool "Enable seccomp to safely compute untrusted bytecode"
>>>>>>>>         depends on PROC_FS
>>>>>>>> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
>>>>>>>> index 4bc47f47cfd8..7dabd580426d 100644
>>>>>>>> --- a/arch/loongarch/Makefile
>>>>>>>> +++ b/arch/loongarch/Makefile
>>>>>>>> @@ -48,7 +48,11 @@ KBUILD_CFLAGS_MODULE         += -fplt -Wa,-mla-global-with-abs,-mla-local-with-abs
>>>>>>>>  cflags-y += -ffreestanding
>>>>>>>>  cflags-y += $(call cc-option, -mno-check-zero-division)
>>>>>>>>
>>>>>>>> +ifdef CONFIG_PHYSICAL_START
>>>>>>>> +load-y         = $(CONFIG_PHYSICAL_START)
>>>>>>>> +else
>>>>>>>>  load-y         = 0x9000000000200000
>>>>>>>> +endif
>>>>>>>>  bootvars-y     = VMLINUX_LOAD_ADDRESS=$(load-y)
>>>>>>>>
>>>>>>>>  drivers-$(CONFIG_PCI)          += arch/loongarch/pci/
>>>>>>>> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
>>>>>>>> index 20b64ac3f128..df5aea129364 100644
>>>>>>>> --- a/arch/loongarch/kernel/Makefile
>>>>>>>> +++ b/arch/loongarch/kernel/Makefile
>>>>>>>> @@ -17,7 +17,8 @@ obj-$(CONFIG_CPU_HAS_FPU)     += fpu.o
>>>>>>>>  obj-$(CONFIG_MODULES)          += module.o module-sections.o
>>>>>>>>  obj-$(CONFIG_STACKTRACE)       += stacktrace.o
>>>>>>>>
>>>>>>>> -obj-$(CONFIG_KEXEC)             += machine_kexec.o relocate_kernel.o
>>>>>>>> +obj-$(CONFIG_KEXEC)             += machine_kexec.o relocate_kernel.o crash.o
>>>>>>>> +obj-$(CONFIG_CRASH_DUMP)        += crash_dump.o
>>>>>>>>
>>>>>>>>  obj-$(CONFIG_PROC_FS)          += proc.o
>>>>>>>>
>>>>>>>> diff --git a/arch/loongarch/kernel/crash.c b/arch/loongarch/kernel/crash.c
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..b4f249ec6301
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/arch/loongarch/kernel/crash.c
>>>>>>>> @@ -0,0 +1,100 @@
>>>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>>>> +/*
>>>>>>>> + * Copyright (C) 2022 Loongson Technology Corporation Limited
>>>>>>>> + *
>>>>>>>> + * Derived from MIPS
>>>>>>>> + */
>>>>>>>> +#include <linux/kernel.h>
>>>>>>>> +#include <linux/smp.h>
>>>>>>>> +#include <linux/reboot.h>
>>>>>>>> +#include <linux/crash_dump.h>
>>>>>>>> +#include <linux/delay.h>
>>>>>>>> +#include <linux/irq.h>
>>>>>>>> +#include <linux/types.h>
>>>>>>>> +#include <linux/sched.h>
>>>>>>>> +#include <linux/sched/task_stack.h>
>>>>>>>> +#include <asm/cacheflush.h>
>>>>>>>> +#include <asm/kexec.h>
>>>>>>>> +
>>>>>>>> +static cpumask_t cpus_in_crash = CPU_MASK_NONE;
>>>>>>>> +
>>>>>>>> +#ifdef CONFIG_SMP
>>>>>>>> +static void crash_shutdown_secondary(void *passed_regs)
>>>>>>>> +{
>>>>>>>> +       struct pt_regs *regs = passed_regs;
>>>>>>>> +       int cpu = smp_processor_id();
>>>>>>>> +
>>>>>>>> +       /*
>>>>>>>> +        * If we are passed registers, use those.  Otherwise get the
>>>>>>>> +        * regs from the last interrupt, which should be correct, as
>>>>>>>> +        * we are in an interrupt.  But if the regs are not there,
>>>>>>>> +        * pull them from the top of the stack.  They are probably
>>>>>>>> +        * wrong, but we need something to keep from crashing again.
>>>>>>>> +        */
>>>>>>>> +       if (!regs)
>>>>>>>> +               regs = get_irq_regs();
>>>>>>>> +       if (!regs)
>>>>>>>> +               regs = task_pt_regs(current);
>>>>>>>> +
>>>>>>>> +       local_irq_disable();
>>>>>>>> +       if (!cpumask_test_cpu(cpu, &cpus_in_crash))
>>>>>>>> +               crash_save_cpu(regs, cpu);
>>>>>>>> +       cpumask_set_cpu(cpu, &cpus_in_crash);
>>>>>>>> +
>>>>>>>> +       while (!atomic_read(&kexec_ready_to_reboot))
>>>>>>>> +               cpu_relax();
>>>>>>>> +
>>>>>>>> +       kexec_reboot();
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +/* Override the weak function in kernel/panic.c */
>>>>>>>> +void crash_smp_send_stop(void)
>>>>>>>> +{
>>>>>>>> +       static int cpus_stopped;
>>>>>>>> +       unsigned long timeout;
>>>>>>>> +       unsigned int ncpus;
>>>>>>>> +
>>>>>>>> +       /*
>>>>>>>> +        * This function can be called twice in panic path, but obviously
>>>>>>>> +        * we execute this only once.
>>>>>>>> +        */
>>>>>>>> +       if (cpus_stopped)
>>>>>>>> +               return;
>>>>>>>> +
>>>>>>>> +       cpus_stopped = 1;
>>>>>>>> +
>>>>>>>> +        /* Excluding the panic cpu */
>>>>>>>> +       ncpus = num_online_cpus() - 1;
>>>>>>>> +
>>>>>>>> +       smp_call_function(crash_shutdown_secondary, NULL, 0);
>>>>>>>> +       smp_wmb();
>>>>>>>> +
>>>>>>>> +       /*
>>>>>>>> +        * The crash CPU sends an IPI and wait for other CPUs to
>>>>>>>> +        * respond. Delay of at least 10 seconds.
>>>>>>>> +        */
>>>>>>>> +       pr_emerg("Sending IPI to other cpus...\n");
>>>>>>>> +       timeout = USEC_PER_SEC * 10;
>>>>>>>> +       while ((cpumask_weight(&cpus_in_crash) < ncpus) && timeout--) {
>>>>>>>> +               cpu_relax();
>>>>>>>> +               udelay(1);
>>>>>>>> +       }
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +#endif
>>>>>>>> +
>>>>>>>> +void machine_crash_shutdown(struct pt_regs *regs)
>>>>>>>> +{
>>>>>>>> +       int crashing_cpu;
>>>>>>>> +
>>>>>>>> +       local_irq_disable();
>>>>>>>> +
>>>>>>>> +       crashing_cpu = smp_processor_id();
>>>>>>>> +       crash_save_cpu(regs, crashing_cpu);
>>>>>>>> +
>>>>>>>> +       /* shutdown non-crashing cpus */
>>>>>>>> +       crash_smp_send_stop();
>>>>>>>> +       cpumask_set_cpu(crashing_cpu, &cpus_in_crash);
>>>>>>>> +
>>>>>>>> +       pr_info("Starting crashdump kernel...\n");
>>>>>>>> +}
>>>>>>>> diff --git a/arch/loongarch/kernel/crash_dump.c b/arch/loongarch/kernel/crash_dump.c
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..13e5d2f7870d
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/arch/loongarch/kernel/crash_dump.c
>>>>>>>> @@ -0,0 +1,19 @@
>>>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>>>> +#include <linux/highmem.h>
>>>>>>>> +#include <linux/crash_dump.h>
>>>>>>>> +#include <linux/io.h>
>>>>>>>> +
>>>>>>>> +ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
>>>>>>>> +                        size_t csize, unsigned long offset)
>>>>>>>> +{
>>>>>>>> +       void  *vaddr;
>>>>>>>> +
>>>>>>>> +       if (!csize)
>>>>>>>> +               return 0;
>>>>>>>> +
>>>>>>>> +       vaddr = kmap_local_pfn(pfn);
>>>>>>>> +       csize = copy_to_iter(vaddr + offset, csize, iter);
>>>>>>>> +       kunmap_local(vaddr);
>>>>>>>> +
>>>>>>>> +       return csize;
>>>>>>>> +}
>>>>>>>> diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
>>>>>>>> index 4ffcd4cd9c8c..f793a3ff09a3 100644
>>>>>>>> --- a/arch/loongarch/kernel/machine_kexec.c
>>>>>>>> +++ b/arch/loongarch/kernel/machine_kexec.c
>>>>>>>> @@ -69,7 +69,7 @@ int machine_kexec_prepare(struct kimage *kimage)
>>>>>>>>                 continue;
>>>>>>>>         }
>>>>>>>>
>>>>>>>> -       /* kexec need a safe page to save reboot_code_buffer */
>>>>>>>> +       /* kexec/kdump need a safe page to save reboot_code_buffer */
>>>>>>>>         kimage->control_code_page = virt_to_page((void *)KEXEC_CTRL_CODE);
>>>>>>>>
>>>>>>>>         reboot_code_buffer =
>>>>>>>> @@ -113,10 +113,6 @@ static void kexec_shutdown_secondary(void *)
>>>>>>>>
>>>>>>>>         kexec_reboot();
>>>>>>>>  }
>>>>>>>> -
>>>>>>>> -void machine_crash_shutdown(struct pt_regs *regs)
>>>>>>>> -{
>>>>>>>> -}
>>>>>>>>  #endif
>>>>>>>>
>>>>>>>>  void machine_shutdown(void)
>>>>>>>> @@ -135,7 +131,8 @@ void machine_kexec(struct kimage *image)
>>>>>>>>
>>>>>>>>         jump_addr = (unsigned long)phys_to_virt(image->start);
>>>>>>>>
>>>>>>>> -       first_ind_entry = (unsigned long)phys_to_virt(image->head & PAGE_MASK);
>>>>>>>> +       if (image->type == KEXEC_TYPE_DEFAULT)
>>>>>>>> +               first_ind_entry = (unsigned long)phys_to_virt(image->head & PAGE_MASK);
>>>>>>>>
>>>>>>>>         /*
>>>>>>>>          * The generic kexec code builds a page list with physical
>>>>>>>> @@ -167,7 +164,8 @@ void machine_kexec(struct kimage *image)
>>>>>>>>
>>>>>>>>         /*
>>>>>>>>          * We know we were online, and there will be no incoming IPIs at
>>>>>>>> -        * this point.
>>>>>>>> +        * this point. Mark online again before rebooting so that the crash
>>>>>>>> +        * analysis tool will see us correctly.
>>>>>>>>          */
>>>>>>>>         set_cpu_online(smp_processor_id(), true);
>>>>>>>>
>>>>>>>> diff --git a/arch/loongarch/kernel/mem.c b/arch/loongarch/kernel/mem.c
>>>>>>>> index 7423361b0ebc..c6def6ff81c8 100644
>>>>>>>> --- a/arch/loongarch/kernel/mem.c
>>>>>>>> +++ b/arch/loongarch/kernel/mem.c
>>>>>>>> @@ -5,6 +5,7 @@
>>>>>>>>  #include <linux/efi.h>
>>>>>>>>  #include <linux/initrd.h>
>>>>>>>>  #include <linux/memblock.h>
>>>>>>>> +#include <linux/of_fdt.h>
>>>>>>>>
>>>>>>>>  #include <asm/bootinfo.h>
>>>>>>>>  #include <asm/loongson.h>
>>>>>>>> @@ -61,4 +62,9 @@ void __init memblock_init(void)
>>>>>>>>
>>>>>>>>         /* Reserve the initrd */
>>>>>>>>         reserve_initrd_mem();
>>>>>>>> +
>>>>>>>> +       /* Mainly reserved memory for the elf core head */
>>>>>>>> +       early_init_fdt_scan_reserved_mem();
>>>>>>>> +       /* Parse linux,usable-memory-range is for crash dump kernel */
>>>>>>>> +       early_init_dt_check_for_usable_mem_range();
>>>>>>>>  }
>>>>>>>> diff --git a/arch/loongarch/kernel/relocate_kernel.S b/arch/loongarch/kernel/relocate_kernel.S
>>>>>>>> index d1f242f74ea8..4ee5ac4ac2d7 100644
>>>>>>>> --- a/arch/loongarch/kernel/relocate_kernel.S
>>>>>>>> +++ b/arch/loongarch/kernel/relocate_kernel.S
>>>>>>>> @@ -28,6 +28,12 @@ SYM_CODE_START(relocate_new_kernel)
>>>>>>>>         move            s2, a2
>>>>>>>>         move            s3, a3
>>>>>>>>
>>>>>>>> +       /*
>>>>>>>> +        * In case of a kdump/crash kernel, the indirection page is not
>>>>>>>> +        * populated as the kernel is directly copied to a reserved location
>>>>>>>> +        */
>>>>>>>> +       beqz            s2, done
>>>>>>>> +
>>>>>>>>  process_entry:
>>>>>>>>         PTR_L           s4, s2, 0
>>>>>>>>         PTR_ADDI        s2, s2, SZREG
>>>>>>>> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
>>>>>>>> index f938aae3e92c..ea34b77e402f 100644
>>>>>>>> --- a/arch/loongarch/kernel/setup.c
>>>>>>>> +++ b/arch/loongarch/kernel/setup.c
>>>>>>>> @@ -19,6 +19,8 @@
>>>>>>>>  #include <linux/memblock.h>
>>>>>>>>  #include <linux/initrd.h>
>>>>>>>>  #include <linux/ioport.h>
>>>>>>>> +#include <linux/kexec.h>
>>>>>>>> +#include <linux/crash_dump.h>
>>>>>>>>  #include <linux/root_dev.h>
>>>>>>>>  #include <linux/console.h>
>>>>>>>>  #include <linux/pfn.h>
>>>>>>>> @@ -186,6 +188,50 @@ static int __init early_parse_mem(char *p)
>>>>>>>>  }
>>>>>>>>  early_param("mem", early_parse_mem);
>>>>>>>>
>>>>>>>> +static void __init loongarch_parse_crashkernel(void)
>>>>>>>> +{
>>>>>>>> +#ifdef CONFIG_KEXEC
>>>>>>>> +       unsigned long long start;
>>>>>>>> +       unsigned long long total_mem;
>>>>>>>> +       unsigned long long crash_size, crash_base;
>>>>>>>> +       int ret;
>>>>>>>> +
>>>>>>>> +       total_mem = memblock_phys_mem_size();
>>>>>>>> +       ret = parse_crashkernel(boot_command_line, total_mem,
>>>>>>>> +                               &crash_size, &crash_base);
>>>>>>>> +       if (ret != 0 || crash_size <= 0)
>>>>>>>> +               return;
>>>>>>>> +
>>>>>>>> +
>>>>>>>> +       start = memblock_phys_alloc_range(crash_size, 1, crash_base,
>>>>>>>> +                                       crash_base + crash_size);
>>>>>>>> +       if (start != crash_base) {
>>>>>>>> +               pr_warn("Invalid memory region reserved for crash kernel\n");
>>>>>>>> +               return;
>>>>>>>> +       }
>>>>>>>> +
>>>>>>>> +       crashk_res.start = crash_base;
>>>>>>>> +       crashk_res.end   = crash_base + crash_size - 1;
>>>>>>>> +#endif
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void __init request_crashkernel(struct resource *res)
>>>>>>>> +{
>>>>>>>> +#ifdef CONFIG_KEXEC
>>>>>>>> +       int ret;
>>>>>>>> +
>>>>>>>> +       if (crashk_res.start == crashk_res.end)
>>>>>>>> +               return;
>>>>>>>> +
>>>>>>>> +       ret = request_resource(res, &crashk_res);
>>>>>>>> +       if (!ret)
>>>>>>>> +               pr_info("Reserving %ldMB of memory at %ldMB for crashkernel\n",
>>>>>>>> +                       (unsigned long)((crashk_res.end -
>>>>>>>> +                                        crashk_res.start + 1) >> 20),
>>>>>>>> +                       (unsigned long)(crashk_res.start  >> 20));
>>>>>>>> +#endif
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>  void __init platform_init(void)
>>>>>>>>  {
>>>>>>>>         efi_init();
>>>>>>>> @@ -229,6 +275,8 @@ static void __init arch_mem_init(char **cmdline_p)
>>>>>>>>
>>>>>>>>         check_kernel_sections_mem();
>>>>>>>>
>>>>>>>> +       loongarch_parse_crashkernel();
>>>>>>>> +
>>>>>>>>         /*
>>>>>>>>          * In order to reduce the possibility of kernel panic when failed to
>>>>>>>>          * get IO TLB memory under CONFIG_SWIOTLB, it is better to allocate
>>>>>>>> @@ -290,6 +338,7 @@ static void __init resource_init(void)
>>>>>>>>                 request_resource(res, &code_resource);
>>>>>>>>                 request_resource(res, &data_resource);
>>>>>>>>                 request_resource(res, &bss_resource);
>>>>>>>> +               request_crashkernel(res);
>>>>>>>>         }
>>>>>>>>  }
>>>>>>>>
>>>>>>>> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
>>>>>>>> index aa1c95aaf595..0e610872f3f4 100644
>>>>>>>> --- a/arch/loongarch/kernel/traps.c
>>>>>>>> +++ b/arch/loongarch/kernel/traps.c
>>>>>>>> @@ -10,6 +10,7 @@
>>>>>>>>  #include <linux/entry-common.h>
>>>>>>>>  #include <linux/init.h>
>>>>>>>>  #include <linux/kernel.h>
>>>>>>>> +#include <linux/kexec.h>
>>>>>>>>  #include <linux/module.h>
>>>>>>>>  #include <linux/extable.h>
>>>>>>>>  #include <linux/mm.h>
>>>>>>>> @@ -246,6 +247,9 @@ void __noreturn die(const char *str, struct pt_regs *regs)
>>>>>>>>
>>>>>>>>         oops_exit();
>>>>>>>>
>>>>>>>> +       if (regs && kexec_should_crash(current))
>>>>>>>> +               crash_kexec(regs);
>>>>>>>> +
>>>>>>>>         if (in_interrupt())
>>>>>>>>                 panic("Fatal exception in interrupt");
>>>>>>>>
>>>>>>>> --
>>>>>>>> 2.36.0
>>>>>>>>
>>>>>>
>>>>
>>

