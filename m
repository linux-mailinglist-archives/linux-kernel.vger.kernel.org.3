Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB074A92DF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 04:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356881AbiBDD5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 22:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356873AbiBDD5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 22:57:13 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACC8C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 19:57:13 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o16-20020a17090aac1000b001b62f629953so11905382pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 19:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3RAHC5JpxAqYMofiRYRDeUYE27k98N5i2YcPubXjat4=;
        b=SJyXuCfQLgYHmeTZ7aZCE98hIP2BB4/vL0Duh8M6pd27jCJyirDKscDdTAp7zstDb6
         SXnRBLJ58sk8+GfxsLGYzd20RSvcC6bwMdNY67BHXO0ZyfC2Hsk9m1em0YABkNWpC0r5
         hnmFLqBqbdw3X9ahgizBIXf85JIxMwv/dTW4d1ZkeNmYyBR4Tbk9hWv7Z7fVAST0dmxg
         qQbBUYEwXjGJ0cc7k49Na0+LRgRrDO+ilL4xyLqDsllXcPa8bsP8tlaCarHcRcfqlQnG
         OywyZx7eury2E7Ed8tOOzmx1a8RGi3jKUe5gUu9OdyPdkIkAzjd4ucvhVistRYz2SYKW
         Iomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3RAHC5JpxAqYMofiRYRDeUYE27k98N5i2YcPubXjat4=;
        b=4TSacPkWZrM/Y13Iv8jzqzZcCVoVlxlt0ylO+fGqSOpg8bofhE45jlrilixj00upNj
         UZ+wnmJn0Rlzg3t7w1GujVzSgGIYpqWJAS1Azppl/WuhusIbM1LxJllBvokGQTC2z1g0
         Ol7GFXWAJkjHnRLJR4x0GUZV7FXcnF9nvcTyuAK+MUg9i8pfwmd+S3xm0+Fxety7iEjK
         2gTxHEldYZECeHyTYKsoFyIHpNmt+uZtTfPObHnjAEHcmk/qtYuv8XlJOZHjTb+9YjNS
         W84r3ngNVX0Shz5+T9rWz+FSf/qI+oCAdOTYZlFfk63zMN+T3MoY2Dwt5/0HxGxRjcXj
         JwFw==
X-Gm-Message-State: AOAM533cUpukX+gh/jTV9wlCvbmMg4Nq9g7u8ZmFP3xWjQmB9Ra5n8Ko
        ZcLasP32M3p9sLIaWEEDaKTIFZVX2NU=
X-Google-Smtp-Source: ABdhPJyqTzTqqws9bis9joTymlm/KreHOU9PXVebXLbPPPopXwlBsT1+9Ed9ZBC0T4irvJEB9e3zKg==
X-Received: by 2002:a17:90b:1012:: with SMTP id gm18mr1065375pjb.84.1643947032421;
        Thu, 03 Feb 2022 19:57:12 -0800 (PST)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id 204sm506229pfu.91.2022.02.03.19.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 19:57:11 -0800 (PST)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v9 3/4] trace/objtrace: Add testcases for objtrace
Date:   Fri,  4 Feb 2022 11:56:43 +0800
Message-Id: <20220204035644.734878-4-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204035644.734878-1-xiehuan09@gmail.com>
References: <20220204035644.734878-1-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a series of testcases to illustrate correct and incorrect usage of
objtrace trigger.

Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
---
 .../ftrace/test.d/trigger/trigger-objtrace.tc | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
new file mode 100644
index 000000000000..d894442b6a30
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc
@@ -0,0 +1,41 @@
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
+echo 'p bio_add_page arg1=$arg1 arg2=$arg2' > kprobe_events
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
+# The parameter existed on event
+! echo 'objtrace:add:arg2:u32:1' > events/kprobes/p_bio_add_page_0/trigger
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

