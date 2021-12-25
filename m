Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA75047F1E6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 05:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhLYEzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 23:55:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45360 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhLYEzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 23:55:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3CCDB80AEA;
        Sat, 25 Dec 2021 04:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BE3C36AEA;
        Sat, 25 Dec 2021 04:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640408110;
        bh=lhZLi2fHARrNEq4LLSfdR+qEsQoJ5dBnyjq9x9/osWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O47U4vTrj3QNxk6GmpLhVdXkGt5KIq0adYPONhPiS9zlmdIF6dLUKm0ctzE/UgxMe
         AOO+ct+kJG9RjRRx17r37NUn60LQ+rja9ygBdLrloP3wt0Bl5PnSmL+VzMw9xQogy2
         jX7VJKQb09vFq2it5MjwIV32f/uONVr7d2xEbZ8u/DwV08SQ/FGn9B4+heWUVT31rU
         hRfkOMfWGSoTbXWqjwcGV2B+YN4kEZ1zNryRBx5lmDeCdiQALPnsWs6AoCf+ksoVYK
         4E7ExCWDluxwuV4SMgi8C0SrGLz7GoJ//7HdRHpqJhZZzVYe71q2yKQWEDIPHvZHOQ
         yx1fmsSGGF6rA==
From:   guoren@kernel.org
To:     guoren@kernel.org, will@kernel.org, tglx@linutronix.de,
        benh@kernel.crashing.org, arnd@arndb.de, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        christophe.leroy@csgroup.eu
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.or,
        linuxppc-dev@lists.ozlabs.org, inux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 4/8] sched: powerpc: Remove unused TASK_SIZE_OF
Date:   Sat, 25 Dec 2021 12:54:26 +0800
Message-Id: <20211225045430.2868608-5-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211225045430.2868608-1-guoren@kernel.org>
References: <20211225045430.2868608-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This macro isn't used in Linux sched, now. Delete in
include/linux/sched.h and arch's include/asm.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/task_size_64.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/task_size_64.h b/arch/powerpc/include/asm/task_size_64.h
index c993482237ed..38fdf8041d12 100644
--- a/arch/powerpc/include/asm/task_size_64.h
+++ b/arch/powerpc/include/asm/task_size_64.h
@@ -44,11 +44,7 @@
  */
 #define TASK_SIZE_USER32 (0x0000000100000000UL - (1 * PAGE_SIZE))
 
-#define TASK_SIZE_OF(tsk)						\
-	(test_tsk_thread_flag(tsk, TIF_32BIT) ? TASK_SIZE_USER32 :	\
-						TASK_SIZE_USER64)
-
-#define TASK_SIZE TASK_SIZE_OF(current)
+#define TASK_SIZE (is_32bit_task() ? TASK_SIZE_USER32 : TASK_SIZE_USER64)
 
 #define TASK_UNMAPPED_BASE_USER32 (PAGE_ALIGN(TASK_SIZE_USER32 / 4))
 #define TASK_UNMAPPED_BASE_USER64 (PAGE_ALIGN(DEFAULT_MAP_WINDOW_USER64 / 4))
-- 
2.25.1

