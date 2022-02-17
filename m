Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC874BAB50
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243416AbiBQUwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:52:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiBQUwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:52:53 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57D0606D6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 12:52:37 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d11b6259adso23893277b3.19
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 12:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dXZ88eAMDfwar4flZwsv+0VQlp1BfXAwBS19QSjW6e8=;
        b=Oxm18ISxi+ZPYDl/60bnw8L9ZtUKS/pHPdOCTMHLJn/8IdCoq30zdpjgqk1oGeBtQu
         kKuqpHMgoDSISAaIQD6AZbPs9rKS69UGKO/VBQaQ6V4R36XpRiwkQShXt28nIO7GFVhO
         rK2TPeFj2gHA+jO4z/OAxg0F4uBBOh1mYHNPfxQyFNdpXAULn8BVi0vyCgenE6fUB4gA
         QBBWYMsh7u6X+5p7CKyhJx8ITF0UrYj0VOiuOcTGeJAOHwyqEGHvuTy4Fm9BiFAl3lqt
         4lYpYp2do0CzN/yZLCJAGR9kvT+CrGw7tO/Kv25LWU62NhSXNpdfD7YTKTPuzeCfuNQ9
         wXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dXZ88eAMDfwar4flZwsv+0VQlp1BfXAwBS19QSjW6e8=;
        b=Ba+OU97h04ehG5lx8cpo0ZAdyO9xFAz3zr86GycwEbDMD01iU3wOhFpXoMgewzF/GJ
         OvhXhugo2Rw0PfhlICkqF/NiMLPto1Bx3H+Bm2hz6BB1hOIR2+ZNlPTruXU0Qmm0YTAk
         7Kb7m9mRyhlqTw9F5itEwjvyn2bayqxT8LW1K1KBUgALXXX90u5sXNUgdySwrlInS3qH
         Nehef/RFtEctw/Q2SYs45FLlEIJXgEtBoyYPAy05D/fQ0iiqn+T+r454MXGPSiNPvTJl
         LanPp4MWluIXLLBV5SQyEN+N7hD2L1pNoZ+CA+/bxSaZuON7QkM4LsmFE+yIPfMutKjp
         YRPw==
X-Gm-Message-State: AOAM531KDLqn7XDVEpU6q7q/6vYcqkyjKsGd3kBv/4llzv4Ld9SlHKVX
        6hq6NEwOXy2yoWAZ7LLKWZriPxfwDkddQA==
X-Google-Smtp-Source: ABdhPJzzYU3teBRLayZvyQuTnK5mTuMVlHS4CiXz14vHh1ugV53dl5JsmpPHJKJp7LlHGwaBuB5nMfWQsSgpmQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:1d37:446c:f8bc:463])
 (user=dlatypov job=sendgmr) by 2002:a25:3814:0:b0:623:a445:a40a with SMTP id
 f20-20020a253814000000b00623a445a40amr4563052yba.80.1645131156960; Thu, 17
 Feb 2022 12:52:36 -0800 (PST)
Date:   Thu, 17 Feb 2022 12:52:25 -0800
Message-Id: <20220217205227.4098452-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH 1/3] kunit: tool: readability tweaks in KernelCI json
 generation logic
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a more idiomatic check that a list is non-empty (`if mylist:`) and
sinmplify the function body by dedenting and using a dict to map between
the kunit TestStatus enum => KernelCI json status string.

The dict hopefully makes it less likely to have bugs like commit
9a6bb30a8830 ("kunit: tool: fix --json output for skipped tests").

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---

Note: this series is based on my earlier set of kunit tool cleanups for
5.18, https://lore.kernel.org/linux-kselftest/20220118190922.1557074-1-dlatypov@google.com/

There's no interesting semantic dependency, just some boring merge
conflicts, specifically with patch #4 there, https://lore.kernel.org/linux-kselftest/20220118190922.1557074-5-dlatypov@google.com/

---
 tools/testing/kunit/kunit_json.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
index 24d103049bca..14a480d3308a 100644
--- a/tools/testing/kunit/kunit_json.py
+++ b/tools/testing/kunit/kunit_json.py
@@ -16,24 +16,24 @@ from typing import Any, Dict
 
 JsonObj = Dict[str, Any]
 
+_status_map: Dict[TestStatus, str] = {
+	TestStatus.SUCCESS: "PASS",
+	TestStatus.SKIPPED: "SKIP",
+	TestStatus.TEST_CRASHED: "ERROR",
+}
+
 def _get_group_json(test: Test, def_config: str, build_dir: str) -> JsonObj:
 	sub_groups = []  # List[JsonObj]
 	test_cases = []  # List[JsonObj]
 
 	for subtest in test.subtests:
-		if len(subtest.subtests):
+		if subtest.subtests:
 			sub_group = _get_group_json(subtest, def_config,
 				build_dir)
 			sub_groups.append(sub_group)
-		else:
-			test_case = {"name": subtest.name, "status": "FAIL"}
-			if subtest.status == TestStatus.SUCCESS:
-				test_case["status"] = "PASS"
-			elif subtest.status == TestStatus.SKIPPED:
-				test_case["status"] = "SKIP"
-			elif subtest.status == TestStatus.TEST_CRASHED:
-				test_case["status"] = "ERROR"
-			test_cases.append(test_case)
+			continue
+		status = _status_map.get(subtest.status, "FAIL")
+		test_cases.append({"name": subtest.name, "status": status})
 
 	test_group = {
 		"name": test.name,
-- 
2.35.1.473.g83b2b277ed-goog

