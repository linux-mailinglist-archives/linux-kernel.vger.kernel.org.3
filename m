Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639865A04CD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 01:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiHXXmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 19:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiHXXmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 19:42:16 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B164F65B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 16:42:15 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id z18-20020a170903019200b00172dd6da065so7433916plg.14
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 16:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=GgNtt8XHsncrMgE4IbFRR5+V66rX8top3EG46fAYnRQ=;
        b=TkwbARh0dZMRE7NNmMKzQlT77SIZaFyNqwvglcl62fiCu+FaVN1DDQfnQNcqxl1vll
         PhPkHhlVODagqIz4tOQH43BaiM2ryWm+xZSXhAossnzohFLZSs+2A8oX3zn//MSOMIEB
         urVepvzcnyoWCw8fvVDJPxIuspFkyvYUrga4TCZ14ZMrMeVpUJJMfRYK5dD0aP+Sossv
         cU6qmYxY2kKa5AlDkc3R705d9YOAeNYmXbHg2hE5AnBn51FwPSreQ31kq4W8fi2ILaCi
         o5uUEvWoWzQnYliEL6hJCdZ55gk3zSKWuIxJm4oZY3fzNdDPICAZzK1Q09wgMrreTAl4
         f5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=GgNtt8XHsncrMgE4IbFRR5+V66rX8top3EG46fAYnRQ=;
        b=6HzOJuaTBHYGqAC8iP945eWC/K8SPRP84gNoU3Abq3zxK1xZQZ6fg3nMXQWhm1a+4c
         01wlqHHL4fbvJ1/6XtA33Zs3Ru4fhoALKofVdKKHKR8Ve9eqZeXQLVr97Sajd9Ulvbh6
         E0b7kRfA8aclYGIURWMHJEYY/B7MLZU3pRF9dq8nDwYRs+MzVDB5Hpk1huQSLgq+Pn5f
         G3acRJOaN70c96PWOY+OnL60qqkaNL0ha3/jrGa/t7lgy8iFXoI/IeOVUg2SBDkPmeij
         3hZtLilXixteWwU15zaovRAJ7v6Q/eC6btN8mJbIezy70jRZQMTTgH5us7UKSxQ6duaZ
         WHrw==
X-Gm-Message-State: ACgBeo36K6lKVBUXr3F9daKWY9K3uTC2qKwcqrYjgoLVjhzih7Aw0j8B
        heCi2YQ50V8oCBI9udLaRjMWi/38VTM=
X-Google-Smtp-Source: AA6agR6x5JpK2ntXNc8GBL28Et5asGmcl9MZgoMJ3jvSRbAgpvHAOAHK5SwfyRyWL8p/UZjWA2Fo4nhGynM=
X-Received: from pshier-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b0b])
 (user=pshier job=sendgmr) by 2002:a17:90b:33d2:b0:1fb:971b:c5e9 with SMTP id
 lk18-20020a17090b33d200b001fb971bc5e9mr1509609pjb.90.1661384534988; Wed, 24
 Aug 2022 16:42:14 -0700 (PDT)
Date:   Wed, 24 Aug 2022 16:42:11 -0700
Message-Id: <20220824234211.1625026-1-pshier@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v2] intel_idle: avoid tracing MSR writes while idling
From:   Peter Shier <pshier@google.com>
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

With commit bf5835bcdb963 ("intel_idle: Disable IBRS during long idle"),
enabling wrmsr trace with CONFIG_LOCKDEP causes "suspicious
rcu_dereference_check() usage" warning because do_trace_write_msr does not
use trace_write_msr_rcuidle.

Change intel_idle_ibrs to use native_wrmsr to avoid tracing

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

v2:
- changed to avoid tracing

v1: https://lore.kernel.org/all/20220823234353.937002-1-pshier@google.com/

 drivers/idle/intel_idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 3e101719689a..df129c73786f 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -187,12 +187,12 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
 	int ret;
 
 	if (smt_active)
-		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+		native_wrmsr(MSR_IA32_SPEC_CTRL, 0);
 
 	ret = __intel_idle(dev, drv, index);
 
 	if (smt_active)
-		wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
+		native_wrmsr(MSR_IA32_SPEC_CTRL, spec_ctrl);
 
 	return ret;
 }
-- 
