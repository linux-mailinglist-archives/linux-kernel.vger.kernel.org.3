Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4308959E7FA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244076AbiHWQrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344147AbiHWQqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:46:51 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4501C6FC6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:25:08 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id bf3-20020a17090b0b0300b001fb29d80046so2507447pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=QWKuLGeQgOwRURxq7JoMTU3dLzHqHHHK1oS3f4BccKo=;
        b=GrRVd//5LW1PqHd4+nmw6iQxSDEv6SZl5rq7HvG1ZJxkWdbroNR0IQv8QL0Ed2zy2Z
         XS84YhajnhHij1m6VLGokiI4brAmotcy4aU9GAHbjNRHu9oBai/BGZOVsHo05UwBQG/t
         DT9BwpLi9hZP9gRnX6seb5nEuJSf+RB0AnnlqoHS/kQp50pVUaKGGK/H3pC1JeY0I5bd
         5GerYP1n64mD7BCQimQCl8T/9JMDBQT/r3nNdE8DpBOqR5445aSzh3U0nLHwsqlRWAvb
         y+Hkp3MQklnI9vQcisuFfVEd1nvAAqK7tWeo1RwG9Nh5gA9jiQu5y0hP87d1B8tXblgP
         3GXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=QWKuLGeQgOwRURxq7JoMTU3dLzHqHHHK1oS3f4BccKo=;
        b=MuUkMqFT5AyTXaXZc42l+Wr2PlNHwlkOo7GcfLQBO7MbN/FryvbAb3f+4wATIuKEpL
         iWJTQQAz0c/0A0q5GNepPjhwHwlSgD+RNeHgK031hZMNXx1DRAf6lWkJvARz6e23v7tZ
         MPoD2cfg67V76Ovs5lF/w1i4xbuIFl2Rt7AA8J8rQ03vuucNEBFxNRlxRi89wZta/UxE
         xBu1yUCaPW5nDm2X/GTkfc5cjyvZYk6SK10s6iVkZepxZ7Vx0Y3vp4agH5M2Gwlg3Q8b
         3l9bKSfjsGOaR8jprLDg3wNU6OxT7/3NBHB91XIotW3ESP3PmEaYELL/IGnq0ckY1IHw
         dzjw==
X-Gm-Message-State: ACgBeo21KFd1TgxfLZnrSSqSEnY1AISLy0Jimi0r6bOXz1xF88gnHqiF
        Q0skdZtcI2YLSNu5D0H6pxuLFJLMkbPw854=
X-Google-Smtp-Source: AA6agR7/i5co66jtp2HCxpHPVsfI+WFBs/BqAssIQ+wYlUCD1tfwcs4GkOkSfZf6nev2LPSvgvuPF9Dk/9obk25L
X-Received: from joefradley-custom-96.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:831])
 (user=joefradley job=sendgmr) by 2002:a17:902:7003:b0:172:cbb0:9af8 with SMTP
 id y3-20020a170902700300b00172cbb09af8mr17254972plk.57.1661264708208; Tue, 23
 Aug 2022 07:25:08 -0700 (PDT)
Date:   Tue, 23 Aug 2022 07:24:55 -0700
In-Reply-To: <20220823142456.3977086-1-joefradley@google.com>
Message-Id: <20220823142456.3977086-3-joefradley@google.com>
Mime-Version: 1.0
References: <20220823142456.3977086-1-joefradley@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v2 2/2] kunit: no longer call module_info(test, "Y") for kunit modules
From:   Joe Fradley <joefradley@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     Joe Fradley <joefradley@google.com>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because KUnit test execution is not a guarantee with the kunit.enable
parameter we want to be careful to only taint the kernel when actual
tests run. Calling module_info(test, "Y") for every KUnit module
automatically causes the kernel to be tainted upon module load. Therefore,
we're removing this call and relying on the KUnit framework to taint the
kernel or not.

Signed-off-by: Joe Fradley <joefradley@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
Changes since v1:
- Added David's and Brendan's Reviewed-by for tags.

 include/kunit/test.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index ee6bf4ecbd89..512089e5ce4e 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -253,7 +253,6 @@ static inline int kunit_run_all_tests(void)
 #endif /* IS_BUILTIN(CONFIG_KUNIT) */
 
 #define __kunit_test_suites(unique_array, ...)				       \
-	MODULE_INFO(test, "Y");						       \
 	static struct kunit_suite *unique_array[]			       \
 	__aligned(sizeof(struct kunit_suite *))				       \
 	__used __section(".kunit_test_suites") = { __VA_ARGS__ }
-- 
2.37.1.595.g718a3a8f04-goog

