Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C686F522C13
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242039AbiEKGF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiEKGFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:05:52 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0844D60C6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:05:45 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so1146744pjq.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M2tMIjY53oynE5ZZlI/baO0lGZKZqD2qqN0eNb/iE2w=;
        b=PWhnEnJk9qvGqrSC7B+xbAQJFKIXMFzEqbX5YybccBDSFAD0JdmcVlA4aoZosIjEn6
         jWruvxH1PxvP/amFuB48PZbbNr5pORQQafPTLAV5wflu7go3zAO6g7xXJwd0pUZJa1ij
         Qk1ooH64bNO2AbmgXsF4uDjg5H3A08W36IgEJjgSNozKEMuCXwOvZyrsk99wMmCe29uF
         uVwBU99akYHf+S7Ghh8jyLJhYc+txT750TY71WiD/u8RHc83zMTJGbefCmcjfvKuzfN1
         4+KLv0uW/SqBrVpSfuygCQDQocWmhPikwA+9stwzEQcTHPvORve9yo5DzdMa88fdqGf4
         zzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M2tMIjY53oynE5ZZlI/baO0lGZKZqD2qqN0eNb/iE2w=;
        b=S4iBqaTWXgxPeAl51C5yuqHVwo0TCNqko+Xk+qqaH+U1otHYgfChVgTE+Uma961n+p
         wt3IfKXa1pa/zI+xjqrcWlGml5uH6X01LFLRStrMBwphEbPW5AkhDcqCTQ642UJsqHh9
         vqmXPVjSgV3pZcvs8E9cO6rklvwPLvdSAHoa0nWBqAxNPqYHR2P+HazwSGp1z8ADsZDO
         ih6LA+eArzs+ihWI6S3bDdQXmbLSas0ynKlFnnPDb31e7oXhCQVkCqI+aF55W0t6vvlK
         Ff5U8PljrTcZXfdPqh4nUKKFzCX7ohXQAB2Sob4wlUJr+I76B+wVr5ujKiI++iNdAech
         mc5A==
X-Gm-Message-State: AOAM532u3KxeBw5sDGu1tuseMIRhq4IyV5nRKwiFgLSIxzgvbSt+8MH0
        6m5pbaNjVrb+uPuyOXYVLNoy+g==
X-Google-Smtp-Source: ABdhPJzCg92rzXG3n/bMXqch/TKUzBM6ZIxdElEeaqetBR69Pcu9FbBXio81XWJ/L3/M9y8Px6C/lg==
X-Received: by 2002:a17:902:ec8c:b0:15e:a371:ad7d with SMTP id x12-20020a170902ec8c00b0015ea371ad7dmr23663232plg.12.1652249143871;
        Tue, 10 May 2022 23:05:43 -0700 (PDT)
Received: from localhost.localdomain ([106.213.2.134])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090a31c700b001d960eaed66sm800216pjf.42.2022.05.10.23.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 23:05:42 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org, dianders@chromium.org, will@kernel.org,
        liwei391@huawei.com
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, mhiramat@kernel.org,
        jason.wessel@windriver.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 2/2] arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step
Date:   Wed, 11 May 2022 11:35:21 +0530
Message-Id: <20220511060521.465744-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511060521.465744-1-sumit.garg@linaro.org>
References: <20220511060521.465744-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only the first attempt to single-step has any effect. After
that all further stepping remains "stuck" at the same program counter
value.

Refer to the ARM Architecture Reference Manual (ARM DDI 0487E.a) D2.12,
i think PSTATE.SS=1 should be set each step for transferring the PE to the
'Active-not-pending' state. The problem here is PSTATE.SS=1 is not set
since the second single-step.

After the first single-step, the PE transferes to the 'Inactive' state,
with PSTATE.SS=0 and MDSCR.SS=1, thus PSTATE.SS won't be set to 1 due to
kernel_active_single_step()=true. Then the PE transferes to the
'Active-pending' state when ERET and returns to the debugger by step
exception.

Before this patch:
==================
Entering kdb (current=0xffff3376039f0000, pid 1) on processor 0 due to Keyboard Entry
[0]kdb>

[0]kdb>
[0]kdb> bp write_sysrq_trigger
Instruction(i) BP #0 at 0xffffa45c13d09290 (write_sysrq_trigger)
    is enabled   addr at ffffa45c13d09290, hardtype=0 installed=0

[0]kdb> go
$ echo h > /proc/sysrq-trigger

Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to Breakpoint @ 0xffffad651a309290
[1]kdb> ss

Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to SS trap @ 0xffffad651a309294
[1]kdb> ss

Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to SS trap @ 0xffffad651a309294
[1]kdb>

After this patch:
=================
Entering kdb (current=0xffff6851c39f0000, pid 1) on processor 0 due to Keyboard Entry
[0]kdb> bp write_sysrq_trigger
Instruction(i) BP #0 at 0xffffc02d2dd09290 (write_sysrq_trigger)
    is enabled   addr at ffffc02d2dd09290, hardtype=0 installed=0

[0]kdb> go
$ echo h > /proc/sysrq-trigger

Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to Breakpoint @ 0xffffc02d2dd09290
[1]kdb> ss

Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd09294
[1]kdb> ss

Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd09298
[1]kdb> ss

Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd0929c
[1]kdb>

Fixes: 44679a4f142b ("arm64: KGDB: Add step debugging support")
Co-developed-by: Wei Li <liwei391@huawei.com>
Signed-off-by: Wei Li <liwei391@huawei.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/include/asm/debug-monitors.h | 1 +
 arch/arm64/kernel/debug-monitors.c      | 5 +++++
 arch/arm64/kernel/kgdb.c                | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 00c291067e57..9e1e864d6440 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -104,6 +104,7 @@ void user_regs_reset_single_step(struct user_pt_regs *regs,
 void kernel_enable_single_step(struct pt_regs *regs);
 void kernel_disable_single_step(void);
 int kernel_active_single_step(void);
+void kernel_regs_reset_single_step(struct pt_regs *regs);
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 int reinstall_suspended_bps(struct pt_regs *regs);
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 4f3661eeb7ec..ea3f410aa385 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -438,6 +438,11 @@ int kernel_active_single_step(void)
 }
 NOKPROBE_SYMBOL(kernel_active_single_step);
 
+void kernel_regs_reset_single_step(struct pt_regs *regs)
+{
+	set_regs_spsr_ss(regs);
+}
+
 /* ptrace API */
 void user_enable_single_step(struct task_struct *task)
 {
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 2aede780fb80..acf2196b1e9b 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -224,6 +224,8 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		 */
 		if (!kernel_active_single_step())
 			kernel_enable_single_step(linux_regs);
+		else
+			kernel_regs_reset_single_step(linux_regs);
 		err = 0;
 		break;
 	default:
-- 
2.25.1

