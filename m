Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025F1520106
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238187AbiEIPYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238199AbiEIPYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:24:13 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F77F28FE9E;
        Mon,  9 May 2022 08:20:19 -0700 (PDT)
Received: from localhost.localdomain (154.pool92-186-13.dynamic.orange.es [92.186.13.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id AD3C920EC5B5;
        Mon,  9 May 2022 08:20:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AD3C920EC5B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1652109618;
        bh=XfhHrRThZF8aOS0rr6qXUwCmQQucSBuKvTVfiEM2qbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KfP8DfNAI4MBKVrm9g3GFZPRXm2UsXbAXmZc9kUs++r8+cQlyhl2L3hojSj8kbyi4
         Vksl/ezacECICq5brWkqXPeiatkBkOPvlSoGfhRmHcvqaLVLc9mAWgvZaAN2kd2Whq
         xO/hMuKxaUpjSDLfB2hPytjNjVLDSjgFwtltB4lo=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-trace-devel@vger.kernel.org,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Kiss <daniel.kiss@arm.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/1] arm64: Forget syscall if different from execve*()
Date:   Mon,  9 May 2022 16:19:57 +0100
Message-Id: <20220509151958.441240-2-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509151958.441240-1-flaniel@linux.microsoft.com>
References: <20220509151958.441240-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables exeve*() to be traced by syscalls:sys_exit_execve
tracepoint.
Previously, calling forget_syscall() would set syscall to -1, which impedes
this tracepoint to prints its information.
So, this patch makes call to forget_syscall() conditional by only calling
it when syscall number is not execve() or execveat().

Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
---
 arch/arm64/include/asm/processor.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 73e38d9a540c..e12ceb363d6a 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -34,6 +34,8 @@
 
 #include <vdso/processor.h>
 
+#include <asm-generic/unistd.h>
+
 #include <asm/alternative.h>
 #include <asm/cpufeature.h>
 #include <asm/hw_breakpoint.h>
@@ -250,8 +252,12 @@ void tls_preserve_current_state(void);
 
 static inline void start_thread_common(struct pt_regs *regs, unsigned long pc)
 {
+	s32 previous_syscall = regs->syscallno;
 	memset(regs, 0, sizeof(*regs));
-	forget_syscall(regs);
+	if (previous_syscall == __NR_execve || previous_syscall == __NR_execveat)
+		regs->syscallno = previous_syscall;
+	else
+		forget_syscall(regs);
 	regs->pc = pc;
 
 	if (system_uses_irq_prio_masking())
-- 
2.25.1

