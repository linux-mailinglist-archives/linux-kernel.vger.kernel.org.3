Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23AF4D2FC2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbiCINOS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Mar 2022 08:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbiCINOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:14:17 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ACA310A7D1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:13:18 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-ySWuyVfmPTaf810awxiH3A-1; Wed, 09 Mar 2022 08:13:14 -0500
X-MC-Unique: ySWuyVfmPTaf810awxiH3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB66151DC;
        Wed,  9 Mar 2022 13:13:12 +0000 (UTC)
Received: from x1.com (unknown [10.22.8.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E77D22E11;
        Wed,  9 Mar 2022 13:13:05 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH] tracing/osnoise: Do not unregister events twice
Date:   Wed,  9 Mar 2022 14:13:02 +0100
Message-Id: <938765e17d5a781c2df429a98f0b2e7cc317b022.1646823913.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas reported that using:

 # trace-cmd record -e all -M 10 -p osnoise --poll

Resulted in the following kernel warning:

 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 1217 at kernel/tracepoint.c:404 tracepoint_probe_unregister+0x280/0x370
 [...]
 CPU: 0 PID: 1217 Comm: trace-cmd Not tainted 5.17.0-rc6-next-20220307-nico+ #19
 RIP: 0010:tracepoint_probe_unregister+0x280/0x370
 [...]
 CR2: 00007ff919b29497 CR3: 0000000109da4005 CR4: 0000000000170ef0
 Call Trace:
  <TASK>
  osnoise_workload_stop+0x36/0x90
  tracing_set_tracer+0x108/0x260
  tracing_set_trace_write+0x94/0xd0
  ? __check_object_size.part.0+0x10a/0x150
  ? selinux_file_permission+0x104/0x150
  vfs_write+0xb5/0x290
  ksys_write+0x5f/0xe0
  do_syscall_64+0x3b/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae
 RIP: 0033:0x7ff919a18127
 [...]
 ---[ end trace 0000000000000000 ]---

The warning complains about an attempt to unregister an
unregistered tracepoint.

This happens on trace-cmd because it first stops tracing, and
then switches the tracer to nop. Which is equivalent to:

  # cd /sys/kernel/tracing/
  # echo osnoise > current_tracer
  # echo 0 > tracing_on
  # echo nop > current_tracer

The osnoise tracer stops the workload when no trace instance
is actually collecting data. This can be caused both by
disabling tracing or disabling the tracer itself.

To avoid unregistering events twice, use the existing
trace_osnoise_callback_enabled variable to check if the events
(and the workload) are actually active before trying to
deactivate them.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Fixes: 2fac8d6486d5 ("tracing/osnoise: Allow multiple instances of the same tracer")
Reported-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/trace_osnoise.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index cfddb30e65ab..c9eb5001e5cb 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2200,6 +2200,17 @@ static void osnoise_workload_stop(void)
 	if (osnoise_has_registered_instances())
 		return;
 
+	/*
+	 * If callbacks were already disabled in a previous stop
+	 * call, there is no need to disable then again.
+	 *
+	 * For instance, this happens when tracing is stopped via:
+	 * echo 0 > tracing_on
+	 * echo nop > current_tracer.
+	 */
+	if (!trace_osnoise_callback_enabled)
+		return;
+
 	trace_osnoise_callback_enabled = false;
 	/*
 	 * Make sure that ftrace_nmi_enter/exit() see
-- 
2.34.1

