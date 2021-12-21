Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C197147C48B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239937AbhLURBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240227AbhLURBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:01:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B88C061574;
        Tue, 21 Dec 2021 09:01:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08554B817C5;
        Tue, 21 Dec 2021 17:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81050C36AEC;
        Tue, 21 Dec 2021 17:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640106104;
        bh=5T//5GQugAmz1CEViBCCmsXDs4J5BoJEcY/PJqyOdEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ya5sC66uzXxa7udtqo/unVjSwoVcTSBjptfJw0RYyTUVDE5oX9+M504c435ZgQyBK
         CaWRH0BVMHqbBzk3gvaE3HqqMpgsEQb/drJi0wMSuBfKzLL0S81UhispyKobCvYqbw
         g8RpTdht/DMzv4i7nYcl3kmmkyePlFagSwR09dIq7rv+PC+fzcrHmJwor4Nx+dGHxU
         nFSO7Nh/8NBsBUlCA/lWWFDUJxdGavC9OUFEXCEJeexB+o7Vib9O+36R5+GWXgfqrh
         Vk5CLMreK1SrxVUkKqA0NnZPFt2df8Ir0fs7VD/AnJ+po7zceJU21PauXCitI0BsEF
         r6+BrSBpUMEgg==
From:   guoren@kernel.org
To:     guoren@kernel.org, will@kernel.org, tglx@linutronix.de,
        benh@kernel.crashing.org, arnd@arndb.de, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.or,
        linuxppc-dev@lists.ozlabs.org, inux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 8/8] sched: mips: Remove unused TASK_SIZE_OF
Date:   Wed, 22 Dec 2021 01:00:57 +0800
Message-Id: <20211221170057.2637763-9-guoren@kernel.org>
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
 arch/mips/include/asm/processor.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 4bb24579d12e..8871fc5b0baa 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -61,9 +61,6 @@ extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src
 #define TASK_SIZE (test_thread_flag(TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE64)
 #define STACK_TOP_MAX	TASK_SIZE64
 
-#define TASK_SIZE_OF(tsk)						\
-	(test_tsk_thread_flag(tsk, TIF_32BIT_ADDR) ? TASK_SIZE32 : TASK_SIZE64)
-
 #define TASK_IS_32BIT_ADDR test_thread_flag(TIF_32BIT_ADDR)
 
 #endif
-- 
2.25.1

