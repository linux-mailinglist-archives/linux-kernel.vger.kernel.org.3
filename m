Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FE95729DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 01:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiGLXZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 19:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiGLXZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 19:25:35 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247D7A5E58
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 16:25:35 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id i21-20020aa79095000000b00528bd947f66so2840587pfa.18
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 16:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OhirvL3LrpsrpGUFLH/SV2OLOMXqNUAB/vXAw1XRY00=;
        b=R8xM1rtChBJCyKph+bVpC2te2Q0v2DLVsD8aFQuy8l2zZkyEHlV5DCicE20Y8T9uRW
         1jc2S1CQi4fEh/28xemYWzn+E1SfGirSE+OQEPvYJveHwE+/F/6FJYMjpftsBW05O9US
         OOQInlQ0EVeu5FuhmLv8dTYRebVYbSYZA1zsy7m41XNFkplNRR3kgsDlsazFpzd7oIus
         HqK8FRzTjHqmOTy9UExoMi+dmwCbpv0u+nAj4QwP3CVJmgM4bWmgIexoILG046LhDQ4B
         t1rJl4VfcBRY+VmYzEtBUH5vBbaulgiZS+oVi3GQcasTQyHcmZWXnivlt2whBfObAnz4
         TsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OhirvL3LrpsrpGUFLH/SV2OLOMXqNUAB/vXAw1XRY00=;
        b=1k0fk4A5j5PK3OF5SSGAuONMM1dZVbCs/hokCaKghUHc0+KvxuXT/E1oIE58zE3Qne
         T/BbdEz5FoBILABjcxZYucVXlN/PBwRxUCd2gyP1h53oNk4JQx+056Bc6k2gdhHQVjUt
         0Ob0WnbiKLgoM9r6fm7tv6Nvn6fX/TMZwyvwzAgCdaHwzQUxGFeuRdpH2MkvwvjKe7+i
         o1ldS8IAMmNm+AHEDfkRmbHu9cNZjXd8fHvUQaJcPOMxWrM0pjZzLbPlCB08A7eKV57k
         T290gk7JcvRYLL3dCe0vpC4Oi5z6PzCSb2Rm8XkzJIf/DM9tIMWutnGEMIOkijfnHK2g
         xe8A==
X-Gm-Message-State: AJIora+46hOTCoUfE90QQJoAE11Xxf3wQe3hF1ReJmOVMc2LTjj0gtdY
        zZktMEe0Bpxwf9WVfxi6ED1c7Eku2K0vkw==
X-Google-Smtp-Source: AGRyM1vnAn3L1a5orvF7pBa+LLZ8msIBU+2aUfJxeXzDvaD++UBWHlHM4MdhaBExUPvkVqAR7ySiTLQpTvPeGg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90b:278b:b0:1ef:b15e:61e3 with SMTP
 id pw11-20020a17090b278b00b001efb15e61e3mr6864938pjb.143.1657668334688; Tue,
 12 Jul 2022 16:25:34 -0700 (PDT)
Date:   Wed, 13 Jul 2022 07:25:27 +0800
Message-Id: <20220712232527.1864211-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [PATCH v2] kunit: executor: Fix a memory leak on failure in kunit_filter_tests
From:   David Gow <davidgow@google.com>
To:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, kernel test robot <yujie.liu@intel.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
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

It's possible that memory allocation for 'filtered' will fail, but for the
copy of the suite to succeed. In this case, the copy could be leaked.

Properly free 'copy' in the error case for the allocation of 'filtered'
failing.

Note that there may also have been a similar issue in
kunit_filter_subsuites, before it was removed in "kunit: flatten
kunit_suite*** to kunit_suite** in .kunit_test_suites".

This was reported by clang-analyzer via the kernel test robot, here:
https://lore.kernel.org/all/c8073b8e-7b9e-0830-4177-87c12f16349c@intel.com/

And by smatch via Dan Carpenter and the kernel test robot:
https://lore.kernel.org/all/202207101328.ASjx88yj-lkp@intel.com/

Fixes: a02353f49162 ("kunit: bail out of test filtering logic quicker if OOM")
Reported-by: kernel test robot <yujie.liu@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Thanks everyone! No actual code changes in v2, just fixes to the
description.

Changes since v1:
https://lore.kernel.org/all/20220712095627.1770312-1-davidgow@google.com/
- Fix a mistake in the commit description where we noted the allocation
  for 'copy' could fail, instead of 'filtered'. (Thanks Yujie!)
- Noted in the description that smatch also found this (Thanks Dan!)
- Added the extra Reported-by and Reviewed-by tags.

---
 lib/kunit/executor.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 6c489d6c5e5d..5e223327196a 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -74,8 +74,10 @@ kunit_filter_tests(const struct kunit_suite *const suite, const char *test_glob)
 		return ERR_PTR(-ENOMEM);
 
 	filtered = kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
-	if (!filtered)
+	if (!filtered) {
+		kfree(copy);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	n = 0;
 	kunit_suite_for_each_test_case(suite, test_case) {
-- 
2.37.0.144.g8ac04bfd2-goog

