Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315D04E4908
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbiCVWRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237780AbiCVWRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:17:24 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCE7546B2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e5bcae3665so133049267b3.16
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x5KPGBSUSbYd8r6Fxn0mzFbKXE7+7xB0auo11QNIbWU=;
        b=QLdsZED2n4IqW8UKETQ8GKP2zRviwfaK8u+UJCNNX/EOS5b5PRE4DBTaE2edFLbtV7
         AJUk6+u1351fvM95T4Rk6c7p1Nm4K+AR5LoufJBbvGzLsXNQB54gQjTjBogO5ZtluMu4
         nFNONXZzu469cpjKIJiIpFauUQ1OMOgDwnyrWAO+XIVE9/y4joINUlrLxn0FkynJcX0E
         9ziIMHvJE5PaVIOOuyT8Li4D2jEuezPz3qrNgtA/e6L11x4lX2EZHY3I/niv5HuFCPq8
         xsd3+S1IIQn/oFYWLHuCbT8s4H1ADuf76irwyeDYRXa1K+R21u3EDa7geMqAkbNFlZwI
         FazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x5KPGBSUSbYd8r6Fxn0mzFbKXE7+7xB0auo11QNIbWU=;
        b=beCu3PCRVfuIlySbZCyn93Ow55lbG7C0YO/fBxGfKbld3k7XtZmVhwWhoO3bxq5euq
         svh2ianrjww7H0hOSUyaf41c3kkdNqPlLEXedi7JBvAdGbcAFclZ7xYRQg6v08EXwNvk
         JwMl/Tq0xYeUE2qHjvJBLaB0kj5pIKd7im5KTBUEESUfc/dEtfATe3Dsix2dw/URacss
         WS9ieXOFAfpO2H4F/ouy4756GVCEaO7ovekb4PUz/xHiS8sSslKBmawVqhpsIqXMECxG
         cLGp2vHmD+JD/iUztLgVCQ5u8CZYR5j1RXIU1MyFhdmnA06CliDUx9ZkqxJgkRQLOMS+
         qLYQ==
X-Gm-Message-State: AOAM533tNzFYhK9kpuAQgUKsO9GD7Paiym5OeCUquDt3T4gvmcvRluIn
        mkpCJibMOclWLtICgXPy7xupbkM7awoRLWu+bW9h7UKC0Bb0PLrMs0VkU5lotvP/eMBnnX4pE7R
        XZt5ybsPCLkOFLx+kB1aQ5Vjk/wYebmyP7dkgX8KgZxJvlgHoVA+sUwXswElZUwiWhe1G35fD
X-Google-Smtp-Source: ABdhPJzSL9g/xvSn9I3A0Fn3susXUMd/DqEzperr0Rp1LQzVJ6gC9KCObJzOOKppSekjWHIifoJvEeUd+zLZ
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:1817:acc9:c45f:d133])
 (user=eranian job=sendgmr) by 2002:a81:39d7:0:b0:2e5:2b46:1963 with SMTP id
 g206-20020a8139d7000000b002e52b461963mr31224365ywa.372.1647987345029; Tue, 22
 Mar 2022 15:15:45 -0700 (PDT)
Date:   Tue, 22 Mar 2022 15:15:12 -0700
In-Reply-To: <20220322221517.2510440-1-eranian@google.com>
Message-Id: <20220322221517.2510440-9-eranian@google.com>
Mime-Version: 1.0
References: <20220322221517.2510440-1-eranian@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v7 08/13] ACPI: add perf low power callback
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, rafael@kernel.org,
        ravi.bangoria@amd.com, sandipan.das@amd.com
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
index f8e9fa82cb9b..f83596960d9a 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -21,6 +21,7 @@
 #include <linux/cpuidle.h>
 #include <linux/cpu.h>
 #include <linux/minmax.h>
+#include <linux/perf_event.h>
 #include <acpi/processor.h>
 
 /*
@@ -549,6 +550,8 @@ static void wait_for_freeze(void)
  */
 static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
 {
+	perf_lopwr_cb(true);
+
 	if (cx->entry_method == ACPI_CSTATE_FFH) {
 		/* Call into architectural FFH based C-state */
 		acpi_processor_ffh_cstate_enter(cx);
@@ -559,6 +562,8 @@ static void __cpuidle acpi_idle_do_entry(struct acpi_processor_cx *cx)
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
2.35.1.894.gb6a874cedc-goog

