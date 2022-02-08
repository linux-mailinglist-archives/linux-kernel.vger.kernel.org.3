Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3570A4AE4A6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387929AbiBHWb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386858AbiBHVRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:17:14 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24FDC0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:17:13 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s73-20020a25aa4f000000b0061d764d3c13so453028ybi.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4dR1yNXtmyr78XdAPm6ZMGJLtvP6soDdLw1TSPN/FsI=;
        b=Lrj1tvUasnQmtz5WlTQQZ+9yjaP4dfMnodiJ+cdc9TVnGgD+jiZkyTV1ILXS7CXJ2n
         2JW9VQmmg2xrspIg+IA9NKrIVZ3S8MvlVjsxcipXTlz4M/sDb9vFKioxlrQLh3ujav47
         bA4YWHFqx3mNZodX4jPA3QenKxCjrEci+xMD+soLPt51+d9r/v3BrtapNaI14XjX9W0s
         C9gYXs1pQuq5m3CWtnw+ENKZVFu3FCQpr8mMsfpqw5TdtPLZkxCEKQDD6BJU3KuIpJiX
         0zV6Zlj6C7ii79ob9tsAVzCJ7M8bmNP1JDhfW0TwQb/NiFYQewuwEHMZRi/QqycTh3L7
         eAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4dR1yNXtmyr78XdAPm6ZMGJLtvP6soDdLw1TSPN/FsI=;
        b=bckyKYRlEcSpzxl9R8OR+CQfGNaCpWQofRi/NA1eowDB0wzjOxoqkxQPtsMC8ReX1P
         bsvIQ68nK2QME8SsjGqwZgs3Sil4xuSdFwa6poIYx+JIZcKwC1k901iQeXxd5K2VMo6e
         34Csq8XwfC34Xk+Yi3yFvRyj/YSiq+T574NPMQbVBWOoVKP1/51Yg/YxkEJXb+JnWi1T
         FYb1VRG0MFMgfFC/f8y7qXi989fnAmOOfLWNBnwja3Em3mh1DZNni4NDViwYhH3GgSdD
         hb34cBaX+j3wAFawMVyXZSfUcJjeyHG2dPOiL4r0VfNg9stIoXkQzSdGvMYWGZ20Wok/
         3NJA==
X-Gm-Message-State: AOAM533Wo3g8t9vSEYinCb9VgQvNDzA5vOZT/6bk0Rn9Tw5GVgoEGF6B
        DnIclOEbdMIZU4oCwp21ZjvEmB4rtsa9n4jxsauNBs0MXT0UQ45R2ya3m4RtCnvl2PlGZP9s2n9
        AA4pyS97TRodCW9xDzffc3yioDdhKflwapwk8fEXCqhOoHQpef/GYNkDr350eXRoSVSQALUZ5
X-Google-Smtp-Source: ABdhPJyl9fK0SIMuiVRlhtI77KWnRTLqUU5cOlzF7J9P/p0y4WhEaMJnqOPrg56OWApJUCep4obNtjt/2ZgM
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:6875:3c51:69be:6e2c])
 (user=eranian job=sendgmr) by 2002:a25:c5c4:: with SMTP id
 v187mr6638764ybe.643.1644355032864; Tue, 08 Feb 2022 13:17:12 -0800 (PST)
Date:   Tue,  8 Feb 2022 13:16:33 -0800
In-Reply-To: <20220208211637.2221872-1-eranian@google.com>
Message-Id: <20220208211637.2221872-9-eranian@google.com>
Mime-Version: 1.0
References: <20220208211637.2221872-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 08/12] ACPI: add perf low power callback
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
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

Add an optional callback needed by some PMU features, e.g., AMD
BRS, to give a chance to the perf_events code to change its state before
a CPU goes to low power and after it comes back.

The callback is void when the PERF_NEEDS_LOPWR_CB flag is not set.
This flag must be set in arch specific perf_event.h header whenever needed.
When not set, there is no impact on the ACPI code.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 drivers/acpi/acpi_pad.c       | 6 ++++++
 drivers/acpi/processor_idle.c | 5 +++++
 include/linux/perf_event.h    | 6 ++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index f45979aa2d64..a306a07a60b5 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -164,6 +164,9 @@ static int power_saving_thread(void *data)
 				tsc_marked_unstable = 1;
 			}
 			local_irq_disable();
+
+			perf_lopwr_cb(true);
+
 			tick_broadcast_enable();
 			tick_broadcast_enter();
 			stop_critical_timings();
@@ -172,6 +175,9 @@ static int power_saving_thread(void *data)
 
 			start_critical_timings();
 			tick_broadcast_exit();
+
+			perf_lopwr_cb(false);
+
 			local_irq_enable();
 
 			if (time_before(expire_time, jiffies)) {
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 86560a28751b..880c0a43a529 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -21,6 +21,7 @@
 #include <linux/cpuidle.h>
 #include <linux/cpu.h>
 #include <linux/minmax.h>
+#include <linux/perf_event.h>
 #include <acpi/processor.h>
 
 /*
@@ -544,6 +545,8 @@ static void wait_for_freeze(void)
  */
 static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
 {
+	perf_lopwr_cb(true);
+
 	if (cx->entry_method == ACPI_CSTATE_FFH) {
 		/* Call into architectural FFH based C-state */
 		acpi_processor_ffh_cstate_enter(cx);
@@ -554,6 +557,8 @@ static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
 		inb(cx->address);
 		wait_for_freeze();
 	}
+
+	perf_lopwr_cb(false);
 }
 
 /**
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 496eb6aa6e54..1b98e46588bc 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1676,4 +1676,10 @@ typedef int (perf_snapshot_branch_stack_t)(struct perf_branch_entry *entries,
 					   unsigned int cnt);
 DECLARE_STATIC_CALL(perf_snapshot_branch_stack, perf_snapshot_branch_stack_t);
 
+#ifndef PERF_NEEDS_LOPWR_CB
+static inline void perf_lopwr_cb(bool mode)
+{
+}
+#endif
+
 #endif /* _LINUX_PERF_EVENT_H */
-- 
2.35.0.263.gb82422642f-goog

