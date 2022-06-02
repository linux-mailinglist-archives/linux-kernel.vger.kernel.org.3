Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A7453BCBA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbiFBQqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbiFBQpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:45:55 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795B4186D1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 09:45:54 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id e66so5198605pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 09:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3RAHC5JpxAqYMofiRYRDeUYE27k98N5i2YcPubXjat4=;
        b=a1MvSRziQIXwoR+XFZTTzT9H0To64WFXo/NbGGvpeTHFuTKD3Pwa4V5RHtT6lJpbSF
         YWuFgxs2lKT+xr+RydKXt+6Mog9b/F9R/mvzkDo8ipHODYXlZAtwLkiua9K5cOXmMkW1
         RjzQGR6OXHH4EXfO/xJzur0m27Wyrr3X7rk/CbGn/cehpMRpCgdy1vHgLGjwhW10mh0Z
         NiRt92B+8BJF+nwtbRyZfv53ImDvbaiITukGObi7OgsvNoe+re97d2ZzWgq7BNjKsGLf
         IFxUlcmjGKv8/MglI0lLiUzxHC5+ZN7y2QRl9/U9+yDuGa4Ih4Tybvu3vI4xRQ2VEUZ1
         QaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3RAHC5JpxAqYMofiRYRDeUYE27k98N5i2YcPubXjat4=;
        b=S9lkA+MOX6ZtuR2V/wC78XUOZwkvqAcmwcxODlI2Y3QIGpdtGRwzWtWwROn4k/J7xa
         OwDEnGmMoAzwJpJO50duhHbrQiMee3l99ht9NTKFggZ7QieXDAd3zJJYX0qFlZV9uC9R
         G6TpcWSt6e9dcmjCpGhoYoqCRqqpjYsWRBSYf7JcFKWosbfzvjCL86V87vN7u0pL/cjT
         s2Eo/XJWSd9HAv9N8C0vUW9fgw+EVtnwape1JwRLeN1Vv41SXytq/TFKHCiPri6BFE/g
         46MWfFTyiVVoFDm/UueN8bvMLcCwEyeB7+XaIKctxhxuqW2NNd/HfZ73sEihMGRjRQAB
         ymXQ==
X-Gm-Message-State: AOAM530dD703/KfwlEw98CldO5QwLVPhYqSQQHAp6iAHysAp+qB77X2i
        KUOQsOShOry8eZ/u9mlNgyI=
X-Google-Smtp-Source: ABdhPJxyBrPlrmGF+0nE2WX4KWz0CQo2zIs6GNYUjYuBisnCy0HSCU7adBIaPMUpibcnSOATAzT01g==
X-Received: by 2002:a63:f966:0:b0:3fc:de79:5355 with SMTP id q38-20020a63f966000000b003fcde795355mr3505167pgk.211.1654188354006;
        Thu, 02 Jun 2022 09:45:54 -0700 (PDT)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id b127-20020a62cf85000000b0051b9c02e4a3sm3821888pfg.178.2022.06.02.09.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 09:45:53 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v11 3/4] trace/objtrace: Add testcases for objtrace
Date:   Fri,  3 Jun 2022 00:45:17 +0800
Message-Id: <20220602164518.286295-4-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220602164518.286295-1-xiehuan09@gmail.com>
References: <20220602164518.286295-1-xiehuan09@gmail.com>
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

