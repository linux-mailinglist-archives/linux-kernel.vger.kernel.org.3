Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46D6462207
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbhK2UUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbhK2URM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:17:12 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2E9C08ED4B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:50:25 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so14760994pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kryIRj8itYCF1TTsF9+Gx7ZLlBZd5qrSWyChaI+fLhg=;
        b=Yz+ySofTeAFvI+JHhSXhIF0JHFKxYPsvBNWP5PC1CI49I0NdSl2GMVakMbDEniL/AH
         Kg3rBV2YsCDbvUqMFs2aZqGu9WC3JcTSWsG8Nilp/imhh5yrHnV/30lvAOct426YYacF
         xHAg4RYNgLzNAPrQ1nfpGUeqhuygZ2qZTEUhFDb7epNSe5IRK/skaDRJj9zpNov1JbWJ
         0BwAoznwl0y0DbM6GmkrB+j+fnqfHkUUKupeGDA14k4jIDreMJ9ldKB3l6J2I+pehnqo
         2xS2Abftduu19orxIF3oiRAw61ZuHNoGUsd0TleL79pFpNkCh19A07xjcvk8h1HT7uaV
         v9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kryIRj8itYCF1TTsF9+Gx7ZLlBZd5qrSWyChaI+fLhg=;
        b=mOWAd/mmZZylaGivRbldyPkK0b01zr+i1x+iv5U+SAdmsJtGZ484L4pmSUP+DoeH8O
         e5569GyKT0Sto9rqsp/PQnl3q1ty34oFeW3ZNbZS7vwWinL+uWE/iVx9G9VgCvBgPkYg
         2NxDkUkfSFBMvsUN4aG4Sd1N12QUPNhcrWK3s7lJqIsk2F6mnh06HjJB1GK54OI3sO1H
         1RU8Rvl7j8iGQfKv7wSwarWbMVSCuRw5GFzTBk0Snbx9ZVeagOpETCnNZZAeNzKExXd5
         GQpUPJnHpHz4+0YkvDaKEcQ7zWKpgeA0uy63kDaP9ke+74c2+cj7U75qVmyBoYxeovmV
         A5Jg==
X-Gm-Message-State: AOAM532IOAUpA9r9zNwsExVGg2NZ6NNYKVez6xSiHVs8tAmY6VaNik3e
        t/6SNUYZJhphLtqQLLQxnzg=
X-Google-Smtp-Source: ABdhPJx8vQX9biSDzJnYQjMXLgDfho1GJxSxrd5O/r9LGrhf6Q0uHteHshnOk93KMKGxHSw9r9Hhbw==
X-Received: by 2002:a17:902:e842:b0:142:dbc:bade with SMTP id t2-20020a170902e84200b001420dbcbademr62486832plg.45.1638204624812;
        Mon, 29 Nov 2021 08:50:24 -0800 (PST)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id mr2sm14044211pjb.25.2021.11.29.08.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 08:50:24 -0800 (PST)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [RFC][PATCH v6 4/5] trace/objtrace: Add testcases for objtrace
Date:   Tue, 30 Nov 2021 00:49:50 +0800
Message-Id: <20211129164951.220511-5-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129164951.220511-1-xiehuan09@gmail.com>
References: <20211129164951.220511-1-xiehuan09@gmail.com>
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

