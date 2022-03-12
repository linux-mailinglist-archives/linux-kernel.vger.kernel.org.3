Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6DB4D6FE8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 16:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiCLP5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 10:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiCLP5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:57:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C66D4C7B5;
        Sat, 12 Mar 2022 07:56:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E706D60F90;
        Sat, 12 Mar 2022 15:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6AFC340EB;
        Sat, 12 Mar 2022 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647100588;
        bh=od4DZd0RLS1dMTaaAwprQNSP717OVfCCfXQ6agXS2qg=;
        h=From:To:Cc:Subject:Date:From;
        b=eH3BKmP1eY5WFgQDG8ivgfDeSu1O9Vq0VPXhyq9HqC9ovmTrvBIqL2dyRiJdecW7n
         blM7cR91Fff/k93Id3Nf17e9SSxYErKv8TnOxLwl/86d6SOLy3KFZzzEnwj3tsyPwg
         VeHjgsOQBqjMVnMwBo8SKlPtce90RPUU1IsALnIkjkOhB/vNZ2n9oNigYybOPRG1Sc
         2CTl/S9hdWO3UEr4z/xNz6nP6ppzSHY/31HFNcM6cgLZLfILxwpRAQSAcToSsSiPbz
         tQG8FC7pKaX/2m4eX5vmXZDLkKAyQ3yTMHWxp2A1AOI7og63hBK4TnZs9TfQeZUI22
         1OdZ9CRzsOwxA==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [RFC PATCH] arch: patch_text: Fixup last cpu should be master
Date:   Sat, 12 Mar 2022 23:56:03 +0800
Message-Id: <20220312155603.1752193-1-guoren@kernel.org>
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
infrastructure with atomic cpu_count. The origin idea is that when
the master CPU patch_text, others should wait for it. But current
implementation is using the first CPU as master, which couldn't
guarantee continue CPUs are waiting. This patch changes the last
CPU as the master to solve the potaintial risk.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Peter Zijlstra <peterz@infradead.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/patching.c      | 4 ++--
 arch/csky/kernel/probes/kprobes.c | 2 +-
 arch/riscv/kernel/patch.c         | 2 +-
 arch/xtensa/kernel/jump_label.c   | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
index 771f543464e0..6cfea9650e65 100644
--- a/arch/arm64/kernel/patching.c
+++ b/arch/arm64/kernel/patching.c
@@ -117,8 +117,8 @@ static int __kprobes aarch64_insn_patch_text_cb(void *arg)
 	int i, ret = 0;
 	struct aarch64_insn_patch *pp = arg;
 
-	/* The first CPU becomes master */
-	if (atomic_inc_return(&pp->cpu_count) == 1) {
+	/* The last CPU becomes master */
+	if (atomic_inc_return(&pp->cpu_count) == (num_online_cpus() - 1)) {
 		for (i = 0; ret == 0 && i < pp->insn_cnt; i++)
 			ret = aarch64_insn_patch_text_nosync(pp->text_addrs[i],
 							     pp->new_insns[i]);
diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
index 42920f25e73c..19821a06a991 100644
--- a/arch/csky/kernel/probes/kprobes.c
+++ b/arch/csky/kernel/probes/kprobes.c
@@ -30,7 +30,7 @@ static int __kprobes patch_text_cb(void *priv)
 	struct csky_insn_patch *param = priv;
 	unsigned int addr = (unsigned int)param->addr;
 
-	if (atomic_inc_return(&param->cpu_count) == 1) {
+	if (atomic_inc_return(&param->cpu_count) == (num_online_cpus() - 1)) {
 		*(u16 *) addr = cpu_to_le16(param->opcode);
 		dcache_wb_range(addr, addr + 2);
 		atomic_inc(&param->cpu_count);
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 0b552873a577..cca72a9388e3 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -104,7 +104,7 @@ static int patch_text_cb(void *data)
 	struct patch_insn *patch = data;
 	int ret = 0;
 
-	if (atomic_inc_return(&patch->cpu_count) == 1) {
+	if (atomic_inc_return(&patch->cpu_count) == (num_online_cpus() - 1)) {
 		ret =
 		    patch_text_nosync(patch->addr, &patch->insn,
 					    GET_INSN_LENGTH(patch->insn));
diff --git a/arch/xtensa/kernel/jump_label.c b/arch/xtensa/kernel/jump_label.c
index 61cf6497a646..7e1d3f952eb3 100644
--- a/arch/xtensa/kernel/jump_label.c
+++ b/arch/xtensa/kernel/jump_label.c
@@ -40,7 +40,7 @@ static int patch_text_stop_machine(void *data)
 {
 	struct patch *patch = data;
 
-	if (atomic_inc_return(&patch->cpu_count) == 1) {
+	if (atomic_inc_return(&patch->cpu_count) == (num_online_cpus() - 1)) {
 		local_patch_text(patch->addr, patch->data, patch->sz);
 		atomic_inc(&patch->cpu_count);
 	} else {
-- 
2.25.1

