Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BE94A9CE9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 17:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376605AbiBDQYf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Feb 2022 11:24:35 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:29567 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376564AbiBDQYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 11:24:23 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-rV3NRtUVMxaCyBGTewz_8A-1; Fri, 04 Feb 2022 11:24:19 -0500
X-MC-Unique: rV3NRtUVMxaCyBGTewz_8A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF53C1853026;
        Fri,  4 Feb 2022 16:24:18 +0000 (UTC)
Received: from x1.com (unknown [10.22.33.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7C8B7E91E;
        Fri,  4 Feb 2022 16:24:17 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 4/4] rtla/osnoise: Fix segmentation fault when failing to enable -t
Date:   Fri,  4 Feb 2022 17:24:05 +0100
Message-Id: <264ff7941b7551ec0b6e5862e40cf3dd593d0ff0.1643990447.git.bristot@kernel.org>
In-Reply-To: <cover.1643990447.git.bristot@kernel.org>
References: <cover.1643990447.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtla osnoise and timerlat are causing a segmentation fault when running
with the --trace option on a kernel that does not support multiple
instances. For example:

    [root@f34 rtla]# rtla osnoise top -t
    failed to enable the tracer osnoise
    Could not enable osnoiser tracer for tracing
    Failed to enable the trace instance
    Segmentation fault (core dumped)

This error happens because the exit code of the tools is trying
to destroy the trace instance that failed to be created.

Make osnoise_destroy_tool() aware of possible NULL osnoise_tool *,
and do not attempt to destroy it.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Fixes: 1eceb2fc2ca5 ("rtla/osnoise: Add osnoise top mode")
Fixes: 829a6c0b5698 ("rtla/osnoise: Add the hist mode")
Fixes: a828cd18bc4a ("rtla: Add timerlat tool and timelart top mode")
Fixes: 1eeb6328e8b3 ("rtla/timerlat: Add timerlat hist mode")
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/osnoise.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 7b73d1eccd0e..5648f9252e58 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -750,6 +750,9 @@ void osnoise_put_context(struct osnoise_context *context)
  */
 void osnoise_destroy_tool(struct osnoise_tool *top)
 {
+	if (!top)
+		return;
+
 	trace_instance_destroy(&top->trace);
 
 	if (top->context)
-- 
2.34.1

