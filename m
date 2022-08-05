Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA0658B270
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 00:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241851AbiHEWWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 18:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241779AbiHEWV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 18:21:56 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3A11ADAF
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 15:21:55 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id y17-20020a63e251000000b0041d322b88b6so173779pgj.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 15:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=18f+8YL6aOvEHaZ2GuJdUMnF89FwCoTjUmHERMQZXDE=;
        b=FsK4U64sZVq+y1SyuqOQStvSBS7X8QECCn6LIsVMr2xn0nkzLI8+c5D4j5EMd+AUhk
         j3t/30i3HkCUWA8GRrEV/n5la5QXWMAMmnEib1Gi4341JdPl8J5TfnHLWNa+y5fVP+eV
         oJ9bBE123va/TwKlbkn1J19gX+WOPS5lk3FwZlPtz0EcE3ZPCeaSKNYq9YOdEzFcDRFj
         lzgI8luSNRGb7P0bwY+aM7gsZ7WkQblht0scSjo8RmMJapESKs0qw+DFJAb+seJ/d+fa
         mzUs1GKxmI0hZowF1OygbHCwUgPDBmTWHAd9Z5XtwUGQJ2j7xvAyT0Qa4igHULcSRtrM
         vWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=18f+8YL6aOvEHaZ2GuJdUMnF89FwCoTjUmHERMQZXDE=;
        b=LDFgZmATr2+n85CsSaAXdxzclozTdaDUQjUFwtFFzJM8+BiuxwiPIplaYTR1wr3S2v
         pFPeS9XV4aeCF2t0uxsE7fejclcLLijbGZO0eYa/NIepS8Pt01ARwWMecx5FMqeLdZNl
         8+MsTijDXyKvMDtbpJhl7elHW/PyR/8wp0wgvqaZFgYScArr9X0BE5ZWJBG4Gd7ePmyt
         sYUyLLjJ5PHo6PSstdwbF7yoq1HcF8O8hIzyHZpBVA63sbhLN35qYzFsds4G3mqVB0mX
         EyeL21uXiC2iP1hoo8LnG4lJXo8gHrEHmt6cUKW4wlhvqu87eesWc15y/SWKPXKiV5G7
         +ndQ==
X-Gm-Message-State: ACgBeo34+mEviIUStsYMqD42ua1mPNiiGgbGLfBv0zeGa6PFu63XsBAV
        BNRgK1GddHzeTZZhlyhGeTexatSzS14=
X-Google-Smtp-Source: AA6agR5SYNgjRPD70HCAO4QbLAX75hHQo60LfWD/m1Gc2TjfjizdokqQLPw4iq40ChDMtnBNielltDU4BD0=
X-Received: from jeffxud.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:e37])
 (user=jeffxu job=sendgmr) by 2002:a05:6a00:22d0:b0:52e:49f3:3f52 with SMTP id
 f16-20020a056a0022d000b0052e49f33f52mr8783529pfj.54.1659738115213; Fri, 05
 Aug 2022 15:21:55 -0700 (PDT)
Date:   Fri,  5 Aug 2022 22:21:25 +0000
In-Reply-To: <20220805222126.142525-1-jeffxu@google.com>
Message-Id: <20220805222126.142525-5-jeffxu@google.com>
Mime-Version: 1.0
References: <20220805222126.142525-1-jeffxu@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v2 4/5] selftests/memfd: add tests for MFD_NOEXEC
From:   <jeffxu@google.com>
To:     skhan@linuxfoundation.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, mnissler@chromium.org, jannh@google.com,
        Jeff Xu <jeffxu@chromium.org>
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

From: Daniel Verkamp <dverkamp@chromium.org>

Tests that ensure MFD_NOEXEC memfds have the appropriate mode bits and
cannot be chmod-ed into being executable.

Co-developed-by: Jeff Xu <jeffxu@chromium.org>
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
---
 tools/testing/selftests/memfd/memfd_test.c | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 1d7e7b36bbdd..4906f778564e 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -36,6 +36,10 @@
 #define MAX_PATH 256
 #endif
 
+#ifndef MFD_NOEXEC
+#define MFD_NOEXEC	0x0008U
+#endif
+
 /*
  * Default is not to test hugetlbfs
  */
@@ -1006,6 +1010,35 @@ static void test_seal_exec(void)
 	close(fd);
 }
 
+/*
+ * Test memfd_create with MFD_NOEXEC flag
+ * Test that MFD_NOEXEC applies F_SEAL_EXEC and prevents change of exec bits
+ */
+static void test_noexec(void)
+{
+	int fd;
+
+	printf("%s NOEXEC\n", memfd_str);
+
+	/* Create with NOEXEC and ALLOW_SEALING */
+	fd = mfd_assert_new("kern_memfd_noexec",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_NOEXEC);
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+	mfd_fail_chmod(fd, 0777);
+	close(fd);
+
+	/* Create with NOEXEC but without ALLOW_SEALING */
+	fd = mfd_assert_new("kern_memfd_noexec",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_NOEXEC);
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC | F_SEAL_SEAL);
+	mfd_fail_chmod(fd, 0777);
+	close(fd);
+}
+
 /*
  * Test sharing via dup()
  * Test that seals are shared between dupped FDs and they're all equal.
@@ -1179,6 +1212,7 @@ int main(int argc, char **argv)
 
 	test_create();
 	test_basic();
+	test_noexec();
 
 	test_seal_write();
 	test_seal_future_write();
-- 
2.37.1.559.g78731f0fdb-goog

