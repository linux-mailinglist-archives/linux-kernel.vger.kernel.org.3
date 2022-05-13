Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4393B525D9A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378337AbiEMIcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378301AbiEMIce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:32:34 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573752A8042
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:32:32 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id gb16-20020a17090b061000b001d78792caebso3706846pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 01:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0ybWbXGPDsdksfVbXJMzQ1kLilXdTLhR2XM1EfoNTaQ=;
        b=mDbxxzGMPRe66EbTeOC0DGcg92DtfgZjKodWRekjDNOouMcdlsxRTubPmRzKzEg//+
         NCtUoa0kB6dTGI5dBm+INXN2ngqEyVFZVXDa1xF8ystd1DFn7NF/874SjcTIb3v1qTDL
         UymPtLbOczNqc1qU+w3EfujQ9VYJzaSa2Qnvmnf/lzLYCpJn4fZi+optc113jKzHURNo
         Icw7XTBDwAPWE0plpyLnMfuriavPbm//BT2ukq/OrV6jT80TPt0YfRKsZBzv9Q1B6pqz
         vgtX3KGFCOlzV8Ozs/+RNXW5okVxVEvqN77emPfFAivLiAuMxWkThJEtfhfN9RcB3J/t
         lPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0ybWbXGPDsdksfVbXJMzQ1kLilXdTLhR2XM1EfoNTaQ=;
        b=dUQNHZIpkzXzR5WEYKzH/RWmUTn+py0fFYKUFK8I8/CH61tgpjQgB9J7oWVNXhgquA
         Eqo8KGnkeGS04Rdl4vGz1cjKPql2NA2aMpZRL+4TvlfPozHjOQ/e0+U8VetsJw+Ewr7U
         pBEFoKeh8Zwvz7u3AUWfUsc6/pruuF7IzS8UMqNtt6vaGkrEjPLuYFH4YGcq1m9suDRm
         JybLSLqJrHZ/vHbuEgENw4OYCE7RLu+9hANuqtQWrX5cnDLl7xkI3+KoqisOZBWWdfwV
         p2yJ9GG7uYZxicpjGLDMbPaaR2e9V4yLYINukOWQAvGkT/X43PsJ27B7pVqtcd4Z0D0N
         ZYqA==
X-Gm-Message-State: AOAM530o0wCb7C1OutfZStYyQp47NFB66TnawJZ3mN2uIpZu1sPvJVMP
        OuilBWCfODN2plIftoRvlaXiYDNda0/sAQ==
X-Google-Smtp-Source: ABdhPJwfM5WbnpLP6WV99kx1KJIHYyM2xlBrsLZ0h+Pzul4XBI2zEL0Co3qEuGI3DWYVY6zO3MyaEFEHAAIkrg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:903:248:b0:155:ecb7:dfaf with SMTP id
 j8-20020a170903024800b00155ecb7dfafmr3832462plh.84.1652430751562; Fri, 13 May
 2022 01:32:31 -0700 (PDT)
Date:   Fri, 13 May 2022 16:32:12 +0800
In-Reply-To: <20220429043913.626647-1-davidgow@google.com>
Message-Id: <20220513083212.3537869-2-davidgow@google.com>
Mime-Version: 1.0
References: <20220429043913.626647-1-davidgow@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 2/3] kunit: Taint the kernel when KUnit tests are run
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
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

Make KUnit trigger the new TAINT_TEST taint when any KUnit test is run.
Due to KUnit tests not being intended to run on production systems, and
potentially causing problems (or security issues like leaking kernel
addresses), the kernel's state should not be considered safe for
production use after KUnit tests are run.

Signed-off-by: David Gow <davidgow@google.com>
---
 lib/kunit/test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 0f66c13d126e..2b808117bd4a 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -11,6 +11,7 @@
 #include <kunit/test-bug.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
+#include <linux/panic.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
 
@@ -498,6 +499,9 @@ int kunit_run_tests(struct kunit_suite *suite)
 	struct kunit_result_stats suite_stats = { 0 };
 	struct kunit_result_stats total_stats = { 0 };
 
+	/* Taint the kernel so we know we've run tests. */
+	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
+
 	kunit_print_subtest_start(suite);
 
 	kunit_suite_for_each_test_case(suite, test_case) {
-- 
2.36.0.550.gb090851708-goog

