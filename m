Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6814C4B6B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243346AbiBYQyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243269AbiBYQw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:52:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B1B22322E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:52:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8CD9B832A0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79490C34101;
        Fri, 25 Feb 2022 16:52:20 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nNdpL-00B8Ls-Gw;
        Fri, 25 Feb 2022 11:52:19 -0500
Message-ID: <20220225165219.356099467@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 25 Feb 2022 11:51:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [for-linus][PATCH 07/13] ftrace: Remove unused ftrace_startup_enable() stub
References: <20220225165151.824659113@goodmis.org>
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

From: Nathan Chancellor <nathan@kernel.org>

When building with clang + CONFIG_DYNAMIC_FTRACE=n + W=1, there is a
warning:

  kernel/trace/ftrace.c:7194:20: error: unused function 'ftrace_startup_enable' [-Werror,-Wunused-function]
  static inline void ftrace_startup_enable(int command) { }
                     ^
  1 error generated.

Clang warns on instances of static inline functions in .c files with W=1
after commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

The ftrace_startup_enable() stub has been unused since
commit e1effa0144a1 ("ftrace: Annotate the ops operation on update"),
where its use outside of the CONFIG_DYNAMIC_TRACE section was replaced
by ftrace_startup_all().  Remove it to resolve the warning.

Link: https://lkml.kernel.org/r/20220214192847.488166-1-nathan@kernel.org

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f9feb197b2da..a4b462b6f944 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7191,7 +7191,6 @@ static int __init ftrace_nodyn_init(void)
 core_initcall(ftrace_nodyn_init);
 
 static inline int ftrace_init_dyn_tracefs(struct dentry *d_tracer) { return 0; }
-static inline void ftrace_startup_enable(int command) { }
 static inline void ftrace_startup_all(int command) { }
 
 # define ftrace_startup_sysctl()	do { } while (0)
-- 
2.34.1
