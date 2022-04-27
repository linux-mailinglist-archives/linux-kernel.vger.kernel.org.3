Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A0A5122E6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbiD0TlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiD0Tj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:39:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7DD1096
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11D7B60E06
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8276EC385AF;
        Wed, 27 Apr 2022 19:36:43 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1njnSs-002Ix7-IZ;
        Wed, 27 Apr 2022 15:36:42 -0400
Message-ID: <20220427193642.410340843@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Apr 2022 15:36:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [for-next][PATCH 16/21] tracing: Change `if (strlen(glob))` to `if (glob[0])`
References: <20220427193623.529296556@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

No need to traverse to the end of string. If the first byte is not a NUL
char, it's guaranteed `if (strlen(glob))` is true.

Link: https://lkml.kernel.org/r/20220417185630.199062-3-ammarfaizi2@gnuweeb.org

Cc: Ingo Molnar <mingo@redhat.com>
Cc: GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 80c25be23c45..fe10179893c1 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6217,7 +6217,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	if (WARN_ON(!glob))
 		return -EINVAL;
 
-	if (strlen(glob)) {
+	if (glob[0]) {
 		hist_err_clear();
 		last_cmd_set(file, param_and_filter);
 	}
-- 
2.35.1
