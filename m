Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260A459EFD3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 01:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiHWXoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 19:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHWXoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 19:44:00 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3F08A6DA
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 16:43:59 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id s3-20020a17090a5d0300b001fb3ac54a03so2463738pji.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 16:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=buqUxxwCuurQCGvIWcBzNGEGiMpXO6f0MopvbFAVuy4=;
        b=s/Oyq3bRVMysOt8x1cdAlmAVaIQaKOVzdheav1QwmS/why5h7fuGl6FotWAtmCy+Ic
         311rK/Dfs3CoeZbhiTK/EV9qg4CTFVe9PRqhF55GA1M6x0Qazif190N4PDrL4Iw8e22I
         Or2ddCuIb+nCXb0Oq09xFIU6w+tZZa2CYkFCtfHbqQmsHEbVpR/HaykE718hfD/2+cmK
         FHCsHVR/BzQT5aIaRQXrR2krqsAu4c1izZCkVr+W5nRiDk2q6/9pDHE4N4r9mRi5UiDX
         +uZA43S6aKRTYPnA/t+VEktQhywGjsdlU8JDZpVqw6aVn0GvJCle5n89MdNDfLt/fwxJ
         Imsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=buqUxxwCuurQCGvIWcBzNGEGiMpXO6f0MopvbFAVuy4=;
        b=zGzFNwg2FoSmki9lBotl+hPKTLDacGHkdidR7DE8d7gbvk18tPeUTD4F+L1xwcAbM1
         lv2LFKr6AklpMcPUm59u9EMfZb/B1Ypvs9p/hipSz+irKqOsElowVuljaoO9it0J/3pt
         AxIl9IkkO+xzfJ6ISSQf69/teHL4SUrJthYn7XwRzX6M1i/wWV2FRdjwerDWODGSdFRo
         421x4ZIDhF/HXjHAtkKKszwmB8V5pGIcXrwH8fr4PYDjjL1bYicEMtkbMdLZ1fWYk8+d
         VoYDnY9keslubGo6q45YbT/AkV0mKWqIKKuH2YwfDw2IQkM3TDeZC+vsKt1mSck0bZJ8
         7lGQ==
X-Gm-Message-State: ACgBeo0h86dAuQxoejlBLx9xj8V0Jjfw5aj4dASWEOPklvCeZnhs17kh
        nrgBmlVXnNJwLIrtZi6EzKl3/BTjPf0=
X-Google-Smtp-Source: AA6agR5+C8UQv+q7r1T7kLEd8fXqzZIi6N5tjhP3Ko5nQNLbJjezxePfaQk5d1pCxegFzhVlFxLYJf2DCnQ=
X-Received: from pshier-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b0b])
 (user=pshier job=sendgmr) by 2002:a17:902:c945:b0:16d:d425:324a with SMTP id
 i5-20020a170902c94500b0016dd425324amr25716205pla.7.1661298238537; Tue, 23 Aug
 2022 16:43:58 -0700 (PDT)
Date:   Tue, 23 Aug 2022 16:43:53 -0700
Message-Id: <20220823234353.937002-1-pshier@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH] x86/msr: add idle version of wrmsr trace
From:   FirstName LastName <pshier@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Roth <michael.roth@amd.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Peter Shier <pshier@google.com>
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

From: Peter Shier <pshier@google.com>

With commit bf5835bcdb963 ("intel_idle: Disable IBRS during long idle"),
enabling wrmsr trace with CONFIG_LOCKDEP causes "suspicious
rcu_dereference_check() usage" warning because do_trace_write_msr does not
use trace_write_msr_rcuidle.

Add idle versions of needed routines and change intel_idle_ibrs to use it.

Sample warning:
============================
WARNING: suspicious RCU usage
6.0.0-dbg-DEV #7 Tainted: G S         O      
-----------------------------
arch/x86/include/asm/msr-trace.h:48 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
RCU used illegally from extended quiescent state!
no locks held by swapper/59/0.

