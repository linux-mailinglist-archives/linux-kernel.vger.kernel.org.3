Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD8347F1E0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 05:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhLYEzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 23:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhLYEzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 23:55:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CABC061401;
        Fri, 24 Dec 2021 20:55:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61319B80947;
        Sat, 25 Dec 2021 04:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F74C36AED;
        Sat, 25 Dec 2021 04:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640408101;
        bh=D7/U3HVHnvdLiesri1jE7OLilV2Wekoh0yj4lEBJWbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=byrTRC+8fxp8jHbj0YHIBTJx13ra9eI4+1+wqqb2XatoanHFeEnUAB5CPEexvwuwC
         RTxw6e8ibZfN8wvqdtxRQUqStPIviNR1tukjX6HSyvfiLGP/AcWEmF9o6gQ1cNUlMO
         MhUE6Ti6oGVKLse3OXbpvmnFWsABcjQVMue3COD79wkSU2vX77zDHRWbFBdiRLROu+
         JsbXlEXlUZPg82q/iMvMoN5Nw8lOaL5zFXNm4TEUS8KE+OSgZJX3403HFGX5C/d7WF
         BuopzUBs5cGJgVtZ8znSl2oVIZUcEZoIbWAwL6YU0MYms5CYlqeSGDbERbvQhYUEDP
         bln0VWBZohRhA==
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
Subject: [PATCH V2 2/8] sched: x86: Remove unused TASK_SIZE_OF
Date:   Sat, 25 Dec 2021 12:54:24 +0800
Message-Id: <20211225045430.2868608-3-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211225045430.2868608-1-guoren@kernel.org>
References: <20211225045430.2868608-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This macro isn't used in Linux, now. Delete in
include/linux/sched.h and arch's include/asm.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/page_64_types.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index e9e2c3ba5923..6191cf417c31 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -74,8 +74,6 @@
 					IA32_PAGE_OFFSET : DEFAULT_MAP_WINDOW)
 #define TASK_SIZE		(test_thread_flag(TIF_ADDR32) ? \
 					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
-#define TASK_SIZE_OF(child)	((test_tsk_thread_flag(child, TIF_ADDR32)) ? \
-					IA32_PAGE_OFFSET : TASK_SIZE_MAX)
 
 #define STACK_TOP		TASK_SIZE_LOW
 #define STACK_TOP_MAX		TASK_SIZE_MAX
-- 
2.25.1

