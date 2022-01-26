Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC0849D637
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbiAZXft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbiAZXff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:35:35 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B709C061748
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:35 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e13-20020a25e70d000000b00615e9bc9a3cso2345482ybh.22
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ulMgtd6x96jG6tCfGZGL3p9K4KlDKETPTfH7yfW0hQ8=;
        b=ZGNzDExYrlSxN26l6ZApt1VHvn6A7+ousOyz1eFpPV0c98avTxfZaYwEbtoZGg/awu
         G8EsGu+2z/eE1OJT9jRsdNq3Q2ErLloyQdcJClDGoViScFvp++sWbCbY2SaD8RnRiCt0
         LCvo/C9Y13Q+OYidoMoJZdB8mSIvtlukXaaKNsw1CK4teK+ZTeSdGAmGwnYf6kJFRNnR
         05hr9au+6NsMFWIMSu9VIpt9Fk0HKW3ciGq05/y0QZ9StDVJvlmlevM6+E2LBhQWAchO
         6C8eIocT4FGZ3g1ZSOhRshzuYnA+xK4gTrCnD7j0JpMc5FSNAJwzL8FdNOAO57fNjk3B
         QygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ulMgtd6x96jG6tCfGZGL3p9K4KlDKETPTfH7yfW0hQ8=;
        b=fzatqapnpZPh3b9D4/Wb4Mjhmee2mDqpJI+FqD5CrDgYsC/E+0jmbIkW5fEYXbvZ1I
         S7hAM66T3mATwASNmma2MH7FJBeInaQrfzLs6v48feNtAVI+fjvk2+q1KFsPf7mnDpxQ
         Tecx7N29+D07fklu4ZPPRFhniaU9D9pj/lO6mJpyoNjq1AGlhuMJDLLPhCBWaMQ+R+uF
         P2dAjMpuSdzgEKbL5bNwLY1eqCye25KD2u2fztucbAgXhhHg9tcXuB6v1I+gFKkORDws
         T5IynZbFrmQ2oqcfLUoPnTvSoBRM/6x8EZVdSiUXvpVB0ZPS6OJMAA/nH3TgsdQO8Y4i
         4HsQ==
X-Gm-Message-State: AOAM53283hfiwHUs4Du/cSOHh8NWLd3CAnvemIZAJ2SUXPx+VXMvDAqg
        BnsNHWDx/be6D1wfLhEAYdp6/DzFWgzpS+XNUXeVKgAajVJm5+AGmfk9ahOaLYoefjKfh+I1ZuA
        pv6zFDx9cFQ2zuLsZm7Rx7oluWnKpdLFKqM7Z8yjVgHlHVQPJQcRoFvmlm31+cda3+unkRfyy
X-Google-Smtp-Source: ABdhPJw59Kp9P+RuhMIEDLLIWDnBge5WSuJZQvgW12qtYsS9k89ZQzkc0dnQD46CB2d280Mp6tzgL+jUe2p9
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:9ce0:6f20:c145:eac])
 (user=eranian job=sendgmr) by 2002:a81:d24a:: with SMTP id
 m10mr0ywl.312.1643240133655; Wed, 26 Jan 2022 15:35:33 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:34:49 -0800
In-Reply-To: <20220126233454.3362047-1-eranian@google.com>
Message-Id: <20220126233454.3362047-9-eranian@google.com>
Mime-Version: 1.0
References: <20220126233454.3362047-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v5 08/13] ACPI: add perf low power callback
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add an optional callback needed by some PMU features, e.g., AMD
BRS, to give a chance to the perf_events code to change its state before
going to low power and after coming back.

The callback is void when the PERF_NEEDS_LOPWR_CB flag is not set.
This flag must be set in arch specific perf_event.h header whenever needed.
When not set, there is no impact of the ACPI code.

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
2.35.0.rc0.227.g00780c9af4-goog

