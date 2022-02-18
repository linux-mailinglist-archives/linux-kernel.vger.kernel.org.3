Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F233A4BBED7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbiBRR56 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Feb 2022 12:57:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbiBRR54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:57:56 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04F0C21B1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:57:38 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-deJtrdHpMBS6WWtPDsmWAA-1; Fri, 18 Feb 2022 12:57:23 -0500
X-MC-Unique: deJtrdHpMBS6WWtPDsmWAA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10113801AC5;
        Fri, 18 Feb 2022 17:57:22 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CC5D2BCC1;
        Fri, 18 Feb 2022 17:57:19 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 3/3] rtla/osnoise: Fix error message when failing to enable trace instance
Date:   Fri, 18 Feb 2022 18:57:09 +0100
Message-Id: <53ef0582605af91eca14b19dba9fc9febb95d4f9.1645206561.git.bristot@kernel.org>
In-Reply-To: <cover.1645206561.git.bristot@kernel.org>
References: <cover.1645206561.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
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

When a trace instance creation fails, tools are printing:

	Could not enable -> osnoiser <- tracer for tracing

Print the actual (and correct) name of the tracer it fails to enable.

Fixes: b1696371d865 ("rtla: Helper functions for rtla")
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/osnoise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 5648f9252e58..e60f1862bad0 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -810,7 +810,7 @@ struct osnoise_tool *osnoise_init_trace_tool(char *tracer)
 
 	retval = enable_tracer_by_name(trace->trace.inst, tracer);
 	if (retval) {
-		err_msg("Could not enable osnoiser tracer for tracing\n");
+		err_msg("Could not enable %s tracer for tracing\n", tracer);
 		goto out_err;
 	}
 
-- 
2.34.1

