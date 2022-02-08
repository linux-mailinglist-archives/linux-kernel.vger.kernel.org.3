Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E4E4AE48D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345564AbiBHWfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386203AbiBHTnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:43:47 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82EDC0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:43:46 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so2937103pjl.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sJjbNLxKnq2MLHtlOHVGr5cmsCqOoxOU5S439s399rs=;
        b=FCaFfDHqOKbbM+LTbZb/y7018/XOb/NmUt5E6W+YnPsqxKsfSDMkWZB/l0fglbgasl
         clQebc8o6nC+U2ONdp4ydBS2u9mOTBEPiyiovDrjfweqhsE4OQLY6vnmZL4LYFkMGbp4
         zx0Ldh7CVLEFZaAg0EkxPR7V58GWFRcK38oNqFb+kXJM/NXJ/LE0zDxE1iwSW9o0UhKv
         5mYjmoD1oql0ihFJrAlulXXNG0pefXs1oTT0rJ79JaxEBu0b7PhNtIS7oKe589fqyeuz
         iQS0o2k9uDlyVH34IVZDep+1o0VwKMV1j7oN9lcKwBo0mpIgqI5YGnPdeRoXaSL3qxo7
         v8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sJjbNLxKnq2MLHtlOHVGr5cmsCqOoxOU5S439s399rs=;
        b=wqzzijdvJFyh0RSjuzhNSR5XP+/H1fdf0/x0d4HzwfnVPrg4HNlb73kwSVrbCZAFwG
         Nv6SB+ex6XsC3DQaVgMLbDr3FPgUJumB7Kh/PuNIyOjB0mMIg9d+CQqtCb+U/Jz/Pn9p
         d+BoFtB01s9HlBwLW0mtt/6b1Zkoj6En9CVslh3ANrxjU15tg3+XHCGp1EkI6S6zXDwf
         HjBcS/+oSHzKl1QVB3ZfV8yZmYdg9MUQWKBKxWM6m9vHNZ0PLWvwYRsQw9AuTcwReRIa
         chgt6KRxICdVTpSvE6hAZoBanINThLJJ17E4ohfr/C9/DNFbwazciFskj4SKoHSbIEsT
         Lddg==
X-Gm-Message-State: AOAM531xSExTNXEJjNo9lk37lcwq41N7pPeKIfEHHOymk52zyo73XDlj
        XI9MZSvimhAJ5Vi86SjPhvA=
X-Google-Smtp-Source: ABdhPJxcdJhuyvcGJERiilgb8k7uMGXZtduHdT/KN0RWAWmAOJukqmIGccAe7pKgqTm7G6G9cfXrHQ==
X-Received: by 2002:a17:90b:4c06:: with SMTP id na6mr3057583pjb.174.1644349426360;
        Tue, 08 Feb 2022 11:43:46 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:347f:e607:176:4358])
        by smtp.gmail.com with ESMTPSA id w11sm16876839pfu.50.2022.02.08.11.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:43:45 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH 05/12] drm/i915: Protect lockdep functions with #ifdef
Date:   Tue,  8 Feb 2022 11:43:17 -0800
Message-Id: <20220208194324.85333-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208194324.85333-1-namhyung@kernel.org>
References: <20220208194324.85333-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With upcoming lock tracepoints config, it'd define some of lockdep
functions without enabling CONFIG_LOCKDEP actually.  The existing code
assumes those functions will be removed by the preprocessor but it's
not the case anymore.  Let's protect the code with #ifdef's explicitly.

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 drivers/gpu/drm/i915/intel_wakeref.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/intel_wakeref.c b/drivers/gpu/drm/i915/intel_wakeref.c
index dfd87d082218..6e4b8d036283 100644
--- a/drivers/gpu/drm/i915/intel_wakeref.c
+++ b/drivers/gpu/drm/i915/intel_wakeref.c
@@ -106,8 +106,11 @@ void __intel_wakeref_init(struct intel_wakeref *wf,
 	wf->wakeref = 0;
 
 	INIT_DELAYED_WORK(&wf->work, __intel_wakeref_put_work);
+
+#ifdef CONFIG_LOCKDEP
 	lockdep_init_map(&wf->work.work.lockdep_map,
 			 "wakeref.work", &key->work, 0);
+#endif
 }
 
 int intel_wakeref_wait_for_idle(struct intel_wakeref *wf)
-- 
2.35.0.263.gb82422642f-goog

