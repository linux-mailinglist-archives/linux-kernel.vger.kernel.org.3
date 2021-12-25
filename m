Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FF347F1F3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 05:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhLYEzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 23:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhLYEzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 23:55:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088ECC061757;
        Fri, 24 Dec 2021 20:55:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C29C2B80939;
        Sat, 25 Dec 2021 04:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530E6C36AE5;
        Sat, 25 Dec 2021 04:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640408129;
        bh=w04+g7RvLMoxdOro5NWVNK03xjcmOlA8n0cnB++OVgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eCTqFf8wEuhKfl21rpwpQBj1OGBxWCcduW0UCq8AuFCWh6YKZEYyaumEk2oPBg1Nr
         +b+zZxfPoJ3FQCA+hOw+Dyq+etKS9P0I8GgXRJ67CoYacaJAYaUdNe9uo1GxKs9Zeb
         e7Z5rB3yAayaAqZQUVl8Uf+0CZkrtkYcIBmGt4Oxl0tRuSny5Nw4Xf/sc80GSbWWYB
         yJwEIm4ExI7dPLbBD7XWlQ8ta56gLEsInjVFihTzwwoHIvJB2QMShRxHwQ+0EhVR+w
         xU29LRpOI2qzHno8Xssll8YCIU+XJUk8Rgcu46UvpsQfNVvEf49cUEqbdq/itMNGjx
         Oq3EWlpNtKNjQ==
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
Subject: [PATCH V2 8/8] sched: mips: Remove unused TASK_SIZE_OF
Date:   Sat, 25 Dec 2021 12:54:30 +0800
Message-Id: <20211225045430.2868608-9-guoren@kernel.org>
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

