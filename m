Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5D6522E7B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbiEKIeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243851AbiEKIby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:31:54 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2014161F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:53 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j6so1342087pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=x6ToxOR7YfZxDHTS67U76S1k5UUycsNd/uMEmp36m6E=;
        b=VJW9tSadeCifXTSdxhfEPeWI4fmioJpfsAgUeEhgGTlogv/K4ujejUPly/Cl2QSK1G
         NlwZ2g3QTBsmoNm1akHbtZkL/AUmUSISj2dqsBrd3osoqB0a6ze17V2FZS7Pt99rAecC
         /5JAwlfta5wfTLVUz/+oJXyKOQ6/n8f+CdFhSaivIc8hwSgKlBtW+UYj5IgVtl61UFMC
         UMggQKUx5Ai28e6DJdlissZ0g+vzTygRMdmmZ7G6jm0B/Dy5sZa2p1YO7mHAqbqOeYgr
         OToNGNj4ximPHXedlAxGrQNc+/oqfay6+pTxvUVFTgkVQek2yFgCSRB/V0/RqPQTILR1
         AjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=x6ToxOR7YfZxDHTS67U76S1k5UUycsNd/uMEmp36m6E=;
        b=bIigw0RT8a9huGZMyfWt7vwuL7EQAKuXoYwlQpLI8FetM+Hj0IQnKRQhZZu+k4ULBh
         VrtC3e0S2R/EF6C6unec+hS9NGeoxmTjDeD+uYvQ+ffl2A4ZsNotSHLL6+1BVU7fJWIl
         8drZWcbDRIFOl7zJfpu1mYVfXGj5Q9FjWjUVuaQPbtKkPMSLp/y/OpSJzE+uf+/lI63W
         jwlG8o5HLjw/BCbXoQ9UgBBjI9trQ4nI9rRG7tzdXg1MVvD69LyUwUOqBSMrfhwUc7WX
         ni80LGW2AcUDx4cw4P48NdxNijJmd9LN/vGZeiXVZ0019Fy/ZwRM4FhUwQ6qJPYqdJzY
         C98g==
X-Gm-Message-State: AOAM531QgqnLe8yYuFEWM1rb+Cz8iW10w96jxEgY7tD3gXUSVfwBEd7C
        7NAa+ocvPswWlJSuYj+QzVJC1Q==
X-Google-Smtp-Source: ABdhPJx15RGqfuPuZb8T8Y8dM3Hj7bcyXhoTbZu79yl5bVMGa2Ii0EiR3p7uOOyPV5w4bDico4Q6dA==
X-Received: by 2002:a05:6a00:2282:b0:50e:552:973a with SMTP id f2-20020a056a00228200b0050e0552973amr23550542pfe.79.1652257912480;
        Wed, 11 May 2022 01:31:52 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7900a000000b0050dc7628170sm1020202pfo.74.2022.05.11.01.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 01:31:52 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
Subject: [PATCH v10 14/16] riscv: Fix a kernel panic issue if $s2 is set to a specific value before entering Linux
Date:   Wed, 11 May 2022 08:31:24 +0000
Message-Id: <3929aa1c47484a6bbc96a46158e412664233bbc4.1652257230.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1652257230.git.greentime.hu@sifive.com>
References: <cover.1652257230.git.greentime.hu@sifive.com>
In-Reply-To: <cover.1652257230.git.greentime.hu@sifive.com>
References: <cover.1652257230.git.greentime.hu@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Panic log:
[    0.018707] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[    0.023060] Oops [#1]
[    0.023214] Modules linked in:
[    0.023725] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.14.0 #33
[    0.023955] Hardware name: SiFive,FU800 (DT)
[    0.024150] epc : __vstate_save+0x1c/0x48
[    0.024654]  ra : arch_dup_task_struct+0x70/0x108
[    0.024815] epc : ffffffff80005ad8 ra : ffffffff800035a8 sp : ffffffff81203d50
[    0.025020]  gp : ffffffff812e8290 tp : ffffffff8120bdc0 t0 : 0000000000000000
[    0.025216]  t1 : 0000000000000000 t2 : 0000000000000000 s0 : ffffffff81203d80
[    0.025424]  s1 : ffffffff8120bdc0 a0 : ffffffff8120c820 a1 : 0000000000000000
[    0.025659]  a2 : 0000000000001000 a3 : 0000000000000000 a4 : 0000000000000600
[    0.025869]  a5 : ffffffff8120cdc0 a6 : ffffffe00160b400 a7 : ffffffff80a1fe60
[    0.026069]  s2 : ffffffe0016b8000 s3 : ffffffff81204000 s4 : 0000000000004000
[    0.026267]  s5 : 0000000000000000 s6 : ffffffe0016b8000 s7 : ffffffe0016b9000
[    0.026475]  s8 : ffffffff81203ee0 s9 : 0000000000800300 s10: ffffffff812e9088
[    0.026689]  s11: ffffffd004008000 t3 : 0000000000000000 t4 : 0000000000000100
[    0.026900]  t5 : 0000000000000600 t6 : ffffffe00167bcc4
[    0.027057] status: 8000000000000720 badaddr: 0000000000000000 cause: 000000000000000f
[    0.027344] [<ffffffff80005ad8>] __vstate_save+0x1c/0x48
[    0.027567] [<ffffffff8000abe8>] copy_process+0x266/0x11a0
[    0.027739] [<ffffffff8000bc98>] kernel_clone+0x90/0x2aa
[    0.027915] [<ffffffff8000c062>] kernel_thread+0x76/0x92
[    0.028075] [<ffffffff8072e34c>] rest_init+0x26/0xfc
[    0.028242] [<ffffffff80800638>] arch_call_rest_init+0x10/0x18
[    0.028423] [<ffffffff80800c4a>] start_kernel+0x5ce/0x5fe
[    0.029188] ---[ end trace 9a59af33f7ba3df4 ]---
[    0.029479] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.029907] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

