Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB68447C478
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240206AbhLURBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:01:32 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40598 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240192AbhLURB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:01:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22A7C61689;
        Tue, 21 Dec 2021 17:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FDCC36AE9;
        Tue, 21 Dec 2021 17:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640106085;
        bh=C4uY6IDvAgo0GjDDiLqZiUWK++v8kONm1c6xElXqxzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0qMkaMVdT68wSaWhMCLc29zOalWNaalFSakJlfoA1Yeax4Napww7JdrtDYY/bKQT
         2u/Vhc6ofKWE7Z3UHx4Jv11wgMtgyvxmBm5WcDZPr3gDeyC3ZssTDTqaVG6rVJTlAY
         3d6Snwwk6R1XNV1xjcx24WZ3QO55ab93bXuOmPqSKnq3GZtmvMIhogvRIBbGR2efEy
         4xruHJ6zF5BPdTFUsrA+GU/AOYVXTL05eUSHytp55g4Erzjexd/4pLa76dJmmTVoXK
         kR7LcVChH591TjkxdDyOn5aZUysU0sB9RJtfU3mmaS0yA8Lt9ofHH781poR87gMph/
         Nn9aN3KsR2n+A==
From:   guoren@kernel.org
To:     guoren@kernel.org, will@kernel.org, tglx@linutronix.de,
        benh@kernel.crashing.org, arnd@arndb.de, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.or,
        linuxppc-dev@lists.ozlabs.org, inux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 4/8] sched: powerpc: Remove unused TASK_SIZE_OF
Date:   Wed, 22 Dec 2021 01:00:53 +0800
Message-Id: <20211221170057.2637763-5-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211221170057.2637763-1-guoren@kernel.org>
References: <20211221170057.2637763-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This macro isn't used in Linux sched, now. Delete in
include/linux/sched.h and arch's include/asm.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/powerpc/include/asm/task_size_64.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/task_size_64.h b/arch/powerpc/include/asm/task_size_64.h
index c993482237ed..7e2eca4fac4d 100644
--- a/arch/powerpc/include/asm/task_size_64.h
+++ b/arch/powerpc/include/asm/task_size_64.h
@@ -44,12 +44,10 @@
  */
 #define TASK_SIZE_USER32 (0x0000000100000000UL - (1 * PAGE_SIZE))
 
-#define TASK_SIZE_OF(tsk)						\
-	(test_tsk_thread_flag(tsk, TIF_32BIT) ? TASK_SIZE_USER32 :	\
+#define TASK_SIZE							\
+	(test_tsk_thread_flag(current, TIF_32BIT) ? TASK_SIZE_USER32 :	\
 						TASK_SIZE_USER64)
 
-#define TASK_SIZE TASK_SIZE_OF(current)
-
 #define TASK_UNMAPPED_BASE_USER32 (PAGE_ALIGN(TASK_SIZE_USER32 / 4))
 #define TASK_UNMAPPED_BASE_USER64 (PAGE_ALIGN(DEFAULT_MAP_WINDOW_USER64 / 4))
 
-- 
2.25.1

