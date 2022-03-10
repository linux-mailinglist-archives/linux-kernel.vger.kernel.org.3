Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1AA4D5210
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245485AbiCJSfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbiCJSfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:35:53 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7288A19D621;
        Thu, 10 Mar 2022 10:34:51 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id m2so5691241pll.0;
        Thu, 10 Mar 2022 10:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZTabEAQ65sqak7IeRk/QmG52+JEgAGMHd10hUU/HKM=;
        b=gzVNO3biIrix2FoQLOK5xkz0oczUF6xvtNh+4XdiTSSDWoKkuQsV1bJNPyZRc6W24N
         Mi9PuQdiXg5oRw3IAHQY9Zzc5twR4Q630OzwPCn5ALyrPeXEXinkmQqMMbN6cx03/cGY
         feitvHICwO+FnxITf3KSxNRZByyyIWOHVxMCd6KYvzDzJz82270Lla2MpEyxhSWVuror
         cSxs+2WkYe7AwsQGg5aWYBOygC+i5T9HLApC+u+Q3ICFCtzeVNhhI410Jzk/Kw3c5YfO
         5dKmy312HoLu2ffHY0jqIu5KiRdRvv2j9443I4O5GNLS+5qvT76RHe/oyl9ze8l0l3EH
         9N8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZTabEAQ65sqak7IeRk/QmG52+JEgAGMHd10hUU/HKM=;
        b=ZXqpsM/GaSIY7GctWU5vV9w7PR0VUaIYX61kaLjRoab85J07Az9NHXJZQd2Y11wnRk
         Y9lzLeJ3N+NQ9q8OEWhOVbqK+3L/k3tDovMTCEpiwPjRhCvTIxYnENVTYx3sTTjV+2z0
         RehtJuTE6L9DhEV4+LSCA6wLdubYSToX2nH9D2ebnDjQnFeJO4q7we5QoBoZIyYvDfGp
         e+UNgtyiMYT1PbxgvCvQTEgQpkCwloMw1YypQN1gDedz7YbRrbappOI6s2YuPeQdyOTm
         IMPor/W+TnUiihjHcpj2kxxWgCauQ9NWGsbxwx3YMrijDpb9v2w7S84a2vXgmYUq1tKz
         sIpQ==
X-Gm-Message-State: AOAM531IY/V+lLBeGpsATqGT48iQXbwpKuKYBbVpqtjVHBff9VShwMF/
        /NLtfmxYuS0ZTBoOkQvdAZ4=
X-Google-Smtp-Source: ABdhPJxeRwPmh4o/BYU0MiPTeqwVhPQIxIKwxcuBlPTRcRFErAYkviEyFX1vEiiQJRY1f1MAibMxuw==
X-Received: by 2002:a17:902:bc47:b0:151:ac43:eae0 with SMTP id t7-20020a170902bc4700b00151ac43eae0mr6579800plz.117.1646937290952;
        Thu, 10 Mar 2022 10:34:50 -0800 (PST)
Received: from localhost.localdomain ([103.149.162.114])
        by smtp.gmail.com with ESMTPSA id k23-20020aa790d7000000b004f6c8b7c13bsm7255155pfk.132.2022.03.10.10.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 10:34:50 -0800 (PST)
From:   Dongli Si <kvmx86@gmail.com>
X-Google-Original-From: Dongli Si <sidongli1997@gmail.com>
To:     peterz@infradead.org, joerg.roedel@amd.com
Cc:     liam.merwick@oracle.com, kim.phillips@amd.com, mingo@kernel.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf/x86/amd: Don't touch the Host-only bit inside the guest hypervisor
Date:   Fri, 11 Mar 2022 02:34:04 +0800
Message-Id: <20220310183404.1291725-1-sidongli1997@gmail.com>
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

With nested virtualization, when the guest hypervisor runs a nested guest
and if uses "perf record" in an AMD Milan guest hypervisor, the guest
hypervisor dmesg will reports the following warning message:

[] unchecked MSR access error: WRMSR to 0xc0010200 (tried to write 0x0000020000510076)
at rIP: 0xffffffff81003a50 (x86_pmu_enable_all+0x60/0x100)
[] Call Trace:
[]  <IRQ>
[]  ? x86_pmu_enable+0x146/0x300
[]  __perf_install_in_context+0x150/0x170

The AMD64_EVENTSEL_HOSTONLY bit is defined and used on the host, while
the guest hypervisor performance monitor unit should avoid such use.

Fixes: 1018faa6cf23 ("perf/x86/kvm: Fix Host-Only/Guest-Only counting with SVM disabled")
Signed-off-by: Dongli Si <sidongli1997@gmail.com>
---
v2: Add run_as_host function and improve description
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

