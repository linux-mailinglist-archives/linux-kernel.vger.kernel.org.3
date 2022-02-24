Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F064C35C2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiBXTVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbiBXTVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:21:35 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B2124FBB6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:21:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b11-20020a5b008b000000b00624ea481d55so712476ybp.19
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XeyKS8RFDw4jOveKpKzpaWOeY5Iszmw9j6umKWFdclY=;
        b=RGLMCO1Etdpy755zbZrEGgrFJvgWznO+TQvBEcFQPzPb8J0/RUoA1yjnAqVSw+C0VM
         f174wesSM91IxNRS2ued7Rjo8EeUwimObR1mHdSl7IIpdyCaHp+qIzPUHs68Om6+dZeL
         nHGw+Y2pAtbJbifYV0sP4xrqs9X/nCpIoS58RtKNe87ka4ozoG8RGxchDv26rSLYgGbi
         Fr+2mOVyVOnbQScZ68KltzVd2vYWJLvV2YOeQfPw3ACqHOk26dPOiMNs6d4uyBcD7eHR
         xDSkO0qU5p1lNIuO3x6d9I4XoNIYHcyiv8FarCoMjrrTmiESzUO/2T8j7DhzVWG1NOUV
         TTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XeyKS8RFDw4jOveKpKzpaWOeY5Iszmw9j6umKWFdclY=;
        b=Jn9isN4GcY4rN9EooVBGOqIpPKljPMCnpY5LPHu4cXu++DnHe7qQm3t5Yo0BbAExJ2
         6UF+gUs0eNLTdjj8sw6vorD80kwXyurYQjhwssJcfRX5vK4XtZjEdMvSSuYJ/Dzu/dPj
         VWg7nfbxI5PRqdqa4057EY22Zhqv5A19qFj3YC9xL8Y5gxinpdx6xxgp8Td1KyjOWSeY
         nkt1mlbKSjpjr6L407cjVcviXYDIdI62s+ZURwfepT0KPqfkvsz6xYIOpZzueDbEvTfm
         OMitM9Lt9P4jxCSnD+CfI7ybiTUz++pRfnyo55UqFy14Mhzvc4UNN9TogF7ZRkx4yn+y
         7rLQ==
X-Gm-Message-State: AOAM5339foVN8/oHwrq7hPc45JFwAT2M5oBk01xu2PGF1wztYhimVWkm
        R/1YWOl8tKxWtLCnRy/R2Ek6UgVaOYYS5Q==
X-Google-Smtp-Source: ABdhPJxyg2MoliW/bMDs8Trw98DfmYoIgUcWqP9ZDRosz12QtS2nE3rQpgaQ46fTufkIQRuNeMHAGaj0oUThMg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:96e5:fbf5:15ed:8b6f])
 (user=dlatypov job=sendgmr) by 2002:a05:6902:4e2:b0:611:19fc:a30 with SMTP id
 w2-20020a05690204e200b0061119fc0a30mr3818796ybs.431.1645730462280; Thu, 24
 Feb 2022 11:21:02 -0800 (PST)
Date:   Thu, 24 Feb 2022 11:20:36 -0800
In-Reply-To: <20220224192036.2388302-1-dlatypov@google.com>
Message-Id: <20220224192036.2388302-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20220224192036.2388302-1-dlatypov@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 3/3] kunit: tool: properly report the used arch for --json,
 or '' if not known
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

Before, kunit.py always printed "arch": "UM" in its json output, but...
1. With `kunit.py parse`, we could be parsing output from anywhere, so
    we can't say that.
2. Capitalizing it is probably wrong, as it's `ARCH=um`
3. Commit 87c9c1631788 ("kunit: tool: add support for QEMU") made it so
   kunit.py could knowingly run a different arch, yet we'd still always
   claim "UM".

This patch addresses all of those. E.g.

1.
$ ./tools/testing/kunit/kunit.py parse .kunit/test.log --json | grep -o '"arch.*' | sort -u
"arch": "",

2.
$ ./tools/testing/kunit/kunit.py run --json | ...
"arch": "um",

3.
$ ./tools/testing/kunit/kunit.py run --json --arch=x86_64 | ...
"arch": "x86_64",

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit.py        | 2 +-
 tools/testing/kunit/kunit_json.py   | 4 ++--
 tools/testing/kunit/kunit_kernel.py | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 7dd6ed42141f..5c03f1546732 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -153,7 +153,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 				test_glob = request.filter_glob.split('.', maxsplit=2)[1]
 				filter_globs = [g + '.'+ test_glob for g in filter_globs]
 
-	metadata = kunit_json.Metadata(build_dir=request.build_dir)
+	metadata = kunit_json.Metadata(arch=linux.arch(), build_dir=request.build_dir, def_config='kunit_defconfig')
 
 	test_counts = kunit_parser.TestCounts()
 	exec_time = 0.0
diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
index 0a7e29a315ed..1212423fe6bc 100644
--- a/tools/testing/kunit/kunit_json.py
+++ b/tools/testing/kunit/kunit_json.py
@@ -18,8 +18,8 @@ from typing import Any, Dict
 @dataclass
 class Metadata:
 	"""Stores metadata about this run to include in get_json_result()."""
-	arch: str = 'UM'
-	def_config: str = 'kunit_defconfig'
+	arch: str = ''
+	def_config: str = ''
 	build_dir: str = ''
 
 JsonObj = Dict[str, Any]
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index fe159e7ff697..bbbe2ffe30b7 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -248,6 +248,8 @@ class LinuxSourceTree(object):
 			kconfig = kunit_config.parse_from_string('\n'.join(kconfig_add))
 			self._kconfig.merge_in_entries(kconfig)
 
+	def arch(self) -> str:
+		return self._arch
 
 	def clean(self) -> bool:
 		try:
-- 
2.35.1.574.g5d30c73bfb-goog

