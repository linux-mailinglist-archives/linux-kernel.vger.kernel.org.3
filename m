Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE6B50EE65
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241694AbiDZCCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241706AbiDZCCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:02:09 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8998B8BE2C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 18:59:02 -0700 (PDT)
Received: from kwepemi100024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KnQ5D0q66z1JBmX;
        Tue, 26 Apr 2022 09:58:08 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 kwepemi100024.china.huawei.com (7.221.188.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 09:59:00 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 09:58:59 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <guoren@kernel.org>, <mhiramat@kernel.org>, <palmer@dabbelt.com>
CC:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <jszhang@kernel.org>,
        <peterz@infradead.org>, <liaochang1@huawei.com>, <me@packi.ch>,
        <penberg@kernel.org>, <lihuafei1@huawei.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] riscv: kprobe: Allow coexistence of ftrace and kprobe
Date:   Tue, 26 Apr 2022 09:57:51 +0800
Message-ID: <20220426015751.88582-2-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220426015751.88582-1-lihuafei1@huawei.com>
References: <20220426015751.88582-1-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using ftrace and kprobe at the same time, it was found that one
might cause the other to be unavailable. This can be reproduced by the
following steps.

  # cd /sys/kernel/debug/tracing/
  # echo cmdline_proc_show > set_ftrace_filter
  # echo function > current_tracer
  # echo 'p cmdline_proc_show' > kprobe_events
  # echo 'p cmdline_proc_show+4' >> kprobe_events
  # ls events/kprobes/
  enable                 p_cmdline_proc_show_0
  filter                 p_cmdline_proc_show_4
  # echo 1 > events/kprobes/p_cmdline_proc_show_4/enable
  # echo 1 > events/kprobes/p_cmdline_proc_show_0/enable
  [  129.830108] 00000000ebed457d: expected (ffdb0097 4f0080e7) but got (00100073 4f0080e7)
  [  129.835990] ------------[ ftrace bug ]------------
  [  129.839510] ftrace failed to modify
  [  129.839536] [<ffffffff80258910>] cmdline_proc_show+0x0/0x46
  [  129.845831]  actual:   23:3c:11:fe:73:00:10:00
  [  129.849299] Updating ftrace call site to call a different ftrace function
  [  129.853998] ftrace record flags: e0000002
  [  129.856771]  (2) R
  [  129.856771]  expected tramp: ffffffff80008e60
  [  129.861688] ------------[ cut here ]------------
  [  129.865092] WARNING: CPU: 0 PID: 14 at kernel/trace/ftrace.c:2085 ftrace_bug+0x21a/0x24c
  [  129.870949] Modules linked in:
  [  129.873301] CPU: 0 PID: 14 Comm: migration/0 Not tainted 5.18.0-rc3-00002-gd8bfcd250f58 #6
  [  129.879217] Hardware name: riscv-virtio,qemu (DT)
  [  129.882666] Stopper: multi_cpu_stop+0x0/0x168 <- stop_machine_cpuslocked+0xfa/0x12e
  [  129.888430] epc : ftrace_bug+0x21a/0x24c
  [  129.891254]  ra : ftrace_bug+0x21a/0x24c
  [  129.894057] epc : ffffffff807c3bee ra : ffffffff807c3bee sp : ff20000000283c80
  [  129.899144]  gp : ffffffff813a83b8 tp : ff60000080021600 t0 : ffffffff804155c0
  [  129.904257]  t1 : 0720072007200720 t2 : 7420646574636570 s0 : ff20000000283cb0
  [  129.909402]  s1 : ff6000007fe622a0 a0 : 0000000000000022 a1 : c0000000ffffefff
  [  129.914472]  a2 : 0000000000000001 a3 : 0000000000000000 a4 : 341adec112294700
  [  129.919487]  a5 : 341adec112294700 a6 : 0000000000000730 a7 : 0000000000000030
  [  129.924595]  s2 : ffffffff80258910 s3 : ffffffffffffffea s4 : 0000000000000000
  [  129.929776]  s5 : 0000000000000a35 s6 : ffffffff80d667c8 s7 : ff6000007fe04000
  [  129.934892]  s8 : 0000000000000004 s9 : 0000000000000002 s10: 0000000000000001
  [  129.939992]  s11: 0000000000000003 t3 : ff6000007ff20f00 t4 : ff6000007ff20f00
  [  129.945134]  t5 : ff6000007ff20000 t6 : ff200000002839c8
  [  129.948838] status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
  [  129.954580] [<ffffffff800bf110>] ftrace_replace_code+0xce/0xd0
  [  129.958771] [<ffffffff800bf280>] ftrace_modify_all_code+0xb4/0x12c
  [  129.964420] [<ffffffff800bf30a>] __ftrace_modify_code+0x12/0x1c
  [  129.969163] [<ffffffff800b4ea4>] multi_cpu_stop+0x9a/0x168
  [  129.973035] [<ffffffff800b4b1c>] cpu_stopper_thread+0xb4/0x15e
  [  129.977205] [<ffffffff8003457a>] smpboot_thread_fn+0x106/0x1e4
  [  129.981277] [<ffffffff80030ca6>] kthread+0xee/0x108
  [  129.984763] [<ffffffff800039ba>] ret_from_exception+0x0/0xc
  [  129.988809] ---[ end trace 0000000000000000 ]---
  # cat trace
  # tracer: function
  #
  # WARNING: FUNCTION TRACING IS CORRUPTED
  #          MAY BE MISSING FUNCTION EVENTS
  # entries-in-buffer/entries-written: 0/0   #P:4
  #
  #                                _-----=> irqs-off/BH-disabled
  #                               / _----=> need-resched
  #                              | / _---=> hardirq/softirq
  #                              || / _--=> preempt-depth
  #                              ||| / _-=> migrate-disable
  #                              |||| /     delay
  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
  #              | |         |   |||||     |         |

