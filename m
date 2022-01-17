Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3294C490BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbiAQPn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237299AbiAQPnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:43:25 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FF2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:43:25 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id l13so17226878qvz.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xP9+nNeU0pPJaNyxSHM1rhH01w3/wZxyHMR8TSEhtmc=;
        b=HI+dCws7RQMLYP9FBlt/2mFcL0vyCtoCwfD9I0VStsOrIN6g8+Fo9xE/YelF6Pbxu3
         XiFr/vbnUpBGg7toREDqQ8zDaFgRoAOqG5NzYjJDCX2HnP6Fq1POJ1aa7hBDy6HLVbqM
         MIWNj3C6u1IiBvd+9vOsrxLcTiJyYHZjrZEPPhIJAcX1+pyyOKg8WTdoRzGKyPQcZMLy
         gtn/B++uXwvZzVzljfwRvGRn3Uw3l/zbG641yc+3FPnNx8v6tuJ8mbiU9+FD0JW2fC6H
         BjSries8Zi7VLqiWZ6yWEChcWLiahxcOMv0MKIXzDQl9x0iGC+oey6o28L26CQchYmud
         1y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xP9+nNeU0pPJaNyxSHM1rhH01w3/wZxyHMR8TSEhtmc=;
        b=nvkFN96tRHNvbWQstXFs3TgUafgsZh2bynoSlnSjVixAjNCjc9UhVKO7gX9EykxBsO
         YlkXdMC8ErYVA4laLJlgr1I+j1AalarIhDiIw3PifW7ls6Ap2Rxvyg8Jjz5lkfK2ECDL
         MecttCRFPLabqoDagscB8IesEZtNHFMKCueBN3U2oNE62EQnHf1RPLCXUlYI3hh3tKTM
         Z+txJ43Jd2R5kFQLB2HGIx/jRl4uzCMMct/w420UKSByfzF6zKzon8VB3crxXjWUNEZF
         Mve35gUTLSfWWqZv+SMP3RrK3FD7LiLfuBDQz/5uHuo3OWQ1R5SSNmRSyKafMLpfoNvY
         LigA==
X-Gm-Message-State: AOAM533gsB6MxQkloMjT8XmQm674jYKl4c9IxbiroinbysFomHlzR4a4
        svj9xC/gM2hV2hDMgW/dB7qP+9rPtT2eBMcG
X-Google-Smtp-Source: ABdhPJyuIYYJkAmO78IaACd35H7++l0ftE0t2n1dbEcW++BwwQmlTQhzXYiFoGGUv/HzUQyK31Z0aQ==
X-Received: by 2002:a05:6214:4001:: with SMTP id kd1mr18390236qvb.13.1642434204942;
        Mon, 17 Jan 2022 07:43:24 -0800 (PST)
Received: from WRT-WX9.. ([207.246.89.135])
        by smtp.gmail.com with ESMTPSA id i11sm3978507qti.55.2022.01.17.07.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 07:43:24 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] sysrq: do not omit current cpu when showing backtrace of all active CPUs
Date:   Mon, 17 Jan 2022 23:43:00 +0800
Message-Id: <20220117154300.2808-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The backtrace of current CPU also should be printed as it is active. This
change add stack trace for current CPU and print a hint for idle CPU for
the generic workqueue based printing. (x86 already does this)

Now it looks like below:
[  279.401567] sysrq: Show backtrace of all active CPUs
[  279.407234] sysrq: CPU5:
[  279.407505] Call Trace:
[  279.408789] [<ffffffff8000606c>] dump_backtrace+0x2c/0x3a
[  279.411698] [<ffffffff800060ac>] show_stack+0x32/0x3e
[  279.411809] [<ffffffff80542258>] sysrq_handle_showallcpus+0x4c/0xc6
[  279.411929] [<ffffffff80542f16>] __handle_sysrq+0x106/0x26c
[  279.412034] [<ffffffff805436a8>] write_sysrq_trigger+0x64/0x74
[  279.412139] [<ffffffff8029cd48>] proc_reg_write+0x8e/0xe2
[  279.412252] [<ffffffff8021a8f8>] vfs_write+0x90/0x2be
[  279.412362] [<ffffffff8021acd2>] ksys_write+0xa6/0xce
[  279.412467] [<ffffffff8021ad24>] sys_write+0x2a/0x38
[  279.412689] [<ffffffff80003ff8>] ret_from_syscall+0x0/0x2
[  279.417173] sysrq: CPU6: backtrace skipped as idling
[  279.417185] sysrq: CPU4: backtrace skipped as idling
[  279.417187] sysrq: CPU0: backtrace skipped as idling
[  279.417181] sysrq: CPU7: backtrace skipped as idling
[  279.417190] sysrq: CPU1: backtrace skipped as idling
[  279.417193] sysrq: CPU3: backtrace skipped as idling
[  279.417219] sysrq: CPU2:
[  279.419179] Call Trace:
[  279.419440] [<ffffffff8000606c>] dump_backtrace+0x2c/0x3a
[  279.419782] [<ffffffff800060ac>] show_stack+0x32/0x3e
[  279.420015] [<ffffffff80542b30>] showacpu+0x5c/0x96
[  279.420317] [<ffffffff800ba71c>] flush_smp_call_function_queue+0xd6/0x218
[  279.420569] [<ffffffff800bb438>] generic_smp_call_function_single_interrupt+0x14/0x1c
[  279.420798] [<ffffffff800079ae>] handle_IPI+0xaa/0x13a
[  279.421024] [<ffffffff804dcb92>] riscv_intc_irq+0x56/0x70
[  279.421274] [<ffffffff80a05b70>] generic_handle_arch_irq+0x6a/0xfa
[  279.421518] [<ffffffff80004006>] ret_from_exception+0x0/0x10
[  279.421750] [<ffffffff80096492>] rcu_idle_enter+0x16/0x1e

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 drivers/tty/sysrq.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index bbfd004449b5..34cfdda4aff5 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -232,8 +232,10 @@ static void showacpu(void *dummy)
 	unsigned long flags;
 
 	/* Idle CPUs have no interesting backtrace. */
-	if (idle_cpu(smp_processor_id()))
+	if (idle_cpu(smp_processor_id())) {
+		pr_info("CPU%d: backtrace skipped as idling\n", smp_processor_id());
 		return;
+	}
 
 	raw_spin_lock_irqsave(&show_lock, flags);
 	pr_info("CPU%d:\n", smp_processor_id());
@@ -260,10 +262,13 @@ static void sysrq_handle_showallcpus(int key)
 
 		if (in_hardirq())
 			regs = get_irq_regs();
-		if (regs) {
-			pr_info("CPU%d:\n", smp_processor_id());
+
+		pr_info("CPU%d:\n", smp_processor_id());
+		if (regs)
 			show_regs(regs);
-		}
+		else
+			show_stack(NULL, NULL, KERN_INFO);
+
 		schedule_work(&sysrq_showallcpus);
 	}
 }
-- 
2.32.0

