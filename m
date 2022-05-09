Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DC951F50B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbiEIHFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbiEIGzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:55:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76C5115C9C
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 23:51:32 -0700 (PDT)
Received: from kwepemi100025.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KxWyv47JdzhZ2X;
        Mon,  9 May 2022 14:50:47 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi100025.china.huawei.com (7.221.188.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 14:51:23 +0800
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 14:51:22 +0800
Subject: Re: [PATCH 2/2] riscv: kprobe: Allow coexistence of ftrace and kprobe
To:     Guo Ren <guoren@kernel.org>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        "Anil S Keshavamurthy" <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>, <jszhang@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, <liaochang1@huawei.com>,
        =?UTF-8?Q?Patrick_St=c3=a4hlin?= <me@packi.ch>,
        Pekka Enberg <penberg@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20220426015751.88582-1-lihuafei1@huawei.com>
 <20220426015751.88582-2-lihuafei1@huawei.com>
 <CAJF2gTRSBcxr3+f86PSiy706dkvxEWA+90JCA4658ZwVf7sB5w@mail.gmail.com>
 <CAJF2gTR+EgsgCOuRbEGwpjRcAmbdqOGw9KK6AuDnyHQy95v9mA@mail.gmail.com>
 <022b5310-0084-0327-721a-49ee8bcde346@huawei.com>
 <CAJF2gTRj1xhUz4f847zx7B1w1enUCKcVqoVF5EdpZN9govMX8w@mail.gmail.com>
From:   Li Huafei <lihuafei1@huawei.com>
Message-ID: <2a577c23-6ca2-b43e-85e4-1f409eab7a88@huawei.com>
Date:   Mon, 9 May 2022 14:51:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAJF2gTRj1xhUz4f847zx7B1w1enUCKcVqoVF5EdpZN9govMX8w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.67.110.237]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo Ren,

