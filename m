Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F854D79DF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 05:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiCNE0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 00:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiCNE0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 00:26:11 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189DB10FF5;
        Sun, 13 Mar 2022 21:25:02 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 9so12488633pll.6;
        Sun, 13 Mar 2022 21:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UiAHqGBIM+cfNI9owbzK7nwjbmtEignfka2Wp98X+Xg=;
        b=oYtNS7cStt5ZqNlKnrdVy722BZ89Cq1DiKKeqQ/6yN7Ev+itix+lGnW3vtC0fLa9ie
         +6s2b3xrOV2jtlzUfxDLoNxa2fBgrA+uhmnAwsVL0K0KUfu7mw5BMqIrwZwnV9sJGkyD
         gyJjCDeKPfVUS26nr0gM++pVjG3/0VWJ36mNkhtKsJyho+TUFD7GPJs9iG8m0G/T5Tqo
         UfRnh6IA4PdQD8cnEYbADr1BWF8T88EQu96dZTsI08L2wEgrFJ3HfeUpMaj/Aw8zzz1C
         EjENioe6aPFQyShvAjOGlWkrLCL+o9fVLsryvsZywB32aLcEGeLJ0YwbtzCYoCZHvP5b
         Idfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UiAHqGBIM+cfNI9owbzK7nwjbmtEignfka2Wp98X+Xg=;
        b=XytiN4Dj4Zv1ssOfpqT0S0qQsjnrY0r1CC5BULIa9qZQ42zI8JF69NPqGnJqliZRuO
         TlCbKgFCebILQ+Mcg9NBSM3ql5eZ7s9hMpYiskpFl4x8Bkop8/10xfsfnGPHFZ2mZD+M
         iJW+4a3Nv9hQPMrHYkjpDZeYpQg9oI60sNlGPT7BRsQ+aoTxX0slDG9+h24ui6WZze2c
         VxI0JYItySH2XkSZGwxcv/41CkqYk+/1wYUGRCT25Vvl16f943kGRIXxKc0YVQmFs8Mx
         F6PK5m9H97VdlY3/H1u5hH3YxlVK0LacnEWVJsOPcYyrH4dLpBxxzzvWqdpdueoDmJxu
         ahUg==
X-Gm-Message-State: AOAM533CQAtZoh1vFf3HR84UU4kRPr7u/rdbW+uXtU0pZmttvNoKUy7k
        ys3WFR8jnPRBvGhhhiRESYE=
X-Google-Smtp-Source: ABdhPJyds6/EOWgn1LIFNhg0V3YMbw3B4QAYJTONCWSSQQGtyTU712OQqp5ozQJlDcqZV/ci1TNS2Q==
X-Received: by 2002:a17:902:e943:b0:153:f9b:99c9 with SMTP id b3-20020a170902e94300b001530f9b99c9mr21485762pll.170.1647231901533;
        Sun, 13 Mar 2022 21:25:01 -0700 (PDT)
Received: from localhost.localdomain ([103.149.162.115])
        by smtp.gmail.com with ESMTPSA id w8-20020a63a748000000b0038117e18f02sm7500309pgo.29.2022.03.13.21.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 21:25:01 -0700 (PDT)
From:   Dongli Si <kvmx86@gmail.com>
X-Google-Original-From: Dongli Si <sidongli1997@gmail.com>
To:     peterz@infradead.org, joerg.roedel@amd.com
Cc:     liam.merwick@oracle.com, kim.phillips@amd.com, mingo@kernel.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] perf/x86/amd: Don't touch the Host-only bit inside the guest hypervisor
Date:   Mon, 14 Mar 2022 12:22:54 +0800
Message-Id: <20220314042254.1487836-1-sidongli1997@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongli Si <sidongli1997@gmail.com>

With nested virtualization on AMD Milan, if "perf record" is run in an
L1 hypervisor with an L2 guest, the following warning is emitted in
the L1 guest.

[] unchecked MSR access error: WRMSR to 0xc0010200 (tried to write 0x0000020000510076)
at rIP: 0xffffffff81003a50 (x86_pmu_enable_all+0x60/0x100)
[] Call Trace:
[]  <IRQ>
[]  ? x86_pmu_enable+0x146/0x300
[]  __perf_install_in_context+0x150/0x170

The AMD64_EVENTSEL_HOSTONLY bit is defined and used on the host (L0),
while the L1 hypervisor Performance Monitor Unit should avoid such use.

Fixes: 1018faa6cf23 ("perf/x86/kvm: Fix Host-Only/Guest-Only counting with SVM disabled")
Signed-off-by: Dongli Si <sidongli1997@gmail.com>
Tested-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
---
v3: Add Tested-by, Reviewed-by from Liam and improve description.
v2: https://lore.kernel.org/all/20220310183404.1291725-1-sidongli1997@gmail.com/
v1: https://lore.kernel.org/all/20220227132640.3-1-sidongli1997@gmail.com/

 arch/x86/events/amd/core.c        |  4 +++-
 arch/x86/include/asm/hypervisor.h | 10 ++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 9687a8aef01c..14cd079243a4 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -8,6 +8,7 @@
 #include <linux/jiffies.h>
 #include <asm/apicdef.h>
 #include <asm/nmi.h>
+#include <asm/hypervisor.h>
 
 #include "../perf_event.h"
 
@@ -1027,7 +1028,8 @@ void amd_pmu_enable_virt(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	cpuc->perf_ctr_virt_mask = 0;
+	if (run_as_host())
+		cpuc->perf_ctr_virt_mask = 0;
 
 	/* Reload all events */
 	amd_pmu_disable_all();
diff --git a/arch/x86/include/asm/hypervisor.h b/arch/x86/include/asm/hypervisor.h
index e41cbf2ec41d..fcc66c23cc72 100644
--- a/arch/x86/include/asm/hypervisor.h
+++ b/arch/x86/include/asm/hypervisor.h
@@ -73,11 +73,21 @@ static inline bool hypervisor_is_type(enum x86_hypervisor_type type)
 {
 	return x86_hyper_type == type;
 }
+
+static inline bool run_as_host(void)
+{
+	return hypervisor_is_type(X86_HYPER_NATIVE);
+}
 #else
 static inline void init_hypervisor_platform(void) { }
 static inline bool hypervisor_is_type(enum x86_hypervisor_type type)
 {
 	return type == X86_HYPER_NATIVE;
 }
+
+static inline bool run_as_host(void)
+{
+	return true;
+}
 #endif /* CONFIG_HYPERVISOR_GUEST */
 #endif /* _ASM_X86_HYPERVISOR_H */
-- 
2.32.0

