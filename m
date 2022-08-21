Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E4A59B0F5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 02:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbiHUAI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 20:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbiHUAIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 20:08:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E6A1260E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 17:08:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6221FB80B64
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 00:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F437C43470;
        Sun, 21 Aug 2022 00:08:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oPYWC-005DkR-2k;
        Sat, 20 Aug 2022 20:08:44 -0400
Message-ID: <20220821000844.684668694@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 20 Aug 2022 20:07:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [for-linus][PATCH 02/10] tracing: React to error return from traceprobe_parse_event_name()
References: <20220821000737.328590235@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Bulwahn <lukas.bulwahn@gmail.com>

The function traceprobe_parse_event_name() may set the first two function
arguments to a non-null value and still return -EINVAL to indicate an
unsuccessful completion of the function. Hence, it is not sufficient to
just check the result of the two function arguments for being not null,
but the return value also needs to be checked.

Commit 95c104c378dc ("tracing: Auto generate event name when creating a
group of events") changed the error-return-value checking of the second
traceprobe_parse_event_name() invocation in __trace_eprobe_create() and
removed checking the return value to jump to the error handling case.

Reinstate using the return value in the error-return-value checking.

Link: https://lkml.kernel.org/r/20220811071734.20700-1-lukas.bulwahn@gmail.com

Fixes: 95c104c378dc ("tracing: Auto generate event name when creating a group of events")
Acked-by: Linyu Yuan <quic_linyyuan@quicinc.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_eprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 4a0e9d927443..550671985fd1 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -883,7 +883,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	trace_probe_log_set_index(1);
 	sys_event = argv[1];
 	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2, 0);
-	if (!sys_event || !sys_name) {
+	if (ret || !sys_event || !sys_name) {
 		trace_probe_log_err(0, NO_EVENT_INFO);
 		goto parse_error;
 	}
-- 
2.35.1
