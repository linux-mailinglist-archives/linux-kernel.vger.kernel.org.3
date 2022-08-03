Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBBB5892B3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 21:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbiHCT1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 15:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbiHCT1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 15:27:07 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9933C564E5
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 12:27:06 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id p29-20020a056a000a1d00b0052d93f32bdbso4027988pfh.14
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 12:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:reply-to:from:to:cc;
        bh=v6/mEopqhFY1D69DUbdL+MCeZPJSIwmGFWEXSi2+X5M=;
        b=dDizul2odF4KXcGl96z2JZqEiUseQsnNckZ4KWCDvQzwCqf9ZiomK8Br019BZTEwU1
         xa7X8sjdAaen/2QF4p3mHmBpyv782xcoYUGcqBdMGu0VaPYJy3u4iWE3RI4y6Hk9RKLr
         Z+RoVudGF+on6Mt/eAKFAd/GpF1ipMT0jRTmLwGK7c8q40yG+C+9OyL7WWlobgm8BlpC
         XmfibJRDKtoDa/LknqEgBFEaKxM1o2jm9mW1BoCEz44fOe6qO8qZStyU56gT2bcwRiBV
         jxkNaO5W3qF7zjtgaEo5ul6dm3PWnPSDmFMfUmnw/Y7mFXKFok0o+GCxBLtywYFWow8M
         6p3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=v6/mEopqhFY1D69DUbdL+MCeZPJSIwmGFWEXSi2+X5M=;
        b=YAfYIKNRaxeCXbQ3USTZeU/I3YdhbrH6oNDRSd+tNbIq2MLnFgEsGWlgw170lfQyIo
         GcgQ6+6/vJK8mQA61kW79hm89enU9eeANryekQh7NV5/kJaJjYdh/8bBKLHBYHSYCbEO
         qdp6oiBccqy4CMRi44elY338UNNm3ZhVW+X89XWsW+CK6yAs1W+rxpzkSNSko0ANFC/1
         j8HoSEM4a1Sk+6IBL/ZJWyBe1/Zqbi8Ruhtc+JuX0RVJEYhR/8+9t6koyNsmIjxMoQ9C
         EO1xJaumNibyBFJmXf9sszpTTpNa6OK+yjBNAVquIBX9DjAnxwryjX5rrHEo063EIoOS
         FXZw==
X-Gm-Message-State: ACgBeo3RiFIgpxBqE0IXhHoQUhzNR0eSUOGMT0OJyG0PcSSaQgUo1ULW
        tdjxmK1yvnX6dPN8oCtLBqwfKBlxRBY=
X-Google-Smtp-Source: AA6agR6zxQ8tMq014wMaDX6OMKsRz5+Wsn+8kD/TGhjeMPf6x8qb0wiedAKEY6UqDxidmq5qbkjB1/Bpj2w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:9431:0:b0:52d:d7f2:477e with SMTP id
 y17-20020aa79431000000b0052dd7f2477emr9765133pfo.7.1659554826214; Wed, 03 Aug
 2022 12:27:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  3 Aug 2022 19:26:53 +0000
In-Reply-To: <20220803192658.860033-1-seanjc@google.com>
Message-Id: <20220803192658.860033-3-seanjc@google.com>
Mime-Version: 1.0
References: <20220803192658.860033-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v2 2/7] perf/x86/core: Remove unnecessary stubs provided for
 KVM-only helpers
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove CONFIG_PERF_EVENT=n stubs for functions that are effectively
KVM-only.  KVM selects PERF_EVENT and will never consume the stubs.
Dropping the unnecessary stubs will allow simplifying x86_perf_get_lbr()
by getting rid of the impossible-to-hit error path (which KVM doesn't
even check).

Opportunstically reorganize the declarations to collapse multiple
CONFIG_PERF_EVENTS #ifdefs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/perf_event.h | 53 ++++++++-----------------------
 1 file changed, 13 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index cc47044401ff..aba196172500 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -509,46 +509,18 @@ extern u64 perf_get_hw_event_config(int hw_event);
 extern void perf_check_microcode(void);
 extern void perf_clear_dirty_counters(void);
 extern int x86_perf_rdpmc_index(struct perf_event *event);
-#else
-static inline void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
-{
-	memset(cap, 0, sizeof(*cap));
-}
 
-static inline u64 perf_get_hw_event_config(int hw_event)
-{
-	return 0;
-}
-
-static inline void perf_events_lapic_init(void)	{ }
-static inline void perf_check_microcode(void) { }
-#endif
-
-#if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
+#ifdef CONFIG_CPU_SUP_INTEL
 extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr, void *data);
 extern int x86_perf_get_lbr(struct x86_pmu_lbr *lbr);
-#else
-struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr, void *data);
-static inline int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
-{
-	return -1;
-}
-#endif
+extern void intel_pt_handle_vmx(int on);
+#endif /* CONFIG_CPU_SUP_INTEL */
 
-#ifdef CONFIG_CPU_SUP_INTEL
- extern void intel_pt_handle_vmx(int on);
-#else
-static inline void intel_pt_handle_vmx(int on)
-{
+#ifdef CONFIG_CPU_SUP_AMD
+extern void amd_pmu_enable_virt(void);
+extern void amd_pmu_disable_virt(void);
 
-}
-#endif
-
-#if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_AMD)
- extern void amd_pmu_enable_virt(void);
- extern void amd_pmu_disable_virt(void);
-
-#if defined(CONFIG_PERF_EVENTS_AMD_BRS)
+#ifdef CONFIG_PERF_EVENTS_AMD_BRS
 
 #define PERF_NEEDS_LOPWR_CB 1
 
@@ -566,12 +538,13 @@ static inline void perf_lopwr_cb(bool lopwr_in)
 	static_call_mod(perf_lopwr_cb)(lopwr_in);
 }
 
-#endif /* PERF_NEEDS_LOPWR_CB */
+#endif /* CONFIG_PERF_EVENTS_AMD_BRS */
+#endif /* CONFIG_CPU_SUP_AMD */
 
-#else
- static inline void amd_pmu_enable_virt(void) { }
- static inline void amd_pmu_disable_virt(void) { }
-#endif
+#else  /* !CONFIG_PERF_EVENTS */
+static inline void perf_events_lapic_init(void)	{ }
+static inline void perf_check_microcode(void) { }
+#endif /* CONFIG_PERF_EVENTS */
 
 #define arch_perf_out_copy_user copy_from_user_nmi
 
-- 
2.37.1.559.g78731f0fdb-goog

