Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B474901E7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiAQGXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:23:49 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:47771 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234620AbiAQGXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:23:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V2-m4ej_1642400624;
Received: from localhost.localdomain(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0V2-m4ej_1642400624)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Jan 2022 14:23:46 +0800
From:   Yinan Liu <yinan@linux.alibaba.com>
To:     rostedt@goodmis.org, nathan@kernel.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] script/sorttable: fix some initialization problems
Date:   Mon, 17 Jan 2022 14:23:44 +0800
Message-Id: <20220117062344.15633-2-yinan@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220117062344.15633-1-yinan@linux.alibaba.com>
References: <20220115225920.0e5939aa@gandalf.local.home>
 <20220117062344.15633-1-yinan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

elf_mcount_loc and mcount_sort_thread definitions are not
initialized immediately within the function, which can cause
the judgment logic to use uninitialized values when the
initialization logic of subsequent code fails.

Link: https://lkml.kernel.org/r/20211212113358.34208-2-yinan@linux.alibaba.com

Fixes:72b3942a173c (scripts: ftrace - move the sort-processing in ftrace_init)
Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
---
 scripts/sorttable.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index 1e8b77928fa4..13ae3262ec96 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -199,6 +199,8 @@ static int compare_extable(const void *a, const void *b)
 	return 0;
 }
 #ifdef MCOUNT_SORT_ENABLED
+pthread_t mcount_sort_thread;
+
 struct elf_mcount_loc {
 	Elf_Ehdr *ehdr;
 	Elf_Shdr *init_data_sec;
@@ -282,10 +284,9 @@ static int do_sort(Elf_Ehdr *ehdr,
 	unsigned int shnum;
 	unsigned int shstrndx;
 #ifdef MCOUNT_SORT_ENABLED
-	struct elf_mcount_loc mstruct;
+	struct elf_mcount_loc mstruct = {NULL, NULL, 0, 0};
 	uint_t _start_mcount_loc = 0;
 	uint_t _stop_mcount_loc = 0;
-	pthread_t mcount_sort_thread;
 #endif
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
 	unsigned int orc_ip_size = 0;
-- 
2.19.1.6.gb485710b

