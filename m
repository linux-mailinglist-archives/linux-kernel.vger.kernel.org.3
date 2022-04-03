Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA3B4F0A2D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 16:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359023AbiDCOds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 10:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343750AbiDCOdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 10:33:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAD42FFDC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 07:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29220611D6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 14:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B49C3411A;
        Sun,  3 Apr 2022 14:31:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nb1GW-001Ei0-BK;
        Sun, 03 Apr 2022 10:31:40 -0400
Message-ID: <20220403143140.186803554@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 03 Apr 2022 10:25:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 5/7] tracing: Set user_events to BROKEN
References: <20220403142500.388473000@goodmis.org>
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

After being merged, user_events become more visible to a wider audience
that have concerns with the current API. It is too late to fix this for
this release, but instead of a full revert, just mark it as BROKEN (which
prevents it from being selected in make config). Then we can work finding
a better API. If that fails, then it will need to be completely reverted.

Link: https://lore.kernel.org/all/2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com/
Link: https://lkml.kernel.org/r/20220330155835.5e1f6669@gandalf.local.home

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 16a52a71732d..f83d29adb375 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -741,6 +741,7 @@ config USER_EVENTS
 	bool "User trace events"
 	select TRACING
 	select DYNAMIC_EVENTS
+	depends on BROKEN || COMPILE_TEST # API needs to be straighten out
 	help
 	  User trace events are user-defined trace events that
 	  can be used like an existing kernel trace event.  User trace
-- 
2.35.1
