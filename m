Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231485A9E0F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbiIARdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiIARdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:33:12 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC739413E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:33:10 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id m15-20020a170902db0f00b001753b1c5adeso4235723plx.18
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=toQG5Z5nBBy1r8xg7zoFpTxuXMus911akVxRxr9n+oM=;
        b=Hdz2/W9HzWlTkRMQsR89JPn80MjKvE7MBUKdVInOy6m5SPM6rc/dQBlPRS2RFSF2bc
         Sk8W7t6tRQ0+B3KqjEfxT4UpAlh4qKZaQBIAFPzBTOKu04VcYD9CrBaW4DHRwOXujX2p
         prMyNb7FMLNVE4HibzgTIruHq2XJ+IMNFJ380TC/cWOKFU1+hdMD23MzMQUnLuuH/hiy
         ZxFhY8Tef7TfOTI4bIDCDNSVn3zP57ybZUyi3TJPf3cOhnyBW6thTa0u+4QByQWrHwCm
         3/U1g/Orlh3zGf7KihYQIvS3JffKt8F8CkKy7lNl7A/Pulaxqw7gFcsRrHkXaF29JPtt
         wxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=toQG5Z5nBBy1r8xg7zoFpTxuXMus911akVxRxr9n+oM=;
        b=Gto4MAHybmVFmwlhPWjU9Nt0hptGqyV7GCFwwzdav1dbeYqcnGr5T4K+YHHr1dqFle
         xpHOGxBsgOV1gtysn0x2C3JsGMMobh7bVFAFyfoxHV61+1xrFdkL8piHEIHuC+ADfoML
         AzL/1Na5HqsFcp7f8TD9jDuxJIxgXkl8tZgJR6EEbhOzGj/FRPUHOur59tFvDe8iGBqs
         jAun3O2eoZ1/VD7/yhReJ4SQ4d+QMUyEz3kTqwsB22kzSeCZH0wmwQhWCrd+xEB4rvvw
         VZqgnQrFECJt/WVIT7n4OWN35JvLiwSb+6cx0vROGFEab5r7hmR03UiYESrKn65oVb3Z
         lKTA==
X-Gm-Message-State: ACgBeo2BYHqxKL9bNNNX6Rws9nltJYXeQSmaIVNSCysCyHqAOkwSmyXt
        IJ7HcgbHAGW2dJcOnwvtEQJT8BX9i3s=
X-Google-Smtp-Source: AA6agR6ZaSAAeeYRAm64gGT138n9rAuKa5Qq6wwfx5dLRyHcXluRD1qCzGz+zpDN1ff5O1o2pTq82DP1zz0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2446:b0:528:5da9:cc7 with SMTP id
 d6-20020a056a00244600b005285da90cc7mr32728141pfj.51.1662053589567; Thu, 01
 Sep 2022 10:33:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  1 Sep 2022 17:32:58 +0000
In-Reply-To: <20220901173258.925729-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220901173258.925729-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173258.925729-6-seanjc@google.com>
Subject: [PATCH v4 5/5] KVM: VMX: Advertise PMU LBRs if and only if perf
 supports LBRs
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Advertise LBR support to userspace via MSR_IA32_PERF_CAPABILITIES if and
only if perf fully supports LBRs.  Perf may disable LBRs (by zeroing the
number of LBRs) even on platforms the allegedly support LBRs, e.g. if
probing any LBR MSRs during setup fails.

Fixes: be635e34c284 ("KVM: vmx/pmu: Expose LBR_FMT in the MSR_IA32_PERF_CAPABILITIES")
Reported-by: Like Xu <like.xu.linux@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a5e3c1e6aa2b..8e237268ac10 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1829,6 +1829,7 @@ static inline bool vmx_feature_control_msr_valid(struct kvm_vcpu *vcpu,
 u64 vmx_get_perf_capabilities(void)
 {
 	u64 perf_cap = PMU_CAP_FW_WRITES;
+	struct x86_pmu_lbr lbr;
 	u64 host_perf_cap = 0;
 
 	if (!enable_pmu)
@@ -1837,7 +1838,9 @@ u64 vmx_get_perf_capabilities(void)
 	if (boot_cpu_has(X86_FEATURE_PDCM))
 		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
 
-	perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
+	x86_perf_get_lbr(&lbr);
+	if (lbr.nr)
+		perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
 
 	if (vmx_pebs_supported()) {
 		perf_cap |= host_perf_cap & PERF_CAP_PEBS_MASK;
-- 
2.37.2.789.g6183377224-goog