On 2022/4/30 15:08, Guo Ren wrote:
> On Fri, Apr 29, 2022 at 5:15 PM Li Huafei <lihuafei1@huawei.com> wrote:
>> Hi Guo Ren,
>>
>> On 2022/4/26 16:16, Guo Ren wrote:
>>> On Tue, Apr 26, 2022 at 4:01 PM Guo Ren <guoren@kernel.org> wrote:
>>>> On Tue, Apr 26, 2022 at 9:59 AM Li Huafei <lihuafei1@huawei.com> wrote:
>>>>> When using ftrace and kprobe at the same time, it was found that one
>>>>> might cause the other to be unavailable. This can be reproduced by the
>>>>> following steps.
>>>>>
>>>>>     # cd /sys/kernel/debug/tracing/
>>>>>     # echo cmdline_proc_show > set_ftrace_filter
>>>>>     # echo function > current_tracer
>>>>>     # echo 'p cmdline_proc_show' > kprobe_events
>>>>>     # echo 'p cmdline_proc_show+4' >> kprobe_events
>>>>>     # ls events/kprobes/
>>>>>     enable                 p_cmdline_proc_show_0
>>>>>     filter                 p_cmdline_proc_show_4
>>>>>     # echo 1 > events/kprobes/p_cmdline_proc_show_4/enable
>>>>>     # echo 1 > events/kprobes/p_cmdline_proc_show_0/enable
>>>>>     [  129.830108] 00000000ebed457d: expected (ffdb0097 4f0080e7) but got (00100073 4f0080e7)
>>>>>     [  129.835990] ------------[ ftrace bug ]------------
>>>>>     [  129.839510] ftrace failed to modify
>>>>>     [  129.839536] [<ffffffff80258910>] cmdline_proc_show+0x0/0x46
>>>>>     [  129.845831]  actual:   23:3c:11:fe:73:00:10:00
>>>>>     [  129.849299] Updating ftrace call site to call a different ftrace function
>>>>>     [  129.853998] ftrace record flags: e0000002
>>>>>     [  129.856771]  (2) R
>>>>>     [  129.856771]  expected tramp: ffffffff80008e60
>>>>>     [  129.861688] ------------[ cut here ]------------
>>>>>     [  129.865092] WARNING: CPU: 0 PID: 14 at kernel/trace/ftrace.c:2085 ftrace_bug+0x21a/0x24c
>>>>>     [  129.870949] Modules linked in:
>>>>>     [  129.873301] CPU: 0 PID: 14 Comm: migration/0 Not tainted 5.18.0-rc3-00002-gd8bfcd250f58 #6
>>>>>     [  129.879217] Hardware name: riscv-virtio,qemu (DT)
>>>>>     [  129.882666] Stopper: multi_cpu_stop+0x0/0x168 <- stop_machine_cpuslocked+0xfa/0x12e
>>>>>     [  129.888430] epc : ftrace_bug+0x21a/0x24c
>>>>>     [  129.891254]  ra : ftrace_bug+0x21a/0x24c
>>>>>     [  129.894057] epc : ffffffff807c3bee ra : ffffffff807c3bee sp : ff20000000283c80
>>>>>     [  129.899144]  gp : ffffffff813a83b8 tp : ff60000080021600 t0 : ffffffff804155c0
>>>>>     [  129.904257]  t1 : 0720072007200720 t2 : 7420646574636570 s0 : ff20000000283cb0
>>>>>     [  129.909402]  s1 : ff6000007fe622a0 a0 : 0000000000000022 a1 : c0000000ffffefff
>>>>>     [  129.914472]  a2 : 0000000000000001 a3 : 0000000000000000 a4 : 341adec112294700
>>>>>     [  129.919487]  a5 : 341adec112294700 a6 : 0000000000000730 a7 : 0000000000000030
>>>>>     [  129.924595]  s2 : ffffffff80258910 s3 : ffffffffffffffea s4 : 0000000000000000
>>>>>     [  129.929776]  s5 : 0000000000000a35 s6 : ffffffff80d667c8 s7 : ff6000007fe04000
>>>>>     [  129.934892]  s8 : 0000000000000004 s9 : 0000000000000002 s10: 0000000000000001
>>>>>     [  129.939992]  s11: 0000000000000003 t3 : ff6000007ff20f00 t4 : ff6000007ff20f00
>>>>>     [  129.945134]  t5 : ff6000007ff20000 t6 : ff200000002839c8
>>>>>     [  129.948838] status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
>>>>>     [  129.954580] [<ffffffff800bf110>] ftrace_replace_code+0xce/0xd0
>>>>>     [  129.958771] [<ffffffff800bf280>] ftrace_modify_all_code+0xb4/0x12c
>>>>>     [  129.964420] [<ffffffff800bf30a>] __ftrace_modify_code+0x12/0x1c
>>>>>     [  129.969163] [<ffffffff800b4ea4>] multi_cpu_stop+0x9a/0x168
>>>>>     [  129.973035] [<ffffffff800b4b1c>] cpu_stopper_thread+0xb4/0x15e
>>>>>     [  129.977205] [<ffffffff8003457a>] smpboot_thread_fn+0x106/0x1e4
>>>>>     [  129.981277] [<ffffffff80030ca6>] kthread+0xee/0x108
>>>>>     [  129.984763] [<ffffffff800039ba>] ret_from_exception+0x0/0xc
>>>>>     [  129.988809] ---[ end trace 0000000000000000 ]---
>>>>>     # cat trace
>>>>>     # tracer: function
>>>>>     #
>>>>>     # WARNING: FUNCTION TRACING IS CORRUPTED
>>>>>     #          MAY BE MISSING FUNCTION EVENTS
>>>>>     # entries-in-buffer/entries-written: 0/0   #P:4
>>>>>     #
>>>>>     #                                _-----=> irqs-off/BH-disabled
>>>>>     #                               / _----=> need-resched
>>>>>     #                              | / _---=> hardirq/softirq
>>>>>     #                              || / _--=> preempt-depth
>>>>>     #                              ||| / _-=> migrate-disable
>>>>>     #                              |||| /     delay
>>>>>     #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>>>>>     #              | |         |   |||||     |         |
>>>>>
>>>>> As you can see, the ftrace functionality is broken. This is because
>>>>> DYNAMIC_FTRACE uses 4 instructions to make the jump from the function
>>>>> entry to the ftrace trampoline.
>>>>>
>>>>> After 'echo function > current_tracer':
>>>>>
>>>>>     <cmdline_proc_show>:
>>>>>       0xffffffff80258910 <+0>:     sd      ra,-8(sp)
>>>>>       0xffffffff80258914 <+4>:     auipc   ra,0xffdb0
>>>>>       0xffffffff80258918 <+8>:     jalr    1264(ra) # 0xffffffff80008e04 <ftrace_caller>
>>>>>       0xffffffff8025891c <+12>:    ld      ra,-8(sp)
>>>>>
>>>>> After 'echo 1 > events/kprobes/p_cmdline_proc_show_4/enable':
>>>>>
>>>>>     <cmdline_proc_show>:
>>>>>       0xffffffff80258910 <+0>:     sd      ra,-8(sp)
>>>>>       0xffffffff80258914 <+4>:     ebreak
>>>>>       0xffffffff80258918 <+8>:     jalr    1264(ra)
>>>>>       0xffffffff8025891c <+12>:    ld      ra,-8(sp)
>>>>>
>>>>> This time the second instruction is replaced with a breakpoint
>>>>> instruction and the ftrace-related instructions are broken. Then, when
>>>>> enabling 'p_cmdline_proc_show_0', a regs ftrace handler is registered
>>>>> based on KPROBES_ON_FTRACE, ftrace_modify_call() changes 'ftrace_caller'
>>>>> to 'ftrace_regs_caller', and checks for ftrace-related instructions is
>>>>> modified or not. Here it has been modified, causing ftrace to report a
>>>>> warning and disable itself.
>>>>>
>>>>> In turn, the breakpoints inserted by kprobe may be overwritten by
>>>>> ftrace.
>>>>>
>>>>> The problem is that we think that only the first instruction address at
>>>>> the function entry is needed for ftrace, but it is actually the first 4.
>>>>> As Masami mentioned in [1], we can treat the first 4 instructions as a
>>>>> 16-byte virtual instruction, and we can probe func+0 based on
>>>>> KPROBES_ON_FTRACE, but not func+4, func+8 and func+12. This way, ftrace
>>>>> and kprobe do not bother each other and can coexist.
>>>>>
>>>>> After this patch:
>>>>>
>>>>>     # cd /sys/kernel/debug/tracing/
>>>>>     # echo cmdline_proc_show > set_ftrace_filter
>>>>>     # echo function > current_tracer
>>>>>     # echo 'p cmdline_proc_show' > kprobe_events
>>>>>     # echo 'p cmdline_proc_show' > kprobe_events
>>>>>     # echo 'p cmdline_proc_show+4' >> kprobe_events
>>>>>     sh: write error: Invalid or incomplete multibyte or wide character
>>>>>     # echo 'p cmdline_proc_show+8' >> kprobe_events
>>>>>     sh: write error: Invalid or incomplete multibyte or wide character
>>>>>     # echo 'p cmdline_proc_show+12' >> kprobe_events
>>>>>     sh: write error: Invalid or incomplete multibyte or wide character
>>>>>     # echo 'p cmdline_proc_show+16' >> kprobe_events
>>>>>     # ls events/kprobes/
>>>>>     enable                  p_cmdline_proc_show_0
>>>>>     filter                  p_cmdline_proc_show_16
>>>>>     # echo 1 > events/kprobes/enable
>>>>>     # cat ../kprobes/list
>>>>>     ffffffff80258b14  k  cmdline_proc_show+0x0    [FTRACE]
>>>>>     ffffffff80258b24  k  cmdline_proc_show+0x10
>>>>>     # cat /proc/cmdline
>>>>>     nokaslr rootwait root=/dev/vda rw
>>>>>     # cat trace
>>>>>     # tracer: function
>>>>>     #
>>>>>     # entries-in-buffer/entries-written: 3/3   #P:4
>>>>>     #
>>>>>     #                                _-----=> irqs-off/BH-disabled
>>>>>     #                               / _----=> need-resched
>>>>>     #                              | / _---=> hardirq/softirq
>>>>>     #                              || / _--=> preempt-depth
>>>>>     #                              ||| / _-=> migrate-disable
>>>>>     #                              |||| /     delay
>>>>>     #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>>>>>     #              | |         |   |||||     |         |
>>>>>                  cat-142     [000] ...2.   181.493233: p_cmdline_proc_show_0: (cmdline_proc_show+0x0/0x46)
>>>>>                  cat-142     [000] ...2.   181.494271: cmdline_proc_show <-seq_read_iter
>>>>>                  cat-142     [000] d....   181.494573: p_cmdline_proc_show_16: (cmdline_proc_show+0x10/0x46)
>>>>>
>>>>> [1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20191218140622.57bbaca5@xhacker.debian/
>>>>>
>>>>> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
>>>>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>>>>> ---
>>>>>    arch/riscv/kernel/probes/kprobes.c | 31 ++++++++++++++++++++++++++++++
>>>>>    kernel/kprobes.c                   |  2 +-
>>>>>    2 files changed, 32 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
>>>>> index e6e950b7cf32..ebe32eb6c349 100644
>>>>> --- a/arch/riscv/kernel/probes/kprobes.c
>>>>> +++ b/arch/riscv/kernel/probes/kprobes.c
>>>>> @@ -21,6 +21,37 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>>>>>    static void __kprobes
>>>>>    post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
>>>>>
>>>>> +#ifdef CONFIG_DYNAMIC_FTRACE
>>>>> +kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
>>>>> +                                        bool *on_func_entry)
>>>>> +{
>>>>> +       unsigned long faddr = ftrace_location(addr);
>>>>> +
>>>>> +       /*
>>>>> +        * The first 4 instructions at the beginning of the ftraced function
>>>>> +        * are used as a jump to ftrace trampoline, which we can think of as
>>>>> +        * a 16-byte virtual instruction. This allows the function entry to be
>>>>> +        * probed with the help of KPROBES_ON_FTRACE and does not break ftrace
>>>>> +        * functionality.
>>>>> +        */
>>>>> +       if (faddr && offset <= 12) {
>>>>> +               /*
>>>>> +                * As mentioned above, we treat the first 4 instructions of
>>>>> +                * the ftraced function as a virtual instruction, so that we
>>>>> +                * can only probe func+0, not func+4, func+8 and func+12.
>>>>> +                */
>>>>> +               if (offset)
>>>>> +                       return ERR_PTR(-EILSEQ);
>>>> Nak, we should change API in the patch.
>>> Typo: we shouldn't change API in the patch.
>>
>> You are right, can't change API in this patch.  If here let
>> func+offs(<16) be equivalent to func+0, then there will be:
>>
>>       # echo 'p cmdline_proc_show' > kprobe_events
>>       # echo 'p cmdline_proc_show+4' >> kprobe_events
>>       # echo 'p cmdline_proc_show+8' >> kprobe_events
>>       # echo 'p cmdline_proc_show+12' >> kprobe_events
>>       # ls events/kprobes/
>>       enable                  p_cmdline_proc_show_0 p_cmdline_proc_show_4
>>       filter                  p_cmdline_proc_show_12 p_cmdline_proc_show_8
>>       # cat ../kprobes/list
>>       ffffffff80258b08  k  cmdline_proc_show+0x0 [DISABLED][FTRACE]
>>       ffffffff80258b08  k  cmdline_proc_show+0x0 [DISABLED][FTRACE]
>>       ffffffff80258b08  k  cmdline_proc_show+0x0 [DISABLED][FTRACE]
>>       ffffffff80258b08  k  cmdline_proc_show+0x0 [DISABLED][FTRACE]
>>
>> While it may be a bit confusing for the user, it has no functional
>> impact and usually we only probe for func+0. Making func+offs(<16) equal
>> to func+0 seems acceptable.
>>
>>
>>>> Reference below:
>>>>
>>>> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
>>>> index 04dad3380041..4fbab6b89be3 100644
>>>> --- a/arch/riscv/include/asm/ftrace.h
>>>> +++ b/arch/riscv/include/asm/ftrace.h
>>>> @@ -77,6 +77,32 @@ do {
>>>>                    \
>>>>     */
>>>>    #define MCOUNT_INSN_SIZE 8
>>>>
>>>> +/*
>>>> + * Put16 bytes at the front of function within patchable function entry
>>>> + * nops' area.
>>>> + *
>>>> + * 0: REG_S  ra, -SZREG(sp)
>>>> + * 1: auipc  ra, 0x?
>>>> + * 2: jalr   -?(ra)
>>>> + * 3: REG_L  ra, -SZREG(sp)
>>>> + *
>>>> + * So the opcodes is:
>>>> + * 0: 0xfe113c23 (sd)/0xfe112e23 (sw)
>>>> + * 1: 0x???????? -> auipc
>>>> + * 2: 0x???????? -> jalr
>>>> + * 3: 0xff813083 (ld)/0xffc12083 (lw)
>>>> + */
>>>> +#if __riscv_xlen == 64
>>>> +#define INSN0  0xfe113c23
>>>> +#define INSN3  0xff813083
>>>> +#elif __riscv_xlen == 32
>>>> +#define INSN0  0xfe112e23
>>>> +#define INSN3  0xffc12083
>>>> +#endif
>>>> +
>>>> +#define FUNC_ENTRY_SIZE        16
>>>> +#define FUNC_ENTRY_JMP 4
>>>> +
>>>>    #ifndef __ASSEMBLY__
>>>>    struct dyn_ftrace;
>>>>    int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
>>>> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
>>>> index 4716f4cdc038..be51aa87134e 100644
>>>> --- a/arch/riscv/kernel/ftrace.c
>>>> +++ b/arch/riscv/kernel/ftrace.c
>>>> @@ -72,32 +72,6 @@ static int __ftrace_modify_call(unsigned long
>>>> hook_pos, unsigned long target,
>>>>           return 0;
>>>>    }
>>>>
>>>> -/*
>>>> - * Put 5 instructions with 16 bytes at the front of function within
>>>> - * patchable function entry nops' area.
>>>> - *
>>>> - * 0: REG_S  ra, -SZREG(sp)
>>>> - * 1: auipc  ra, 0x?
>>>> - * 2: jalr   -?(ra)
>>>> - * 3: REG_L  ra, -SZREG(sp)
>>>> - *
>>>> - * So the opcodes is:
>>>> - * 0: 0xfe113c23 (sd)/0xfe112e23 (sw)
>>>> - * 1: 0x???????? -> auipc
>>>> - * 2: 0x???????? -> jalr
>>>> - * 3: 0xff813083 (ld)/0xffc12083 (lw)
>>>> - */
>>>> -#if __riscv_xlen == 64
>>>> -#define INSN0  0xfe113c23
>>>> -#define INSN3  0xff813083
>>>> -#elif __riscv_xlen == 32
>>>> -#define INSN0  0xfe112e23
>>>> -#define INSN3  0xffc12083
>>>> -#endif
>>>> -
>>>> -#define FUNC_ENTRY_SIZE        16
>>>> -#define FUNC_ENTRY_JMP 4
>>>> -
>>>>    int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>>>>    {
>>>>           unsigned int call[4] = {INSN0, 0, 0, INSN3};
>>>> @@ -124,7 +98,6 @@ int ftrace_make_nop(struct module *mod, struct
>>>> dyn_ftrace *rec,
>>>>           return 0;
>>>>    }
>>>>
>>>> -
>>>>    /*
>>>>     * This is called early on, and isn't wrapped by
>>>>     * ftrace_arch_code_modify_{prepare,post_process}() and therefor doesn't hold
>>>> diff --git a/arch/riscv/kernel/probes/kprobes.c
>>>> b/arch/riscv/kernel/probes/kprobes.c
>>>> index e6e950b7cf32..c16a819a81c1 100644
>>>> --- a/arch/riscv/kernel/probes/kprobes.c
>>>> +++ b/arch/riscv/kernel/probes/kprobes.c
>>>> @@ -21,6 +21,33 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>>>>    static void __kprobes
>>>>    post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
>>>>
>>>> +#ifdef CONFIG_DYNAMIC_FTRACE
>>>> +kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned
>>>> long offset,
>>>> +                                        bool *on_func_entry)
>>>> +{
>>>> +       /*
>>>> +        * The first 4 instructions at the beginning of the ftraced function
>>>> +        * are used as a jump to ftrace trampoline, which we can think of as
>>>> +        * a 16-byte virtual instruction. This allows the function entry to be
>>>> +        * probed with the help of KPROBES_ON_FTRACE and does not break ftrace
>>>> +        * functionality.
>>>> +        */
>>>> +       if (offset < FUNC_ENTRY_SIZE) {
>>>> +               /*
>>>> +                * As mentioned above, we treat the first 4 instructions of
>>>> +                * the ftraced function as a virtual instruction, so that we
>>>> +                * can only probe func+0, and func+4, func+8 and func+12
>>>> +                * would be changed to func+0.
>>>> +                */
>>>> +               *on_func_entry = true;
>>>> +               return (kprobe_opcode_t *)ftrace_location(addr);
>>>> +       } else {
>>>> +               *on_func_entry = false;
>>>> +               return (kprobe_opcode_t *)(addr + offset);
>>>> +       }
>>>> +}
>>> Another better implementation:
>>> +kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned
>>> long offset,
>>> +                                        bool *on_func_entry)
>>> +{
>>> +       /*
>>> +        * The first 4 instructions at the beginning of the ftraced function
>>> +        * are used as a jump to ftrace trampoline, which we can think of as
>>> +        * a 16-byte virtual instruction. This allows the function entry to be
>>> +        * probed with the help of KPROBES_ON_FTRACE and does not break ftrace
>>> +        * functionality.
>>> +        */
>>> +       if (offset < FUNC_ENTRY_SIZE) {,
>> Thanks a lot for providing such a detailed implementation. Yes, it is
>> better to use these macro definitions. But I think we first need to use
>> ftrace_location(addr) to determine if the function can be traced. no
>> special handling here is needed for notrace functions.
>>
>> +kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned
>> long offset,
>> +                                        bool *on_func_entry)
>> +{
>> +       unsigned long faddr = ftrace_location(addr);
> Seems x86 & powerpc also need that check? I don't think
> ftrace_location is necessary, or the solution should be more common.


The x86 should not need to add checks, since x86 ftrace only uses one 
instruction.

On the ppc, the address is adjusted in kprobe_lookup_name() using 
ftrace_location_range(), but as mentioned in the comments of ppc's 
arch_adjust_kprobe_addr(), this part of the processing should be moved 
to arch_adjust_kprobe_addr():

     /* XXX try and fold the magic of kprobe_lookup_name() in this */
     kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, 
unsigned long offset,
                                             bool *on_func_entry)
     {
             *on_func_entry = arch_kprobe_on_func_entry(offset);
             return (kprobe_opcode_t *)(addr + offset);
     }

I think it depends on the architecture needs whether to check here or 
not. On riscv, the check avoids taking func+offs(<16) -> func+0 for the 
notrace function to make it possible to probe func+4, func+8, func+12 
for the notrace function.

But it might also make sense to take a consistent treatment for all 
functions (func+offs(<16) -> func+0 ), without confusing the user.


Thanks,

Huafei

>
>
>> +
>> +       /*
>> +        * The first 4 instructions at the beginning of the ftraced function
>> +        * are used as a jump to ftrace trampoline, which we can think of as
>> +        * a 16-byte virtual instruction. This allows the function entry
>> to be
>> +        * probed with the help of KPROBES_ON_FTRACE and does not break
>> ftrace
>> +        * functionality.
>> +        */
>> +       if (faddr && offset < FUNC_ENTRY_SIZE) {
>> +               /*
>> +                * As mentioned above, we treat the first 4 instructions of
>> +                * the ftraced function as a virtual instruction, so that we
>> +                * can only probe func+0, and func+4, func+8 and func+12
>> would
>> +                * be changed to func+0.
>> +                */
>> +               *on_func_entry = true;
>> +               return (kprobe_opcode_t *)faddr;
>> +       } else {
>> +               *on_func_entry = !offset;
>> +               return (kprobe_opcode_t *)(addr + offset);
>> +       }
>> +}
>>
>> Is this ok?
>>
>>
>> Thanks,
>>
>> Huafei
>>
>>
>>> +               /*
>>> +                * As mentioned above, we treat the first 4 instructions of
>>> +                * the ftraced function as a virtual instruction, so that we
>>> +                * can only probe func+0, and func+4, func+8 and func+12
>>> +                * would be changed to func+0.
>>> +                */
>>> +               offset = 0;
>>> +       }
>>> +
>>> +       *on_func_entry = !offset;
>>> +       return (kprobe_opcode_t *)(addr + offset);
>>> +}
>>>
>>>> +#endif
>>>> +
>>>>    static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>>>>    {
>>>>           unsigned long offset = GET_INSN_LENGTH(p->opcode);
>>>>
>>>>> +
>>>>> +               *on_func_entry = true;
>>>>> +               return (kprobe_opcode_t *)faddr;
>>>>> +       }
>>>>> +
>>>>> +       *on_func_entry = !offset;
>>>>> +       return (kprobe_opcode_t *)(addr + offset);
>>>>> +}
>>>>> +#endif
>>>>> +
>>>>>    static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>>>>>    {
>>>>>           unsigned long offset = GET_INSN_LENGTH(p->opcode);
>>>>> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
>>>>> index dbe57df2e199..b41de7ce8bff 100644
>>>>> --- a/kernel/kprobes.c
>>>>> +++ b/kernel/kprobes.c
>>>>> @@ -1553,7 +1553,7 @@ _kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
>>>>>            * at the start of the function.
>>>>>            */
>>>>>           addr = arch_adjust_kprobe_addr((unsigned long)addr, offset, on_func_entry);
>>>>> -       if (addr)
>>>>> +       if (IS_ERR(addr) || addr)
>>>> Nak, If you really want to change API, please send another patch and
>>>> add ftrace_location(addr) in x86 & powerpc, firstly.
>>>>
>>>>>                   return addr;
>>>>>
>>>>>    invalid:
>>>>> --
>>>>> 2.17.1
>>>>>
>>>>
>>>> --
>>>> Best Regards
>>>>    Guo Ren
>>>>
>>>> ML: https://lore.kernel.org/linux-csky/
>>>
>
>