stack backtrace:
CPU: 59 PID: 0 Comm: swapper/59 Tainted: G S         O       6.0.0-dbg-DEV #7
Call Trace:
 dump_stack_lvl
 dump_stack
 lockdep_rcu_suspicious
 trace_write_msr
 do_trace_write_msr
 intel_idle_ibrs
 cpuidle_enter_state
 cpuidle_enter
 do_idle
 cpu_startup_entry
 start_secondary
 secondary_startup_64_no_verify


Tested on skylake using:
echo "msr:write_msr" >/sys/kernel/debug/tracing/set_event
with and without patch.

Signed-off-by: Peter Shier <pshier@google.com>
---
 arch/x86/include/asm/msr.h | 16 ++++++++++++++++
 arch/x86/lib/msr.c         |  6 ++++++
 drivers/idle/intel_idle.c  |  4 ++--
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 65ec1965cd28..248cc58b7758 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -62,10 +62,12 @@ DECLARE_TRACEPOINT(read_msr);
 DECLARE_TRACEPOINT(write_msr);
 DECLARE_TRACEPOINT(rdpmc);
 extern void do_trace_write_msr(unsigned int msr, u64 val, int failed);
+extern void do_trace_write_msr_idle(unsigned int msr, u64 val, int failed);
 extern void do_trace_read_msr(unsigned int msr, u64 val, int failed);
 extern void do_trace_rdpmc(unsigned int msr, u64 val, int failed);
 #else
 static inline void do_trace_write_msr(unsigned int msr, u64 val, int failed) {}
+extern void do_trace_write_msr_idle(unsigned int msr, u64 val, int failed) {}
 static inline void do_trace_read_msr(unsigned int msr, u64 val, int failed) {}
 static inline void do_trace_rdpmc(unsigned int msr, u64 val, int failed) {}
 #endif
@@ -148,6 +150,15 @@ native_write_msr(unsigned int msr, u32 low, u32 high)
 		do_trace_write_msr(msr, ((u64)high << 32 | low), 0);
 }
 
+static inline void notrace
+native_write_msr_idle(unsigned int msr, u32 low, u32 high)
+{
+	__wrmsr(msr, low, high);
+
+	if (tracepoint_enabled(write_msr))
+		do_trace_write_msr_idle(msr, ((u64)high << 32 | low), 0);
+}
+
 /* Can be uninlined because referenced by paravirt */
 static inline int notrace
 native_write_msr_safe(unsigned int msr, u32 low, u32 high)
@@ -262,6 +273,11 @@ static inline void wrmsrl(unsigned int msr, u64 val)
 	native_write_msr(msr, (u32)(val & 0xffffffffULL), (u32)(val >> 32));
 }
 
+static inline void wrmsrl_idle(unsigned int msr, u64 val)
+{
+	native_write_msr_idle(msr, (u32)(val & 0xffffffffULL), (u32)(val >> 32));
+}
+
 /* wrmsr with exception handling */
 static inline int wrmsr_safe(unsigned int msr, u32 low, u32 high)
 {
diff --git a/arch/x86/lib/msr.c b/arch/x86/lib/msr.c
index b09cd2ad426c..58fdf0f13850 100644
--- a/arch/x86/lib/msr.c
+++ b/arch/x86/lib/msr.c
@@ -121,6 +121,12 @@ void do_trace_write_msr(unsigned int msr, u64 val, int failed)
 EXPORT_SYMBOL(do_trace_write_msr);
 EXPORT_TRACEPOINT_SYMBOL(write_msr);
 
+void do_trace_write_msr_idle(unsigned int msr, u64 val, int failed)
+{
+	trace_write_msr_rcuidle(msr, val, failed);
+}
+EXPORT_SYMBOL(do_trace_write_msr_idle);
+
 void do_trace_read_msr(unsigned int msr, u64 val, int failed)
 {
 	trace_read_msr(msr, val, failed);
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 3e101719689a..bdecd2638c59 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -187,12 +187,12 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
 	int ret;
 
 	if (smt_active)
-		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+		wrmsrl_idle(MSR_IA32_SPEC_CTRL, 0);
 
 	ret = __intel_idle(dev, drv, index);
 
 	if (smt_active)
-		wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
+		wrmsrl_idle(MSR_IA32_SPEC_CTRL, spec_ctrl);
 
 	return ret;
 }
-- 


