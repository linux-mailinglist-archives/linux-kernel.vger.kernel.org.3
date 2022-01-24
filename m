Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973BD498213
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbiAXO0h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jan 2022 09:26:37 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:41288 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238202AbiAXOYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:24:41 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-Lu2NlBYqOpiVgmCEFu51BA-1; Mon, 24 Jan 2022 09:24:37 -0500
X-MC-Unique: Lu2NlBYqOpiVgmCEFu51BA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F201F1923B85;
        Mon, 24 Jan 2022 14:24:35 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82BD5798B2;
        Mon, 24 Jan 2022 14:24:34 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 7/8] rtla/osnoise: Fix error message when failing to enable trace instance
Date:   Mon, 24 Jan 2022 15:24:10 +0100
Message-Id: <c2a20c84d63092e685af9649f9b7656c3ecd1c90.1643033113.git.bristot@kernel.org>
In-Reply-To: <cover.1643033113.git.bristot@kernel.org>
References: <cover.1643033113.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a trace instance creation fails, tools are printing:

	Could not enable -> osnoiser <- tracer for tracing

Print the actual (and correct) name of the tracer it fails to enable.

Fixes: b1696371d865 ("rtla: Helper functions for rtla")
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/osnoise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 7b73d1eccd0e..c1368315d508 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -807,7 +807,7 @@ struct osnoise_tool *osnoise_init_trace_tool(char *tracer)
 
 	retval = enable_tracer_by_name(trace->trace.inst, tracer);
 	if (retval) {
-		err_msg("Could not enable osnoiser tracer for tracing\n");
+		err_msg("Could not enable %s tracer for tracing\n", tracer);
 		goto out_err;
 	}
 
-- 
2.34.1

