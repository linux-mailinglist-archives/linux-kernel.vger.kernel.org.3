Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67D74806CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 07:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbhL1GsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 01:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbhL1GsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 01:48:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5645EC061574;
        Mon, 27 Dec 2021 22:48:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE1F660AB8;
        Tue, 28 Dec 2021 06:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E30EC36AE7;
        Tue, 28 Dec 2021 06:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640674089;
        bh=+GnMS/OPoYG7iR/KsEwNlbZjf29CM2NqgjFZvoobNBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZJdIjCPIfEdOY3H6eDHZ64LATvocPbarXuzVAnDl8T0QYyhPYUknYTdU5yEB/5wH
         NyafdEETUQ4Nar9C/HYFZYzLmZ7Y2JRLXOmmp3iDp/rOOSOXK9P5Z4+qFAe4Lgxno6
         IJ1EdExYBCP61Trn/pi6UNaWiAA1P08h9oz/t0z/fIKGVn77QO1smVyMJQGR2uW+Gg
         ipF0UHM0iDJvkfyPFL06LFlHdDtFwbmQOzxsY/hnE+yJPAsTgJyjvh2zZpnHXNxol5
         QSWBr4hM3EeOGMJCIwVGxLMiMISxsH4Q+FRA6S5egJHIjQGy3+7nNGcWA+t9P5Gu5N
         gU1XAx3pRx2kA==
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
Subject: [PATCH V3 5/8] sched: s390: Remove unused TASK_SIZE_OF
Date:   Tue, 28 Dec 2021 14:47:26 +0800
Message-Id: <20211228064730.2882351-6-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211228064730.2882351-1-guoren@kernel.org>
References: <20211228064730.2882351-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This macro isn't used in Linux sched, now. Delete in
include/linux/sched.h and arch's include/asm.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/include/asm/processor.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index f54c152bf2bf..5581b64a4236 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -88,11 +88,10 @@ extern void __bpon(void);
  * User space process size: 2GB for 31 bit, 4TB or 8PT for 64 bit.
  */
 
-#define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_31BIT) ? \
+#define TASK_SIZE		(test_thread_flag(TIF_31BIT) ? \
 					_REGION3_SIZE : TASK_SIZE_MAX)
 #define TASK_UNMAPPED_BASE	(test_thread_flag(TIF_31BIT) ? \
 					(_REGION3_SIZE >> 1) : (_REGION2_SIZE >> 1))
-#define TASK_SIZE		TASK_SIZE_OF(current)
 #define TASK_SIZE_MAX		(-PAGE_SIZE)
 
 #define STACK_TOP		(test_thread_flag(TIF_31BIT) ? \
-- 
2.25.1

