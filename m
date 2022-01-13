Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E1248D036
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 02:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiAMBjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 20:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiAMBi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:38:57 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD41C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 17:38:57 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so8505852pji.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 17:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kryIRj8itYCF1TTsF9+Gx7ZLlBZd5qrSWyChaI+fLhg=;
        b=coAPwOqiiQXqDLnQJHZghIMfurOOSA/kL6ULbmhw0jkGFdTvcflOkqj4RbMWaPBidm
         G5S0SfDfRQsHUW41U6NyKQ4CHfYCIQ5iTrXWHm+fVd5zFVFi58TaqpLnL9jacFYu8Fff
         GtKDClPQkFlKU971PtKkeqG6iFj0XKo6ridlM6wfM4XTt2fG7aiCnz9rS8kfUq1c76F9
         1KNoNckxuWnQLqzZ7I084YnQZCu9ANVjZy80Z/OwJ/jAs7wAF8t/mILDwkeJ6pAsUKtt
         nvA4W1ha8lWXrZdXeH6P5WAuKM1gcc+3eL6KRw91GahiAlozoF362MUBtM8k4v5dYnAW
         4v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kryIRj8itYCF1TTsF9+Gx7ZLlBZd5qrSWyChaI+fLhg=;
        b=Q0gO11sgrGBTwLbaM2o+8DpVkohq0+myrvCahPJ0Mw+FQDljVrJHk2iotLNN1xfY/B
         vwSXIq42yORma6BDmHYSTPFZkPg7vc2AV616FP8jsrN8UmZhC47SH2AB2YfzU8/Ij9rN
         blif4MPM6hNNOxB5XVgdu4TXINlr3x4/cp3NZnlEEblY5YhkPcb3rfTgMd+z8azpHVLm
         jnulDpaAwXTOHCgRJPSgkCqOEfxPOt0l1qkH6isq/e+KeP0UoLX0ujWYkEsFRjITwKzX
         CAGU1hYScCLnNEPnNn2kYYVjuWjREHXeJjat01TPcl/5X+k5QL9Tv3KaOthxTE6CElxW
         h3Vg==
X-Gm-Message-State: AOAM533X2+sYK6rniury4Vm6SVN6TXPC2V4yw6KrmcWqNfFwsg5X8vue
        aPn1uktnkuOyUPHP0Mr7f+Y=
X-Google-Smtp-Source: ABdhPJxTcev08Xzdeh3YZqERwYxHpi7tG1M7pgvAu/On7naj+Y+gLn05OPwqS1yLr/o3ltL93GgoBA==
X-Received: by 2002:a17:902:c651:b0:148:b0af:6f80 with SMTP id s17-20020a170902c65100b00148b0af6f80mr2206709pls.130.1642037937222;
        Wed, 12 Jan 2022 17:38:57 -0800 (PST)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id b4sm799990pfl.101.2022.01.12.17.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 17:38:56 -0800 (PST)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v7 3/4] trace/objtrace: Add testcases for objtrace
Date:   Thu, 13 Jan 2022 09:38:34 +0800
Message-Id: <20220113013835.503285-4-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113013835.503285-1-xiehuan09@gmail.com>
References: <20220113013835.503285-1-xiehuan09@gmail.com>
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

