Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D415556AE0A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbiGGV6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbiGGV6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:58:33 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8B2C1E3D7;
        Thu,  7 Jul 2022 14:58:32 -0700 (PDT)
Received: from localhost.localdomain (unknown [98.59.227.103])
        by linux.microsoft.com (Postfix) with ESMTPSA id 39EB52044E3A;
        Thu,  7 Jul 2022 14:58:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 39EB52044E3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1657231112;
        bh=2Ap9b42+7PS01tMomF0UoTpbPfyX7eb8WdCg4A5a8S0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bGpxt66uQtd1VhAvn5csr2ozPYzS0YfJpTagNp2yUMxoH5Z6FmQy9uIONqDtoYNnF
         W7HOLIKFYPhSr+faQMGJiYbAFauPw9/vFIisWJ4iMtEK5DodUcRJiLt3b84vuwQ8jK
         9AlxpoPcEwEZpyOAgFGFWz/UKWfE/btp4oraSFvs=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/7] tracing/user_events: Remove BROKEN and restore user_events.h location
Date:   Thu,  7 Jul 2022 14:58:22 -0700
Message-Id: <20220707215828.2021-2-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707215828.2021-1-beaub@linux.microsoft.com>
References: <20220707215828.2021-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
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
index 2c43e327a619..9bb54c0b3b2d 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -767,7 +767,6 @@ config USER_EVENTS
 	bool "User trace events"
 	select TRACING
 	select DYNAMIC_EVENTS
-	depends on BROKEN || COMPILE_TEST # API needs to be straighten out
 	help
 	  User trace events are user-defined trace events that
 	  can be used like an existing kernel trace event.  User trace
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 4afc41e321ac..7bff4c8b90f2 100644
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

