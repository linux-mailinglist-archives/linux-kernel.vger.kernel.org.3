Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9661490BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbiAQPoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240627AbiAQPow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:44:52 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BEBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:44:51 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id bt14so12922044qvb.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MY35t/sGCjknDi4hTsrGfNGKuQt3p93XQ6aOci+nLL4=;
        b=g9wm8Lw3WVrky+tnBekhR0ffK8hd+/1w60cTe4CcaydzdS+dZwVEMaRlfS/R9iwVSL
         X7l3VVQFlPOrM2Y74lgnlrBHlCXFNxkDL5lYCAOeIBCEZZPTVOrm+6b4e8hJKC+BZsgW
         Fw018n91TCf7bvIAKXTjaAEFGR3A/tkburZFWwlAoJAF8BmguCRfwnQytUzxRqNYW1VI
         OimsBZ3RP0f+5sRtUnqbpL2WNukFEePmkZTDzYenjwFLOMBssGm7WrXh9Y8dropYpV+r
         ysbpfqveYeYwwbt6CAM/sZP9z+lOHh6z9HQ0sNA6lUTMGZ32OG/zKmAjcsZmQWQJiGU8
         I2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MY35t/sGCjknDi4hTsrGfNGKuQt3p93XQ6aOci+nLL4=;
        b=f36uf26xVntVnJzRrfXD5V0EaYqLTaVTS614d/DCOEDjmJR5OWSpL4TI3xiVoVRCE7
         IXnogR63xFSNXXTUvbMjFIwWwd3dzr1I0BmmCx1gw+vZSoRzbx0S1Jor4VBpoa/d2QCI
         oBoE/R6FqIYPo8r0wVkAWBMcHSSf3lryXJgaokVJFDD5TnPQLgq+qLeBEzHJQzWStUJJ
         nKTD7u4EfLFyHT57BsgXxKthUzopbJIZ5l/G2LpLVaNo6FJ84526XVT5y9RB3MSwmeVh
         K0CmBZj0oDtUUzjVOuZD8znhFwZgBNJmmp/xTBP7wsjLFeCDrZtvjq7z12vYV8VYEUv9
         m41A==
X-Gm-Message-State: AOAM530qDF0BGgz41qDD30MQEZ3VJZ6gD6W+QmcMg/Sx56R3YWbswb5x
        sD4PX4lla5K4NN7N8QGfeQNkVaymzCCG2m19
X-Google-Smtp-Source: ABdhPJxYJuBxBWIneGwnFame4xgpvZ9ADMOTgUdeh8A+Ln+EBHDhdY9snDS+9CwOmALjfmUUbnAdUA==
X-Received: by 2002:ad4:5e8b:: with SMTP id jl11mr18704294qvb.128.1642434291010;
        Mon, 17 Jan 2022 07:44:51 -0800 (PST)
Received: from WRT-WX9.. ([207.246.89.135])
        by smtp.gmail.com with ESMTPSA id h7sm8857551qkb.109.2022.01.17.07.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 07:44:50 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] riscv: eliminate unreliable __builtin_frame_address(1)
Date:   Mon, 17 Jan 2022 23:44:33 +0800
Message-Id: <20220117154433.3124-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried different pieces of code which uses __builtin_frame_address(1)
(with both gcc version 7.5.0 and 10.3.0) to verify whether it works as
expected on riscv64. The result is negative.

What the compiler had generated is as below:
31                      fp = (unsigned long)__builtin_frame_address(1);
   0xffffffff80006024 <+200>:   ld      s1,0(s0)

It takes '0(s0)' as the address of frame 1 (caller), but the actual address
should be '-16(s0)'.

          |       ...       | <-+
          +-----------------+   |
          | return address  |   |
          | previous fp     |   |
          | saved registers |   |
          | local variables |   |
  $fp --> |       ...       |   |
          +-----------------+   |
          | return address  |   |
          | previous fp --------+
          | saved registers |
  $sp --> | local variables |
          +-----------------+

This leads the kernel can not dump the full stack trace on riscv.

[    7.222126][    T1] Call Trace:
[    7.222804][    T1] [<ffffffff80006058>] dump_backtrace+0x2c/0x3a

This problem is not exposed on most riscv builds just because the '0(s0)'
occasionally is the address frame 2 (caller's caller), if only ra and fp
are stored in frame 1 (caller).

          |       ...       | <-+
          +-----------------+   |
          | return address  |   |
  $fp --> | previous fp     |   |
          +-----------------+   |
          | return address  |   |
          | previous fp --------+
          | saved registers |
  $sp --> | local variables |
          +-----------------+

This could be a *bug* of gcc that should be fixed. But as noted in gcc
manual "Calling this function with a nonzero argument can have
unpredictable effects, including crashing the calling program.", let's
remove the '__builtin_frame_address(1)' in backtrace code.

With this fix now it can show full stack trace:
[   10.444838][    T1] Call Trace:
[   10.446199][    T1] [<ffffffff8000606c>] dump_backtrace+0x2c/0x3a
[   10.447711][    T1] [<ffffffff800060ac>] show_stack+0x32/0x3e
[   10.448710][    T1] [<ffffffff80a005c0>] dump_stack_lvl+0x58/0x7a
[   10.449941][    T1] [<ffffffff80a005f6>] dump_stack+0x14/0x1c
[   10.450929][    T1] [<ffffffff804c04ee>] ubsan_epilogue+0x10/0x5a
[   10.451869][    T1] [<ffffffff804c092e>] __ubsan_handle_load_invalid_value+0x6c/0x78
[   10.453049][    T1] [<ffffffff8018f834>] __pagevec_release+0x62/0x64
[   10.455476][    T1] [<ffffffff80190830>] truncate_inode_pages_range+0x132/0x5be
[   10.456798][    T1] [<ffffffff80190ce0>] truncate_inode_pages+0x24/0x30
[   10.457853][    T1] [<ffffffff8045bb04>] kill_bdev+0x32/0x3c
...

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 arch/riscv/kernel/stacktrace.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 201ee206fb57..14d2b53ec322 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -22,15 +22,16 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			     bool (*fn)(void *, unsigned long), void *arg)
 {
 	unsigned long fp, sp, pc;
+	int level = 0;
 
 	if (regs) {
 		fp = frame_pointer(regs);
 		sp = user_stack_pointer(regs);
 		pc = instruction_pointer(regs);
 	} else if (task == NULL || task == current) {
-		fp = (unsigned long)__builtin_frame_address(1);
-		sp = (unsigned long)__builtin_frame_address(0);
-		pc = (unsigned long)__builtin_return_address(0);
+		fp = (unsigned long)__builtin_frame_address(0);
+		sp = sp_in_global;
+		pc = (unsigned long)walk_stackframe;
 	} else {
 		/* task blocked in __switch_to */
 		fp = task->thread.s[0];
@@ -42,7 +43,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 		unsigned long low, high;
 		struct stackframe *frame;
 
-		if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
+		if (unlikely(!__kernel_text_address(pc) || (level++ >= 1 && !fn(arg, pc))))
 			break;
 
 		/* Validate frame pointer */
-- 
2.32.0

