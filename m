Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C79529169
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 22:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348549AbiEPT6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 15:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347956AbiEPTwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:52:35 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73BD45054
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:48:07 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id h13-20020a170902f70d00b0015f4cc5d19aso6146070plo.18
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Qkg0VjWV3dsGLC/CTbEN1HI3toMCNaiLgVonfkXEzUI=;
        b=ELl/+bvBtXGZEAVx8mem5Q3fzIyUxLAZGICbsmjVju4tZ944Iwcorx7cGW1jTq1iYe
         ktSPcF4PizIiRw0N0DST0B1W3+to2EnvgNTAv9TXxjOGKn7LubfIoqpPLlMhOA6+bwBm
         BXaevB4q+4AcFdXD98nI4UDZoDP27eMKHOKqaTwOufzSl1HLCiZOrKbruZnnN4BXEOSg
         D76Qm4xAyw/pTTdIyEUXvh3tcyRqCi8MqQszIB6DB+NcoXAULeUsSU60PL29iVlFkB3n
         QAnltMu6gSJA9SeEJx6l8qjBmc9ZUy4LjMJg+CRP+1+NAQvzhI3eeHQUsDlR4OK8tn6q
         iHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Qkg0VjWV3dsGLC/CTbEN1HI3toMCNaiLgVonfkXEzUI=;
        b=vnYhKpSVwB7cZgc9M1pKEGo1DfA+v+/SGlX2N0g/1eo4uYDht5As22QjfqWsP1Stss
         OnsfAPJs32snTqIUAI8YtztVCoKwn0Z6TQcM1SXxwlVGctEpAOCpxzmHOvNPMM4qXWVy
         KR2hvL5l0me2iQaU6VN5dLt/fu65oOoUdMjbCTU/FlkVxFkjgJmw4ykuDnS6iyIHAYki
         n/LxccXn4EsRDlhSVTt2R7aSlNyUrMdSjxHhpF7p2CsPYMuX/euDIjt6zUCHQ54SZLrr
         u5fHTUb9OViBpSZ6+uyK3NxUchC9GcznwCzNGmR6viKlwAb75NtvkIRWqpL2aSnxYu9f
         s0lw==
X-Gm-Message-State: AOAM531Xaufbjat7pgDCgqzZUKNHU6ISlYK4BUaJ7yTLdrjzs/hb8jvE
        e4qMM/Q/QRDX/LrqS6IxTZc6Vkn9zLlQgQ==
X-Google-Smtp-Source: ABdhPJz0foU0ikc41QMADjDWwlkzr82FMjEnCkBdlOiEAm5yyAiZw9tbfdq+oePhNzVyIsOmA4tEa+4C3+OyWQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:8f91:3848:5672:cb59])
 (user=dlatypov job=sendgmr) by 2002:a17:90a:990c:b0:1df:fb1:bc2f with SMTP id
 b12-20020a17090a990c00b001df0fb1bc2fmr14623551pjp.79.1652730486427; Mon, 16
 May 2022 12:48:06 -0700 (PDT)
Date:   Mon, 16 May 2022 12:47:28 -0700
Message-Id: <20220516194730.1546328-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH 1/3] kunit: tool: drop unused load_config argument
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
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

It's always set to true except in one test case.
And in that test case it can safely be set to true anyways.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_kernel.py    | 4 ----
 tools/testing/kunit/kunit_tool_test.py | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 3539efaf99ba..8bc8305ba817 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -219,7 +219,6 @@ class LinuxSourceTree:
 	def __init__(
 	      self,
 	      build_dir: str,
-	      load_config=True,
 	      kunitconfig_path='',
 	      kconfig_add: Optional[List[str]]=None,
 	      arch=None,
@@ -233,9 +232,6 @@ class LinuxSourceTree:
 			self._arch = 'um' if arch is None else arch
 			self._ops = get_source_tree_ops(self._arch, cross_compile)
 
-		if not load_config:
-			return
-
 		if kunitconfig_path:
 			if os.path.isdir(kunitconfig_path):
 				kunitconfig_path = os.path.join(kunitconfig_path, KUNITCONFIG_PATH)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 25a2eb3bf114..b9158017ece6 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -393,7 +393,7 @@ class LinuxSourceTreeTest(unittest.TestCase):
 			return subprocess.Popen(['echo "hi\nbye"'], shell=True, text=True, stdout=subprocess.PIPE)
 
 		with tempfile.TemporaryDirectory('') as build_dir:
-			tree = kunit_kernel.LinuxSourceTree(build_dir, load_config=False)
+			tree = kunit_kernel.LinuxSourceTree(build_dir)
 			mock.patch.object(tree._ops, 'start', side_effect=fake_start).start()
 
 			with self.assertRaises(ValueError):

base-commit: 8a7ccad38f8b25c8202efd69371a022357286400
-- 
2.36.1.124.g0e6072fb45-goog

