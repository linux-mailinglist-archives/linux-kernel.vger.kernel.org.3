Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964594FF03B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiDMG6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiDMG5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:57:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2C9240B5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:55:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h15-20020a17090a054f00b001cb7cd2b11dso1152700pjf.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dsqCdkEBcKp3bCTKPoDfs4lnykltoKN4ieexou7gS/s=;
        b=ZRubBcePe0F86s5WG3BwiN6JnjD85ysGkxhX8NmanR9+FwYndGr3Wwakj9sP6H12mk
         4zNBs0RDUCaLp3Rk8pV5AKzIycmTkHii9d45njkrTxBwuV6Ylh3oiN9M3+scjOYGRawh
         9S6xO8my1W9jhnuta+RB3d7mke1d76WJt871aM9EkoXEzkyt1gCtjS9SnQP5xWWeMh7E
         YqQG4fehssvxa5EpBuFqHr9zMpqKbN/wg4oKdjTQR4L8EO3pCLUcJlq+PTFEcKdo6ajq
         Wrss1WXhjKHlAs7GlojNcS8repDM5y3yc0lXWVIsnPxbB1a5P05VDBNlm4aXZCH7hPTo
         KnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dsqCdkEBcKp3bCTKPoDfs4lnykltoKN4ieexou7gS/s=;
        b=wC6AYEr5mECxFi97fObkvWUUTORxJtvzNjnhmqcY5034K+HEfareQu6Ud2oZMMu33t
         sA/PwyivQquW85knPS9D+Pi6hyoWV9E286yJ5VZYX32Io0T4NvKZJ8LANx+LZKaPTYes
         b5Up0TlwPuft3gu6q+2n3KPV96GtdovYwkqVk/yh+cKBDzZUSMpSb/9hReKGWwc/usWZ
         LTXqs+JnZtP8fyBPksx646XBTKID4hOwqlsQPRa2qAUKW5PzqtnX5431kQ6qDI/w2gEG
         0j7t2h8/Byc6Je/datCFGECJY5WOJzk5XXv7xRKErFrWPZpZmHCMQQrD7pH3JEOSKm8h
         BwPA==
X-Gm-Message-State: AOAM532TgXn/WNxqQCLVDSsfQL8S0ttMtmDTUtYAyRH/bNkJBV6c/5ER
        Cd4IM8g0g4VmnANaXe3ERFQU9w==
X-Google-Smtp-Source: ABdhPJymWrw++STavmjsxycTlQTViSsW/wc2iZHskV3l+3Iam0Yezf9SkgoYpwJfq0jL24znGUaytw==
X-Received: by 2002:a17:90b:4d0e:b0:1cd:4cef:52a5 with SMTP id mw14-20020a17090b4d0e00b001cd4cef52a5mr2582823pjb.60.1649832922603;
        Tue, 12 Apr 2022 23:55:22 -0700 (PDT)
Received: from localhost.localdomain ([223.177.215.72])
        by smtp.gmail.com with ESMTPSA id m15-20020a638c0f000000b003827bfe1f5csm4926908pgd.7.2022.04.12.23.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 23:55:22 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
        will@kernel.org, liwei391@huawei.com
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, mhiramat@kernel.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        maz@kernel.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 2/2] arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step
Date:   Wed, 13 Apr 2022 12:24:58 +0530
Message-Id: <20220413065458.88541-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413065458.88541-1-sumit.garg@linaro.org>
References: <20220413065458.88541-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After fixing wrongly single-stepping into the irq handler, when we execute
single-step in kdb/kgdb, we can see only the first step can work.

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

