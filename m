Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C5157533C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbiGNQoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiGNQnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:43:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F831F9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:43:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14976B82734
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0332C341C6;
        Thu, 14 Jul 2022 16:43:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1oC1w3-004lVx-P0;
        Thu, 14 Jul 2022 12:43:31 -0400
Message-ID: <20220714164331.609693610@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 14 Jul 2022 12:43:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [for-next][PATCH 20/23] tracing: eprobe: Remove duplicate is_good_name() operation
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

traceprobe_parse_event_name() already validate SYSTEM and EVENT name,
there is no need to call is_good_name() after it.

Link: https://lore.kernel.org/all/1656296348-16111-3-git-send-email-quic_linyyuan@quicinc.com/

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_eprobe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index b805b570305f..8979cb9ec37a 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -887,8 +887,6 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 					  sys_event - argv[1]);
 	if (ret || !sys_name)
 		goto parse_error;
-	if (!is_good_name(sys_event) || !is_good_name(sys_name))
-		goto parse_error;
 
 	mutex_lock(&event_mutex);
 	event_call = find_and_get_event(sys_name, sys_event);
-- 
2.35.1
