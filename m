Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A805A7229
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiHaABN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiHaABB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:01:01 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4BE6B8D2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:00:59 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id n30-20020a17090a5aa100b001fb0c492d5eso5506534pji.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc;
        bh=qJXKs+ZLE9emDk3uVMrPeQaTARYDAHlXW11oK3RW2Wc=;
        b=SeC4SpEUA9Pj0gJ4NsFdHazet6GE9bdJ1dT6nWyveIfGZuo4CKCEVpytHC64cm9plj
         wOdcAYiLeQSXoHXjHQY2kqRBjQVhPudE0imZ22YGjYoIbrM6bDxeQOE8AH7eLW7f0ezd
         WH2vXQB6njqucYikofJ7Ee/NM6nFuGUTwz+7SftSDtbcPOENu0gg/MUl2PUczy8BJJz2
         hyExUDUd77eEx4pxmLpyzU7b8ABB1IT93OerKqZeCNQBastYtbtlIAtEIRdyfksk+1oR
         ONRzuizCjC3rQ1A3LaB9bt6kB1/BWGcmbDAw/SZNbE+uA0DXDJMXodqMZrpiCfvsJWxA
         SMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=qJXKs+ZLE9emDk3uVMrPeQaTARYDAHlXW11oK3RW2Wc=;
        b=zipvqGMdg84LIy3+Du3CZFAuCoWSPpJG+9XztobjcCg91W1yRWlmKJr2D27C0HTO09
         99+HFvFq+N+MxnbGXq/Jpp0dqv3OAGiGmk/4dE19GVHOK2jZr1EtpAQYegyeERurwlRi
         UnzgnfSVsfwYty+i55ALfQB3R5o1hYRIgvcnesx+94KWBJUPAIbzeebZ9a9NUUagZfQJ
         ql6lpM6FRcEyT6rVaokyL0chwwRIGBeGvWN1Hn2FDNstAy9F3X0wQu1nkFKNq876BjI1
         30T+I9gY8xN15gSkRyymNSbWn4vy9u9KF+L1jd0dLX0tFbULnI2MQiDT5qWX9QxOFscR
         qTKA==
X-Gm-Message-State: ACgBeo0H5LntOzETF0RFNKmQHj9/572qCwNvlvHOvlHdUj6iy82QFQis
        GBfEQoK7e1hOn/tqo+eiMVilp1XWozA=
X-Google-Smtp-Source: AA6agR7Ex184XlJZTk1AEwJjTtBbOvVyb+1EL7HgzEsb95OcRUH5oln+KYkb9WpAdL/XG36FFJKIVlM6JxA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:9430:0:b0:537:ab14:6cd8 with SMTP id
 y16-20020aa79430000000b00537ab146cd8mr23155574pfo.29.1661904059303; Tue, 30
 Aug 2022 17:00:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 31 Aug 2022 00:00:51 +0000
In-Reply-To: <20220831000051.4015031-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220831000051.4015031-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220831000051.4015031-4-seanjc@google.com>
Subject: [PATCH v3 3/3] KVM: VMX: Advertise PMU LBRs if and only if perf
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
 arch/x86/kvm/vmx/capabilities.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index c5e5dfef69c7..d2fdaf888d33 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -404,6 +404,7 @@ static inline bool vmx_pebs_supported(void)
 static inline u64 vmx_get_perf_capabilities(void)
 {
 	u64 perf_cap = PMU_CAP_FW_WRITES;
+	struct x86_pmu_lbr lbr;
 	u64 host_perf_cap = 0;
 
 	if (!enable_pmu)
@@ -412,7 +413,9 @@ static inline u64 vmx_get_perf_capabilities(void)
 	if (boot_cpu_has(X86_FEATURE_PDCM))
 		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
 
-	perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
+	x86_perf_get_lbr(&lbr);
+	if (lbr.nr)
+		perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
 
 	if (vmx_pebs_supported()) {
 		perf_cap |= host_perf_cap & PERF_CAP_PEBS_MASK;
-- 
2.37.2.672.g94769d06f0-goog

