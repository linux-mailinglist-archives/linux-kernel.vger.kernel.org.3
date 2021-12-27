Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182F9480378
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 19:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhL0Sul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 13:50:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34216 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhL0Suk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 13:50:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D80BF61121
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 18:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08374C36AEA;
        Mon, 27 Dec 2021 18:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640631039;
        bh=EYsKbt3rUVkRJqrJ9Nsgsi3ljZJ98du0Nz+EkljC4PE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BILYG4+KeLnegaOxz62reQc5hSXTrYt5D6fq3p0j+EWdJTuGM54KvsuKEYwDQirlH
         pCI/C4ZgVS2CmY1kcW9vGkcEtZrUEYG2U5aDLzPZQOfpwCZTA7R9nzhqZuoSJ2Tg1H
         45gB01E8WMfypWTdBG7/fk4AzigB9Z3A/KehS1pY5VRf0vBClH49zKrFFn7tXEs/+P
         TBKo1M3Nk6ADZ4sIeqYZ/taXUfV1p4+8MQlMobM8GE4xhrZqAYRrwnKS8eCYJZMehh
         r7XaDvDPmAcZo5aZ71xXAS1vEmOIBIJmngh2DvcwG7rFQ11uBKsT+p87lXctfgJGFt
         uxvmBZ/y1kpRg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Brian Cain <bcain@codeaurora.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 3/3] csky: Fix function name in csky_alignment() and die()
Date:   Mon, 27 Dec 2021 11:48:51 -0700
Message-Id: <20211227184851.2297759-4-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211227184851.2297759-1-nathan@kernel.org>
References: <20211227184851.2297759-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building ARCH=csky defconfig:

arch/csky/kernel/traps.c: In function 'die':
arch/csky/kernel/traps.c:112:17: error: implicit declaration of function
'make_dead_task' [-Werror=implicit-function-declaration]
  112 |                 make_dead_task(SIGSEGV);
      |                 ^~~~~~~~~~~~~~

The function's name is make_task_dead(), change it so there is no more
build error.

Fixes: 0e25498f8cd4 ("exit: Add and use make_task_dead.")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/csky/abiv1/alignment.c | 2 +-
 arch/csky/kernel/traps.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
index 5e2fb45d605c..2df115d0e210 100644
--- a/arch/csky/abiv1/alignment.c
+++ b/arch/csky/abiv1/alignment.c
@@ -294,7 +294,7 @@ void csky_alignment(struct pt_regs *regs)
 				__func__, opcode, rz, rx, imm, addr);
 		show_regs(regs);
 		bust_spinlocks(0);
-		make_dead_task(SIGKILL);
+		make_task_dead(SIGKILL);
 	}
 
 	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)addr);
diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
index 88a47035b925..50481d12d236 100644
--- a/arch/csky/kernel/traps.c
+++ b/arch/csky/kernel/traps.c
@@ -109,7 +109,7 @@ void die(struct pt_regs *regs, const char *str)
 	if (panic_on_oops)
 		panic("Fatal exception");
 	if (ret != NOTIFY_STOP)
-		make_dead_task(SIGSEGV);
+		make_task_dead(SIGSEGV);
 }
 
 void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
-- 
2.34.1

