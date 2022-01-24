Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB20498207
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbiAXOY5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jan 2022 09:24:57 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:20616 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238111AbiAXOYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:24:39 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-RsgB6JPWNyKzfZgGuJqN6g-1; Mon, 24 Jan 2022 09:24:35 -0500
X-MC-Unique: RsgB6JPWNyKzfZgGuJqN6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23ED41923B80;
        Mon, 24 Jan 2022 14:24:34 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00925798B2;
        Mon, 24 Jan 2022 14:24:32 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 6/8] rtla/timerlat_hist: Fix segmentation fault when failing to enable -t
Date:   Mon, 24 Jan 2022 15:24:09 +0100
Message-Id: <78b201bfbeabdb8c55fcd51d76e0475c437175ed.1643033113.git.bristot@kernel.org>
In-Reply-To: <cover.1643033113.git.bristot@kernel.org>
References: <cover.1643033113.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtla timerlat hist is causing a segmentation fault when running with
the --trace option on a kernel that does not support multiple
instances. For example:

    [root@f34 rtla]# rtla timerlat hist -t
    failed to enable the tracer timerlat
    Could not enable osnoiser tracer for tracing
    Failed to enable the trace instance
    Segmentation fault (core dumped)

This error happens because the exit code of the tools is trying
to destroy the trace instance that failed to be created.

Rearrange the order in which trace instances are destroyed to avoid
this problem.

Fixes: (1eeb6328e8b3 "rtla/timerlat: Add timerlat hist mode")
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/timerlat_hist.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 235f9620ef3d..74ccb6351ad2 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -792,7 +792,7 @@ int timerlat_hist_main(int argc, char *argv[])
 						    trace);
 		if (retval < 0) {
 			err_msg("Error iterating on events\n");
-			goto out_hist;
+			goto out_trace;
 		}
 
 		if (!tracefs_trace_is_on(trace->inst))
@@ -811,11 +811,12 @@ int timerlat_hist_main(int argc, char *argv[])
 		}
 	}
 
+out_trace:
+	if (params->trace_output)
+		osnoise_destroy_tool(record);
 out_hist:
 	timerlat_free_histogram(tool->data);
 	osnoise_destroy_tool(tool);
-	if (params->trace_output)
-		osnoise_destroy_tool(record);
 	free(params);
 out_exit:
 	exit(return_value);
-- 
2.34.1

