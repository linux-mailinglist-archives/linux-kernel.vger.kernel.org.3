Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0454806C6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 07:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbhL1GsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 01:48:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57590 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbhL1Gr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 01:47:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5248F61179;
        Tue, 28 Dec 2021 06:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B461C36AE8;
        Tue, 28 Dec 2021 06:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640674077;
        bh=/VO3mwMyYHdNKGu6mJrX7t4r1f7trz6vaxvlX8LEffY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u0Z+gaFu9yOEolHHZSFm2vC77NNXpU8xjLgXD6b4FJiGxM1Z3F8p4yIfmKGhcMK91
         c8PLQD9tvX4Vg+Amr6L5JmafWBZWsCg/tgGBq5Op/3c/UhiGsQbIs2QaMzQvfYLX4v
         f5NpaviTdxFF6h7lhOG6eaGArgZdxhtLG3IXNKVtLZbEgU5hMamvgYTSTUFpA9Ufm9
         cQK/Zh7Iqs61G1h8A0y2sfFQ9bIX9cluLqoPFbvwvY03VxQWX7bPXQFQJaiNg2PWzV
         90Vguy4HU3WZiTkU7cvBWYm9D/8VbW12bd3v6dzjd4YkZOSr5o/2Ocs/0GQiEr6X4S
         oQEyvHOuTZb5g==
From:   guoren@kernel.org
To:     guoren@kernel.org, will@kernel.org, tglx@linutronix.de,
        benh@kernel.crashing.org, arnd@arndb.de, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        christophe.leroy@csgroup.eu, hca@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.or,
        linuxppc-dev@lists.ozlabs.org, inux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V3 3/8] sched: sparc: Remove unused TASK_SIZE_OF
Date:   Tue, 28 Dec 2021 14:47:24 +0800
Message-Id: <20211228064730.2882351-4-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211228064730.2882351-1-guoren@kernel.org>
References: <20211228064730.2882351-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This macro isn't used in Linux, now. Delete in
include/linux/sched.h and arch's include/asm.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
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

