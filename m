Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2733057F805
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 03:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiGYBqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 21:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiGYBpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 21:45:53 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEDCD53;
        Sun, 24 Jul 2022 18:45:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VKFhH2j_1658713547;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VKFhH2j_1658713547)
          by smtp.aliyun-inc.com;
          Mon, 25 Jul 2022 09:45:48 +0800
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, huanyi.xj@alibaba-inc.com,
        heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [RESEND PATCH V2 4/5] RISC-V: Fixup getting correct current pc
Date:   Mon, 25 Jul 2022 09:45:38 +0800
Message-Id: <20220725014539.1037627-5-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220725014539.1037627-1-xianting.tian@linux.alibaba.com>
References: <20220725014539.1037627-1-xianting.tian@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When use 'echo c > /proc/sysrq-trigger' to trigger kdump, riscv_crash_save_regs()
will be called to save regs to vmcore, we found "epc" value 00ffffffa5537400
is not a valid kernel virtual address, but is a user virtual address. Other
regs(eg, ra, sp, gp...) are correct kernel virtual address.
Actually 0x00ffffffb0dd9400 is the user mode PC of 'PID: 113 Comm: sh', which
is saved in the task's stack.

[   21.201701] CPU: 0 PID: 113 Comm: sh Kdump: loaded Not tainted 5.18.9 #45
[   21.201979] Hardware name: riscv-virtio,qemu (DT)
[   21.202160] epc : 00ffffffa5537400 ra : ffffffff80088640 sp : ff20000010333b90
[   21.202435]  gp : ffffffff810dde38 tp : ff6000000226c200 t0 : ffffffff8032be7c
[   21.202707]  t1 : 0720072007200720 t2 : 30203a7375746174 s0 : ff20000010333cf0
[   21.202973]  s1 : 0000000000000000 a0 : ff20000010333b98 a1 : 0000000000000001
[   21.203243]  a2 : 0000000000000010 a3 : 0000000000000000 a4 : 28c8f0aeffea4e00
[   21.203519]  a5 : 28c8f0aeffea4e00 a6 : 0000000000000009 a7 : ffffffff8035c9b8
[   21.203794]  s2 : ffffffff810df0a8 s3 : ffffffff810df718 s4 : ff20000010333b98
[   21.204062]  s5 : 0000000000000000 s6 : 0000000000000007 s7 : ffffffff80c4a468
[   21.204331]  s8 : 00ffffffef451410 s9 : 0000000000000007 s10: 00aaaaaac0510700
[   21.204606]  s11: 0000000000000001 t3 : ff60000001218f00 t4 : ff60000001218f00
[   21.204876]  t5 : ff60000001218000 t6 : ff200000103338b8
[   21.205079] status: 0000000200000020 badaddr: 0000000000000000 cause: 0000000000000008

With the incorrect PC, the backtrace showed by crash tool as below, the first
stack frame is abnormal,

crash> bt
PID: 113      TASK: ff60000002269600  CPU: 0    COMMAND: "sh"
 #0 [ff2000001039bb90] __efistub_.Ldebug_info0 at 00ffffffa5537400 <-- Abnormal
 #1 [ff2000001039bcf0] panic at ffffffff806578ba
 #2 [ff2000001039bd50] sysrq_reset_seq_param_set at ffffffff8038c030
 #3 [ff2000001039bda0] __handle_sysrq at ffffffff8038c5f8
 #4 [ff2000001039be00] write_sysrq_trigger at ffffffff8038cad8
 #5 [ff2000001039be20] proc_reg_write at ffffffff801b7edc
 #6 [ff2000001039be40] vfs_write at ffffffff80152ba6
 #7 [ff2000001039be80] ksys_write at ffffffff80152ece
 #8 [ff2000001039bed0] sys_write at ffffffff80152f46

With the patch, we can get current kernel mode PC, the output as below,

[   17.607658] CPU: 0 PID: 113 Comm: sh Kdump: loaded Not tainted 5.18.9 #42
[   17.607937] Hardware name: riscv-virtio,qemu (DT)
[   17.608150] epc : ffffffff800078f8 ra : ffffffff8008862c sp : ff20000010333b90
[   17.608441]  gp : ffffffff810dde38 tp : ff6000000226c200 t0 : ffffffff8032be68
[   17.608741]  t1 : 0720072007200720 t2 : 666666666666663c s0 : ff20000010333cf0
[   17.609025]  s1 : 0000000000000000 a0 : ff20000010333b98 a1 : 0000000000000001
[   17.609320]  a2 : 0000000000000010 a3 : 0000000000000000 a4 : 0000000000000000
[   17.609601]  a5 : ff60000001c78000 a6 : 000000000000003c a7 : ffffffff8035c9a4
[   17.609894]  s2 : ffffffff810df0a8 s3 : ffffffff810df718 s4 : ff20000010333b98
[   17.610186]  s5 : 0000000000000000 s6 : 0000000000000007 s7 : ffffffff80c4a468
[   17.610469]  s8 : 00ffffffca281410 s9 : 0000000000000007 s10: 00aaaaaab5bb6700
[   17.610755]  s11: 0000000000000001 t3 : ff60000001218f00 t4 : ff60000001218f00
[   17.611041]  t5 : ff60000001218000 t6 : ff20000010333988
[   17.611255] status: 0000000200000020 badaddr: 0000000000000000 cause: 0000000000000008

With the correct PC, the backtrace showed by crash tool as below,

crash> bt
PID: 113      TASK: ff6000000226c200  CPU: 0    COMMAND: "sh"
 #0 [ff20000010333b90] riscv_crash_save_regs at ffffffff800078f8 <--- Normal
 #1 [ff20000010333cf0] panic at ffffffff806578c6
 #2 [ff20000010333d50] sysrq_reset_seq_param_set at ffffffff8038c03c
 #3 [ff20000010333da0] __handle_sysrq at ffffffff8038c604
 #4 [ff20000010333e00] write_sysrq_trigger at ffffffff8038cae4
 #5 [ff20000010333e20] proc_reg_write at ffffffff801b7ee8
 #6 [ff20000010333e40] vfs_write at ffffffff80152bb2
 #7 [ff20000010333e80] ksys_write at ffffffff80152eda
 #8 [ff20000010333ed0] sys_write at ffffffff80152f52

Fixes: e53d28180d4d ("RISC-V: Add kdump support")
Co-developed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 arch/riscv/kernel/crash_save_regs.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/crash_save_regs.S b/arch/riscv/kernel/crash_save_regs.S
index 7832fb763aba..b2a1908c0463 100644
--- a/arch/riscv/kernel/crash_save_regs.S
+++ b/arch/riscv/kernel/crash_save_regs.S
@@ -44,7 +44,7 @@ SYM_CODE_START(riscv_crash_save_regs)
 	REG_S t6,  PT_T6(a0)	/* x31 */
 
 	csrr t1, CSR_STATUS
-	csrr t2, CSR_EPC
+	auipc t2, 0x0
 	csrr t3, CSR_TVAL
 	csrr t4, CSR_CAUSE
 
-- 
2.17.1

