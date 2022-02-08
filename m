Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617374AE11B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385232AbiBHSmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385162AbiBHSm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:42:26 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25001C0611DA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:42:24 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m7so57845pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sJjbNLxKnq2MLHtlOHVGr5cmsCqOoxOU5S439s399rs=;
        b=mP+JA2jOmXnN0QJajfkIUt/2J+YY274d73Tpsayrg0OPhRz09HHxfcvuU3B3mwiqnY
         hzY0Lbl2ZeFudSA8gidRqmKkzOBsskPWAA95Zhxz8AtGg7QzLr/mkOq6pIW/roTuds6T
         RD8W3Hr++o41fiElpLT3ULAynuFkC4d6yBwqaZvLGC9j+mi5ijc3EeXbJLUotnx9rN39
         HARmHpca2ynWd/QIQHy20dDcT4nFTlWV+f9iNzfI+mRidIjU2ZEa1iTlRQilY+y877y9
         i75AiuaSyy8HT1tgf4RtYq2nyiarZfbhBBea1TzXMYz7ONYn80/FFFIyDt9ns+5pFD0M
         /PlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sJjbNLxKnq2MLHtlOHVGr5cmsCqOoxOU5S439s399rs=;
        b=rMHwDzSk51n4xwP6B06IAZwLSnMAShJdqjh9BrDhEF+TxS5ocsSrF/dQv/Hi8a/0f1
         AtFmY4ovbwc7za/L0731kEjlcL5PPhjoc/0/xJsF+rdiP/PduZNQzdFTXR+b902Higi4
         dio0cD6zqb5naU03pbqr0n0T/yR00BM2KMZK88ax3W3PTreTuNdV2wongevQG0kkTOP3
         OpJoeXmyGmxSd+VAUaEJ0yvQg8b4T2vvDZNidDt35J3dS35S5OrLDQjoOZxKOycq3qXI
         PDvA78i6tWISa5QzA2mMOpQGsWaFK5m6iloUDbnXhX3ZFNdKqYzv3qJaQCN9jRFQ03LG
         apoA==
X-Gm-Message-State: AOAM5336klqFd6X4SDdhKuiFDTvh6bUYjHpH260x4OLVkH6XOg/+ujBh
        O4evhTGIwGarbsy4ixKz4A8=
X-Google-Smtp-Source: ABdhPJzBjlE3rwJV9oAI24HmL30J4frNkDJPBvRKrr6l9+m4t4xU0yXmOxL4eqLQrp0Uc4O4QKknBA==
X-Received: by 2002:a17:902:e74e:: with SMTP id p14mr5639468plf.95.1644345743659;
        Tue, 08 Feb 2022 10:42:23 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:347f:e607:176:4358])
        by smtp.gmail.com with ESMTPSA id l14sm3517027pjf.1.2022.02.08.10.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:42:23 -0800 (PST)
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
        "Paul E. McKenney" <paul.mckenney@linaro.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH 05/12] drm/i915: Protect lockdep functions with #ifdef
Date:   Tue,  8 Feb 2022 10:42:01 -0800
Message-Id: <20220208184208.79303-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208184208.79303-1-namhyung@kernel.org>
References: <20220208184208.79303-1-namhyung@kernel.org>
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

