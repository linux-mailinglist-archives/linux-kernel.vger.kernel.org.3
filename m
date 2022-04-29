Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B58515371
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379948AbiD2SQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379923AbiD2SQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:16:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3E7C749C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:13:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb7d137101so81453557b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sL4XXKW/JkXSCKlfCPPNQVCwhZjkWTkPQxVqGebWlkY=;
        b=J8I5/PjQmTyc7WXDivtsNpPPj3oCtvBdvBNDRZ016t+T537sEc6xywczIJjMi05DZh
         OT1tpJeA7Ys1Oalyk/Q7g8bQO3eNce6w6ztjAyvQGEW7zmxJZvQO6ZCtW+9Tie8pys5Q
         tgMFfSRBeh79U+MlvjO7SwoBhWU6fipFTqmjGEvrjTzjp51iImfSo4bPnFMHPC37HuzK
         +NUVBBR0ZgofOK61hfA1YC99wfQ0UpDi75zqTeBk2mysDTntcVYfxeM3lHA9iDwjCVmn
         DRjB0Xwxj7EMaeICNXQPuX77pluy0vvMfEFcJ1AgmId2Qgl9lIpd1K+HYiz68u2ZCc2F
         FLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sL4XXKW/JkXSCKlfCPPNQVCwhZjkWTkPQxVqGebWlkY=;
        b=6MLgkQNFOzB0sfzvXWZYa4W65qheAGJvD26YM6B/bSK8bLm5BwRLj8v/d1mEz6X1nV
         loSFoz46ebWSmch08RLwK1qhWVsxKnpWQHgItdH+yyGFwnI1mvAum8oYwKk0EvkP1F4G
         NTYE0lQ4HLwZ7lvINSepvMPLnd5vXGlvaNlAXs7uLxdHIJCuasrGz56IBK6ItOBy634/
         5LFq/F7v/6xPSplrj3zCTNxuyCQ4ZSe/JqS247I9O0ZB++atDPCbGJUkqjXMDK+Z+m8f
         nlHs9VY3KzcvFR50iwCZj2xWMb0R6wxa1Vu6HzBkHqCWW6Gq3/eMrNlBQwC9BrcDrf0y
         Zbsg==
X-Gm-Message-State: AOAM533lb5BaYwl/mlV/X4ysFQYzX8LA5P8Wm9jIC/QRA0f4wGGtJOVd
        MGzwakm+xKdThRsWGBO3WxHtb6rzVCx8Ww==
X-Google-Smtp-Source: ABdhPJyyVRFTKlRDuFIct0JNB1b+NegMWENKiEyuTk/7a5uhOrU993QYfuCRnGk4qCfG6URZ47v+Y5zg7zypzw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:183a:36d7:2dcb:1773])
 (user=dlatypov job=sendgmr) by 2002:a25:9383:0:b0:648:458e:423e with SMTP id
 a3-20020a259383000000b00648458e423emr669169ybm.583.1651255993442; Fri, 29 Apr
 2022 11:13:13 -0700 (PDT)
Date:   Fri, 29 Apr 2022 11:12:59 -0700
In-Reply-To: <20220429181259.622060-1-dlatypov@google.com>
Message-Id: <20220429181259.622060-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20220429181259.622060-1-dlatypov@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v2 4/4] kunit: fix debugfs code to use enum kunit_status, not bool
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6d2426b2f258 ("kunit: Support skipped tests") switched to using
`enum kunit_status` to track the result of running a test/suite since we
now have more than just pass/fail.

This callsite wasn't updated, silently converting to enum to a bool and
then back.

Fixes: 6d2426b2f258 ("kunit: Support skipped tests")
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
v1 -> v2: added this patch.
---
 lib/kunit/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index b71db0abc12b..1048ef1b8d6e 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -52,7 +52,7 @@ static void debugfs_print_result(struct seq_file *seq,
 static int debugfs_print_results(struct seq_file *seq, void *v)
 {
 	struct kunit_suite *suite = (struct kunit_suite *)seq->private;
-	bool success = kunit_suite_has_succeeded(suite);
+	enum kunit_status success = kunit_suite_has_succeeded(suite);
 	struct kunit_case *test_case;
 
 	if (!suite || !suite->log)
-- 
2.36.0.464.gb9c8b46e94-goog

