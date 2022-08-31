Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806BA5A722A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiHaABD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiHaAA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:00:57 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47125659F0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:00:56 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id c17-20020a17090ad91100b001fdb29e1943so3109766pjv.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc;
        bh=vo5HdwRPjV6Nw++vuMl/iEPDJH4m1OFL3i5pfdtXoVE=;
        b=Djuq1dwHroOnQMQJ3UVirD/6ihOvXXj1ckAIf1EOYJDaxNuanAHVo827cEL2o4/Nb8
         mqplmhj7jxCZ0vMvojiQth3c7E0kBTGWG4K9/7bOE75vCjprxG7+fAHKLyfeF6YlULtm
         y/5+zEqsBTaZR/8IkBQnEBu5ZmBFi0fW41NOVgpdywtBHBpeFGx66WIrT78dlom7Hinp
         ElCeCcdjGisfx8p4V4EwNh/+m8Qf5Xpn4bBCagGSeZmw8Z9BIWBSolh20CvzNtQN94VC
         vXbCNoTAHTHmkN426naO9FoD6WCtxDaLTdneAAWLAxrOOIYcHYfwjBvWJ0tgS+txafWN
         jzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=vo5HdwRPjV6Nw++vuMl/iEPDJH4m1OFL3i5pfdtXoVE=;
        b=7gE7WmmBzTNRaMZxAkDrh4q1HqcHmlrQ50eM/1N3rJpgDa3wt51TDSkhAIITb9m0Wa
         PSPwCUDjmDbOXXYHMUiugyBIjQuqAnr0sQPBuTVwrlj0z3cVZHIetIdjkrxweKrxfzxV
         nJSdaCiNZQNc6u2hlX+65fInJ9L3p5sR4SojuF+YfDQ/WujXcBXRlCRgfey/RlmqE4ON
         IMuQJYNVtwCielTh/ismqtAstm90xuymOddGBGvrgwzM3e97+Phgi4kSlgzCJF4Zyxqk
         WXsoX43yVJ4M+lxYrIq5Hu6SkT6M4Ujcz9GxAgijjJcOqc/nb/Bpggav0xXCnz0TtECG
         sjrw==
X-Gm-Message-State: ACgBeo1sgbrk35M44CCYpKEetgMDBVvQsSwmMAzhjvOVD0KwfUAqmtie
        KE52ISRymKdQjpwg5ntmm/8rtA3p2Ug=
X-Google-Smtp-Source: AA6agR5m+62T7xHSzPIU2GAafdzd2hDCL8JP1w40ZoO3eUABfskgZ+ViDXGRJuTI6f9RjxggnW67RBjMx4c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e884:b0:174:9834:53 with SMTP id
 w4-20020a170902e88400b0017498340053mr14868368plg.2.1661904055854; Tue, 30 Aug
 2022 17:00:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 31 Aug 2022 00:00:49 +0000
In-Reply-To: <20220831000051.4015031-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220831000051.4015031-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220831000051.4015031-2-seanjc@google.com>
Subject: [PATCH v3 1/3] perf/x86/core: Remove unnecessary stubs provided for
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
index f6fc8dd51ef4..f839eb55f298 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -525,46 +525,18 @@ extern u64 perf_get_hw_event_config(int hw_event);
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
 
@@ -582,12 +554,13 @@ static inline void perf_lopwr_cb(bool lopwr_in)
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
2.37.2.672.g94769d06f0-goog