The NULL pointer accessing caused the kernel panic. There is a NULL
pointer is because in vstate_save() function it will check
(regs->status & SR_VS) == SR_VS_DIRTY and this is true, but it shouldn't
be true because vector is not used here. Since vector is not used, datap
won't be allocated so it is NULL. The reason why regs->status is set to
a wrong value is because pt_regs->status is put in stack and it is polluted
after setup_vm() called.

In prologue of setup_vm(), we can observe it will save s2 to stack however
s2 is meaningless here because the caller is assembly code and s2 is just
some value from previous stage. The compiler will base on calling
convention to save the register to stack. Then 0x80008638 in s2 is saved
to stack. It might be any value. In this failure case it is 0x80008638 and
it will accidentally cause SR_VS_DIRTY to call the vstate_save() function.

(gdb) info addr setup_vm
Symbol "setup_vm" is a function at address 0xffffffff80802c8a.
(gdb) va2pa 0xffffffff80802c8a
$64 = 0x80a02c8a
(gdb) x/10i 0x80a02c8a
   0x80a02c8a:  addi    sp,sp,-48
   0x80a02c8c:  li      a3,-1
   0x80a02c8e:  auipc   a5,0xff7fd
   0x80a02c92:  addi    a5,a5,882
   0x80a02c96:  sd      s0,32(sp)
   0x80a02c98:  sd      s2,16(sp) <-- store to stack

After returning from setup_vm()
(gdb) x/20i  0x0000000080201138
   0x80201138:  mv      a0,s1
   0x8020113a:  auipc   ra,0x802
   0x8020113e:  jalr    -1200(ra)    <-- jump to setup_vm()
   0x80201142:  auipc   a0,0xa03
(gdb) p/x $sp
$70 = 0x81404000
(gdb) p/x *(struct pt_regs*)($sp-0x120)
$71 = {
  epc = 0x0,
  ra = 0x0,
  sp = 0x0,
  gp = 0x0,
  tp = 0x0,
  t0 = 0x0,
  t1 = 0x0,
  t2 = 0x0,
  s0 = 0x0,
  s1 = 0x0,
  a0 = 0x0,
  a1 = 0x0,
  a2 = 0x0,
  a3 = 0x81403f90,
  a4 = 0x80c04000,
  a5 = 0x1,
  a6 = 0xffffffff81337000,
  a7 = 0x81096700,
  s2 = 0x81400000,
  s3 = 0xffffffff81200000,
  s4 = 0x81403fd0,
  s5 = 0x80a02c6c,
  s6 = 0x8000000000006800,
  s7 = 0x0,
  s8 = 0xfffffffffffffff3,
  s9 = 0x80c01000,
  s10 = 0x81096700,
  s11 = 0x82200000,
  t3 = 0x81404000,
  t4 = 0x80a02dea,
  t5 = 0x0,
  t6 = 0x82200000,
  status = 0x80008638, <- Wrong value in stack!!!
  badaddr = 0x82200000,
  cause = 0x0,
  orig_a0 = 0x80201142
}
(gdb) p/x $pc
$72 = 0x80201142
(gdb) p/x sizeof(struct pt_regs)
$73 = 0x120

Co-developed-by: ShihPo Hung <shihpo.hung@sifive.com>
Signed-off-by: ShihPo Hung <shihpo.hung@sifive.com>
Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/kernel/head.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 2877af90b025..0c307c0bd3d6 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -299,6 +299,7 @@ clear_bss_done:
 	/* Initialize page tables and relocate to virtual addresses */
 	la sp, init_thread_union + THREAD_SIZE
 	XIP_FIXUP_OFFSET sp
+	addi sp, sp, -PT_SIZE
 #ifdef CONFIG_BUILTIN_DTB
 	la a0, __dtb_start
 	XIP_FIXUP_OFFSET a0
@@ -316,6 +317,7 @@ clear_bss_done:
 	/* Restore C environment */
 	la tp, init_task
 	la sp, init_thread_union + THREAD_SIZE
+	addi sp, sp, -PT_SIZE
 
 #ifdef CONFIG_KASAN
 	call kasan_early_init
-- 
2.17.1

