Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0A04809D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhL1OHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:07:39 -0500
Received: from relay.sw.ru ([185.231.240.75]:59172 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231987AbhL1OHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
        Content-Type; bh=tx47HFzMlsEhwc6zti0sz/0X7l005/6uh3l5wRLtXWg=; b=oZkQvaGH/jay
        JAS9vqBI3FaggDok4m3QdCR4JB/d2yEcYDFFQrrM2En4yxYgmG/sa9HoZfZqcbhOb/wiM17HGQanm
        XKTRlT94vVDwO0hfCxVruttQW0bxa04zIrckmcjrscedH2IM4dyv8fGdVGSalFmKFYrfYWNMTBods
        p2Zus=;
Received: from [192.168.15.33] (helo=cobook.home)
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <nikita.yushchenko@virtuozzo.com>)
        id 1n2D8U-004nv0-M3; Tue, 28 Dec 2021 17:07:30 +0300
From:   Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: [PATCH] trace/osnoise: fix event unhooking
Date:   Tue, 28 Dec 2021 17:07:27 +0300
Message-Id: <20211228140727.2467771-1-nikita.yushchenko@virtuozzo.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If start_per_cpu_kthreads() called from osnoise_workload_start() returns
error, event hooks are left in broken state: unhook_irq_events() called
but unhook_thread_events() and unhook_softirq_events() not called, and
trace_osnoise_callback_enabled flag not cleared.

On the next tracer enable, hooks get not installed due to
trace_osnoise_callback_enabled flag.

And on the further tracer disable an attempt to remove non-installed
hooks happened, hitting a WARN_ON_ONCE() in tracepoint_remove_func().

Fix the error path by adding the missing part of cleanup.
While at this, introduce osnoise_unhook_events() to avoid code
duplication between this error path and notmal tracer disable.

Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
---
 kernel/trace/trace_osnoise.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 7520d43aed55..aa6f26612ccc 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2123,6 +2123,13 @@ static int osnoise_hook_events(void)
 	return -EINVAL;
 }
 
+static void osnoise_unhook_events(void)
+{
+	unhook_thread_events();
+	unhook_softirq_events();
+	unhook_irq_events();
+}
+
 /*
  * osnoise_workload_start - start the workload and hook to events
  */
@@ -2155,7 +2162,8 @@ static int osnoise_workload_start(void)
 
 	retval = start_per_cpu_kthreads();
 	if (retval) {
-		unhook_irq_events();
+		trace_osnoise_callback_enabled = false;
+		osnoise_unhook_events();
 		return retval;
 	}
 
@@ -2186,9 +2194,7 @@ static void osnoise_workload_stop(void)
 
 	stop_per_cpu_kthreads();
 
-	unhook_irq_events();
-	unhook_softirq_events();
-	unhook_thread_events();
+	osnoise_unhook_events();
 }
 
 static void osnoise_tracer_start(struct trace_array *tr)
-- 
2.30.2

