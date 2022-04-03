Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21F24F0A2F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 16:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243344AbiDCOeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 10:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359004AbiDCOdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 10:33:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9985C2FFD9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 07:31:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F327B80BD9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 14:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9ABFC34113;
        Sun,  3 Apr 2022 14:31:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nb1GW-001Ej6-NJ;
        Sun, 03 Apr 2022 10:31:40 -0400
Message-ID: <20220403143140.552957584@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 03 Apr 2022 10:25:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [for-linus][PATCH 7/7] tracing: Move user_events.h temporarily out of include/uapi
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

While user_events API is under development and has been marked for broken
to not let the API become fixed, move the header file out of the uapi
directory. This is to prevent it from being installed, then later changed,
and then have an old distro user space update with a new kernel, where
applications see the user_events being available, but the old header is in
place, and then they get compiled incorrectly.

Also, surround the include with CONFIG_COMPILE_TEST to the current
location, but when the BROKEN tag is taken off, it will use the uapi
directory, and fail to compile. This is a good way to remind us to move
the header back.

Link: https://lore.kernel.org/all/20220330155835.5e1f6669@gandalf.local.home
Link: https://lkml.kernel.org/r/20220330201755.29319-1-mathieu.desnoyers@efficios.com
Link: https://lkml.kernel.org/r/20220401143903.188384f3@gandalf.local.home

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/{uapi => }/linux/user_events.h | 0
 kernel/trace/trace_events_user.c       | 5 +++++
 2 files changed, 5 insertions(+)
 rename include/{uapi => }/linux/user_events.h (100%)

diff --git a/include/uapi/linux/user_events.h b/include/linux/user_events.h
similarity index 100%
rename from include/uapi/linux/user_events.h
rename to include/linux/user_events.h
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 846c27bc7aef..706e1686b5eb 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -18,7 +18,12 @@
 #include <linux/tracefs.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+/* Reminder to move to uapi when everything works */
+#ifdef CONFIG_COMPILE_TEST
+#include <linux/user_events.h>
+#else
 #include <uapi/linux/user_events.h>
+#endif
 #include "trace.h"
 #include "trace_dynevent.h"
 
-- 
2.35.1
