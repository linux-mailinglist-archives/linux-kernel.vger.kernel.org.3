Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FA34A36D6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355129AbiA3OpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355109AbiA3Ooz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:44:55 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD88C061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 06:44:54 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id n32so10581866pfv.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 06:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kryIRj8itYCF1TTsF9+Gx7ZLlBZd5qrSWyChaI+fLhg=;
        b=MMiKK8jwpOK13mc21HfEe654xK0nw4NOyaOMmklAJMgkLAR51PoZ34JqZExYOghXRF
         S6p926neaWY6GnSSe1PYLdRbIck7pqIO4fTDLLazAXbwm92LAs3n09TqiZXJi37bvgdk
         Xy0jYTN4F1qdb6Ameb+IC4l9KtAowmfc9wrsIjHGpKwS2FT3ucMJX+xDIXeTfYaDMzbo
         OHTbHk6pRxIQN/8JHvjiWwrACwb/jdVmjKzz/4OIhmAzSEWJn/9SU6aOq0TIAjq+OrJV
         bQIgwYWA4B2G4afkSqDHwFokT4XvLyXjPoZnNONHnR2wh0ZkZynCQmrMampYwPCnTh59
         6JUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kryIRj8itYCF1TTsF9+Gx7ZLlBZd5qrSWyChaI+fLhg=;
        b=ePOGUh9QDPc0ObvkN12yygi9oCJUjlStgtl0URoL/+N2EscFW7rHu8s6r6NdwLOLWg
         QrsAV8tzMqRpRbSTzcnlkE7iTRzHLQsPqYWFnh5iWHZuH4Lx/+R1lEtRqP1PgYP/z/EH
         O97jPYe//Os/ST7PTLuqisRkLe8TWIXfdLQejjIFJlRiaKFBpSdndrWEFcIORxnP87ip
         FOD+fE2HrzPY6gA3WVTvLGqliJ73j/j65XCZUFDNQ2wu4leEUIiqhkZO0zZx+VeMDhDA
         6Sbfl6+ioWKaSL4BPrcsC7WN+W7ZpUfEy9UU6WUbVdWlYz0396JBeTgBpVlYwh1FbMV1
         9CwQ==
X-Gm-Message-State: AOAM530+IBhD0p2t5eHdz8uXlmqQ6zE6EEWJretbt0T/fmZMljjBDWAQ
        iBDnxKXDkMquR5oMrd3WTxI=
X-Google-Smtp-Source: ABdhPJwnxr6UdYT0cRgOgG2ljd+33yKK9/uhOnDOswx789vSX/GlSD2ICkvA1MUMEW0K1iqJctYWFA==
X-Received: by 2002:a63:c106:: with SMTP id w6mr13600672pgf.313.1643553894499;
        Sun, 30 Jan 2022 06:44:54 -0800 (PST)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id w8sm10502126pfu.128.2022.01.30.06.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 06:44:54 -0800 (PST)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v8 3/4] trace/objtrace: Add testcases for objtrace
Date:   Sun, 30 Jan 2022 22:44:29 +0800
Message-Id: <20220130144430.453221-4-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220130144430.453221-1-xiehuan09@gmail.com>
References: <20220130144430.453221-1-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a series of testcases to illustrate correct and incorrect usage of
objtrace trigger.

Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
---
 .../ftrace/test.d/trigger/trigger-objtrace.tc | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
new file mode 100644
index 000000000000..d71eb157c51f
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
@@ -0,0 +1,39 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test objtrace-trigger
+# requires: kprobe_events "objtrace":README
+
+fail() { #msg
+    echo $1
+    exit_fail
+}
+
+echo 'p bio_add_page arg1=$arg1' > kprobe_events
+
+FEATURE=`grep objtrace events/kprobes/p_bio_add_page_0/trigger`
+if [ -z "$FEATURE" ]; then
+    echo "objtrace trigger is not supported"
+    exit_unsupported
+fi
+
+echo "Test objtrace trigger"
+echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > \
+	events/kprobes/p_bio_add_page_0/trigger
+if [ -z $? ]; then
+	fail "objtrace trigger syntax error"
+fi
+
+echo "Test objtrace semantic errors"
+
+# Being lack of objtrace command
+! echo 'objtrace:arg1,0x28:u32:1' > events/kprobes/p_bio_add_page_0/trigger
+# Bad parameter name
+! echo 'objtrace:add:argx:u32:1' > events/kprobes/p_bio_add_page_0/trigger
+
+echo "reset objtrace trigger"
+
+echo '!objtrace:add:arg1,0x28:u32' > \
+	events/kprobes/p_bio_add_page_0/trigger
+echo '-:p_bio_add_page_0' >> ./kprobe_events
+
+exit 0
-- 
2.25.1

