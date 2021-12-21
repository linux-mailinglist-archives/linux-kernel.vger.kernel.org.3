Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC00D47C475
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbhLURB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:01:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35420 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240128AbhLURBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:01:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FF35B817CC;
        Tue, 21 Dec 2021 17:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0189C36AEA;
        Tue, 21 Dec 2021 17:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640106080;
        bh=hDrpxjLpH7AYnsBnnFE9PQK2fvJYNhcVso1F5XKuDwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AJ4Xuw6oLpN8ml0LwHdI39lylRfTgDcfl8iIiQTt73Uxrxsz18t5iWDWxLfFMofvf
         BYXiPVWpbcpVSl+Up80Kzzr/UdNMenLF3AEowc7WAONmtN9qA9wdZ6ufhnVed+63jp
         yNi0L5okjlgWTf9w+/nPeVMhvMjmxgK7G9whxRzeqpgBVhCHO4lrGODFKI63ljF917
         o6H6mITHNRBhOgqqlA2JwTsceC4kbYwisgUKxrEtVrEAGfZjnM8MR6aAUmjqpF3/H4
         zl21s/bk5UNrnDwlw7d3pKwOL1+ZdYf+8Hm2dMUIym6Ke5jWRJE0C6/Tf08BXA9APE
         xVzSJAXLFU/sA==
From:   guoren@kernel.org
To:     guoren@kernel.org, will@kernel.org, tglx@linutronix.de,
        benh@kernel.crashing.org, arnd@arndb.de, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.or,
        linuxppc-dev@lists.ozlabs.org, inux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 3/8] sched: sparc: Remove unused TASK_SIZE_OF
Date:   Wed, 22 Dec 2021 01:00:52 +0800
Message-Id: <20211221170057.2637763-4-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211221170057.2637763-1-guoren@kernel.org>
References: <20211221170057.2637763-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This macro isn't used in Linux, now. Delete in
include/linux/sched.h and arch's include/asm.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/sparc/include/asm/processor_64.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
index ae851e8fce4c..628349fc4cdd 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -27,9 +27,6 @@
 #define VPTE_SIZE	(1 << (VA_BITS - PAGE_SHIFT + 3))
 #endif
 
-#define TASK_SIZE_OF(tsk) \
-	(test_tsk_thread_flag(tsk,TIF_32BIT) ? \
-	 (1UL << 32UL) : ((unsigned long)-VPTE_SIZE))
 #define TASK_SIZE \
 	(test_thread_flag(TIF_32BIT) ? \
 	 (1UL << 32UL) : ((unsigned long)-VPTE_SIZE))
-- 
2.25.1

