Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D181B4EE9D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 10:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244283AbiDAIji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 04:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiDAIjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 04:39:37 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2995324D998;
        Fri,  1 Apr 2022 01:37:49 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso1874666pjh.3;
        Fri, 01 Apr 2022 01:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C2ZIrzrEu1TFpqYxyQ0dZlhf84IbrKS0ewf8L2avMJM=;
        b=owpFPbxS5cv785WPDwMLC8/CIbDqRFmgDc7Nycduk/Hhf+Y6CNlqLQHYjRVL2kj6Ds
         P5Uznb0su5/YA/8EUJ2M3PfA/gVWy5oVJkP2yPLCTPWYD/ekzHVHKAIcLkivK0tbYJcf
         +lRRO8tCj59oIjO0Fh7CTU7BcAv0jf9bBqmuEOyJTkKktUau02pXSwjO1tLyH2vZCxWg
         U2zMkKuWqz0T7L2g+bbbntOCxwZOtNsKz/EQZ22MtftPatXDUIgKNp8GNExBz8Aeo96N
         G2RsvE4N9jaGjcmqEnnrFZ/QbdsrMVBzTCLM15K6kUT94i5ZPfUBgLiaeI8uuZOwuSys
         4ZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C2ZIrzrEu1TFpqYxyQ0dZlhf84IbrKS0ewf8L2avMJM=;
        b=YuaaDK/9LsYf2RdhvgtyJ7rmO1lJnaC8eKhbSVkahovYJ8wS9vtPVm1zF+4KXBBK4a
         NIjh3t6akK3t3+LeqE/t+WbBuyu+FhZ7bqg/FBm+Lqtk4oCOl2J5dYkflC5chSR18X+b
         KT83wX+ue5CS1OYVyFoI7QZwzgXeNOdMrgSfxqb5e1bc//th2UigbyOMjIRDfSzdwJZt
         AUBAdd6A081pOmJZM+5jZwLZOZlZNlfBSvmOP84wXntNeSu0iM1PLgRVzPofc7c7tCV6
         8DsYaPhusTD+RN3GyFNoYhxGVRWmVnOLXGIMiRbynHkv9RY/eRyrtO0xh+xuHVQQxLHo
         Tccw==
X-Gm-Message-State: AOAM532+dsbbxq2GdRI0qV2vdTRTeFxcj66Z6B9w11pE3tzAL9Tuh472
        GEWigOyjOgIU34NCCWhMl4Y=
X-Google-Smtp-Source: ABdhPJyuhFzNZZCSVVgPjdDJbR2FwY3ZfDhx4tSj4Nw2TTWTyLJW/s5Wz4yBBRvvrPthA7l59gJF2w==
X-Received: by 2002:a17:902:6b44:b0:154:4bee:c434 with SMTP id g4-20020a1709026b4400b001544beec434mr9208094plt.43.1648802268572;
        Fri, 01 Apr 2022 01:37:48 -0700 (PDT)
Received: from localhost.localdomain ([103.149.162.115])
        by smtp.gmail.com with ESMTPSA id l13-20020a056a00140d00b004e13da93eaasm2109374pfu.62.2022.04.01.01.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 01:37:48 -0700 (PDT)
From:   Dongli Si <kvmx86@gmail.com>
X-Google-Original-From: Dongli Si <sidongli1997@gmail.com>
To:     peterz@infradead.org, joro@8bytes.org
Cc:     liam.merwick@oracle.com, kim.phillips@amd.com, mingo@kernel.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/amd: Don't touch the Host-Only/Guest-Only bit inside the guest
Date:   Fri,  1 Apr 2022 16:36:59 +0800
Message-Id: <20220401083659.2529658-1-sidongli1997@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongli Si <sidongli1997@gmail.com>

With nested virtualization on AMD Milan:

If "perf record" is run in an L1 hypervisor with an L2 guest,
the following warning is emitted in the L1 guest.

[] unchecked MSR access error: WRMSR to 0xc0010200 (tried to write 0x0000020000510076)
at rIP: 0xffffffff81003a50 (x86_pmu_enable_all+0x60/0x100)
[] Call Trace:
[]  <IRQ>
[]  ? x86_pmu_enable+0x146/0x300
[]  __perf_install_in_context+0x150/0x170

and

If "perf record" is run in an L2 guest,
the following warning is emitted in the L1 guest.

[] unchecked MSR access error: WRMSR to 0xc0010200 (tried to write 0x0000010000510076)
at rIP: 0xffffffff81003a50 (x86_pmu_enable_all+0x60/0x100)
[] Call Trace:
[]  <TASK>
[]  ? x86_pmu_enable+0x146/0x300
[]  __perf_install_in_context+0x150/0x170

The AMD64_EVENTSEL_HOSTONLY/AMD64_EVENTSEL_GUESTONLY bit is defined and
used on the host (L0), while the L1 hypervisor Performance Monitor Unit
should avoid such use.

Fixes: 1018faa6cf23 ("perf/x86/kvm: Fix Host-Only/Guest-Only counting with SVM disabled")
Signed-off-by: Dongli Si <sidongli1997@gmail.com>
---
 arch/x86/events/amd/core.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 9687a8aef01c..79bd60d6b0fd 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -8,6 +8,7 @@
 #include <linux/jiffies.h>
 #include <asm/apicdef.h>
 #include <asm/nmi.h>
+#include <asm/hypervisor.h>
 
 #include "../perf_event.h"
 
@@ -533,7 +534,15 @@ static void amd_pmu_cpu_starting(int cpu)
 	struct amd_nb *nb;
 	int i, nb_id;
 
-	cpuc->perf_ctr_virt_mask = AMD64_EVENTSEL_HOSTONLY;
+	/*
+	 * The Host-Only/Guest-Only bit can only be set on the host.
+	 * When SVM is disabled, set the Host-Only bit will cause the
+	 * performance counter to not work.
+	 */
+	if (hypervisor_is_type(X86_HYPER_NATIVE))
+		cpuc->perf_ctr_virt_mask = AMD64_EVENTSEL_HOSTONLY;
+	else
+		cpuc->perf_ctr_virt_mask = AMD64_EVENTSEL_GUESTONLY | AMD64_EVENTSEL_HOSTONLY;
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
@@ -1023,10 +1032,16 @@ __init int amd_pmu_init(void)
 	return 0;
 }
 
+/*
+ * Unmask the Host-only bit when virtualization is enabled on the Host Hypervisor
+ */
 void amd_pmu_enable_virt(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
+	if (!hypervisor_is_type(X86_HYPER_NATIVE))
+		return;
+
 	cpuc->perf_ctr_virt_mask = 0;
 
 	/* Reload all events */
@@ -1035,10 +1050,16 @@ void amd_pmu_enable_virt(void)
 }
 EXPORT_SYMBOL_GPL(amd_pmu_enable_virt);
 
+/*
+ * Mask the Host-only bit when virtualization is disabled on the Host Hypervisor
+ */
 void amd_pmu_disable_virt(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
+	if (!hypervisor_is_type(X86_HYPER_NATIVE))
+		return;
+
 	/*
 	 * We only mask out the Host-only bit so that host-only counting works
 	 * when SVM is disabled. If someone sets up a guest-only counter when
-- 
2.32.0

