Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F274D7218
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 02:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiCMBXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 20:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbiCMBXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 20:23:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DFA24081;
        Sat, 12 Mar 2022 17:22:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2C27B80123;
        Sun, 13 Mar 2022 01:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CFDC340EC;
        Sun, 13 Mar 2022 01:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647134556;
        bh=2YQxyoOOki3WVR0j2UQxO+ys6flh/Qon049D3a/0iu4=;
        h=From:To:Cc:Subject:Date:From;
        b=X8p7gwzI+mEmzlREpKziVcY64DsccPFAFM4hgwI1QNXHep1omrAqPvLt0uDzeEV2k
         que4wgyhPK2NY4Dj+CM3UDAZDPLA5n+H/349nJobRRVQhjbBzUoLcILzj977Dq2ljV
         v28IIMz2kFn4vbwfzfpb0bh3Ytmp4FjOwgs3oJmyGAd8YBNB/xMuitxgmNkaBHog7c
         f8ySilpnVPW1S97/HZORNWobKILN3ZuSn+iE2avxdH9g70BsSF15kvXeWiEHb9GR88
         XCuUluRfu+4bJ7EG2jMlJJVAF5kbYIOykB+MES5V145Mnvpp4+OrrYagW+hwZsVKNE
         pnCWpXW9Ja8dg==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, Guo Ren <guoren@linux.alibaba.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH V2] arch: patch_text: Fixup last cpu should be master
Date:   Sun, 13 Mar 2022 09:22:21 +0800
Message-Id: <20220313012221.1755483-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

These patch_text implementations are using stop_machine_cpuslocked
infrastructure with atomic cpu_count. The original idea: When the
master CPU patch_text, the others should wait for it. But current
implementation is using the first CPU as master, which couldn't
guarantee the remaining CPUs are waiting. This patch changes the
last CPU as the master to solve the potential risk.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Peter Zijlstra <peterz@infradead.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Arnd Bergmann <arnd@arndb.de>

---
Changes in V2:
 - Fixup last cpu should be num_online_cpus() by Max Filippov
 - Fixup typos found by Max Filippov
---
 arch/arm64/kernel/patching.c      | 4 ++--
 arch/csky/kernel/probes/kprobes.c | 2 +-
 arch/riscv/kernel/patch.c         | 2 +-
 arch/xtensa/kernel/jump_label.c   | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
index 771f543464e0..33e0fabc0b79 100644
--- a/arch/arm64/kernel/patching.c
+++ b/arch/arm64/kernel/patching.c
@@ -117,8 +117,8 @@ static int __kprobes aarch64_insn_patch_text_cb(void *arg)
 	int i, ret = 0;
 	struct aarch64_insn_patch *pp = arg;
 
-	/* The first CPU becomes master */
-	if (atomic_inc_return(&pp->cpu_count) == 1) {
+	/* The last CPU becomes master */
+	if (atomic_inc_return(&pp->cpu_count) == num_online_cpus()) {
 		for (i = 0; ret == 0 && i < pp->insn_cnt; i++)
 			ret = aarch64_insn_patch_text_nosync(pp->text_addrs[i],
 							     pp->new_insns[i]);
diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
index 42920f25e73c..34ba684d5962 100644
--- a/arch/csky/kernel/probes/kprobes.c
+++ b/arch/csky/kernel/probes/kprobes.c
@@ -30,7 +30,7 @@ static int __kprobes patch_text_cb(void *priv)
 	struct csky_insn_patch *param = priv;
 	unsigned int addr = (unsigned int)param->addr;
 
-	if (atomic_inc_return(&param->cpu_count) == 1) {
+	if (atomic_inc_return(&param->cpu_count) == num_online_cpus()) {
 		*(u16 *) addr = cpu_to_le16(param->opcode);
 		dcache_wb_range(addr, addr + 2);
 		atomic_inc(&param->cpu_count);
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 0b552873a577..765004b60513 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -104,7 +104,7 @@ static int patch_text_cb(void *data)
 	struct patch_insn *patch = data;
 	int ret = 0;
 
-	if (atomic_inc_return(&patch->cpu_count) == 1) {
+	if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
 		ret =
 		    patch_text_nosync(patch->addr, &patch->insn,
 					    GET_INSN_LENGTH(patch->insn));
diff --git a/arch/xtensa/kernel/jump_label.c b/arch/xtensa/kernel/jump_label.c
index 61cf6497a646..b67efcd7e32c 100644
--- a/arch/xtensa/kernel/jump_label.c
+++ b/arch/xtensa/kernel/jump_label.c
@@ -40,7 +40,7 @@ static int patch_text_stop_machine(void *data)
 {
 	struct patch *patch = data;
 
-	if (atomic_inc_return(&patch->cpu_count) == 1) {
+	if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
 		local_patch_text(patch->addr, patch->data, patch->sz);
 		atomic_inc(&patch->cpu_count);
 	} else {
-- 
2.25.1

