Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC17452892A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245449AbiEPPsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiEPPsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:48:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373992B1B8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:48:37 -0700 (PDT)
Received: from zn.tnic (p2e55dbad.dip0.t-ipconnect.de [46.85.219.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B87F21EC0657;
        Mon, 16 May 2022 17:48:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652716115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=Vw0/+5TWAFxZKiQF4TjtWHuWtyWwh13+PZYNjCwWyyI=;
        b=NToEONIg+JaQqV+ORV9xAqfw5aIvekjrl5RHGYv1KExuDtAdfzyJ1wQzjwItmFsa+3SshQ
        HZVy/euq0TYej/JPDPLIf68SooZQYHJU1QqTqHiWFsusQPR9eXLGRbU5uOeT9HlxkX6usa
        f9eYkI5OJzEocPC85v0oIVUaCsn6y54=
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephane Eranian <eranian@google.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf/x86/amd: Run AMD BRS code only on supported hw
Date:   Mon, 16 May 2022 17:48:38 +0200
Message-Id: <20220516154838.7044-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

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
---
 arch/x86/events/amd/brs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 895c82165d85..bee8765a1e9b 100644
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
-- 
2.35.1

