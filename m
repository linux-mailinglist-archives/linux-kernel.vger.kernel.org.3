Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95177575346
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbiGNQpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbiGNQnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:43:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1308F6300
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:43:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1159662060
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76765C34114;
        Thu, 14 Jul 2022 16:43:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1oC1w3-004lVN-J9;
        Thu, 14 Jul 2022 12:43:31 -0400
Message-ID: <20220714164331.428296150@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 14 Jul 2022 12:43:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [for-next][PATCH 19/23] tracing: eprobe: Add missing log index
References: <20220714164256.403842845@goodmis.org>
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

From: Linyu Yuan <quic_linyyuan@quicinc.com>

Add trace_probe_log_set_index(1) to allow report correct error
if user input wrong SYSTEM.EVENT format.

Link: https://lore.kernel.org/all/1656296348-16111-2-git-send-email-quic_linyyuan@quicinc.com/

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_eprobe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 7d4478525c66..b805b570305f 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -881,6 +881,7 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	if (!is_good_name(event) || !is_good_name(group))
 		goto parse_error;
 
+	trace_probe_log_set_index(1);
 	sys_event = argv[1];
 	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2,
 					  sys_event - argv[1]);
-- 
2.35.1
