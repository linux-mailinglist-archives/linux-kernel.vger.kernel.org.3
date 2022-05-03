Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE87517CC2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 07:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiECFFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 01:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiECFFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 01:05:12 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6170A3EB85
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 22:01:40 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c11so3845574plg.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 22:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EnEoLxNESFUTI46rXZ49NiSZqFRgdh8+36EAvyHGQns=;
        b=gd+RFqIrUmVYueZ4Bw6793FFqgcHp4mHcQbLos/DbvQXnZz8eUFvcHxvIkvGnUGo74
         /cnoBUkC53CVEEz6O/hV9GLnxN6IM2eyZA7oZ6pCGT7cnPzdacr9X7afPAgMe+3UbzKq
         oQD6FpyOTUMVZOhQ8/gXizwELs7An1vrq32aK/PdpIEvgE2pvUjsJB7iph3PToDaYsjt
         A2wQkEU9zPSAjUl7Yr20MEKVr7fNJYZQ7flnKP12PGnI27d2E5wJK2oQhkcCKbx1d+Tf
         DI3zZbZ/YV0Nbo1XUI3uEBcFYCLZuARDBXf6OxRInIKL/7r4LQcwKbjVbQhL7WXxDS+K
         MbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EnEoLxNESFUTI46rXZ49NiSZqFRgdh8+36EAvyHGQns=;
        b=nJMe/E0j5PB49mGrMBOPp0fasNH6/D5QDrMR/xL8QwcbalCKqP3Cd/ysnBhSs8Fqva
         eB2XNvSYJAkXS5U3h+QzzCok6zReKt+l+th2lDI51xJoGqIN5NtrVR0Fv8NcMy4mnZwI
         jARQNgYJ9iKlCj8iFN66BQkgRuWBh78KXfSIst50IB+eOuC6D647opTiqFeVDYXP3p8n
         /8Ovu1rvYAelsUBISbcq9htUPa+YxWZS8UGY0dU4XtH1g6G6v6ev/lqtex2jDc8y5/wx
         jr7LSnVZw8/tZX+jI8QBPiu6gYGZkeU7yqfQRFnD0GBb/8xYxzf94Fe4u2bT8dnkCRMb
         JZgg==
X-Gm-Message-State: AOAM530uLWhcfds1RvWF43rX0hYJheWjyW6p7JvRuUjDBL3LohGYygI9
        oQw5P+4R/h462NdQQVMoboe6/L4bXPIbonsf
X-Google-Smtp-Source: ABdhPJxRPzN58QziFP/ngC1wLLm0Rp2I/CIWsVaWLrSIL+s77G48MTmB7eQ5OUnmhLU0KxaMgROmzA==
X-Received: by 2002:a17:903:189:b0:15e:9584:fbe7 with SMTP id z9-20020a170903018900b0015e9584fbe7mr12153547plg.65.1651554099135;
        Mon, 02 May 2022 22:01:39 -0700 (PDT)
Received: from minbar.home.kylehuey.com (c-71-198-251-229.hsd1.ca.comcast.net. [71.198.251.229])
        by smtp.gmail.com with ESMTPSA id 3-20020aa79143000000b0050dc76281e6sm5519416pfi.192.2022.05.02.22.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 22:01:38 -0700 (PDT)
From:   Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        Robert O'Callahan <robert@ocallahan.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Kyle Huey <me@kylehuey.com>
Subject: [PATCH] KVM: x86/svm: Account for family 17h event renumberings in amd_pmc_perf_hw_id
Date:   Mon,  2 May 2022 22:01:36 -0700
Message-Id: <20220503050136.86298-1-khuey@kylehuey.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle Huey <me@kylehuey.com>

Zen renumbered some of the performance counters that correspond to the
well known events in perf_hw_id. This code in KVM was never updated for
that, so guest that attempt to use counters on Zen that correspond to the
pre-Zen perf_hw_id values will silently receive the wrong values.

This has been observed in the wild with rr[0] when running in Zen 3
guests. rr uses the retired conditional branch counter 00d1 which is
incorrectly recognized by KVM as PERF_COUNT_HW_STALLED_CYCLES_BACKEND.

[0] https://rr-project.org/

Signed-off-by: Kyle Huey <me@kylehuey.com>
---
 arch/x86/kvm/svm/pmu.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index b14860863c39..43d24746c0a7 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -45,6 +45,22 @@ static struct kvm_event_hw_type_mapping amd_event_mapping[] = {
 	[7] = { 0xd1, 0x00, PERF_COUNT_HW_STALLED_CYCLES_BACKEND },
 };
 
+/* duplicated from amd_f17h_perfmon_event_map. */
+static struct kvm_event_hw_type_mapping amd_f17h_event_mapping[] = {
+	[0] = { 0x76, 0x00, PERF_COUNT_HW_CPU_CYCLES },
+	[1] = { 0xc0, 0x00, PERF_COUNT_HW_INSTRUCTIONS },
+	[2] = { 0x60, 0xff, PERF_COUNT_HW_CACHE_REFERENCES },
+	[3] = { 0x64, 0x09, PERF_COUNT_HW_CACHE_MISSES },
+	[4] = { 0xc2, 0x00, PERF_COUNT_HW_BRANCH_INSTRUCTIONS },
+	[5] = { 0xc3, 0x00, PERF_COUNT_HW_BRANCH_MISSES },
+	[6] = { 0x87, 0x02, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND },
+	[7] = { 0x87, 0x01, PERF_COUNT_HW_STALLED_CYCLES_BACKEND },
+};
+
+/* amd_pmc_perf_hw_id depends on these being the same size */
+static_assert(ARRAY_SIZE(amd_event_mapping) ==
+	     ARRAY_SIZE(amd_f17h_event_mapping));
+
 static unsigned int get_msr_base(struct kvm_pmu *pmu, enum pmu_type type)
 {
 	struct kvm_vcpu *vcpu = pmu_to_vcpu(pmu);
@@ -140,6 +156,7 @@ static inline struct kvm_pmc *get_gp_pmc_amd(struct kvm_pmu *pmu, u32 msr,
 
 static unsigned int amd_pmc_perf_hw_id(struct kvm_pmc *pmc)
 {
+	struct kvm_event_hw_type_mapping *event_mapping;
 	u8 event_select = pmc->eventsel & ARCH_PERFMON_EVENTSEL_EVENT;
 	u8 unit_mask = (pmc->eventsel & ARCH_PERFMON_EVENTSEL_UMASK) >> 8;
 	int i;
@@ -148,15 +165,20 @@ static unsigned int amd_pmc_perf_hw_id(struct kvm_pmc *pmc)
 	if (WARN_ON(pmc_is_fixed(pmc)))
 		return PERF_COUNT_HW_MAX;
 
+	if (boot_cpu_data.x86 >= 0x17)
+		event_mapping = amd_f17h_event_mapping;
+	else
+		event_mapping = amd_event_mapping;
+
 	for (i = 0; i < ARRAY_SIZE(amd_event_mapping); i++)
-		if (amd_event_mapping[i].eventsel == event_select
-		    && amd_event_mapping[i].unit_mask == unit_mask)
+		if (event_mapping[i].eventsel == event_select
+		    && event_mapping[i].unit_mask == unit_mask)
 			break;
 
 	if (i == ARRAY_SIZE(amd_event_mapping))
 		return PERF_COUNT_HW_MAX;
 
-	return amd_event_mapping[i].event_type;
+	return event_mapping[i].event_type;
 }
 
 /* check if a PMC is enabled by comparing it against global_ctrl bits. Because
-- 
2.36.0

