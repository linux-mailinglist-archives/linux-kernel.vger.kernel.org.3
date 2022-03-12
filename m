Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974C94D7182
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 00:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiCLX1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 18:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiCLX1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 18:27:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358699398A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 15:25:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A144B80B36
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 23:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36D0C340F6;
        Sat, 12 Mar 2022 23:25:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nTB7P-000WhR-NR;
        Sat, 12 Mar 2022 18:25:51 -0500
Message-ID: <20220312232551.559953567@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 12 Mar 2022 18:25:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 09/12] tracing: Fix strncpy warning in trace_events_synth.c
References: <20220312232525.234705244@goodmis.org>
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

From: Tom Zanussi <zanussi@kernel.org>

0-day reported the strncpy error below:

../kernel/trace/trace_events_synth.c: In function 'last_cmd_set':
../kernel/trace/trace_events_synth.c:65:9: warning: 'strncpy' specified bound depends on the length o\
f the source argument [-Wstringop-truncation]
   65 |         strncpy(last_cmd, str, strlen(str) + 1);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../kernel/trace/trace_events_synth.c:65:32: note: length computed here
   65 |         strncpy(last_cmd, str, strlen(str) + 1);
      |                                ^~~~~~~~~~~

There's no reason to use strncpy here, in fact there's no reason to do
anything but a simple kstrdup() (note we don't even need to check for
failure since last_cmod is expected to be either the last cmd string
or NULL, and the containing function is a void return).

Link: https://lkml.kernel.org/r/77deca8cbfd226981b3f1eab203967381e9b5bd9.camel@kernel.org

Fixes: 27c888da9867 ("tracing: Remove size restriction on synthetic event cmd error logging")

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index fdd79e07e2fc..5e8c07aef071 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -58,11 +58,8 @@ static void last_cmd_set(const char *str)
 		return;
 
 	kfree(last_cmd);
-	last_cmd = kzalloc(strlen(str) + 1, GFP_KERNEL);
-	if (!last_cmd)
-		return;
 
-	strncpy(last_cmd, str, strlen(str) + 1);
+	last_cmd = kstrdup(str, GFP_KERNEL);
 }
 
 static void synth_err(u8 err_type, u16 err_pos)
-- 
2.35.1
