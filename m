Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701F75848C9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 01:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiG1Xww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 19:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiG1Xwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 19:52:49 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 472BE6E891;
        Thu, 28 Jul 2022 16:52:48 -0700 (PDT)
Received: from localhost.localdomain (unknown [76.135.27.191])
        by linux.microsoft.com (Postfix) with ESMTPSA id F033E20FE9A2;
        Thu, 28 Jul 2022 16:52:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F033E20FE9A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1659052368;
        bh=pd8SxtOSvngSpxdTqBR6M7sBWyIdow9hqz290CeIJAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V9JxgtG75cJ44mCCrtzE4s8fKCSyGtBEBiNkgr5Y4LRmXpANMCQAJeTuKPjd59LIr
         H3qmI4ZQde0w2g2JqV4zdaRCdEO0n2WJITUx/Rk8gj9l4icGX84bquc12q7hxc1IVz
         jU4CO3u3A2sRmVR0o3eCnQKbcqn8OKtXc+MotgCg=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/7] tracing/user_events: Remove BROKEN and restore user_events.h location
Date:   Thu, 28 Jul 2022 16:52:35 -0700
Message-Id: <20220728235241.2249-2-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728235241.2249-1-beaub@linux.microsoft.com>
References: <20220728235241.2249-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After having discussions and addressing the ABI issues user_events can
be now marked as working and used by others.

As part of the BROKEN status, user_events.h was moved from its original
uapi location to the kernel location. This needs to be moved back so
it can be used by others.

Link: https://lore.kernel.org/all/20220330155835.5e1f6669@gandalf.local.home
Link: https://lkml.kernel.org/r/20220330201755.29319-1-mathieu.desnoyers@efficios.com
Link: https://lore.kernel.org/all/2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com/
Link: https://lore.kernel.org/all/1651771383.54437.1652370439159.JavaMail.zimbra@efficios.com/

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 include/{ => uapi}/linux/user_events.h | 0
 kernel/trace/Kconfig                   | 1 -
 kernel/trace/trace_events_user.c       | 5 -----
 3 files changed, 6 deletions(-)
 rename include/{ => uapi}/linux/user_events.h (100%)

diff --git a/include/linux/user_events.h b/include/uapi/linux/user_events.h
similarity index 100%
rename from include/linux/user_events.h
rename to include/uapi/linux/user_events.h
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index ccd6a5ade3e9..c9302f46a317 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -770,7 +770,6 @@ config USER_EVENTS
 	bool "User trace events"
 	select TRACING
 	select DYNAMIC_EVENTS
-	depends on BROKEN || COMPILE_TEST # API needs to be straighten out
 	help
 	  User trace events are user-defined trace events that
 	  can be used like an existing kernel trace event.  User trace
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 2c0a6ec75548..fd8ea555437a 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -19,12 +19,7 @@
 #include <linux/tracefs.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
-/* Reminder to move to uapi when everything works */
-#ifdef CONFIG_COMPILE_TEST
-#include <linux/user_events.h>
-#else
 #include <uapi/linux/user_events.h>
-#endif
 #include "trace.h"
 #include "trace_dynevent.h"
 
-- 
2.25.1