As you can see, the ftrace functionality is broken. This is because
DYNAMIC_FTRACE uses 4 instructions to make the jump from the function
entry to the ftrace trampoline.

After 'echo function > current_tracer':

  <cmdline_proc_show>:
    0xffffffff80258910 <+0>:     sd      ra,-8(sp)
    0xffffffff80258914 <+4>:     auipc   ra,0xffdb0
    0xffffffff80258918 <+8>:     jalr    1264(ra) # 0xffffffff80008e04 <ftrace_caller>
    0xffffffff8025891c <+12>:    ld      ra,-8(sp)

After 'echo 1 > events/kprobes/p_cmdline_proc_show_4/enable':

  <cmdline_proc_show>:
    0xffffffff80258910 <+0>:     sd      ra,-8(sp)
    0xffffffff80258914 <+4>:     ebreak
    0xffffffff80258918 <+8>:     jalr    1264(ra)
    0xffffffff8025891c <+12>:    ld      ra,-8(sp)

This time the second instruction is replaced with a breakpoint
instruction and the ftrace-related instructions are broken. Then, when
enabling 'p_cmdline_proc_show_0', a regs ftrace handler is registered
based on KPROBES_ON_FTRACE, ftrace_modify_call() changes 'ftrace_caller'
to 'ftrace_regs_caller', and checks for ftrace-related instructions is
modified or not. Here it has been modified, causing ftrace to report a
warning and disable itself.

In turn, the breakpoints inserted by kprobe may be overwritten by
ftrace.

The problem is that we think that only the first instruction address at
the function entry is needed for ftrace, but it is actually the first 4.
As Masami mentioned in [1], we can treat the first 4 instructions as a
16-byte virtual instruction, and we can probe func+0 based on
KPROBES_ON_FTRACE, but not func+4, func+8 and func+12. This way, ftrace
and kprobe do not bother each other and can coexist.

After this patch:

  # cd /sys/kernel/debug/tracing/
  # echo cmdline_proc_show > set_ftrace_filter
  # echo function > current_tracer
  # echo 'p cmdline_proc_show' > kprobe_events
  # echo 'p cmdline_proc_show' > kprobe_events
  # echo 'p cmdline_proc_show+4' >> kprobe_events
  sh: write error: Invalid or incomplete multibyte or wide character
  # echo 'p cmdline_proc_show+8' >> kprobe_events
  sh: write error: Invalid or incomplete multibyte or wide character
  # echo 'p cmdline_proc_show+12' >> kprobe_events
  sh: write error: Invalid or incomplete multibyte or wide character
  # echo 'p cmdline_proc_show+16' >> kprobe_events
  # ls events/kprobes/
  enable                  p_cmdline_proc_show_0
  filter                  p_cmdline_proc_show_16
  # echo 1 > events/kprobes/enable
  # cat ../kprobes/list
  ffffffff80258b14  k  cmdline_proc_show+0x0    [FTRACE]
  ffffffff80258b24  k  cmdline_proc_show+0x10
  # cat /proc/cmdline
  nokaslr rootwait root=/dev/vda rw
  # cat trace
  # tracer: function
  #
  # entries-in-buffer/entries-written: 3/3   #P:4
  #
  #                                _-----=> irqs-off/BH-disabled
  #                               / _----=> need-resched
  #                              | / _---=> hardirq/softirq
  #                              || / _--=> preempt-depth
  #                              ||| / _-=> migrate-disable
  #                              |||| /     delay
  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
  #              | |         |   |||||     |         |
               cat-142     [000] ...2.   181.493233: p_cmdline_proc_show_0: (cmdline_proc_show+0x0/0x46)
               cat-142     [000] ...2.   181.494271: cmdline_proc_show <-seq_read_iter
               cat-142     [000] d....   181.494573: p_cmdline_proc_show_16: (cmdline_proc_show+0x10/0x46)

[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20191218140622.57bbaca5@xhacker.debian/

Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/riscv/kernel/probes/kprobes.c | 31 ++++++++++++++++++++++++++++++
 kernel/kprobes.c                   |  2 +-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index e6e950b7cf32..ebe32eb6c349 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -21,6 +21,37 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 static void __kprobes
 post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
+					 bool *on_func_entry)
+{
+	unsigned long faddr = ftrace_location(addr);
+
+	/*
+	 * The first 4 instructions at the beginning of the ftraced function
+	 * are used as a jump to ftrace trampoline, which we can think of as
+	 * a 16-byte virtual instruction. This allows the function entry to be
+	 * probed with the help of KPROBES_ON_FTRACE and does not break ftrace
+	 * functionality.
+	 */
+	if (faddr && offset <= 12) {
+		/*
+		 * As mentioned above, we treat the first 4 instructions of
+		 * the ftraced function as a virtual instruction, so that we
+		 * can only probe func+0, not func+4, func+8 and func+12.
+		 */
+		if (offset)
+			return ERR_PTR(-EILSEQ);
+
+		*on_func_entry = true;
+		return (kprobe_opcode_t *)faddr;
+	}
+
+	*on_func_entry = !offset;
+	return (kprobe_opcode_t *)(addr + offset);
+}
+#endif
+
 static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 {
 	unsigned long offset = GET_INSN_LENGTH(p->opcode);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index dbe57df2e199..b41de7ce8bff 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1553,7 +1553,7 @@ _kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
 	 * at the start of the function.
 	 */
 	addr = arch_adjust_kprobe_addr((unsigned long)addr, offset, on_func_entry);
-	if (addr)
+	if (IS_ERR(addr) || addr)
 		return addr;
 
 invalid:
-- 
2.17.1

