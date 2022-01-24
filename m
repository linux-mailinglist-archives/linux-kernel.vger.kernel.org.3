Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59173498205
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbiAXOYv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jan 2022 09:24:51 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:38885 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237825AbiAXOYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:24:35 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-VUguLINpPQqnkC_q7BEGoA-1; Mon, 24 Jan 2022 09:24:33 -0500
X-MC-Unique: VUguLINpPQqnkC_q7BEGoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 960D51091DA2;
        Mon, 24 Jan 2022 14:24:32 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40843798B2;
        Mon, 24 Jan 2022 14:24:31 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 5/8] rtla/timerlat_top: Fix segmentation fault when failing to enable -t
Date:   Mon, 24 Jan 2022 15:24:08 +0100
Message-Id: <2fea7678dda97e09ef80fd5775abf51fc105a857.1643033113.git.bristot@kernel.org>
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

rtla timerlat top is causing a segmentation fault when running with
the --trace option on a kernel that does not support multiple
instances. For example:

    [root@f34 rtla]# rtla timerlat top -t
    failed to enable the tracer timerlat
    Could not enable osnoiser tracer for tracing
    Failed to enable the trace instance
    Segmentation fault (core dumped)

This error happens because the exit code of the tools is trying
to destroy the trace instance that failed to be created.

Rearrange the order in which trace instances are destroyed to avoid
this problem.

Fixes: a828cd18bc4a ("rtla: Add timerlat tool and timelart top mode")
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/timerlat_top.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 1ebd5291539c..323fd1f88313 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -584,7 +584,7 @@ int timerlat_top_main(int argc, char *argv[])
 						    trace);
 		if (retval < 0) {
 			err_msg("Error iterating on events\n");
-			goto out_top;
+			goto out_trace;
 		}
 
 		if (!params->quiet)
@@ -606,12 +606,12 @@ int timerlat_top_main(int argc, char *argv[])
 			save_trace_to_file(record->trace.inst, params->trace_output);
 		}
 	}
-
+out_trace:
+	if (params->trace_output)
+		osnoise_destroy_tool(record);
 out_top:
 	timerlat_free_top(top->data);
 	osnoise_destroy_tool(top);
-	if (params->trace_output)
-		osnoise_destroy_tool(record);
 	free(params);
 out_exit:
 	exit(return_value);
-- 
2.34.1

