Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EAB58F87D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiHKHmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiHKHmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:42:02 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9B08E0DC;
        Thu, 11 Aug 2022 00:42:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0VLyMVg9_1660203714;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VLyMVg9_1660203714)
          by smtp.aliyun-inc.com;
          Thu, 11 Aug 2022 15:41:55 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
        k-hagio-ab@nec.com, hschauhan@nulltrace.org, yixun.lan@gmail.com,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH V6 1/6] RISC-V: kexec: Fixup use of smp_processor_id() in preemptible context
Date:   Thu, 11 Aug 2022 15:41:45 +0800
Message-Id: <20220811074150.3020189-2-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220811074150.3020189-1-xianting.tian@linux.alibaba.com>
References: <20220811074150.3020189-1-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __smp_processor_id() to avoid check the preemption context when
CONFIG_DEBUG_PREEMPT enabled, as we will enter crash kernel and no
return.

Without the patch,
[  103.781044] sysrq: Trigger a crash
[  103.784625] Kernel panic - not syncing: sysrq triggered crash
[  103.837634] CPU1: off
[  103.889668] CPU2: off
[  103.933479] CPU3: off
[  103.939424] Starting crashdump kernel...
[  103.943442] BUG: using smp_processor_id() in preemptible [00000000] code: sh/346
[  103.950884] caller is debug_smp_processor_id+0x1c/0x26
[  103.956051] CPU: 0 PID: 346 Comm: sh Kdump: loaded Not tainted 5.10.113-00002-gce03f03bf4ec-dirty #149
[  103.965355] Call Trace:
[  103.967805] [<ffffffe00020372a>] walk_stackframe+0x0/0xa2
[  103.973206] [<ffffffe000bcf1f4>] show_stack+0x32/0x3e
[  103.978258] [<ffffffe000bd382a>] dump_stack_lvl+0x72/0x8e
[  103.983655] [<ffffffe000bd385a>] dump_stack+0x14/0x1c
[  103.988705] [<ffffffe000bdc8fe>] check_preemption_disabled+0x9e/0xaa
[  103.995057] [<ffffffe000bdc926>] debug_smp_processor_id+0x1c/0x26
[  104.001150] [<ffffffe000206c64>] machine_kexec+0x22/0xd0
[  104.006463] [<ffffffe000291a7e>] __crash_kexec+0x6a/0xa4
[  104.011774] [<ffffffe000bcf3fa>] panic+0xfc/0x2b0
[  104.016480] [<ffffffe000656ca4>] sysrq_reset_seq_param_set+0x0/0x70
[  104.022745] [<ffffffe000657310>] __handle_sysrq+0x8c/0x154
[  104.028229] [<ffffffe0006577e8>] write_sysrq_trigger+0x5a/0x6a
[  104.034061] [<ffffffe0003d90e0>] proc_reg_write+0x58/0xd4
[  104.039459] [<ffffffe00036cff4>] vfs_write+0x7e/0x254
[  104.044509] [<ffffffe00036d2f6>] ksys_write+0x58/0xbe
[  104.049558] [<ffffffe00036d36a>] sys_write+0xe/0x16
[  104.054434] [<ffffffe000201b9a>] ret_from_syscall+0x0/0x2
[  104.067863] Will call new kernel at ecc00000 from hart id 0
[  104.074939] FDT image at fc5ee000
[  104.079523] Bye...

With the patch we can got clear output,
[   67.740553] sysrq: Trigger a crash
[   67.744166] Kernel panic - not syncing: sysrq triggered crash
[   67.809123] CPU1: off
[   67.865210] CPU2: off
[   67.909075] CPU3: off
[   67.919123] Starting crashdump kernel...
[   67.924900] Will call new kernel at ecc00000 from hart id 0
[   67.932045] FDT image at fc5ee000
[   67.935560] Bye...

Fixes: 0e105f1d0037 ("riscv: use hart id instead of cpu id on machine_kexec")
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 arch/riscv/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index df8e24559035..86d1b5f9dfb5 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -171,7 +171,7 @@ machine_kexec(struct kimage *image)
 	struct kimage_arch *internal = &image->arch;
 	unsigned long jump_addr = (unsigned long) image->start;
 	unsigned long first_ind_entry = (unsigned long) &image->head;
-	unsigned long this_cpu_id = smp_processor_id();
+	unsigned long this_cpu_id = __smp_processor_id();
 	unsigned long this_hart_id = cpuid_to_hartid_map(this_cpu_id);
 	unsigned long fdt_addr = internal->fdt_addr;
 	void *control_code_buffer = page_address(image->control_code_page);
-- 
2.17.1

