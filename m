Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9FD59AEE0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 17:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346179AbiHTPf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 11:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345955AbiHTPfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 11:35:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C58463F2E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 08:35:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33860B8068C
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 15:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73429C433C1;
        Sat, 20 Aug 2022 15:35:18 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] LoongArch: Fix build warnings in VDSO
Date:   Sat, 20 Aug 2022 23:35:06 +0800
Message-Id: <20220820153506.607928-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build warnings in VDSO as below:

arch/loongarch/vdso/vgettimeofday.c:9:5: warning: no previous prototype for '__vdso_clock_gettime' [-Wmissing-prototypes]
    9 | int __vdso_clock_gettime(clockid_t clock,
      |     ^~~~~~~~~~~~~~~~~~~~
arch/loongarch/vdso/vgettimeofday.c:15:5: warning: no previous prototype for '__vdso_gettimeofday' [-Wmissing-prototypes]
   15 | int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
      |     ^~~~~~~~~~~~~~~~~~~
arch/loongarch/vdso/vgettimeofday.c:21:5: warning: no previous prototype for '__vdso_clock_getres' [-Wmissing-prototypes]
   21 | int __vdso_clock_getres(clockid_t clock_id,
      |     ^~~~~~~~~~~~~~~~~~~
arch/loongarch/vdso/vgetcpu.c:27:5: warning: no previous prototype for '__vdso_getcpu' [-Wmissing-prototypes]
   27 | int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused)

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/vdso/vgetcpu.c       |  2 ++
 arch/loongarch/vdso/vgettimeofday.c | 15 +++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/vdso/vgetcpu.c b/arch/loongarch/vdso/vgetcpu.c
index 43a0078e4418..e02e775f5360 100644
--- a/arch/loongarch/vdso/vgetcpu.c
+++ b/arch/loongarch/vdso/vgetcpu.c
@@ -24,6 +24,8 @@ static __always_inline const struct vdso_pcpu_data *get_pcpu_data(void)
 	return (struct vdso_pcpu_data *)(get_vdso_base() - VDSO_DATA_SIZE);
 }
 
+extern
+int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused);
 int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused)
 {
 	int cpu_id;
diff --git a/arch/loongarch/vdso/vgettimeofday.c b/arch/loongarch/vdso/vgettimeofday.c
index b1f4548dae92..8f22863bd7ea 100644
--- a/arch/loongarch/vdso/vgettimeofday.c
+++ b/arch/loongarch/vdso/vgettimeofday.c
@@ -6,20 +6,23 @@
  */
 #include <linux/types.h>
 
-int __vdso_clock_gettime(clockid_t clock,
-			 struct __kernel_timespec *ts)
+extern
+int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
+int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 {
 	return __cvdso_clock_gettime(clock, ts);
 }
 
-int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
-			struct timezone *tz)
+extern
+int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
+int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
 	return __cvdso_gettimeofday(tv, tz);
 }
 
-int __vdso_clock_getres(clockid_t clock_id,
-			struct __kernel_timespec *res)
+extern
+int __vdso_clock_getres(clockid_t clock_id, struct __kernel_timespec *res);
+int __vdso_clock_getres(clockid_t clock_id, struct __kernel_timespec *res)
 {
 	return __cvdso_clock_getres(clock_id, res);
 }
-- 
2.31.1

