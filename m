Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7674FBDBC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346632AbiDKNuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbiDKNup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:50:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43768237E4;
        Mon, 11 Apr 2022 06:48:31 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id s8so14607511pfk.12;
        Mon, 11 Apr 2022 06:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LLXZyvUQVDwQmlTRZYr8MZcRMt1y/BLKpRQAolu/Ffc=;
        b=GFVc/seHJMlYRvfRtum43NA3xEtED7d6iAtbmPM31TpzWUfzIew0ASdlttqW7GMKfj
         JxWHu59RLwzno9JG0EUDwiXmwtV/ZztR0dViQqwh1fOCgJ4LOxzQoAkxum1ypEhRnEkF
         m+iFwRUIJRIIlEGbwaqEEINLlQlgdtInbjO1sM3Jf0oRVoppN9yb1oxm/uFPzkQDhGAx
         LuB1hLpvYkQt4saPxjYULzekbSvXf5DOQBECMDOR/2KxaWydwD7RbN3xgSgDGyF6P+gk
         LdePHXuMQpOLKeGDA2M8kv207UH/b2hRxFoPEo06Wu9lmfEDd1SwUnybolDIjWlKwyyY
         SJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LLXZyvUQVDwQmlTRZYr8MZcRMt1y/BLKpRQAolu/Ffc=;
        b=e2Bon6sy8F9y+F/0YqgdTaDjxzaEppd0/6Y8POV8MQK/AxaMPzV0+7fvCqR4y13DLp
         rBKYXcFPAzl5gNaNxSB5P7apscIb3VWR6nTiC9JnirsAsZfM/VRTYJPlw523CBQIxJzN
         zC4yRrOqV8qBvQlqVrPY1rZs7Wh3dF55BbLx+lKuxoZyrZyoT0ZbL9cEBcwnmrI19mOk
         Mz1HupRJRt+FPa7VabIjQqhWRjUpp2e4qDl5/DvNfKRADACLjVXQlCJnzVJXHDKxIPRE
         K2q7eOsoA/cGbG1ZbtSa1XRkbuR0RK4/Xd96yw6jf8WYw3yAQJkQBKsmTkQSo9nn1a97
         YO0g==
X-Gm-Message-State: AOAM5325HRuDVddaDJfb78yhnUfSgG9ma/ioyBRNFno071xmdpivPMJ2
        lM23DNP9Ssv/7+uatgUV/Co=
X-Google-Smtp-Source: ABdhPJxQSywZezCyY3d8fX/H7SUBd9y2VY3EdITrK6hnk+ltd7Eo2Vis/1zCDmzPUsIg0pUGDnT2wg==
X-Received: by 2002:a65:418b:0:b0:382:250b:4dda with SMTP id a11-20020a65418b000000b00382250b4ddamr27265124pgq.428.1649684910717;
        Mon, 11 Apr 2022 06:48:30 -0700 (PDT)
Received: from localhost.localdomain ([103.149.162.115])
        by smtp.gmail.com with ESMTPSA id e6-20020a63aa06000000b00380c8bed5a6sm29420805pgf.46.2022.04.11.06.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 06:48:30 -0700 (PDT)
From:   Dongli Si <kvmx86@gmail.com>
X-Google-Original-From: Dongli Si <sidongli1997@gmail.com>
To:     peterz@infradead.org, joro@8bytes.org, likexu@tencent.com
Cc:     liam.merwick@oracle.com, kim.phillips@amd.com, mingo@kernel.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jmattson@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/amd: cpu_hw_events::perf_ctr_virt_mask should only be used on host
Date:   Mon, 11 Apr 2022 21:46:51 +0800
Message-Id: <20220411134651.740234-1-sidongli1997@gmail.com>
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

perf_ctr_virt_mask is used to mask Host-Only bit when SVM is disabled,
Using it on a guest doesn't make sense and make things obscure.

Revert commit df51fe7ea1c1c
("perf/x86/amd: Don't touch the AMD64_EVENTSEL_HOSTONLY bit inside the guest"),
Because it make things a little obscure and this #GP has been fixed in KVM.

Fixes: 1018faa6cf23 ("perf/x86/kvm: Fix Host-Only/Guest-Only counting with SVM disabled")
Signed-off-by: Dongli Si <sidongli1997@gmail.com>
---
 arch/x86/events/amd/core.c   | 19 ++++++++++++++++++-
 arch/x86/events/perf_event.h |  3 +--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 9687a8aef01c..5ac7d9410d36 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -533,7 +533,12 @@ static void amd_pmu_cpu_starting(int cpu)
 	struct amd_nb *nb;
 	int i, nb_id;
 
-	cpuc->perf_ctr_virt_mask = AMD64_EVENTSEL_HOSTONLY;
+	/*
+	 * When SVM is disabled, set the Host-Only bit will cause the
+	 * performance counter to not work.
+	 */
+	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		cpuc->perf_ctr_virt_mask = AMD64_EVENTSEL_HOSTONLY;
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
@@ -1023,10 +1028,16 @@ __init int amd_pmu_init(void)
 	return 0;
 }
 
+/*
+ * Unmask the Host-only bit when SVM is enabled on the Host Hypervisor
+ */
 void amd_pmu_enable_virt(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return;
+
 	cpuc->perf_ctr_virt_mask = 0;
 
 	/* Reload all events */
@@ -1035,10 +1046,16 @@ void amd_pmu_enable_virt(void)
 }
 EXPORT_SYMBOL_GPL(amd_pmu_enable_virt);
 
+/*
+ * Mask the Host-only bit when SVM is disabled on the Host Hypervisor
+ */
 void amd_pmu_disable_virt(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return;
+
 	/*
 	 * We only mask out the Host-only bit so that host-only counting works
 	 * when SVM is disabled. If someone sets up a guest-only counter when
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 150261d929b9..fa1428ca60b6 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1138,10 +1138,9 @@ void x86_pmu_stop(struct perf_event *event, int flags);
 
 static inline void x86_pmu_disable_event(struct perf_event *event)
 {
-	u64 disable_mask = __this_cpu_read(cpu_hw_events.perf_ctr_virt_mask);
 	struct hw_perf_event *hwc = &event->hw;
 
-	wrmsrl(hwc->config_base, hwc->config & ~disable_mask);
+	wrmsrl(hwc->config_base, hwc->config);
 
 	if (is_counter_pair(hwc))
 		wrmsrl(x86_pmu_config_addr(hwc->idx + 1), 0);
-- 
2.32.0

