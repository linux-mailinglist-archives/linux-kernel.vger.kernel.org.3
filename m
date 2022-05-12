Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E81952531F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356819AbiELRBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356779AbiELRAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:00:48 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3777518371
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:00:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so5435367pji.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3RAHC5JpxAqYMofiRYRDeUYE27k98N5i2YcPubXjat4=;
        b=Kp2ewZZ7jM6je0FurBjkAcOhWg+K3mqCf6/7sECa/dyp9+QcEVVrLmlWMucY2w9zBC
         3tGKT+Y6R0t9+WJ3KSwOB2g/ixEYJxKFAXEyDp9qMw6pbh9O6birSpyxGrfwEsJT0hs3
         g1qqCfCFaBWUcWxL7jroDSotYs04G8sFsdMW90CwgQux6Up8ib5gtnEVT7L6g2o/o7UT
         CM2mNk3AbZNJ+qqrfoW9NwA84Z3j3po/UAhhdEOoSPQVLI/U8kHMlhyVrk8ABxB8rArd
         PCze8gD82Di2lYn15FUQ6NlphUNdx0TpT1vAUGKBcIIKK8kz6tmmcOSi8sYDX9scwrgl
         Hiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3RAHC5JpxAqYMofiRYRDeUYE27k98N5i2YcPubXjat4=;
        b=A2Qg5gBzrpTipBeAWjLjmXwYuPnVqiZxJgOepg9rC5hFRev+wUKzGDSmL09N+jW4lL
         9tKLGRzKcZWJY/U5VPTiHIyLjtBn+bc714RT7A6VDc1vqlSZjCp2IDjAkWDGdSAOs0Cy
         a62hIqohcIQXuNOsmhFEBpQl+xPBCKrYg8zZu80lSA5aKySXw4NIcLBEJrR7arLZnKD1
         alrxAFeVSZFYO8x8JNTRUSna6xnM2SYd9txiB4uWqj3lFRfxMyODyQ191QZ36rYpLniD
         AdBRsq68INfat+r/iBDSBjzgQIDwjFP6L+WsQrYGTk4y3Zr9zyXjHsNVFkV6gXzRtu3P
         n4HQ==
X-Gm-Message-State: AOAM531zBn3pDuTnYkBr9EvtFN112OgpD+2kH05JstTHkqpagZglKPLm
        LHv34PqfExrb3pe0opbJNP0=
X-Google-Smtp-Source: ABdhPJw6EGY9mVef3FyirMIkj3RwU13aMifVKqL62ml09g6/aRIqjuA0Q/cqLfgICKzJ732bbSxgVw==
X-Received: by 2002:a17:90b:4b01:b0:1dc:7405:dd62 with SMTP id lx1-20020a17090b4b0100b001dc7405dd62mr523509pjb.160.1652374844528;
        Thu, 12 May 2022 10:00:44 -0700 (PDT)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id u10-20020a63234a000000b003c14af50605sm2119374pgm.29.2022.05.12.10.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 10:00:43 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v10 3/4] trace/objtrace: Add testcases for objtrace
Date:   Fri, 13 May 2022 01:00:07 +0800
Message-Id: <20220512170008.1301613-4-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220512170008.1301613-1-xiehuan09@gmail.com>
References: <20220512170008.1301613-1-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

