Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624604667CA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359416AbhLBQ1c convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Dec 2021 11:27:32 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:36393 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347508AbhLBQ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:27:30 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-174-H7VfKqQXPsiGYL21N65XZA-1; Thu, 02 Dec 2021 11:24:04 -0500
X-MC-Unique: H7VfKqQXPsiGYL21N65XZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5853839384;
        Thu,  2 Dec 2021 16:24:03 +0000 (UTC)
Received: from x1.com (unknown [10.22.33.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6704F10016F4;
        Thu,  2 Dec 2021 16:23:58 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: tracing/osnoise: Make local variables static
Date:   Thu,  2 Dec 2021 17:23:49 +0100
Message-Id: <15da91ddf7e9883fb717e1cd213f7dd1fe46d14e.1638461649.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> is reporting some local variables not
declared as static on trace_osnoise.c.

Make these variables static.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/trace_osnoise.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 7520d43aed55..fe24e9e38be9 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -197,7 +197,7 @@ struct osnoise_variables {
 /*
  * Per-cpu runtime information.
  */
-DEFINE_PER_CPU(struct osnoise_variables, per_cpu_osnoise_var);
+static DEFINE_PER_CPU(struct osnoise_variables, per_cpu_osnoise_var);
 
 /*
  * this_cpu_osn_var - Return the per-cpu osnoise_variables on its relative CPU
@@ -220,7 +220,7 @@ struct timerlat_variables {
 	u64			count;
 };
 
-DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
+static DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
 
 /*
  * this_cpu_tmr_var - Return the per-cpu timerlat_variables on its relative CPU
@@ -312,7 +312,7 @@ struct timerlat_sample {
 /*
  * Protect the interface.
  */
-struct mutex interface_lock;
+static struct mutex interface_lock;
 
 /*
  * Tracer data.
@@ -1977,8 +1977,8 @@ static struct trace_min_max_param osnoise_print_stack = {
 /*
  * osnoise/timerlat_period: min 100 us, max 1 s
  */
-u64 timerlat_min_period = 100;
-u64 timerlat_max_period = 1000000;
+static u64 timerlat_min_period = 100;
+static u64 timerlat_max_period = 1000000;
 static struct trace_min_max_param timerlat_period = {
 	.lock	= &interface_lock,
 	.val	= &osnoise_data.timerlat_period,
-- 
2.31.1

