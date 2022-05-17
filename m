Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909D052ADE2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiEQWOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiEQWOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:14:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3D14A3EB;
        Tue, 17 May 2022 15:14:36 -0700 (PDT)
Date:   Tue, 17 May 2022 22:14:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652825675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NvSyRGfLgzvvEMxHc9NtKvK2OOjl8fGFwwMnKjFNqmU=;
        b=TtsGX6O/DA8MMBs4GOKlIo0yV9oOLFw1+qDj4wk20imp3Qdl3CTVk1xSkamCDmZzEwtbD1
        Q9wxTe8vMoiCplHnlj/AwpJTP9+H9BdAicpaBgJxrjNmSTsPpadw6vkRvCYk84Ott7vWZp
        1eDzEmTNQWM7lOXWyWYD3r2KivwQ9n8Rb19N3ww9G5F+K2t23i28/u4PBfuWz4p3Wlrv/6
        n50sHSW1gYOzvUAqtZUvV9OrJdrLVJWEVT4q5OTEnbZWStSlWMtDkIUo7GrTp9aeyEBckU
        hDdEAM7d5yQciqPu38yjqJ7ryxd7ZJemWKG6DdePJSaQCJWyBK0WuBXncnzlmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652825675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NvSyRGfLgzvvEMxHc9NtKvK2OOjl8fGFwwMnKjFNqmU=;
        b=4p9GY1q5F0VtLb9GFgFMH3VdsZKdioIciXILgsrYoFk8fvdhc5rZTPrr0E9oKI0Mwl6MJP
        00vIdSLFNNtCOsAw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Run AMD BRS code only on supported hw
Cc:     Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220516154838.7044-1-bp@alien8.de>
References: <20220516154838.7044-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <165282567343.4207.14036565580250908800.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     841b51e4a3590866d17fa2663c64688c25b891b1
Gitweb:        https://git.kernel.org/tip/841b51e4a3590866d17fa2663c64688c25b891b1
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 16 May 2022 17:48:38 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 18 May 2022 00:08:26 +02:00

perf/x86/amd: Run AMD BRS code only on supported hw

This fires on a Fam16h machine here:

 unchecked MSR access error: WRMSR to 0xc000010f (tried to write 0x0000000000000018) \
    at rIP: 0xffffffff81007db1 (amd_brs_reset+0x11/0x50)
 Call Trace:
  <TASK>
  amd_pmu_cpu_starting
  ? x86_pmu_dead_cpu
  x86_pmu_starting_cpu
  cpuhp_invoke_callback
  ? x86_pmu_starting_cpu
  ? x86_pmu_dead_cpu
  cpuhp_issue_call
  ? x86_pmu_starting_cpu
  __cpuhp_setup_state_cpuslocked
  ? x86_pmu_dead_cpu
  ? x86_pmu_starting_cpu
  __cpuhp_setup_state
  ? map_vsyscall
  init_hw_perf_events
  ? map_vsyscall
  do_one_initcall
  ? _raw_spin_unlock_irqrestore
  ? try_to_wake_up
  kernel_init_freeable
  ? rest_init
  kernel_init
  ret_from_fork

because that CPU hotplug callback gets executed on any AMD CPU - not
only on the BRS-enabled ones. Check the BRS feature bit properly.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-By: Stephane Eranian <eranian@google.com>
Link: https://lkml.kernel.org/r/20220516154838.7044-1-bp@alien8.de
---
 arch/x86/events/amd/brs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 895c821..bee8765 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -57,7 +57,7 @@ static inline u64 get_debug_extn_cfg(void)
 
 static bool __init amd_brs_detect(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_BRS))
+	if (!cpu_feature_enabled(X86_FEATURE_BRS))
 		return false;
 
 	switch (boot_cpu_data.x86) {
@@ -112,6 +112,9 @@ static inline int amd_brs_get_tos(union amd_debug_extn_cfg *cfg)
  */
 void amd_brs_reset(void)
 {
+	if (!cpu_feature_enabled(X86_FEATURE_BRS))
+		return;
+
 	/*
 	 * Reset config
 	 */
