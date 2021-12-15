Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E286E47637A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbhLOUjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236138AbhLOUj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:39:27 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3879C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 12:39:27 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e131-20020a25d389000000b005fb5e6eb757so45349271ybf.22
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 12:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sfllunMFpDuZT34Po6N/Y75gCsaWiTA2hy3SEI5N8aU=;
        b=qk+p3k7Lpw2nRf9F2QCp2ERW/hT5HhXf8vtNNmX+DZLYw55Z//nvdsjj2XxBs4Mt4Y
         AHlCUeRruUUifsaB06a04U6HmpGE2laD4f8/VWhj7Vfwc3x3FmuJI2F4X5gdBLcAzfeU
         QjQtSRVm3x6k2qSM2KezijUSLpgTWzDPzdAF9hyvm2w16jn8ZpvD5DI7fEDTqpHFCPdA
         vfSRMD3/K7+BG7SXRVj7uEeS6wa1TGTvwCMa8X7DUayUniQtLGzmluoiwhCgqWU07JmV
         u3e/zJ8fIBlUPr0JrVfdh+mpaBQuc0sVc3ayT1DDy83RlqQ0DpzWKUkeM0jH7zz2memI
         F+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sfllunMFpDuZT34Po6N/Y75gCsaWiTA2hy3SEI5N8aU=;
        b=uXX7gVy1uQrOUdD87DbhCkgCvYFii8ypXY7eGXRvcN3AXNAJQ7j4WOwRMgimQLTY/h
         iCeZ8ZLq+gXrxTBa4x+FnWy4ovFSVhdQLk0IeAqcKRDdzXC89AIx36DrHIISVWjYAwuq
         0+7btLI0eJio+cn/tvoiYSnvL5vM8/wxQIkPBa5C4ToEvKlw+VmJNkgFyMpU0Aku1qx6
         BdIalJ7qn9CSkvQ6Ks2M04BFOqZ4IMNCXnBpWI6x+S33LjBeC52tyrVbbt7bxVQxBsTo
         e2fxDo+Yy/sw1HiZ2dSDnBGCa43gdXAjrxDczFWIt1uUwehKQB4umq0YwU7RLoijIkxJ
         VIpw==
X-Gm-Message-State: AOAM533qFjHYpupsIFECYBqQxBxrts4hNVNzOFFJJhRJCgDjZ3/5v21b
        WzEuBfU49+RQnGLpiaQ0RGBFnXGhoV1Zqg==
X-Google-Smtp-Source: ABdhPJwmSfd229bx3CvEKZL0Rnq5k1dzQeOCkX50InTNnISDRej1puPzT8POL8bzmS3A/sjiVGNjXBr4/+vT9g==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:1bef:2d92:9c3e:f258])
 (user=dlatypov job=sendgmr) by 2002:a25:bb49:: with SMTP id
 b9mr8724144ybk.0.1639600766944; Wed, 15 Dec 2021 12:39:26 -0800 (PST)
Date:   Wed, 15 Dec 2021 12:39:23 -0800
Message-Id: <20211215203923.390608-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v2] kunit: tool: fix newly introduced typechecker errors
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading mypy and pytype from pip, we see 2 new errors when
running ./tools/testing/kunit/run_checks.py.

Error #1: mypy and pytype
They now deduce that importlib.util.spec_from_file_location() can return
None and note that we're not checking for this.

We validate that the arch is valid (i.e. the file exists) beforehand.
Add in an `asssert spec is not None` to appease the checkers.

Error #2: pytype bug https://github.com/google/pytype/issues/1057
It doesn't like `from datetime import datetime`, specifically that a
type shares a name with a module.

We can workaround this by either
* renaming the import or just using `import datetime`
* passing the new `--fix-module-collisions` flag to pytype.

We pick the first option for now because
* the flag is quite new, only in the 2021.11.29 release.
* I'd prefer if people can just run `pytype <file>`

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
v1 -> v2: rebase on top of linx-kselftest kunit branch.
Only conflict was a deleted import in kunit_parser.py
---
 tools/testing/kunit/kunit_kernel.py | 1 +
 tools/testing/kunit/kunit_parser.py | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 12085e04a80c..44bbe54f25f1 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -209,6 +209,7 @@ def get_source_tree_ops_from_qemu_config(config_path: str,
 	# exists as a file.
 	module_path = '.' + os.path.join(os.path.basename(QEMU_CONFIGS_DIR), os.path.basename(config_path))
 	spec = importlib.util.spec_from_file_location(module_path, config_path)
+	assert spec is not None
 	config = importlib.util.module_from_spec(spec)
 	# See https://github.com/python/typeshed/pull/2626 for context.
 	assert isinstance(spec.loader, importlib.abc.Loader)
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 66a7f2fb314a..05ff334761dd 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -12,7 +12,7 @@
 from __future__ import annotations
 import re
 
-from datetime import datetime
+import datetime
 from enum import Enum, auto
 from functools import reduce
 from typing import Iterable, Iterator, List, Optional, Tuple
@@ -517,7 +517,7 @@ ANSI_LEN = len(red(''))
 
 def print_with_timestamp(message: str) -> None:
 	"""Prints message with timestamp at beginning."""
-	print('[%s] %s' % (datetime.now().strftime('%H:%M:%S'), message))
+	print('[%s] %s' % (datetime.datetime.now().strftime('%H:%M:%S'), message))
 
 def format_test_divider(message: str, len_message: int) -> str:
 	"""

base-commit: 1ee2ba89bea86d6389509e426583b49ac19b86f2
-- 
2.34.1.173.g76aa8bc2d0-goog

