Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBAF4806C9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 07:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhL1GsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 01:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbhL1GsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 01:48:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38967C061574;
        Mon, 27 Dec 2021 22:48:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D82DDB8111B;
        Tue, 28 Dec 2021 06:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593AEC36AEE;
        Tue, 28 Dec 2021 06:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640674083;
        bh=kTZEcBT+5Go5nfuBUtuREshHd2md+mgqYEFXzNe9sc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ze8+mzJqajnqM9co8JY/atNts1gRA0tZfEN7BsA4AY8+sT8Q7kOmEYDa0+0WK2j5L
         mxgsj1WP+WkS2V934Bpk4Az5id6zrCQx++knOyRk+24rAvhxftRconCsTV4425VgIo
         QN8XZnHAXF8Hp3NQ94uuXtt3ELe7WmFrSRLsRitk8jRkYKT/dytLroQoy5HaIIq/Z7
         0ZSvrKgSZwk7EqjCDOcD4M0la8Cgt0KJAr5l+1jSOqljbNiStWsFMNOYQCjkKS+lWu
         +1z8oiRGIAvdTvZgElLxzeZQcdNCBj0DU+XBUJCrpO3Flqw8tjQkNTRUDZM2guOdaX
         BFzVW3J3lJCtw==
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
Subject: [PATCH V3 4/8] sched: powerpc: Remove unused TASK_SIZE_OF
Date:   Tue, 28 Dec 2021 14:47:25 +0800
Message-Id: <20211228064730.2882351-5-guoren@kernel.org>
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

