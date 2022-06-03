Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6638153D28E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 21:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349354AbiFCT5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 15:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243107AbiFCT5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:57:43 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20391EED6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 12:57:42 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id x1-20020a170902ec8100b0016634ff72a4so3789810plg.15
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 12:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yw5oLDxPzA4x8GiT50xzenS9433El8aksuU2kCWJ5pk=;
        b=dlp/8I89YhGs2GWgPG5LnOxa8u3bZx25ZgFP34Y/NU/We4cto1TBikJ/iU4HC+xorT
         V/oOkMpMzwOcS4l3IIBMN/rjnX+NhwDcXXTGlH3Difj8Sgr2tYgZNaExYJZs5PEanU+e
         cS/ex2huFpe3TJoCa72Qykd6SQ4vAEEVPg9P3C6rr5/SuTwIGnhs6KUPintnhIr3AnKM
         qUAgflPjChyZxocbm4AjZjv6pVYa6JuO8oj+/nmJ3oXEfzwclIvonTApEfLdsFshhXNT
         UT4w4lFYLaRUnMRxrnisa+RsQwqHBSUJfQGfuHPdvhn9R8Gfqj3tADInlsosGXbqgHzE
         DnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yw5oLDxPzA4x8GiT50xzenS9433El8aksuU2kCWJ5pk=;
        b=h6ceSeM2/cmEx3usJ1g9aPl4FE90f740t6AQmZAO1yKT5ZecMlwHqN4QqipSe0tY6F
         Osca/0n5gcIom/BVxnQ69M6Csq9NjjGpuZLUYOIpveBjwtCKwNEdXU29dCYH24HdPaed
         seavoCM+eywqes93x/lC37dVw8qj55VT4lduSdqdA07SSlxW5G/qZXC/QiwMl5FyJf0k
         5yE+QTDPFdC1Z290VyNi9bu3oeWRwlmjpnXju965jVrDCDLR6NWiNajl+CqLDA+ZOcOv
         jVeUqEt0ax74be7Iq1l2C/KvDgBqsd5vpavKxIQsxK/PafcNiPUju7ZUYUNOFSNY+PaA
         wyXA==
X-Gm-Message-State: AOAM533qy/gN0IqGAQBP1lusk6G57rWva+KNLHHR4HKEsC5vHk4EMqf4
        yeByCVGhCk4NQ7q3JglpPNMYRMMOMR9hLw==
X-Google-Smtp-Source: ABdhPJzoCnFcZNnBxHclYQ934OCjRTdYAMEtGWA0FpDhfRN90AK7GJ6mLI9IbMQnvkNZZC1VRFDNz87aTBEskw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:9ff0:c6ec:46df:8f8a])
 (user=dlatypov job=sendgmr) by 2002:a05:6a00:114b:b0:4f7:915:3ec3 with SMTP
 id b11-20020a056a00114b00b004f709153ec3mr12029785pfm.8.1654286262084; Fri, 03
 Jun 2022 12:57:42 -0700 (PDT)
Date:   Fri,  3 Jun 2022 12:56:25 -0700
In-Reply-To: <20220603195626.121922-1-dlatypov@google.com>
Message-Id: <20220603195626.121922-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220603195626.121922-1-dlatypov@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 2/3] Documentation: kunit: move mention of --jobs flag lower
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ad659ccb5412 ("kunit: tool: Default --jobs to number of CPUs")
changed the --jobs flag from a hard-coded value of 8 to basically
`nproc`.

Therefore, most users should probably not need to bother to tweak this
flag. Having it near the top of the page is more noise than anything.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/run_wrapper.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index 653985ce9cae..1fccf2e099f7 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -30,10 +30,9 @@ We may want to use the following options:
 
 .. code-block::
 
-	./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all
+	./tools/testing/kunit/kunit.py run --timeout=30
 
 - ``--timeout`` sets a maximum amount of time for tests to run.
-- ``--jobs`` sets the number of threads to build the kernel.
 
 kunit_tool will generate a ``.kunitconfig`` with a default
 configuration, if no other ``.kunitconfig`` file exists
@@ -237,6 +236,9 @@ command line arguments:
   compiling a kernel (using ``build`` or ``run`` commands). For example:
   to enable compiler warnings, we can pass ``--make_options W=1``.
 
+- ``--jobs``: The ``-j`` argument to ``make`` when building the kernel.
+  Defaults to the same value as ``nproc``.
+
 - ``--alltests``: Builds a UML kernel with all config options enabled
   using ``make allyesconfig``. This allows us to run as many tests as
   possible.
-- 
2.36.1.255.ge46751e96f-goog

