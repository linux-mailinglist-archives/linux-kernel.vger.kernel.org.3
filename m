Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02C1470C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344354AbhLJVGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344323AbhLJVGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:06:42 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF12DC061353
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:03:06 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t184-20020a2546c1000000b006008b13c80bso18571715yba.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7mohhJk4K3oq5d4zUtPYx/EbSCXTGh8DchcmBcLiDRA=;
        b=hhtYgjy6mfLnYc5lQGvK05AvEsrWKCn788H1MbNRvSos716fh/drCl8vKg5WfRIv6u
         jwTb1wZfrJidid1lrtlXMzIf5seQHB24iYpRZ82bc/tP3pg8lCHmfozula60AK9jnyQc
         QqddWbSDs9sWvnPy121lE25tLNkUAveQcKgS1sepqUQDPeE3CzZk7TqTWuQMCQWtkCPb
         l8k8dZ+Y0kd3bycyv/2D+dH8tW9F8txXJN97P/FSARhUNNG5QO86S0Grgad4J3i9gvpi
         ur7Mb1ndn85bTad9iaHPN5sAYBVesyuw4iRMZLA7L+kYezmVlSXa8jUF6CSBdN70dCRX
         pIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7mohhJk4K3oq5d4zUtPYx/EbSCXTGh8DchcmBcLiDRA=;
        b=GnlnkoZqxkzYG23DzY3g5uUHyX2Oo9OoRFdhNEt1xVGeslP0CQkf7RNy4x4fv5h1LA
         0b7tzsHKyqBgM0gbdSOfRqw9rw0UygO/bcdquVlMx4IrlmQZoVOwWev1o7bC7bBF7xFc
         QYpTcKmLngpDsRe0yYF7AooyIA/2+DbfbmxXdXtxczB9kAZruj2tnvs6E7c+USz9/92G
         J++lxncLeF89Z6jHt4IkjEev8yzzCDm0VFd+cGRIgx5tFQNHdiRUlhmceOZxk10rHd5Y
         /MHZnKAx5nJV0vc9lTcwgP0E9ud3bYQ7W5jyaS5knj9P/CiuAu3TnK5mC9xUXGcPW47j
         CuKg==
X-Gm-Message-State: AOAM530MfqXtRdM25tdBzsiMIY/IiNr2NaUIjYmzbbsWfcx+M6t3HAsj
        bxkCr4/9r2Co6RkmqnEgKYxkdgz4qU1Bw9SQAawYZkIOx1tloIAf26pETJm4L9gAeRkr5jS+jY9
        pPHLawfvbAcBKc8CsnI4q4VLZez3iNKs67/IBbOKLbSwnOJVOtKnMi8wGUwdDGxE1rbDUOpSX
X-Google-Smtp-Source: ABdhPJxermeap/36DshdR78gygYjouBHpF2tbH4E+RjOwZdcQIXmJHz+lWP628Xe2AHyKzMu8SYbtNwDXKph
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:7416:17a6:6678:d4d5])
 (user=eranian job=sendgmr) by 2002:a05:6902:1144:: with SMTP id
 p4mr18155659ybu.189.1639170186073; Fri, 10 Dec 2021 13:03:06 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:02:23 -0800
In-Reply-To: <20211210210229.2991238-1-eranian@google.com>
Message-Id: <20211210210229.2991238-9-eranian@google.com>
Mime-Version: 1.0
References: <20211210210229.2991238-1-eranian@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 08/14] ACPI: add perf low power callback
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
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
index 76ef1bcc8848..7a3a613ae5ed 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -20,6 +20,7 @@
 #include <linux/tick.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu.h>
+#include <linux/perf_event.h>
 #include <acpi/processor.h>
 
 /*
@@ -546,6 +547,8 @@ static void wait_for_freeze(void)
  */
 static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
 {
+	perf_lopwr_cb(true);
+
 	if (cx->entry_method == ACPI_CSTATE_FFH) {
 		/* Call into architectural FFH based C-state */
 		acpi_processor_ffh_cstate_enter(cx);
@@ -556,6 +559,8 @@ static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
 		inb(cx->address);
 		wait_for_freeze();
 	}
+
+	perf_lopwr_cb(false);
 }
 
 /**
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index bbe02c80244b..f9760873e145 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1674,4 +1674,10 @@ typedef int (perf_snapshot_branch_stack_t)(struct perf_branch_entry *entries,
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
2.34.1.173.g76aa8bc2d0-goog

