Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A999536A4D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 04:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355643AbiE1CxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 22:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353003AbiE1Cwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 22:52:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81B712E301
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 19:52:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20E8961D2F
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 02:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84434C3411E;
        Sat, 28 May 2022 02:52:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1numZN-000LM5-I3;
        Fri, 27 May 2022 22:52:49 -0400
Message-ID: <20220528025249.397616848@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 27 May 2022 22:50:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [for-next][PATCH 04/23] ftrace: Deal with error return code of the ftrace_process_locs()
 function
References: <20220528025028.850906216@goodmis.org>
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

From: Yuntao Wang <ytcoode@gmail.com>

The ftrace_process_locs() function may return -ENOMEM error code, which
should be handled by the callers.

Link: https://lkml.kernel.org/r/20220120065949.1813231-1-ytcoode@gmail.com

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 6c5b12669e06..737e895e2aad 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6864,11 +6864,16 @@ void ftrace_module_enable(struct module *mod)
 
 void ftrace_module_init(struct module *mod)
 {
+	int ret;
+
 	if (ftrace_disabled || !mod->num_ftrace_callsites)
 		return;
 
-	ftrace_process_locs(mod, mod->ftrace_callsites,
-			    mod->ftrace_callsites + mod->num_ftrace_callsites);
+	ret = ftrace_process_locs(mod, mod->ftrace_callsites,
+				  mod->ftrace_callsites + mod->num_ftrace_callsites);
+	if (ret)
+		pr_warn("ftrace: failed to allocate entries for module '%s' functions\n",
+			mod->name);
 }
 
 static void save_ftrace_mod_rec(struct ftrace_mod_map *mod_map,
@@ -7201,15 +7206,19 @@ void __init ftrace_init(void)
 	pr_info("ftrace: allocating %ld entries in %ld pages\n",
 		count, count / ENTRIES_PER_PAGE + 1);
 
-	last_ftrace_enabled = ftrace_enabled = 1;
-
 	ret = ftrace_process_locs(NULL,
 				  __start_mcount_loc,
 				  __stop_mcount_loc);
+	if (ret) {
+		pr_warn("ftrace: failed to allocate entries for functions\n");
+		goto failed;
+	}
 
 	pr_info("ftrace: allocated %ld pages with %ld groups\n",
 		ftrace_number_of_pages, ftrace_number_of_groups);
 
+	last_ftrace_enabled = ftrace_enabled = 1;
+
 	set_ftrace_early_filters();
 
 	return;
-- 
2.35.1
