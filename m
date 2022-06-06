Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E709153E606
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241608AbiFFQKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241219AbiFFQK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:10:26 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382DC1A7D1B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:10:25 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id d129so13251671pgc.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 09:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3RAHC5JpxAqYMofiRYRDeUYE27k98N5i2YcPubXjat4=;
        b=qxGV+xuO0d98iiZ1BaOG0oD9tF947wAI4he/SGgq0rGFu25xRcSFEzNCv/gAxEPz1n
         IkY5xGXGwy/GU4gNaXhYqzxTLGQgHsulAMLIFcPs4kRal4o1MgM4GEH5Ozytt8PzBkdD
         KUVSqqPE7fl1CsKMtIUXkCReYe1xbUEjpmMmrmYu3sU9hXwlj9dQxYCZc7zVTqbPVW4d
         n0untM3mRbQ+EwqLmiZGaLM8jsrXRGFvieNQRBE6y/VX4IW6K+pa2ivTE4wWvGRkiK7L
         QZBYTsyeyCnf41o7fQiojDpcz5xJzSBOanh5erBnYWaStL496IVhsFkB7RzhsT98CbMU
         NWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3RAHC5JpxAqYMofiRYRDeUYE27k98N5i2YcPubXjat4=;
        b=qbc6hcJKvOzbLPE42Nks2MQ0zgbpk4A/Kgt7c/j7FzctxOeb9WRDLn7cFyqM4zbMRM
         shRDEDjlB+DtkHhgJXJCIJN402uhs3EO77j3NcQENdDo0wAssYQh/bAMg5hRKZGOVuxU
         SzG4+G+gU1EYvDyJwtOSbGYBG64edX+P/GIMhW6p3nR/ZJu3Eo67Xyz7YDMHPTVxKkjw
         LTL/vMsgdd5wiT8sI1ckOIawg0y3xY6ASaCEE2Hvv9tXyT3pDuUom+eSMg/DYnGDzqZv
         uh34jmD6uH6HoyRp/Hw1ZUX1GqD6eXxjQBxatdaYSeYW5wO1LJ4DOWOOvdxBv8Dg+yjG
         +fpA==
X-Gm-Message-State: AOAM533OfiRyHQNxpdWgEoSlO2Ep4CWLueEk8RNpgZAln4gyK/u4GgWS
        0r7Go8IesEeyfeQUkflBspTjvenAEPngpQ==
X-Google-Smtp-Source: ABdhPJw7ZT4kMJrMO3N3KP+tNkrim+PiyAb4ySUFBvtJVg6uCGzk3lELtCooiarMsgCbV78bQJabzg==
X-Received: by 2002:a63:f403:0:b0:3fc:e1c2:6a53 with SMTP id g3-20020a63f403000000b003fce1c26a53mr20441642pgi.302.1654531824750;
        Mon, 06 Jun 2022 09:10:24 -0700 (PDT)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id l63-20020a632542000000b003fc4001fd5fsm10777246pgl.10.2022.06.06.09.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 09:10:24 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v12 3/4] trace/objtrace: Add testcases for objtrace
Date:   Tue,  7 Jun 2022 00:09:42 +0800
Message-Id: <20220606160943.663180-4-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220606160943.663180-1-xiehuan09@gmail.com>
References: <20220606160943.663180-1-xiehuan09@gmail.com>
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

